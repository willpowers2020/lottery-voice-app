#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup
import psycopg2
import os
import re
import smtplib
from email.mime.text import MIMEText
from datetime import datetime, timedelta
import time
import sys

DATABASE_URL = os.environ.get('DATABASE_URL')
EMAIL_TO = os.environ.get('EMAIL_TO')
EMAIL_FROM = os.environ.get('EMAIL_FROM')
EMAIL_PASSWORD = os.environ.get('EMAIL_PASSWORD')

STATES = {
    'fl': ('Florida', ['pick-2', 'pick-3', 'pick-4', 'pick-5']),
    'ga': ('Georgia', ['cash-3', 'cash-4', 'georgia-five']),
    'tx': ('Texas', ['pick-3', 'daily-4']),
    'oh': ('Ohio', ['pick-3', 'pick-4', 'pick-5']),
    'mi': ('Michigan', ['daily-3', 'daily-4']),
    'il': ('Illinois', ['pick-3', 'pick-4']),
    'ny': ('New York', ['numbers', 'win-4']),
    'nj': ('New Jersey', ['pick-3', 'pick-4']),
    'pa': ('Pennsylvania', ['pick-2', 'pick-3', 'pick-4', 'pick-5']),
    'md': ('Maryland', ['pick-3', 'pick-4', 'pick-5']),
    'va': ('Virginia', ['pick-3', 'pick-4']),
    'nc': ('North Carolina', ['pick-3', 'pick-4']),
    'sc': ('South Carolina', ['pick-3', 'pick-4']),
    'dc': ('Washington, D.C.', ['dc-2', 'dc-3', 'dc-4', 'dc-5']),
}

TIMES = ['midday', 'evening', 'day', 'night', 'morning']

def send_email(subject, body):
    if not all([EMAIL_TO, EMAIL_FROM, EMAIL_PASSWORD]): return
    try:
        msg = MIMEText(body)
        msg['Subject'], msg['From'], msg['To'] = subject, EMAIL_FROM, EMAIL_TO
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as s:
            s.login(EMAIL_FROM, EMAIL_PASSWORD)
            s.send_message(msg)
    except: pass

def get_db():
    return psycopg2.connect(DATABASE_URL)

def find_game_id(cur, state_name, game_slug):
    game_name = game_slug.replace('-', ' ').title()
    for p in [f"%{game_name}%", f"%{game_slug}%"]:
        cur.execute("SELECT g.id FROM games g JOIN states s ON g.state_id=s.id WHERE s.name ILIKE %s AND g.name ILIKE %s AND g.active = true LIMIT 1", (f"%{state_name}%", p))
        r = cur.fetchone()
        if r: return r[0]
    return None

def scrape(state, game_slug, time_suffix, year):
    if time_suffix:
        url = f"https://www.lotterycorner.com/{state}/{game_slug}-{time_suffix}/{year}"
    else:
        url = f"https://www.lotterycorner.com/{state}/{game_slug}/{year}"
    try:
        r = requests.get(url, timeout=10, headers={'User-Agent': 'Mozilla/5.0'})
        if r.status_code != 200: return []
        draws = []
        soup = BeautifulSoup(r.text, 'html.parser')
        for row in soup.find_all('tr'):
            cells = row.find_all('td')
            if len(cells) >= 2:
                try:
                    date = datetime.strptime(cells[0].get_text(strip=True), '%B %d, %Y').date()
                    digits = re.findall(r'\d', cells[1].get_text())
                    # Take only first 2-5 digits based on game type
                    if '2' in game_slug: digits = digits[:2]
                    elif '3' in game_slug: digits = digits[:3]
                    elif '4' in game_slug: digits = digits[:4]
                    else: digits = digits[:5]
                    if 2 <= len(digits) <= 5:
                        draws.append((date, '-'.join(digits), '-'.join(sorted(digits)), sum(int(d) for d in digits)))
                except: pass
        return draws
    except: return []

def check_stale_games(cur):
    """Find games that haven't been updated in 3+ days"""
    cur.execute("""
        SELECT g.id, g.name, s.name as state, MAX(d.draw_date) as latest
        FROM games g
        JOIN states s ON g.state_id = s.id
        JOIN draws d ON d.game_id = g.id
        WHERE g.active = true
        GROUP BY g.id, g.name, s.name
        HAVING MAX(d.draw_date) < CURRENT_DATE - INTERVAL '3 days'
        ORDER BY latest
        LIMIT 20
    """)
    return cur.fetchall()

def main():
    print(f"=== Sync: {datetime.now()} ===")
    conn = get_db()
    cur = conn.cursor()
    
    cur.execute("SELECT MAX(draw_date), COUNT(*) FROM draws")
    latest, total = cur.fetchone()
    today = datetime.now().date()
    print(f"Before: {total:,} draws, latest: {latest}")
    
    # Check for stale games
    stale = check_stale_games(cur)
    if stale:
        print(f"\n⚠️ Found {len(stale)} stale games:")
        for gid, gname, state, last in stale[:5]:
            print(f"  {state} - {gname}: last update {last}")
    
    year = datetime.now().year
    total_added = 0
    
    for state_abbr, (state_name, games) in STATES.items():
        state_added = 0
        for game_slug in games:
            for time_suffix in TIMES + [None]:
                game_full = f"{game_slug}-{time_suffix}" if time_suffix else game_slug
                game_id = find_game_id(cur, state_name, game_full)
                if not game_id: continue
                
                draws = scrape(state_abbr, game_slug, time_suffix, year)
                for d in draws:
                    cur.execute("INSERT INTO draws (game_id, draw_date, value, sorted_value, sums) VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING", (game_id, *d))
                    state_added += cur.rowcount
                conn.commit()
                time.sleep(0.05)
        
        if state_added > 0:
            print(f"  {state_name}: +{state_added}")
        total_added += state_added
    
    cur.execute("SELECT MAX(draw_date), COUNT(*) FROM draws")
    new_latest, new_total = cur.fetchone()
    days_behind = (today - new_latest).days if new_latest else 999
    
    status = "✅ OK" if days_behind <= 1 else "⚠️ BEHIND"
    body = f"""Lottery Sync Report

Status: {status}
Days behind: {days_behind}
Before: {total:,} (latest: {latest})
After: {new_total:,} (latest: {new_latest})
Added: {total_added}
"""
    if stale:
        body += f"\nStale games ({len(stale)}):\n"
        for gid, gname, state, last in stale[:10]:
            body += f"  {state} - {gname}: {last}\n"
    
    print(f"\n{status} | Added: {total_added} | Latest: {new_latest}")
    send_email(f"{status} Lottery Sync: +{total_added}", body)
    conn.close()
    
    if days_behind > 1:
        sys.exit(1)

if __name__ == '__main__':
    main()
