#!/usr/bin/env python3
"""
Comprehensive backfill for Supabase - pulls all historical data from lotterycorner.com
"""
import requests
from bs4 import BeautifulSoup
import psycopg2
import re
from datetime import datetime
import time
import os

# Supabase connection
DATABASE_URL = os.environ.get('DATABASE_URL', 'postgresql://postgres.lewvjrlflatexlcndefi:CHANGEME@aws-1-us-east-1.pooler.supabase.com:5432/postgres')

# All games with exact start years from lotterycorner
GAMES = [
    # Florida
    ('fl', 'pick-2-midday', 'Pick 2 Midday', 2, 2016),
    ('fl', 'pick-2-evening', 'Pick 2 Evening', 2, 2016),
    ('fl', 'pick-3-midday', 'Pick 3 Midday', 3, 2008),
    ('fl', 'pick-3-evening', 'Pick 3 Evening', 3, 1988),
    ('fl', 'pick-4-midday', 'Pick 4 Midday', 4, 2008),
    ('fl', 'pick-4-evening', 'Pick 4 Evening', 4, 1991),
    ('fl', 'pick-5-midday', 'Pick 5 Midday', 5, 2016),
    ('fl', 'pick-5-evening', 'Pick 5 Evening', 5, 2016),
    # Georgia
    ('ga', 'cash-3-midday', 'Cash 3 Midday', 3, 1998),
    ('ga', 'cash-3-evening', 'Cash 3 Evening', 3, 1993),
    ('ga', 'cash-4-midday', 'Cash 4 Midday', 4, 2001),
    ('ga', 'cash-4-evening', 'Cash 4 Evening', 4, 1997),
    ('ga', 'georgia-five-midday', 'Georgia Five Midday', 5, 2010),
    ('ga', 'georgia-five-evening', 'Georgia Five Evening', 5, 2010),
    # Texas
    ('tx', 'pick-3-morning', 'Pick 3 Morning', 3, 2013),
    ('tx', 'pick-3-day', 'Pick 3 Day', 3, 2002),
    ('tx', 'pick-3-evening', 'Pick 3 Evening', 3, 2013),
    ('tx', 'pick-3-night', 'Pick 3 Night', 3, 1993),
    ('tx', 'daily-4-morning', 'Daily 4 Morning', 4, 2013),
    ('tx', 'daily-4-day', 'Daily 4 Day', 4, 2007),
    ('tx', 'daily-4-evening', 'Daily 4 Evening', 4, 2013),
    ('tx', 'daily-4-night', 'Daily 4 Night', 4, 2007),
    # Ohio
    ('oh', 'pick-3-midday', 'Pick 3 Midday', 3, 1999),
    ('oh', 'pick-3-evening', 'Pick 3 Evening', 3, 1998),
    ('oh', 'pick-4-midday', 'Pick 4 Midday', 4, 1999),
    ('oh', 'pick-4-evening', 'Pick 4 Evening', 4, 1998),
    ('oh', 'pick-5-midday', 'Pick 5 Midday', 5, 2012),
    ('oh', 'pick-5-evening', 'Pick 5 Evening', 5, 2012),
    # Pennsylvania
    ('pa', 'pick-2-midday', 'Pick 2 Midday', 2, 2015),
    ('pa', 'pick-2-evening', 'Pick 2 Evening', 2, 2015),
    ('pa', 'pick-3-midday', 'Pick 3 Midday', 3, 2003),
    ('pa', 'pick-3-evening', 'Pick 3 Evening', 3, 1977),
    ('pa', 'pick-4-midday', 'Pick 4 Midday', 4, 2003),
    ('pa', 'pick-4-evening', 'Pick 4 Evening', 4, 1980),
    ('pa', 'pick-5-midday', 'Pick 5 Midday', 5, 2008),
    ('pa', 'pick-5-evening', 'Pick 5 Evening', 5, 2008),
    # California
    ('ca', 'daily-3-midday', 'Daily 3 Midday', 3, 2002),
    ('ca', 'daily-3-evening', 'Daily 3 Evening', 3, 1992),
    ('ca', 'daily-4', 'Daily 4', 4, 2008),
    ('ca', 'fantasy-5', 'Fantasy 5', 5, 2001),
    # New York
    ('ny', 'numbers-midday', 'Numbers Midday', 3, 2008),
    ('ny', 'numbers-evening', 'Numbers Evening', 3, 2008),
    ('ny', 'win-4-midday', 'Win 4 Midday', 4, 2008),
    ('ny', 'win-4-evening', 'Win 4 Evening', 4, 2008),
    # New Jersey
    ('nj', 'pick-3-midday', 'Pick 3 Midday', 3, 2001),
    ('nj', 'pick-3-evening', 'Pick 3 Evening', 3, 1979),
    ('nj', 'pick-4-midday', 'Pick 4 Midday', 4, 2001),
    ('nj', 'pick-4-evening', 'Pick 4 Evening', 4, 1977),
    # Illinois
    ('il', 'pick-3-midday', 'Pick 3 Midday', 3, 1993),
    ('il', 'pick-3-evening', 'Pick 3 Evening', 3, 1982),
    ('il', 'pick-4-midday', 'Pick 4 Midday', 4, 1993),
    ('il', 'pick-4-evening', 'Pick 4 Evening', 4, 1982),
    # Maryland
    ('md', 'pick-3-midday', 'Pick 3 Midday', 3, 1995),
    ('md', 'pick-3-evening', 'Pick 3 Evening', 3, 1976),
    ('md', 'pick-4-midday', 'Pick 4 Midday', 4, 1995),
    ('md', 'pick-4-evening', 'Pick 4 Evening', 4, 1983),
    ('md', 'pick-5-midday', 'Pick 5 Midday', 5, 2022),
    ('md', 'pick-5-evening', 'Pick 5 Evening', 5, 2022),
    # Virginia
    ('va', 'pick-3-day', 'Pick 3 Day', 3, 1989),
    ('va', 'pick-3-night', 'Pick 3 Night', 3, 1995),
    ('va', 'pick-4-day', 'Pick 4 Day', 4, 1991),
    ('va', 'pick-4-night', 'Pick 4 Night', 4, 1995),
    ('va', 'pick-5-day', 'Pick 5 Day', 5, 2024),
    ('va', 'pick-5-night', 'Pick 5 Night', 5, 2024),
    # DC
    ('dc', 'dc-2-midday', 'DC-2 1:50pm', 2, 2018),
    ('dc', 'dc-2-evening', 'DC-2 7:50pm', 2, 2018),
    ('dc', 'dc-3-midday', 'DC-3 1:50pm', 3, 1992),
    ('dc', 'dc-3-evening', 'DC-3 7:50pm', 3, 1983),
    ('dc', 'dc-4-midday', 'DC-4 1:50pm', 4, 1992),
    ('dc', 'dc-4-evening', 'DC-4 7:50pm', 4, 1985),
    ('dc', 'dc-5-midday', 'DC-5 1:50pm', 5, 2009),
    ('dc', 'dc-5-evening', 'DC-5 7:50pm', 5, 2009),
    # Michigan
    ('mi', 'daily-3-midday', 'Daily 3 Midday', 3, 1996),
    ('mi', 'daily-3-evening', 'Daily 3 Evening', 3, 1984),
    ('mi', 'daily-4-midday', 'Daily 4 Midday', 4, 1996),
    ('mi', 'daily-4-evening', 'Daily 4 Evening', 4, 1984),
    # North Carolina
    ('nc', 'pick-3-day', 'Pick 3 Day', 3, 2008),
    ('nc', 'pick-3-evening', 'Pick 3 Evening', 3, 2006),
    ('nc', 'pick-4-day', 'Pick 4 Day', 4, 2011),
    ('nc', 'pick-4-evening', 'Pick 4 Evening', 4, 2009),
    # South Carolina
    ('sc', 'pick-3-midday', 'Pick 3 Midday', 3, 2003),
    ('sc', 'pick-3-evening', 'Pick 3 Evening', 3, 2002),
    ('sc', 'pick-4-midday', 'Pick 4 Midday', 4, 2003),
    ('sc', 'pick-4-evening', 'Pick 4 Evening', 4, 2003),
    # Tennessee
    ('tn', 'cash-3-midday', 'Cash 3 Midday', 3, 2013),
    ('tn', 'cash-3-evening', 'Cash 3 Evening', 3, 2005),
    ('tn', 'cash-3-morning', 'Cash 3 Morning', 3, 2004),
    ('tn', 'cash-4-midday', 'Cash 4 Midday', 4, 2013),
    ('tn', 'cash-4-evening', 'Cash 4 Evening', 4, 2005),
    ('tn', 'cash-4-morning', 'Cash 4 Morning', 4, 2005),
    # Kentucky
    ('ky', 'pick-3-midday', 'Pick 3 Midday', 3, 1999),
    ('ky', 'pick-3-evening', 'Pick 3 Evening', 3, 1998),
    ('ky', 'pick-4-midday', 'Pick 4 Midday', 4, 1999),
    ('ky', 'pick-4-evening', 'Pick 4 Evening', 4, 1998),
    # Indiana
    ('in', 'daily3-midday', 'Daily 3 Midday', 3, 2001),
    ('in', 'daily3-evening', 'Daily 3 Evening', 3, 1990),
    ('in', 'daily4-midday', 'Daily 4 Midday', 4, 2001),
    ('in', 'daily4-evening', 'Daily 4 Evening', 4, 1990),
    # Missouri
    ('mo', 'pick-3-midday', 'Pick 3 Midday', 3, 2004),
    ('mo', 'pick-3-evening', 'Pick 3 Evening', 3, 1998),
    ('mo', 'pick-4-midday', 'Pick 4 Midday', 4, 2004),
    ('mo', 'pick-4-evening', 'Pick 4 Evening', 4, 1998),
    # Louisiana
    ('la', 'pick-3', 'Pick 3', 3, 1992),
    ('la', 'pick-4', 'Pick 4', 4, 1999),
    ('la', 'pick-5', 'Pick 5', 5, 2021),
    # Arkansas
    ('ar', 'cash-3-midday', 'Cash 3 Midday', 3, 2009),
    ('ar', 'cash-3-evening', 'Cash 3 Evening', 3, 2009),
    ('ar', 'cash-4-midday', 'Cash 4 Midday', 4, 2010),
    ('ar', 'cash-4-evening', 'Cash 4 Evening', 4, 2010),
    # Wisconsin
    ('wi', 'pick-3-midday', 'Pick 3 Midday', 3, 2020),
    ('wi', 'pick-3-evening', 'Pick 3 Evening', 3, 1992),
    ('wi', 'pick-4-midday', 'Pick 4 Midday', 4, 2020),
    ('wi', 'pick-4-evening', 'Pick 4 Evening', 4, 1997),
    # Iowa
    ('ia', 'pick-3-midday', 'Pick 3 Midday', 3, 2003),
    ('ia', 'pick-3-evening', 'Pick 3 Evening', 3, 1998),
    ('ia', 'pick-4-midday', 'Pick 4 Midday', 4, 2003),
    ('ia', 'pick-4-evening', 'Pick 4 Evening', 4, 2003),
    # Kansas
    ('ks', 'pick-3', 'Pick 3', 3, 1998),
    ('ks', 'pick-3-evening', 'Pick 3 Evening', 3, 2001),
    # Nebraska
    ('ne', 'pick-3', 'Pick 3', 3, 2005),
    ('ne', 'pick-5', 'Pick 5', 5, 2003),
    # Oklahoma
    ('ok', 'pick-3', 'Pick 3', 3, 2005),
    # Minnesota
    ('mn', 'pick-3', 'Pick 3', 3, 1990),
    # Colorado
    ('co', 'pick-3', 'Pick 3', 3, 2013),
    # Arizona
    ('az', 'pick-3', 'Pick 3', 3, 1998),
    # Connecticut
    ('ct', 'play3-day', 'Play 3 Day', 3, 1998),
    ('ct', 'play3-night', 'Play 3 Night', 3, 1998),
    ('ct', 'play4-day', 'Play 4 Day', 4, 1998),
    ('ct', 'play4-night', 'Play 4 Night', 4, 1998),
    # Delaware
    ('de', 'play-3-day', 'Play 3 Day', 3, 1994),
    ('de', 'play-3-night', 'Play 3 Night', 3, 1994),
    ('de', 'play-4-day', 'Play 4 Day', 4, 1994),
    ('de', 'play-4-night', 'Play 4 Night', 4, 1994),
    # West Virginia
    ('wv', 'daily-3', 'Daily 3', 3, 2014),
    ('wv', 'daily-4', 'Daily 4', 4, 2014),
    # Maine
    ('me', 'tri-state-pick-3-day', 'Pick 3 Day', 3, 2003),
    ('me', 'tri-state-pick-3-evening', 'Pick 3 Evening', 3, 1985),
    ('me', 'tri-state-pick-4-day', 'Pick 4 Day', 4, 2003),
    ('me', 'tri-state-pick-4-evening', 'Pick 4 Evening', 4, 1985),
    # New Hampshire
    ('nh', 'tri-state-pick-3-day', 'Pick 3 Day', 3, 2003),
    ('nh', 'tri-state-pick-3-evening', 'Pick 3 Evening', 3, 1985),
    ('nh', 'tri-state-pick-4-day', 'Pick 4 Day', 4, 2003),
    ('nh', 'tri-state-pick-4-evening', 'Pick 4 Evening', 4, 1985),
    # Vermont
    ('vt', 'tri-state-pick-3-day', 'Pick 3 Day', 3, 2003),
    ('vt', 'tri-state-pick-3-evening', 'Pick 3 Evening', 3, 1985),
    ('vt', 'tri-state-pick-4-day', 'Pick 4 Day', 4, 2003),
    ('vt', 'tri-state-pick-4-evening', 'Pick 4 Evening', 4, 1985),
    # Massachusetts
    ('ma', 'numbers-game-midday', 'Numbers Midday', 4, 1976),
    ('ma', 'numbers-game-evening', 'Numbers Evening', 4, 1976),
    # Rhode Island
    ('ri', 'numbers-game-midday', 'Numbers Midday', 4, 2014),
    ('ri', 'numbers-game-evening', 'Numbers Evening', 4, 2003),
]

