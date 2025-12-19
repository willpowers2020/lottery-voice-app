import requests
from bs4 import BeautifulSoup
import re
from datetime import datetime

url = "https://www.lotterycorner.com/fl/pick-5-evening/2025"
r = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'}, timeout=30)
soup = BeautifulSoup(r.text, 'html.parser')

print("First 10 rows found:")
count = 0
for row in soup.find_all('tr'):
    cells = row.find_all('td')
    if len(cells) >= 2:
        date_text = cells[0].get_text(strip=True)
        nums_text = cells[1].get_text(strip=True)
        digits = re.findall(r'\d', nums_text)
        print(f"  Date: '{date_text}' | Numbers: '{nums_text}' | Digits: {digits}")
        count += 1
        if count >= 10:
            break

print(f"\nTotal rows with 2+ cells: {count}")
