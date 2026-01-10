#!/usr/bin/env python3
"""
Backfill missing historical lottery data from lotterycorner.com
Runs incrementally - safe to run multiple times
"""
import requests
from bs4 import BeautifulSoup
import psycopg2
import re
from datetime import datetime
import os
import time

DATABASE_URL = os.environ.get('DATABASE_URL', 'postgresql://postgres.lewvjrlflatexlcndefi:jx4wdz7vQ62ENoCD@aws-1-us-east-1.pooler.supabase.com:5432/postgres')

# State code -> (state_name, [(slug, game_id, digits), ...])
# game_id from Supabase
BACKFILL_GAMES = {
    'wv': ('West Virginia', [('daily-3', None, 3), ('daily-4', None, 4)]),
    'la': ('Louisiana', [('pick-3', None, 3), ('pick-4', None, 4), ('pick-5', None, 5)]),
    'me': ('Maine', [('tri-state-pick-3-day', None, 3), ('tri-state-pick-3-evening', None, 3),
                     ('tri-state-pick-4-day', None, 4), ('tri-state-pick-4-evening', None, 4)]),
    'nh': ('New Hampshire', [('tri-state-pick-3-day', None, 3), ('tri-state-pick-3-evening', None, 3),
                              ('tri-state-pick-4-day', None, 4), ('tri-state-pick-4-evening', None, 4)]),
    'vt': ('Vermont', [('tri-state-pick-3-day', None, 3), ('tri-state-pick-3-evening', None, 3),
                       ('tri-state-pick-4-day', None, 4), ('tri-state-pick-4-evening', None, 4)]),
    'ne': ('Nebraska', [('pick-3', None, 3), ('pick-5', None, 5)]),
    'va': ('Virginia', [('pick-3-day', None, 3), ('pick-3-night', None, 3),
                        ('pick-4-day', None, 4), ('pick-4-night', None, 4),
                        ('pick-5-day', None, 5), ('pick-5-night', None, 5)]),
    'ia': ('Iowa', [('pick-3-midday', None, 3), ('pick-3-evening', None, 3),
                    ('pick-4-midday', None, 4), ('pick-4-evening', None, 4)]),
    'wi': ('Wisconsin', [('pick-3-midday', None, 3), ('pick-3-evening', None, 3),
                         ('pick-4-midday', None, 4), ('pick-4-evening', None, 4)]),
    'in': ('Indiana', [('daily3-midday', None, 3), ('daily3-evening', None, 3),
                       ('daily4-midday', None, 4), ('daily4-evening', None, 4)]),
    'ky': ('Kentucky', [('pick-3-midday', None, 3), ('pick-3-evening', None, 3),
                        ('pick-4-midday', None, 4), ('pick-4-evening', None, 4)]),
    'tn': ('Tennessee', [('cash-3-midday', None, 3), ('cash-3-evening', None, 3), ('cash-3-morning', None, 3),
                         ('cash-4-midday', None, 4), ('cash-4-evening', None, 4), ('cash-4-morning', None, 4)]),
    'ar': ('Arkansas', [('cash-3-midday', None, 3), ('cash-3-evening', None, 3),
                        ('cash-4-midday', None, 4), ('cash-4-evening', None, 4)]),
    'mo': ('Missouri', [('pick-3-midday', None, 3), ('pick-3-evening', None, 3),
                        ('pick-4-midday', None, 4), ('pick-4-evening', None, 4)]),
    'ks': ('Kansas', [('pick-3', None, 3), ('pick-3-evening', None, 3)]),
    'ok': ('Oklahoma', [('pick-3', None, 3)]),
    'mn': ('Minnesota', [('pick-3', None, 3)]),
    'ct': ('Connecticut', [('play3-day', None, 3), ('play3-night', None, 3),
                           ('play4-day', None, 4), ('play4-night', None, 4)]),
    'de': ('Delaware', [('play-3-day', None, 3), ('play-3-night', None, 3),
                        ('play-4-day', None, 4), ('play-4-night', None, 4)]),
    'ri': ('Rhode Island', [('numbers-game-midday', None, 4), ('numbers-game-evening', None, 4)]),
    'ma': ('Massachusetts', [('numbers-game-midday', None, 4), ('numbers-game-evening', None, 4)]),
    'az': ('Arizona', [('pick-3', None, 3)]),
    'co': ('Colorado', [('pick-3', None, 3)]),
    'id': ('Idaho', [('pick-3-day', None, 3), ('pick-3-night', None, 3),
                     ('pick-4-day', None, 4), ('pick-4-night', None, 4)]),
}

