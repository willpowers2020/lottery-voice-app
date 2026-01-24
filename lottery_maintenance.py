#!/usr/bin/env python3
"""
Lottery Database Maintenance - All-in-one script
"""
import requests
from bs4 import BeautifulSoup
import psycopg2
import re
from datetime import datetime, timedelta
import time
import os
import sys
import smtplib
from email.mime.text import MIMEText

DATABASE_URL = os.environ.get('DATABASE_URL', 'postgresql://postgres.lewvjrlflatexlcndefi:CHANGEME@aws-1-us-east-1.pooler.supabase.com:5432/postgres')

GAMES = [
    ('fl', 'pick-3-midday', 'Florida', 'Pick 3 Midday', 3, 2008),
    ('fl', 'pick-3-evening', 'Florida', 'Pick 3 Evening', 3, 1988),
    ('fl', 'pick-4-midday', 'Florida', 'Pick 4 Midday', 4, 2008),
    ('fl', 'pick-4-evening', 'Florida', 'Pick 4 Evening', 4, 1991),
    ('fl', 'pick-5-midday', 'Florida', 'Pick 5 Midday', 5, 2016),
    ('fl', 'pick-5-evening', 'Florida', 'Pick 5 Evening', 5, 2016),
    ('ga', 'cash-3-midday', 'Georgia', 'Cash 3 Midday', 3, 1998),
    ('ga', 'cash-3-evening', 'Georgia', 'Cash 3 Evening', 3, 1993),
    ('ga', 'cash-4-midday', 'Georgia', 'Cash 4 Midday', 4, 2001),
    ('ga', 'cash-4-evening', 'Georgia', 'Cash 4 Evening', 4, 1997),
    ('ga', 'georgia-five-midday', 'Georgia', 'Georgia Five Midday', 5, 2010),
    ('ga', 'georgia-five-evening', 'Georgia', 'Georgia Five Evening', 5, 2010),
    ('tx', 'pick-3-morning', 'Texas', 'Pick 3 Morning', 3, 2013),
    ('tx', 'pick-3-day', 'Texas', 'Pick 3 Day', 3, 2002),
    ('tx', 'pick-3-evening', 'Texas', 'Pick 3 Evening', 3, 2013),
    ('tx', 'pick-3-night', 'Texas', 'Pick 3 Night', 3, 1993),
    ('tx', 'daily-4-morning', 'Texas', 'Daily 4 Morning', 4, 2013),
    ('tx', 'daily-4-day', 'Texas', 'Daily 4 Day', 4, 2007),
    ('tx', 'daily-4-evening', 'Texas', 'Daily 4 Evening', 4, 2013),
    ('tx', 'daily-4-night', 'Texas', 'Daily 4 Night', 4, 2007),
    ('oh', 'pick-3-midday', 'Ohio', 'Pick 3 Midday', 3, 1999),
    ('oh', 'pick-3-evening', 'Ohio', 'Pick 3 Evening', 3, 1998),
    ('oh', 'pick-4-midday', 'Ohio', 'Pick 4 Midday', 4, 1999),
    ('oh', 'pick-4-evening', 'Ohio', 'Pick 4 Evening', 4, 1998),
    ('oh', 'pick-5-midday', 'Ohio', 'Pick 5 Midday', 5, 2012),
    ('oh', 'pick-5-evening', 'Ohio', 'Pick 5 Evening', 5, 2012),
    ('pa', 'pick-3-midday', 'Pennsylvania', 'Pick 3 Midday', 3, 2003),
    ('pa', 'pick-3-evening', 'Pennsylvania', 'Pick 3 Evening', 3, 1977),
    ('pa', 'pick-4-midday', 'Pennsylvania', 'Pick 4 Midday', 4, 2003),
    ('pa', 'pick-4-evening', 'Pennsylvania', 'Pick 4 Evening', 4, 1980),
    ('pa', 'pick-5-midday', 'Pennsylvania', 'Pick 5 Midday', 5, 2008),
    ('pa', 'pick-5-evening', 'Pennsylvania', 'Pick 5 Evening', 5, 2008),
    ('ca', 'daily-3-midday', 'California', 'Daily 3 Midday', 3, 2002),
    ('ca', 'daily-3-evening', 'California', 'Daily 3 Evening', 3, 1992),
    ('ca', 'daily-4', 'California', 'Daily 4', 4, 2008),
    ('ca', 'fantasy-5', 'California', 'Fantasy 5', 5, 2001),
    ('ny', 'numbers-midday', 'New York', 'Numbers Midday', 3, 2008),
    ('ny', 'numbers-evening', 'New York', 'Numbers Evening', 3, 2008),
    ('ny', 'win-4-midday', 'New York', 'Win 4 Midday', 4, 2008),
    ('ny', 'win-4-evening', 'New York', 'Win 4 Evening', 4, 2008),
    ('nj', 'pick-3-midday', 'New Jersey', 'Pick 3 Midday', 3, 2001),
    ('nj', 'pick-3-evening', 'New Jersey', 'Pick 3 Evening', 3, 1979),
    ('nj', 'pick-4-midday', 'New Jersey', 'Pick 4 Midday', 4, 2001),
    ('nj', 'pick-4-evening', 'New Jersey', 'Pick 4 Evening', 4, 1977),
    ('il', 'pick-3-midday', 'Illinois', 'Pick 3 Midday', 3, 1993),
    ('il', 'pick-3-evening', 'Illinois', 'Pick 3 Evening', 3, 1982),
    ('il', 'pick-4-midday', 'Illinois', 'Pick 4 Midday', 4, 1993),
    ('il', 'pick-4-evening', 'Illinois', 'Pick 4 Evening', 4, 1982),
    ('md', 'pick-3-midday', 'Maryland', 'Pick 3 Midday', 3, 1995),
    ('md', 'pick-3-evening', 'Maryland', 'Pick 3 Evening', 3, 1976),
    ('md', 'pick-4-midday', 'Maryland', 'Pick 4 Midday', 4, 1995),
    ('md', 'pick-4-evening', 'Maryland', 'Pick 4 Evening', 4, 1983),
    ('md', 'pick-5-midday', 'Maryland', 'Pick 5 Midday', 5, 2022),
    ('md', 'pick-5-evening', 'Maryland', 'Pick 5 Evening', 5, 2022),
    ('va', 'pick-3-day', 'Virginia', 'Pick 3 Day', 3, 1989),
    ('va', 'pick-3-night', 'Virginia', 'Pick 3 Night', 3, 1995),
    ('va', 'pick-4-day', 'Virginia', 'Pick 4 Day', 4, 1991),
    ('va', 'pick-4-night', 'Virginia', 'Pick 4 Night', 4, 1995),
    ('dc', 'dc-3-midday', 'Washington, D.C.', 'DC-3 1:50pm', 3, 1992),
    ('dc', 'dc-3-evening', 'Washington, D.C.', 'DC-3 7:50pm', 3, 1983),
    ('dc', 'dc-4-midday', 'Washington, D.C.', 'DC-4 1:50pm', 4, 1992),
    ('dc', 'dc-4-evening', 'Washington, D.C.', 'DC-4 7:50pm', 4, 1985),
    ('dc', 'dc-5-midday', 'Washington, D.C.', 'DC-5 1:50pm', 5, 2009),
    ('dc', 'dc-5-evening', 'Washington, D.C.', 'DC-5 7:50pm', 5, 2009),
    ('mi', 'daily-3-midday', 'Michigan', 'Daily 3 Midday', 3, 1996),
    ('mi', 'daily-3-evening', 'Michigan', 'Daily 3 Evening', 3, 1984),
    ('mi', 'daily-4-midday', 'Michigan', 'Daily 4 Midday', 4, 1996),
    ('mi', 'daily-4-evening', 'Michigan', 'Daily 4 Evening', 4, 1984),
    ('nc', 'pick-3-day', 'North Carolina', 'Pick 3 Day', 3, 2008),
    ('nc', 'pick-3-evening', 'North Carolina', 'Pick 3 Evening', 3, 2006),
    ('nc', 'pick-4-day', 'North Carolina', 'Pick 4 Day', 4, 2011),
    ('nc', 'pick-4-evening', 'North Carolina', 'Pick 4 Evening', 4, 2009),
    ('sc', 'pick-3-midday', 'South Carolina', 'Pick 3 Midday', 3, 2003),
    ('sc', 'pick-3-evening', 'South Carolina', 'Pick 3 Evening', 3, 2002),
    ('sc', 'pick-4-midday', 'South Carolina', 'Pick 4 Midday', 4, 2003),
    ('sc', 'pick-4-evening', 'South Carolina', 'Pick 4 Evening', 4, 2003),
    ('tn', 'cash-3-midday', 'Tennessee', 'Cash 3 Midday', 3, 2013),
    ('tn', 'cash-3-evening', 'Tennessee', 'Cash 3 Evening', 3, 2005),
    ('tn', 'cash-3-morning', 'Tennessee', 'Cash 3 Morning', 3, 2004),
    ('tn', 'cash-4-midday', 'Tennessee', 'Cash 4 Midday', 4, 2013),
    ('tn', 'cash-4-evening', 'Tennessee', 'Cash 4 Evening', 4, 2005),
    ('ky', 'pick-3-midday', 'Kentucky', 'Pick 3 Midday', 3, 1999),
    ('ky', 'pick-3-evening', 'Kentucky', 'Pick 3 Evening', 3, 1998),
    ('ky', 'pick-4-midday', 'Kentucky', 'Pick 4 Midday', 4, 1999),
    ('ky', 'pick-4-evening', 'Kentucky', 'Pick 4 Evening', 4, 1998),
    ('in', 'daily3-midday', 'Indiana', 'Daily 3 Midday', 3, 2001),
    ('in', 'daily3-evening', 'Indiana', 'Daily 3 Evening', 3, 1990),
    ('in', 'daily4-midday', 'Indiana', 'Daily 4 Midday', 4, 2001),
    ('in', 'daily4-evening', 'Indiana', 'Daily 4 Evening', 4, 1990),
    ('mo', 'pick-3-midday', 'Missouri', 'Pick 3 Midday', 3, 2004),
    ('mo', 'pick-3-evening', 'Missouri', 'Pick 3 Evening', 3, 1998),
    ('mo', 'pick-4-midday', 'Missouri', 'Pick 4 Midday', 4, 2004),
    ('mo', 'pick-4-evening', 'Missouri', 'Pick 4 Evening', 4, 1998),
    ('la', 'pick-3', 'Louisiana', 'Pick 3', 3, 1992),
    ('la', 'pick-4', 'Louisiana', 'Pick 4', 4, 1999),
    ('la', 'pick-5', 'Louisiana', 'Pick 5', 5, 2021),
    ('ar', 'cash-3-midday', 'Arkansas', 'Cash 3 Midday', 3, 2009),
    ('ar', 'cash-3-evening', 'Arkansas', 'Cash 3 Evening', 3, 2009),
    ('ar', 'cash-4-midday', 'Arkansas', 'Cash 4 Midday', 4, 2010),
    ('ar', 'cash-4-evening', 'Arkansas', 'Cash 4 Evening', 4, 2010),
    ('wi', 'pick-3-midday', 'Wisconsin', 'Pick 3 Midday', 3, 2020),
    ('wi', 'pick-3-evening', 'Wisconsin', 'Pick 3 Evening', 3, 1992),
    ('wi', 'pick-4-midday', 'Wisconsin', 'Pick 4 Midday', 4, 2020),
    ('wi', 'pick-4-evening', 'Wisconsin', 'Pick 4 Evening', 4, 1997),
    ('ia', 'pick-3-midday', 'Iowa', 'Pick 3 Midday', 3, 2003),
    ('ia', 'pick-3-evening', 'Iowa', 'Pick 3 Evening', 3, 1998),
    ('ia', 'pick-4-midday', 'Iowa', 'Pick 4 Midday', 4, 2003),
    ('ia', 'pick-4-evening', 'Iowa', 'Pick 4 Evening', 4, 2003),
    ('ks', 'pick-3', 'Kansas', 'Pick 3', 3, 1998),
    ('ne', 'pick-3', 'Nebraska', 'Pick 3', 3, 2005),
    ('ne', 'pick-5', 'Nebraska', 'Pick 5', 5, 2003),
    ('ok', 'pick-3', 'Oklahoma', 'Pick 3', 3, 2005),
    ('mn', 'pick-3', 'Minnesota', 'Pick 3', 3, 1990),
    ('co', 'pick-3', 'Colorado', 'Pick 3', 3, 2013),
    ('az', 'pick-3', 'Arizona', 'Pick 3', 3, 1998),
    ('ct', 'play3-day', 'Connecticut', 'Play 3 Day', 3, 1998),
    ('ct', 'play3-night', 'Connecticut', 'Play 3 Night', 3, 1998),
    ('ct', 'play4-day', 'Connecticut', 'Play 4 Day', 4, 1998),
    ('ct', 'play4-night', 'Connecticut', 'Play 4 Night', 4, 1998),
    ('de', 'play-3-day', 'Delaware', 'Play 3 Day', 3, 1994),
    ('de', 'play-3-night', 'Delaware', 'Play 3 Night', 3, 1994),
    ('de', 'play-4-day', 'Delaware', 'Play 4 Day', 4, 1994),
    ('de', 'play-4-night', 'Delaware', 'Play 4 Night', 4, 1994),
    ('wv', 'daily-3', 'West Virginia', 'Daily 3', 3, 2014),
    ('wv', 'daily-4', 'West Virginia', 'Daily 4', 4, 2014),
    ('me', 'tri-state-pick-3-day', 'Maine', 'Pick 3 Day', 3, 2003),
    ('me', 'tri-state-pick-3-evening', 'Maine', 'Pick 3 Evening', 3, 1985),
    ('me', 'tri-state-pick-4-day', 'Maine', 'Pick 4 Day', 4, 2003),
    ('me', 'tri-state-pick-4-evening', 'Maine', 'Pick 4 Evening', 4, 1985),
    ('nh', 'tri-state-pick-3-day', 'New Hampshire', 'Pick 3 Day', 3, 2003),
    ('nh', 'tri-state-pick-3-evening', 'New Hampshire', 'Pick 3 Evening', 3, 1985),
    ('nh', 'tri-state-pick-4-day', 'New Hampshire', 'Pick 4 Day', 4, 2003),
    ('nh', 'tri-state-pick-4-evening', 'New Hampshire', 'Pick 4 Evening', 4, 1985),
    ('vt', 'tri-state-pick-3-day', 'Vermont', 'Pick 3 Day', 3, 2003),
    ('vt', 'tri-state-pick-3-evening', 'Vermont', 'Pick 3 Evening', 3, 1985),
    ('vt', 'tri-state-pick-4-day', 'Vermont', 'Pick 4 Day', 4, 2003),
    ('vt', 'tri-state-pick-4-evening', 'Vermont', 'Pick 4 Evening', 4, 1985),
    ('ma', 'numbers-game-midday', 'Massachusetts', 'Numbers Game Midday', 4, 1976),
    ('ma', 'numbers-game-evening', 'Massachusetts', 'Numbers Game Evening', 4, 1976),
    ('ri', 'numbers-game-midday', 'Rhode Island', 'Numbers Game Midday', 4, 2014),
    ('ri', 'numbers-game-evening', 'Rhode Island', 'Numbers Game Evening', 4, 2003),
]

