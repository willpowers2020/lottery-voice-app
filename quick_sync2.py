import requests
from bs4 import BeautifulSoup
import psycopg2
import re
from datetime import datetime

DATABASE_URL = "postgresql://postgres.lewvjrlflatexlcndefi:jx4wdz7vQ62ENoCD@aws-1-us-east-1.pooler.supabase.com:5432/postgres"
conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor()

game_id = 979

for year in range(2022, 2026):
    url = f"https://www.lotterycorner.com/fl/pick-5-evening/{year}"
    print(f"Fetching {url}...")
    r = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'}, timeout=30)
    soup = BeautifulSoup(r.text, 'html.parser')
    
    added = 0
    for row in soup.find_all('tr'):
        cells = row.find_all('td')
        if len(cells) >= 2:
            date_text = cells[0].get_text(strip=True)
            nums_text = cells[1].get_text(strip=True)
            try:
                date = datetime.strptime(date_text, '%B %d, %Y').date()
                digits = re.findall(r'\d', nums_text)
                if len(digits) == 5:
                    value = '-'.join(digits)
                    sorted_val = '-'.join(sorted(digits))
                    sums = sum(int(d) for d in digits)
                    cur.execute("INSERT INTO draws (game_id, draw_date, value, sorted_value, sums) VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING", (game_id, date, value, sorted_val, sums))
                    if cur.rowcount > 0:
                        added += 1
            except Exception as e:
                pass
    conn.commit()
    print(f"  {year}: +{added}")

cur.execute("SELECT MAX(draw_date) FROM draws WHERE game_id = 979")
print(f"\nLatest date for FL Pick 5 Evening: {cur.fetchone()[0]}")
conn.close()
