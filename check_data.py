#!/usr/bin/env python3
"""
Check if Supabase data is up to date vs lotterycorner.com
"""
import requests
from bs4 import BeautifulSoup
import psycopg2
import re
from datetime import datetime, timedelta
import os

DATABASE_URL = os.environ.get('DATABASE_URL', 'postgresql://postgres.lewvjrlflatexlcndefi:CHANGEME@aws-1-us-east-1.pooler.supabase.com:5432/postgres')

# Sample games to check (one per state)
CHECK_GAMES = [
    ('fl', 'pick-3-evening', 'Florida', 'Pick 3 Evening', 3, 1988),
    ('ga', 'cash-3-evening', 'Georgia', 'Cash 3 Evening', 3, 1993),
    ('tx', 'pick-3-night', 'Texas', 'Pick 3 Night', 3, 1993),
    ('oh', 'pick-3-evening', 'Ohio', 'Pick 3 Evening', 3, 1998),
    ('pa', 'pick-3-evening', 'Pennsylvania', 'Pick 3 Evening', 3, 1977),
    ('ca', 'daily-3-evening', 'California', 'Daily 3 Evening', 3, 1992),
    ('ny', 'numbers-evening', 'New York', 'Numbers Evening', 3, 2008),
    ('nj', 'pick-3-evening', 'New Jersey', 'Pick 3 Evening', 3, 1979),
    ('il', 'pick-3-evening', 'Illinois', 'Pick 3 Evening', 3, 1982),
    ('md', 'pick-3-evening', 'Maryland', 'Pick 3 Evening', 3, 1976),
    ('va', 'pick-3-day', 'Virginia', 'Pick 3 Day', 3, 1989),
    ('dc', 'dc-3-evening', 'Washington, D.C.', 'DC-3 7:50pm', 3, 1983),
    ('mi', 'daily-3-evening', 'Michigan', 'Daily 3 Evening', 3, 1984),
    ('nc', 'pick-3-evening', 'North Carolina', 'Pick 3 Evening', 3, 2006),
    ('sc', 'pick-3-evening', 'South Carolina', 'Pick 3 Evening', 3, 2002),
    ('tn', 'cash-3-morning', 'Tennessee', 'Cash 3 Morning', 3, 2004),
    ('ky', 'pick-3-evening', 'Kentucky', 'Pick 3 Evening', 3, 1998),
    ('in', 'daily3-evening', 'Indiana', 'Daily 3 Evening', 3, 1990),
    ('mo', 'pick-3-evening', 'Missouri', 'Pick 3 Evening', 3, 1998),
    ('la', 'pick-3', 'Louisiana', 'Pick 3', 3, 1992),
    ('ar', 'cash-3-evening', 'Arkansas', 'Cash 3 Evening', 3, 2009),
    ('wi', 'pick-3-evening', 'Wisconsin', 'Pick 3 Evening', 3, 1992),
    ('ia', 'pick-3-evening', 'Iowa', 'Pick 3 Evening', 3, 1998),
    ('ks', 'pick-3', 'Kansas', 'Pick 3', 3, 1998),
    ('ne', 'pick-3', 'Nebraska', 'Pick 3', 3, 2005),
    ('ok', 'pick-3', 'Oklahoma', 'Pick 3', 3, 2005),
    ('mn', 'pick-3', 'Minnesota', 'Pick 3', 3, 1990),
    ('co', 'pick-3', 'Colorado', 'Pick 3', 3, 2013),
    ('az', 'pick-3', 'Arizona', 'Pick 3', 3, 1998),
    ('ct', 'play3-night', 'Connecticut', 'Play 3 Night', 3, 1998),
    ('de', 'play-3-night', 'Delaware', 'Play 3 Night', 3, 1994),
    ('wv', 'daily-3', 'West Virginia', 'Daily 3', 3, 2014),
    ('me', 'tri-state-pick-3-evening', 'Maine', 'Pick 3 Evening', 3, 1985),
    ('ma', 'numbers-game-evening', 'Massachusetts', 'Numbers Evening', 4, 1976),
    ('ri', 'numbers-game-evening', 'Rhode Island', 'Numbers Evening', 4, 2003),
]

