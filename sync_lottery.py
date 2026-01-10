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
    'va': ('Virginia', ['pick-3', 'pick-4', 'pick-5']),
    'nc': ('North Carolina', ['pick-3', 'pick-4']),
    'sc': ('South Carolina', ['pick-3', 'pick-4']),
    'dc': ('Washington, D.C.', ['dc-2', 'dc-3', 'dc-4', 'dc-5']),
    'ca': ('California', ['daily-3', 'daily-4', 'fantasy-5']),
    'ar': ('Arkansas', ['cash-3', 'cash-4']),
    'az': ('Arizona', ['pick-3']),
    'co': ('Colorado', ['pick-3']),
    'ct': ('Connecticut', ['play3', 'play4']),
    'de': ('Delaware', ['play-3', 'play-4']),
    'ia': ('Iowa', ['pick-3', 'pick-4']),
    'in': ('Indiana', ['daily3', 'daily4']),
    'ks': ('Kansas', ['pick-3']),
    'ky': ('Kentucky', ['pick-3', 'pick-4']),
    'la': ('Louisiana', ['pick-3', 'pick-4', 'pick-5']),
    'ma': ('Massachusetts', ['numbers-game']),
    'me': ('Maine', ['tri-state-pick-3', 'tri-state-pick-4']),
    'mn': ('Minnesota', ['pick-3']),
    'mo': ('Missouri', ['pick-3', 'pick-4']),
    'ne': ('Nebraska', ['pick-3', 'pick-5']),
    'nh': ('New Hampshire', ['tri-state-pick-3', 'tri-state-pick-4']),
    'ok': ('Oklahoma', ['pick-3']),
    'ri': ('Rhode Island', ['numbers-game']),
    'tn': ('Tennessee', ['cash-3', 'cash-4']),
    'vt': ('Vermont', ['tri-state-pick-3', 'tri-state-pick-4']),
    'wi': ('Wisconsin', ['pick-3', 'pick-4']),
    'wv': ('West Virginia', ['daily-3', 'daily-4']),
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

def find_game_id(cur, state_name, game_slug, time_slug):
    """Find game_id matching state, game type, and time of day"""
    # Build search patterns
    game_name = game_slug.replace('-', ' ').replace('  ', ' ').title()
    
    # Special cases
    if game_slug == 'numbers':
        game_name = 'Numbers'
    if game_slug == 'win-4':
        game_name = 'Win 4'
    if game_slug == 'georgia-five':
        game_name = 'Georgia Five'
    if game_slug == 'fantasy-5':
        game_name = 'Fantasy 5'
    if game_slug.startswith('dc-'):
        num = game_slug.split('-')[1]
        game_name = f'DC-{num}'
    if game_slug.startswith('tri-state-'):
        parts = game_slug.split('-')
        game_name = f'Pick {parts[-1]}'
    
    time_patterns = {
        'midday': ['%Midday%', '%Day%', '%1:50%'],
        'evening': ['%Evening%', '%Night%', '%7:50%'],
        'day': ['%Day%', '%Midday%'],
        'night': ['%Night%', '%Evening%'],
        'morning': ['%Morning%'],
    }
    
    for tp in time_patterns.get(time_slug, ['%']):
        cur.execute("""
            SELECT g.id FROM games g JOIN states s ON g.state_id = s.id
            WHERE s.name = %s AND g.name ILIKE %s AND g.name ILIKE %s AND g.active = true
            LIMIT 1
        """, (state_name, f'%{game_name}%', tp))
        r = cur.fetchone()
        if r:
            return r[0]
    
    # Fallback without time
    cur.execute("""
        SELECT g.id FROM games g JOIN states s ON g.state_id = s.id
        WHERE s.name = %s AND g.name ILIKE %s AND g.active = true LIMIT 1
    """, (state_name, f'%{game_name}%'))
    r = cur.fetchone()
    return r[0] if r else None

