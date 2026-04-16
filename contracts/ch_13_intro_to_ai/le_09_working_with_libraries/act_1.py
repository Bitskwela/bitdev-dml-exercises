# sales_analysis.py
# ============================================
# SALES ANALYSIS WITH PANDAS
# by: <Your Name>
# ============================================
# Run: pip install pandas numpy
# Then: python act_1.py

import pandas as pd
import numpy as np
from io import StringIO

# Generate inline sample data (in real life, load from sales.csv)
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
2026-01-15,Kare-Kare,18,1980,Friday,True,sunny
2026-01-15,Sinigang,20,1300,Friday,True,rainy
2026-01-30,Kare-Kare,22,2420,Friday,True,sunny
"""

df = pd.read_csv(StringIO(SAMPLE_CSV))

print("=" * 50)
print("  SALES ANALYSIS — Tita Malou's Carinderia")
print("=" * 50)

# TODO: Task 1 — Explore the data
# Print df.head(), df.shape, df.info(), df.describe()


# TODO: Task 2 — Best-sellers
# Use groupby to find top item by quantity and by revenue
# Hint: df.groupby("item")["quantity"].sum().sort_values(ascending=False)


# TODO: Task 3 — Payday analysis
# Compare average revenue payday vs non-payday
# Hint: df.groupby("is_payday")["revenue"].mean()


# TODO: Task 4 — Weather effects
# Group by weather, show mean/sum/count of revenue
# Hint: df.groupby("weather")["revenue"].agg(["mean", "sum", "count"])


# TODO: Task 5 — Day of week
# Find busiest day by total revenue
# Hint: df.groupby("day_of_week")["revenue"].sum()