def get_lc_latest(state, slug):
    """Get latest date from lotterycorner"""
    year = datetime.now().year
    url = f"https://www.lotterycorner.com/{state}/{slug}/{year}"
    try:
        r = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'}, timeout=10)
        if r.status_code != 200:
            return None
        soup = BeautifulSoup(r.text, 'html.parser')
        for row in soup.find_all('tr'):
            cells = row.find_all('td')
            if len(cells) >= 2:
                try:
                    return datetime.strptime(cells[0].get_text(strip=True), '%B %d, %Y').date()
                except:
                    pass
    except:
        pass
    return None

def check():
    print(f"=== Data Check: {datetime.now().strftime('%Y-%m-%d %H:%M')} ===\n")
    
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    
    cur.execute("SELECT COUNT(*) FROM draws")
    total = cur.fetchone()[0]
    print(f"Total draws in DB: {total:,}\n")
    
    today = datetime.now().date()
    yesterday = today - timedelta(days=1)
    
    ok = []
    behind = []
    missing_history = []
    not_found = []
    
    print(f"{'State':<18} {'Game':<20} {'DB Earliest':<12} {'DB Latest':<12} {'LC Latest':<12} {'Status'}")
    print("-" * 95)
    
    for state_code, slug, state_name, game_pattern, digits, start_year in CHECK_GAMES:
        # Get DB info
        cur.execute("""
            SELECT MIN(d.draw_date), MAX(d.draw_date), COUNT(*)
            FROM draws d
            JOIN games g ON d.game_id = g.id
            JOIN states s ON g.state_id = s.id
            WHERE s.name = %s AND g.name ILIKE %s
        """, (state_name, f'%{game_pattern}%'))
        db_earliest, db_latest, db_count = cur.fetchone()
        
        # Get LC latest
        lc_latest = get_lc_latest(state_code, slug)
        
        # Determine status
        if not db_count or db_count == 0:
            status = "❌ NO DATA"
            not_found.append((state_name, game_pattern))
        elif db_earliest and db_earliest.year > start_year:
            status = f"⚠️  Missing {start_year}-{db_earliest.year-1}"
            missing_history.append((state_name, game_pattern, start_year, db_earliest.year))
        elif lc_latest and db_latest and db_latest < lc_latest:
            days_behind = (lc_latest - db_latest).days
            status = f"⚠️  {days_behind}d behind"
            behind.append((state_name, game_pattern, days_behind))
        elif db_latest and db_latest >= yesterday:
            status = "✅ Current"
            ok.append((state_name, game_pattern))
        else:
            status = "⚠️  Stale"
            behind.append((state_name, game_pattern, 0))
        
        print(f"{state_name:<18} {game_pattern:<20} {str(db_earliest or 'None'):<12} {str(db_latest or 'None'):<12} {str(lc_latest or '?'):<12} {status}")
    
    conn.close()
    
    # Summary
    print(f"\n{'='*60}")
    print(f"SUMMARY")
    print(f"{'='*60}")
    print(f"✅ Current:          {len(ok)}")
    print(f"⚠️  Behind:           {len(behind)}")
    print(f"⚠️  Missing history:  {len(missing_history)}")
    print(f"❌ Not found:        {len(not_found)}")
    
    if missing_history:
        print(f"\n📋 NEED BACKFILL:")
        for state, game, start, earliest in missing_history:
            print(f"   {state} {game}: needs {start}-{earliest-1}")
    
    if behind:
        print(f"\n📋 NEED SYNC:")
        for state, game, days in behind:
            print(f"   {state} {game}: {days} days behind")
    
    if not_found:
        print(f"\n📋 NOT IN DB:")
        for state, game in not_found:
            print(f"   {state} {game}")
    
    # Overall status
    print(f"\n{'='*60}")
    if len(ok) == len(CHECK_GAMES):
        print("🎉 ALL DATA UP TO DATE!")
    elif len(ok) + len(behind) == len(CHECK_GAMES) and all(d <= 1 for _, _, d in behind):
        print("✅ DATA MOSTLY CURRENT (within 1 day)")
    else:
        print("⚠️  ACTION NEEDED - Run backfill_all.py")
    print(f"{'='*60}")

if __name__ == '__main__':
    check()