def find_game_id(cur, state_name, slug):
    """Find game_id from database"""
    name = slug.replace('-', ' ').replace('  ', ' ')
    
    # Special mappings
    if 'daily3' in slug:
        name = 'Daily 3'
    if 'daily4' in slug:
        name = 'Daily 4'
    if 'play3' in slug:
        name = 'Play 3'
    if 'play4' in slug:
        name = 'Play 4'
    if 'cash-3' in slug:
        name = 'Cash 3'
    if 'cash-4' in slug:
        name = 'Cash 4'
    if 'tri-state' in slug:
        num = slug.split('-')[-1]
        if num == 'day':
            num = slug.split('-')[-2]
        name = f'Pick {num}'
    if 'numbers-game' in slug:
        name = 'Numbers Game'
    
    time_patterns = []
    if 'midday' in slug or 'day' in slug:
        time_patterns = ['%Midday%', '%Day%', '%Morning%']
    elif 'evening' in slug or 'night' in slug:
        time_patterns = ['%Evening%', '%Night%']
    
    for tp in (time_patterns or ['%']):
        cur.execute("""
            SELECT g.id FROM games g JOIN states s ON g.state_id = s.id
            WHERE s.name = %s AND g.name ILIKE %s AND g.name ILIKE %s AND g.active = true LIMIT 1
        """, (state_name, f'%{name}%', tp))
        r = cur.fetchone()
        if r:
            return r[0]
    
    # Fallback
    cur.execute("""
        SELECT g.id FROM games g JOIN states s ON g.state_id = s.id
        WHERE s.name = %s AND g.name ILIKE %s AND g.active = true LIMIT 1
    """, (state_name, f'%{name}%'))
    r = cur.fetchone()
    return r[0] if r else None

def scrape_year(state, slug, year, digits):
    """Scrape one year from lotterycorner"""
    url = f"https://www.lotterycorner.com/{state}/{slug}/{year}"
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
                    date = datetime.strptime(cells[0].get_text(strip=True), '%B %d, %Y').date()
                    nums = re.findall(r'\d', cells[1].get_text())[:digits]
                    if len(nums) == digits:
                        value = '-'.join(nums)
                        sorted_val = '-'.join(sorted(nums))
                        sums = sum(int(d) for d in nums)
                        draws.append((date, value, sorted_val, sums))
                except:
                    pass
        return draws
    except:
        return []

def backfill():
    print(f"=== Backfill: {datetime.now()} ===")
    
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    
    cur.execute("SELECT COUNT(*) FROM draws")
    before = cur.fetchone()[0]
    print(f"Before: {before:,} draws")
    
    total_added = 0
    current_year = datetime.now().year
    
    for state_code, (state_name, games) in BACKFILL_GAMES.items():
        state_added = 0
        for slug, _, digits in games:
            game_id = find_game_id(cur, state_name, slug)
            if not game_id:
                print(f"  ⚠️ {state_name} {slug}: game not found")
                continue
            
            # Check earliest date for this game
            cur.execute("SELECT MIN(draw_date) FROM draws WHERE game_id = %s", (game_id,))
            earliest = cur.fetchone()[0]
            
            # Determine years to backfill
            if earliest:
                start_year = 2010
                end_year = earliest.year
            else:
                start_year = 2010
                end_year = current_year + 1
            
            for year in range(start_year, end_year + 1):
                draws = scrape_year(state_code, slug, year, digits)
                added = 0
                for d in draws:
                    cur.execute("""
                        INSERT INTO draws (game_id, draw_date, value, sorted_value, sums)
                        VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING
                    """, (game_id, *d))
                    added += cur.rowcount
                conn.commit()
                if added > 0:
                    state_added += added
                time.sleep(0.1)  # Be nice to server
        
        if state_added > 0:
            print(f"  {state_name}: +{state_added}")
            total_added += state_added
    
    cur.execute("SELECT COUNT(*) FROM draws")
    after = cur.fetchone()[0]
    print(f"\n=== Done: +{total_added:,} draws (total: {after:,}) ===")
    
    conn.close()

if __name__ == '__main__':
    backfill()
