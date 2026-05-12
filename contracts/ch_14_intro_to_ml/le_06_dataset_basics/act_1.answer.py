# ============================================
# DATASET EXPLORATION — Full Solution
# Lesson 6 by Dan Santos
# ============================================

import pandas as pd
from io import StringIO

SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Bistek,7,665,Friday,False,cloudy
2025-08-01,Lechon Kawali,5,685,Friday,False,cloudy
2025-08-01,Tinola,13,910,Friday,False,cloudy
2025-08-02,Tinola,9,603,Saturday,False,rainy
2025-08-02,Kare-Kare,8,944,Saturday,False,rainy
2025-08-02,Pinakbet,8,496,Saturday,False,rainy
2025-08-02,Adobo,14,1050,Saturday,False,rainy
2025-08-03,Sinigang,15,975,Sunday,False,sunny
2025-08-03,Lechon Kawali,11,1540,Sunday,False,sunny
2025-08-05,Tinola,8,560,Tuesday,False,cloudy
2025-08-06,Adobo,10,820,Wednesday,False,sunny
2025-08-07,Bistek,9,720,Thursday,False,sunny
2025-08-08,Sinigang,12,780,Friday,False,sunny
2025-08-15,Sinigang,21,1575,Friday,True,rainy
2025-08-15,Kare-Kare,14,1652,Friday,True,rainy
2025-08-15,Adobo,16,1240,Friday,True,rainy
2025-08-16,Adobo,12,960,Saturday,False,rainy
2025-08-18,Tinola,6,420,Monday,False,rainy
2025-08-22,Sinigang,11,715,Friday,False,cloudy
2025-08-23,Kare-Kare,10,1180,Saturday,False,sunny
2025-08-25,Pinakbet,5,310,Monday,False,rainy
2025-08-29,Bistek,13,1235,Friday,False,sunny
2025-08-30,Lechon Kawali,15,2100,Saturday,True,sunny
2025-08-30,Kare-Kare,16,1888,Saturday,True,sunny
2025-08-30,Adobo,18,1440,Saturday,True,sunny
2025-09-01,Adobo,11,825,Monday,False,rainy
2025-09-02,Tinola,7,490,Tuesday,False,rainy
2025-09-05,Sinigang,13,845,Friday,False,sunny
2025-09-15,Kare-Kare,18,2124,Monday,True,sunny
2025-09-15,Sinigang,17,1275,Monday,True,sunny
"""

df = pd.read_csv(StringIO(SAMPLE_CSV))

print("=" * 70)
print("  HEAD"); print("=" * 70)
print(df.head().to_string(index=False))

print()
print("=" * 70)
print("  INFO"); print("=" * 70)
df.info()

print()
print("=" * 70)
print("  DESCRIBE"); print("=" * 70)
print(df.describe().round(2).to_string())

print()
for col in ["item", "day_of_week", "weather"]:
    print(f"-- value_counts: {col} --")
    print(df[col].value_counts().to_string())
    print()

# Fix dtypes
df["is_payday"] = df["is_payday"].map({"True": True, "False": False,
                                         True: True, False: False})
df["date"] = pd.to_datetime(df["date"])
print(f"   date dtype:      {df['date'].dtype}")
print(f"   is_payday dtype: {df['is_payday'].dtype}")

# Patterns
print()
print("=" * 70)
print("  Pattern 1 — payday vs non-payday avg revenue")
print("=" * 70)
print(df.groupby("is_payday")["revenue"].mean().round(0).to_string())

print()
print("=" * 70)
print("  Pattern 2 — top sellers on rainy days")
print("=" * 70)
rainy = df[df["weather"] == "rainy"]
print(rainy.groupby("item")["quantity"].sum()
              .sort_values(ascending=False).to_string())

print()
print("=" * 70)
print("  Pattern 3 — revenue by (day_of_week, is_payday)")
print("=" * 70)
print(df.groupby(["day_of_week", "is_payday"])["revenue"]
        .sum().sort_values(ascending=False).head(8).to_string())

print()
print("-- Takeaway --")
print("   Five minutes of pandas exploration reveals patterns")
print("   any model worth training must rediscover.")
