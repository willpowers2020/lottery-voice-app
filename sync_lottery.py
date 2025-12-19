#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup
import psycopg2
import os
import re
import smtplib
from email.mime.text import MIMEText
from datetime import datetime
import time
import sys

DATABASE_URL = os.environ.get('DATABASE_URL')
EMAIL_TO = os.environ.get('EMAIL_TO')
EMAIL_FROM = os.environ.get('EMAIL_FROM')
EMAIL_PASSWORD = os.environ.get('EMAIL_PASSWORD')

STATES = {'fl': 'Florida', 'ga': 'Georgia', 'tx': 'Texas', 'oh': 'Ohio', 'mi': 'Michigan', 'il': 'Illinois', 'ny': 'New York', 'nj': 'New Jersey', 'pa': 'Pennsylvania', 'md': 'Maryland', 'va': 'Virginia', 'nc': 'North Carolina', 'sc': 'South Carolina', 'tn': 'Tennessee', 'ky': 'Kentucky', 'in': 'Indiana', 'mo': 'Missouri', 'la': 'Louisiana', 'dc': 'Washington, D.C.', 'ca': 'California', 'az': 'Arizona', 'ct': 'Connecticut', 'de': 'Delaware', 'ma': 'Massachusetts'}
GAMES = ['pick-3-midday', 'pick-3-evening', 'pick-4-midday', 'pick-4-evening', 'pick-5-midday', 'pick-5-evening', 'cash-3-midday', 'cash-3-evening', 'cash-4-midday', 'cash-4-evening', 'dc-3-midday', 'dc-3-evening', 'dc-4-midday', 'dc-4-evening', 'dc-5-midday', 'dc-5-evening']

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
    for p in [f"%{game_slug.replace('-', ' ').title()}%", f"%{game_slug}%"]:
        cur.execute("SELECT g.id FROM games g JOIN states s ON g.state_id=s.id WHERE s.name ILIKE %s AND g.name ILIKE %s LIMIT 1", (f"%{state_name}%", p))
        r = cur.fetchone()
        if r: return r[0]
    return None

def scrape(state, game, year):
    try:
        r = requests.get(f"https://www.lotterycorner.com/{state}/{game}/{year}", timeout=10, headers={'User-Agent': 'Mozilla/5.0'})
        if r.status_code != 200: return []
        draws = []
        for row in BeautifulSoup(r.text, 'html.parser').find_all('tr'):
            cells = row.find_all('td')
            if len(cells) >= 2:
                try:
                    date = datetime.strptime(cells[0].get_text(strip=True), '%B %d, %Y').date()
                    digits = re.findall(r'\b(\d)\b', cells[1].get_text())
                    if 2 <= len(digits) <= 5:
                        draws.append((date, '-'.join(digits), '-'.join(sorted(digits)), sum(int(d) for d in digits)))
                except: pass
        return draws
    except: return []

def main():
    print(f"=== Sync: {datetime.now()} ===")
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT MAX(draw_date), COUNT(*) FROM draws")
    latest, total = cur.fetchone()
    today, year = datetime.now().date(), datetime.now().year
    days_behind = (today - latest).days if latest else 999
    total_added = 0
    for state, state_name in STATES.items():
        for game in GAMES:
            game_id = find_game_id(cur, state_name, game)
            if not game_id: continue
            for d in scrape(state, game, year):
                cur.execute("INSERT INTO draws (game_id, draw_date, value, sorted_value, sums) VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING", (game_id, *d))
                total_added += cur.rowcount
            conn.commit()
            time.sleep(0.05)
    cur.execute("SELECT MAX(draw_date), COUNT(*) FROM draws")
    new_latest, new_total = cur.fetchone()
    new_days_behind = (today - new_latest).days if new_latest else 999
    status = "✅ OK" if new_days_behind <= 1 else "⚠️ BEHIND"
    body = f"Status: {status}\nDays behind: {new_days_behind}\nBefore: {total:,} (latest: {latest})\nAfter: {new_total:,} (latest: {new_latest})\nAdded: {total_added}"
    print(body)
    send_email(f"{status} Lottery Sync: +{total_added}", body)
    conn.close()
    if new_days_behind > 1: sys.exit(1)

if __name__ == '__main__':
    main()