def scrape_game(state_code, game_slug, time_slug, year):
    """Scrape draws from lotterycorner"""
    if time_slug:
        url = f"https://www.lotterycorner.com/{state_code}/{game_slug}-{time_slug}/{year}"
    else:
        url = f"https://www.lotterycorner.com/{state_code}/{game_slug}/{year}"
    
    try:
        r = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'}, timeout=15)
        if r.status_code != 200:
            return []
        soup = BeautifulSoup(r.text, 'html.parser')
        draws = []
        for row in soup.find_all('tr'):
            cells = row.find_all('td')
            if len(cells) >= 2:
                try:
                    date_text = cells[0].get_text(strip=True)
                    date = datetime.strptime(date_text, '%B %d, %Y').date()
                    nums_text = cells[1].get_text()
                    digits = re.findall(r'\d', nums_text)
                    
                    # Determine digit count from game type
                    if '2' in game_slug or game_slug == 'dc-2':
                        digits = digits[:2]
                    elif '3' in game_slug or game_slug in ['numbers', 'numbers-game']:
                        digits = digits[:3]
                    elif '4' in game_slug or game_slug == 'win-4':
                        digits = digits[:4]
                    elif '5' in game_slug or game_slug in ['fantasy-5', 'georgia-five']:
                        digits = digits[:5]
                    else:
                        digits = digits[:4]  # Default
                    
                    if len(digits) >= 2:
                        value = '-'.join(digits)
                        sorted_val = '-'.join(sorted(digits))
                        sums = sum(int(d) for d in digits)
                        draws.append((date, value, sorted_val, sums))
                except:
                    pass
        return draws
    except:
        return []

def get_stale_games(cur, days=3):
    """Find games not updated in X days"""
    cur.execute("""
        SELECT g.id, g.name, s.name as state, MAX(d.draw_date) as latest
        FROM games g
        JOIN states s ON g.state_id = s.id
        JOIN draws d ON d.game_id = g.id
        WHERE g.active = true
        GROUP BY g.id, g.name, s.name
        HAVING MAX(d.draw_date) < CURRENT_DATE - INTERVAL '%s days'
        ORDER BY latest
        LIMIT 20
    """, (days,))
    return cur.fetchall()

def sync():
    print(f"=== Sync: {datetime.now()} ===")
    
    conn = get_db()
    cur = conn.cursor()
    
    cur.execute("SELECT COUNT(*), MAX(draw_date) FROM draws")
    before_count, before_date = cur.fetchone()
    print(f"Before: {before_count:,} draws, latest: {before_date}")
    
    # Check for stale games
    stale = get_stale_games(cur)
    if stale:
        print(f"\n⚠️ Found {len(stale)} stale games:")
        for g in stale[:5]:
            print(f"  {g[2]} - {g[1]}: last update {g[3]}")
    
    year = datetime.now().year
    total_added = 0
    
    for state_code, (state_name, games) in STATES.items():
        state_added = 0
        for game_slug in games:
            # Try with times
            for time_slug in TIMES:
                game_id = find_game_id(cur, state_name, game_slug, time_slug)
                if not game_id:
                    continue
                
                draws = scrape_game(state_code, game_slug, time_slug, year)
                for d in draws:
                    cur.execute("""
                        INSERT INTO draws (game_id, draw_date, value, sorted_value, sums) 
                        VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING
                    """, (game_id, *d))
                    state_added += cur.rowcount
            
            # Also try without time (LA, etc)
            game_id = find_game_id(cur, state_name, game_slug, None)
            if game_id:
                draws = scrape_game(state_code, game_slug, None, year)
                for d in draws:
                    cur.execute("""
                        INSERT INTO draws (game_id, draw_date, value, sorted_value, sums) 
                        VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING
                    """, (game_id, *d))
                    state_added += cur.rowcount
        
        conn.commit()
        if state_added > 0:
            print(f"  {state_name}: +{state_added}")
            total_added += state_added
    
    cur.execute("SELECT COUNT(*), MAX(draw_date) FROM draws")
    after_count, after_date = cur.fetchone()
    
    status = "✅ OK" if after_date and after_date >= datetime.now().date() - timedelta(days=1) else "⚠️ STALE"
    print(f"\n{status} | Added: {total_added} | Latest: {after_date}")
    
    # Send alert if stale
    if stale and EMAIL_TO:
        body = f"Stale games found:\n" + "\n".join([f"{g[2]} - {g[1]}: {g[3]}" for g in stale])
        send_email("Lottery Sync Alert", body)
    
    conn.close()

if __name__ == '__main__':
    sync()