def send_email(subject, body):
    EMAIL_TO = os.environ.get('EMAIL_TO')
    EMAIL_FROM = os.environ.get('EMAIL_FROM')
    EMAIL_PASSWORD = os.environ.get('EMAIL_PASSWORD')
    if not all([EMAIL_TO, EMAIL_FROM, EMAIL_PASSWORD]): 
        return
    try:
        msg = MIMEText(body)
        msg['Subject'] = subject
        msg['From'] = EMAIL_FROM
        msg['To'] = EMAIL_TO
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as s:
            s.login(EMAIL_FROM, EMAIL_PASSWORD)
            s.send_message(msg)
        print(f"📧 Email sent")
    except Exception as e:
        print(f"⚠️ Email failed: {e}")

def find_game_id(cur, state_name, game_pattern):
    patterns = [f'%{game_pattern}%']
    if 'Numbers Game' in game_pattern:
        patterns.extend(['%Numbers%Game%', '%Numbers%'])
    if 'Day' in game_pattern:
        patterns.append(game_pattern.replace('Day', 'Midday'))
    if 'Evening' in game_pattern:
        patterns.append(game_pattern.replace('Evening', 'Night'))
    for p in patterns:
        cur.execute("""SELECT g.id FROM games g JOIN states s ON g.state_id = s.id
            WHERE s.name = %s AND g.name ILIKE %s AND g.active = true LIMIT 1""", (state_name, f'%{p}%'))
        r = cur.fetchone()
        if r: return r[0]
    return None

