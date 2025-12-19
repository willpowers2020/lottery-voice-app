import requests
from bs4 import BeautifulSoup
import psycopg2
import re
from datetime import datetime

DATABASE_URL = "postgresql://postgres.lewvjrlflatexlcndefi:jx4wdz7vQ62ENoCD@aws-1-us-east-1.pooler.supabase.com:5432/postgres"
conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor()

# Florida Pick 5 Evening = game_id 979
game_id = 979

for year in range(2021, 2026):
    url = f"https://www.lotterycorner.com/fl/pick-5-evening/{year}"
    r = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
    soup = BeautifulSoup(r.text, 'html.parser')
    
    added = 0
    for row in soup.find_all('tr'):
        cells = row.find_all('td')
        if len(cells) >= 2:
            try:
                date = datetime.strptime(cells[0].get_text(strip=True), '%B %d, %Y').date()
                digits = re.findall(r'\b(\d)\b', cells[1].get_text())
                if len(digits) == 5:
                    value = '-'.join(digits)
                    sorted_val = '-'.join(sorted(digits))
                    sums = sum(int(d) for d in digits)
                    cur.execute("INSERT INTO draws (game_id, draw_date, value, sorted_value, sums) VALUES (%s,%s,%s,%s,%s) ON CONFLICT DO NOTHING", (game_id, date, value, sorted_val, sums))
                    added += cur.rowcount
            except: pass
    conn.commit()
    print(f"{year}: +{added}")

conn.close()
print("Done!")