STATE_NAMES = {
    'fl': 'Florida', 'ga': 'Georgia', 'tx': 'Texas', 'oh': 'Ohio', 'pa': 'Pennsylvania',
    'ca': 'California', 'ny': 'New York', 'nj': 'New Jersey', 'il': 'Illinois',
    'md': 'Maryland', 'va': 'Virginia', 'dc': 'Washington, D.C.', 'mi': 'Michigan',
    'nc': 'North Carolina', 'sc': 'South Carolina', 'tn': 'Tennessee', 'ky': 'Kentucky',
    'in': 'Indiana', 'mo': 'Missouri', 'la': 'Louisiana', 'ar': 'Arkansas',
    'wi': 'Wisconsin', 'ia': 'Iowa', 'ks': 'Kansas', 'ne': 'Nebraska', 'ok': 'Oklahoma',
    'mn': 'Minnesota', 'co': 'Colorado', 'az': 'Arizona', 'ct': 'Connecticut',
    'de': 'Delaware', 'wv': 'West Virginia', 'me': 'Maine', 'nh': 'New Hampshire',
    'vt': 'Vermont', 'ma': 'Massachusetts', 'ri': 'Rhode Island',
}

def find_game_id(cur, state_name, game_pattern):
    """Find game_id in database"""
    cur.execute("""
        SELECT g.id FROM games g JOIN states s ON g.state_id = s.id
        WHERE s.name = %s AND g.name ILIKE %s AND g.active = true LIMIT 1
    """, (state_name, f'%{game_pattern}%'))
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
    except Exception as e:
        print(f"    Error scraping {url}: {e}")
        return []

