# data_explorer.py
# ============================================
# DATA EXPLORER — Full Solution
# by Dan Santos
# ============================================
# Reads a small sample dataset inline and demonstrates
# CSV reading, dictionary accumulation, and analysis —
# all with Python's built-in csv module.
# ============================================

import csv
from io import StringIO

print("=" * 50)
print("  DATA EXPLORER")
print("  Exploring Tita Malou's carinderia sales data")
print("=" * 50)

# Sample dataset kept inline so the lesson runs anywhere
# (including the in-browser sandbox — no filesystem needed).
SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2026-01-01,Sinigang,10,800,Thursday,False,rainy
2026-01-01,Adobo,8,720,Thursday,False,rainy
2026-01-02,Sinigang,15,1200,Friday,True,rainy
2026-01-02,Bistek,12,960,Friday,True,rainy
2026-01-03,Adobo,14,1260,Saturday,False,sunny
2026-01-03,Kare-Kare,10,1100,Saturday,False,sunny
2026-01-05,Tinola,8,560,Monday,False,cloudy
2026-01-06,Sinigang,6,480,Tuesday,False,sunny
2026-01-07,Adobo,10,900,Wednesday,False,cloudy
2026-01-15,Kare-Kare,18,1980,Friday,True,sunny
2026-01-15,Sinigang,20,1600,Friday,True,rainy
2026-01-30,Kare-Kare,22,2420,Friday,True,sunny
"""

# Step 1: Read the CSV
rows = list(csv.DictReader(StringIO(SAMPLE_CSV)))

print(f"\nLoaded {len(rows)} rows of data!")
print(f"   Columns: {list(rows[0].keys())}")

# Step 2: Peek at the first 5 rows
print("\nFirst 5 rows:")
print("-" * 70)
for row in rows[:5]:
    print(f"   {row['date']} | {row['item']:12s} | Qty: {row['quantity']:>3s} | P{row['revenue']:>6s}")

# Step 3: Unique items using a set
items = set()
for row in rows:
    items.add(row["item"])
print(f"\nUnique menu items sold: {len(items)}")
for item in sorted(items):
    print(f"   - {item}")

# Step 4: Total revenue
total_revenue = 0
for row in rows:
    total_revenue += int(row["revenue"])
print(f"\nTotal Revenue: P{total_revenue:,}")

# Step 5: Best-selling item by quantity
item_quantities = {}
for row in rows:
    item = row["item"]
    qty = int(row["quantity"])
    item_quantities[item] = item_quantities.get(item, 0) + qty

print("\nSales by item (total quantity):")
sorted_items = sorted(item_quantities.items(), key=lambda x: x[1], reverse=True)
for item, qty in sorted_items:
    bar = "#" * (qty // 2)
    print(f"   {item:12s} | {qty:>4d} sold | {bar}")

# Step 6: Payday effect
payday_revenue = 0
payday_count = 0
normal_revenue = 0
normal_count = 0

for row in rows:
    if row["is_payday"] == "True":
        payday_revenue += int(row["revenue"])
        payday_count += 1
    else:
        normal_revenue += int(row["revenue"])
        normal_count += 1

if payday_count > 0 and normal_count > 0:
    avg_payday = payday_revenue / payday_count
    avg_normal = normal_revenue / normal_count
    print(f"\nPayday Effect:")
    print(f"   Average revenue per sale (payday):  P{avg_payday:.0f}")
    print(f"   Average revenue per sale (normal):  P{avg_normal:.0f}")
    print(f"   Payday boost: {((avg_payday / avg_normal) - 1) * 100:.0f}% higher!")

# Challenge 1: Weather effect on sinigang
print("\nCHALLENGE 1: Weather Effect on Sinigang")
print("-" * 45)
sinigang_by_weather = {}
for row in rows:
    if "sinigang" in row["item"].lower():
        weather = row["weather"]
        qty = int(row["quantity"])
        sinigang_by_weather.setdefault(weather, []).append(qty)

for weather, quantities in sorted(sinigang_by_weather.items()):
    avg = sum(quantities) / len(quantities)
    total = sum(quantities)
    print(f"   {weather:>8s}: avg {avg:.1f} per sale, {total} total ({len(quantities)} sales)")

# Challenge 2: Revenue by day of week
print("\nCHALLENGE 2: Revenue by Day of Week")
print("-" * 45)
revenue_by_day = {}
for row in rows:
    day = row["day_of_week"]
    revenue = int(row["revenue"])
    revenue_by_day[day] = revenue_by_day.get(day, 0) + revenue

sorted_days = sorted(revenue_by_day.items(), key=lambda x: x[1], reverse=True)
for day, revenue in sorted_days:
    bar = "#" * (revenue // 200)
    print(f"   {day:10s} | P{revenue:>6,} | {bar}")

if sorted_days:
    best_day = sorted_days[0]
    worst_day = sorted_days[-1]
    print(f"\n   Best day:  {best_day[0]} (P{best_day[1]:,})")
    print(f"   Worst day: {worst_day[0]} (P{worst_day[1]:,})")

print("\n-- Key Insight --")
print("   Data tells stories!")
print("   Without this data, Tita Malou relies on gut feeling.")
print("   With data, we can make SMARTER predictions.")
print("   This is why DATA is the fuel of AI!")
