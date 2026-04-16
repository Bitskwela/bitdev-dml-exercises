# sales_analysis.py
# ============================================
# SALES ANALYSIS WITH PANDAS — Full Solution
# by Dan Santos
# ============================================

import pandas as pd
import numpy as np
from io import StringIO

SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2026-01-01,Adobo,12,720,Thursday,False,sunny
2026-01-01,Sinigang,8,520,Thursday,False,sunny
2026-01-02,Adobo,18,1080,Friday,True,rainy
2026-01-02,Sinigang,15,975,Friday,True,rainy
2026-01-02,Kare-Kare,10,1100,Friday,True,rainy
2026-01-03,Adobo,14,840,Saturday,False,sunny
2026-01-03,Bistek,12,840,Saturday,False,sunny
2026-01-05,Tinola,8,440,Monday,False,cloudy
2026-01-06,Adobo,10,600,Tuesday,False,sunny
2026-01-07,Sinigang,7,455,Wednesday,False,cloudy
2026-01-08,Adobo,11,660,Thursday,False,sunny
2026-01-09,Sinigang,14,910,Friday,False,rainy
2026-01-10,Kare-Kare,12,1320,Saturday,False,sunny
2026-01-15,Kare-Kare,18,1980,Friday,True,sunny
2026-01-15,Sinigang,20,1300,Friday,True,rainy
2026-01-30,Kare-Kare,22,2420,Friday,True,sunny
"""

df = pd.read_csv(StringIO(SAMPLE_CSV))

print("=" * 50)
print("  SALES ANALYSIS — Tita Malou's Carinderia")
print("=" * 50)

# Task 1: Explore
print("\n-- Shape --")
print(f"   Rows: {df.shape[0]}, Columns: {df.shape[1]}")

print("\n-- Head --")
print(df.head())

print("\n-- Describe --")
print(df[["quantity", "revenue"]].describe())

# Task 2: Best-sellers
print("\n-- Top by Quantity --")
by_qty = df.groupby("item")["quantity"].sum().sort_values(ascending=False)
print(by_qty)

print("\n-- Top by Revenue --")
by_rev = df.groupby("item")["revenue"].sum().sort_values(ascending=False)
total_rev = by_rev.sum()
for item, rev in by_rev.items():
    pct = rev / total_rev * 100
    bar = "#" * int(pct // 3)
    print(f"   {item:12} P{rev:>6,} ({pct:5.1f}%) {bar}")

# Task 3: Payday analysis
print("\n-- Payday Effect --")
by_payday = df.groupby("is_payday")["revenue"].mean()
print(by_payday)
if True in by_payday.index and False in by_payday.index:
    boost = (by_payday[True] / by_payday[False] - 1) * 100
    print(f"\n   Payday boost: {boost:.1f}% higher revenue per sale")

# Task 4: Weather effects
print("\n-- Weather Effects --")
by_weather = df.groupby("weather")["revenue"].agg(["mean", "sum", "count"])
print(by_weather)

# Sinigang specifically
sinigang = df[df["item"] == "Sinigang"]
print("\n-- Sinigang by Weather --")
print(sinigang.groupby("weather")["quantity"].agg(["mean", "sum", "count"]))

# Task 5: Day of week
print("\n-- Revenue by Day of Week --")
day_order = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
by_day = df.groupby("day_of_week")["revenue"].sum().reindex(day_order).fillna(0)
for day, rev in by_day.items():
    bar = "#" * int(rev / 200)
    print(f"   {day:10} P{int(rev):>6,} {bar}")

# numpy bonus: fastest single transaction
print("\n-- numpy bonus --")
revenues = df["revenue"].to_numpy()
print(f"   Total:    P{np.sum(revenues):,}")
print(f"   Avg:      P{np.mean(revenues):.0f}")
print(f"   Median:   P{np.median(revenues):.0f}")
print(f"   Max:      P{np.max(revenues):,}")
print(f"   Std dev:  P{np.std(revenues):.0f}")

# Executive Summary — Challenge answers
print("\n" + "=" * 50)
print("  💡 TITA MALOU'S BUSINESS INTELLIGENCE REPORT")
print("=" * 50)

# Best item on rainy days
rainy = df[df["weather"] == "rainy"]
if not rainy.empty:
    rainy_top = rainy.groupby("item")["revenue"].sum().sort_values(ascending=False)
    print(f"\n1. Rainy day star:    {rainy_top.index[0]} (P{rainy_top.iloc[0]:,})")

# Payday % boost
print(f"2. Payday revenue:    +{boost:.0f}% higher per sale")

# Top prep day
top_day = by_day.idxmax()
print(f"3. Cook the most on:  {top_day} (P{int(by_day.max()):,} typical revenue)")

print("\n   Recommendations:")
print(f"   - Always stock extra sinigang on rainy days")
print(f"   - Double prep on paydays (15th & 30th)")
print(f"   - Schedule your strongest staff on {top_day}s")