def scrape_year(state, slug, year, digits):
    url = f"https://www.lotterycorner.com/{state}/{slug}/{year}"
    try:
        r = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'}, timeout=15)
        if r.status_code != 200: return []
        soup = BeautifulSoup(r.text, 'html.parser')
        draws = []
        for row in soup.find_all('tr'):
            cells = row.find_all('td')
            if len(cells) >= 2:
                try:
                    date = datetime.strptime(cells[0].get_text(strip=True), '%B %d, %Y').date()
                    nums = re.findall(r'\d', cells[1].get_text())[:digits]
                    if len(nums) == digits:
                        value = '-'.join(nums)
                        sorted_val = '-'.join(sorted(nums))
                        sums = sum(int(d) for d in nums)
                        draws.append((date, value, sorted_val, sums))
                except: pass
        return draws
    except: return []

def run():
    print(f"{'='*60}")
    print(f"🎰 LOTTERY MAINTENANCE - {datetime.now()}")
    print(f"{'='*60}")
    
    try:
        conn = psycopg2.connect(DATABASE_URL)
        conn.autocommit = True
        cur = conn.cursor()
        print("✅ Connected to database")
    except Exception as e:
        print(f"❌ DB CONNECTION FAILED: {e}")
        send_email("❌ Lottery Sync FAILED", f"Database connection failed: {e}")
        sys.exit(1)
    
    cur.execute("SELECT COUNT(*), MAX(draw_date) FROM draws")
    before_count, latest_before = cur.fetchone()
    print(f"📊 Before: {before_count:,} draws, latest: {latest_before}")
    
    # Skip duplicate removal on Supabase (too slow) - use unique index instead
    print("\n📋 Checking for unique index...")
    try:
        cur.execute("""SELECT 1 FROM pg_indexes WHERE tablename='draws' AND indexname='idx_draws_unique'""")
        if not cur.fetchone():
            print("   Creating unique index (this prevents duplicates)...")
            cur.execute("CREATE UNIQUE INDEX CONCURRENTLY IF NOT EXISTS idx_draws_unique ON draws(game_id, draw_date, value)")
            print("   ✅ Index created")
        else:
            print("   ✅ Index exists")
    except Exception as e:
        print(f"   ⚠️ Index check failed: {e}")
    
    print(f"\n📥 SYNCING GAMES...")
    current_year = datetime.now().year
    today = datetime.now().date()
    total_added = 0
    games_synced = 0
    
    for state_code, slug, state_name, game_pattern, digits, start_year in GAMES:
        try:
            game_id = find_game_id(cur, state_name, game_pattern)
            if not game_id: continue
            
            cur.execute("SELECT MIN(draw_date), MAX(draw_date) FROM draws WHERE game_id = %s", (game_id,))
            db_earliest, db_latest = cur.fetchone()
            
            needs_backfill = not db_earliest or db_earliest.year > start_year
            needs_sync = not db_latest or db_latest < today - timedelta(days=1)
            
            if not needs_backfill and not needs_sync: continue
            
            years = []
            if needs_backfill:
                years = list(range(start_year, (db_earliest.year if db_earliest else current_year) + 1))
            if needs_sync:
                years.extend([current_year - 1, current_year])
            years = sorted(set(years))
            
            added = 0
            for year in years:
                for d in scrape_year(state_code, slug, year, digits):
                    try:
                        cur.execute("""INSERT INTO draws (game_id, draw_date, value, sorted_value, sums)
                            VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING""", (game_id, *d))
                        added += cur.rowcount
                    except: pass
                time.sleep(0.05)
            
            if added > 0:
                print(f"   ✅ {state_name} {game_pattern}: +{added}")
                total_added += added
                games_synced += 1
        except Exception as e:
            print(f"   ⚠️ {state_name} {game_pattern}: {e}")
    
    cur.execute("SELECT COUNT(*), MAX(draw_date) FROM draws")
    after_count, latest_after = cur.fetchone()
    
    print(f"\n{'='*60}")
    print(f"📊 After: {after_count:,} draws (+{total_added:,})")
    print(f"📅 Latest: {latest_after}")
    
    # Check if current
    if latest_after and latest_after >= today - timedelta(days=1):
        print("✅ DATA IS CURRENT")
    else:
        print(f"⚠️ DATA MAY BE BEHIND (latest: {latest_after})")
    
    print(f"{'='*60}")
    conn.close()
    sys.exit(0)

if __name__ == '__main__':
    run()