def backfill():
    print(f"=== Supabase Backfill: {datetime.now()} ===")
    print(f"Database: Supabase\n")
    
    conn = psycopg2.connect(DATABASE_URL)
    conn.autocommit = True
    cur = conn.cursor()
    
    cur.execute("SELECT COUNT(*) FROM draws")
    before = cur.fetchone()[0]
    print(f"Before: {before:,} draws\n")
    
    total_added = 0
    current_year = datetime.now().year
    
    for state_code, slug, game_pattern, digits, start_year in GAMES:
        state_name = STATE_NAMES.get(state_code)
        if not state_name:
            continue
            
        game_id = find_game_id(cur, state_name, game_pattern)
        if not game_id:
            print(f"⚠️  {state_name} {game_pattern}: NOT FOUND in DB")
            continue
        
        # Check current earliest in DB
        cur.execute("SELECT MIN(draw_date), MAX(draw_date), COUNT(*) FROM draws WHERE game_id = %s", (game_id,))
        db_earliest, db_latest, db_count = cur.fetchone()
        
        # Determine years to backfill
        if db_earliest and db_earliest.year <= start_year:
            # Already have all historical data, just check recent
            years_needed = list(range(current_year, current_year + 1))
        else:
            # Need historical backfill
            end_year = db_earliest.year if db_earliest else current_year + 1
            years_needed = list(range(start_year, end_year + 1))
        
        if not years_needed:
            continue
            
        game_added = 0
        for year in years_needed:
            draws = scrape_year(state_code, slug, year, digits)
            for d in draws:
                try:
                    cur.execute("""
                        INSERT INTO draws (game_id, draw_date, value, sorted_value, sums)
                        VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING
                    """, (game_id, *d))
                    game_added += cur.rowcount
                except Exception as e:
                    pass
            time.sleep(0.1)
        
        if game_added > 0:
            print(f"✅ {state_name} {game_pattern}: +{game_added} ({min(years_needed)}-{max(years_needed)})")
            total_added += game_added
    
    cur.execute("SELECT COUNT(*) FROM draws")
    after = cur.fetchone()[0]
    print(f"\n{'='*50}")
    print(f"DONE: Added {total_added:,} draws")
    print(f"Total: {after:,} draws")
    
    conn.close()

if __name__ == '__main__':
    backfill()
