# data_explorer.py
# ============================================
# DATA EXPLORER
# Exploring Tita Malou's carinderia sales data
# Using only Python's built-in csv module
# ============================================

import csv
import os

print("=" * 50)
print("  DATA EXPLORER")
print("  Exploring Tita Malou's carinderia sales data")
print("=" * 50)

# Step 0: We'll generate a small sample dataset inline.
# In a real lesson setup, you would read from an existing CSV.
# This lets you run the lesson without any external files.
SAMPLE_CSV = "sample_sales.csv"

sample_data = [
    ["date", "item", "quantity", "revenue", "day_of_week", "is_payday", "weather"],
    ["2026-01-01", "Sinigang", "10", "800", "Thursday", "False", "rainy"],
    ["2026-01-01", "Adobo", "8", "720", "Thursday", "False", "rainy"],
    ["2026-01-02", "Sinigang", "15", "1200", "Friday", "True", "rainy"],
    ["2026-01-02", "Bistek", "12", "960", "Friday", "True", "rainy"],
    ["2026-01-03", "Adobo", "14", "1260", "Saturday", "False", "sunny"],
    ["2026-01-03", "Kare-Kare", "10", "1100", "Saturday", "False", "sunny"],
    ["2026-01-05", "Tinola", "8", "560", "Monday", "False", "cloudy"],
    ["2026-01-06", "Sinigang", "6", "480", "Tuesday", "False", "sunny"],
    ["2026-01-07", "Adobo", "10", "900", "Wednesday", "False", "cloudy"],
    ["2026-01-15", "Kare-Kare", "18", "1980", "Friday", "True", "sunny"],
]

with open(SAMPLE_CSV, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(sample_data)

# TODO: Step 1 — Open and read the CSV file
# Use csv.DictReader to turn each row into a dictionary.
# Append each row to a list called `rows`.

rows = []
# Your code here


# TODO: Step 2 — Print how many rows were loaded and what columns exist.


# TODO: Step 3 — Peek at the first 5 rows with nicely formatted output.


# TODO: Step 4 — Find the unique menu items using a set().


# TODO: Step 5 — Calculate the total revenue by summing int(row["revenue"]).


# TODO: Step 6 — Find the best-selling item by accumulating quantities in a dict.


# TODO: Step 7 — Compare average revenue on payday vs. non-payday.


print("\n-- Key Insight --")
print("   Data tells stories! Without this data, Tita Malou relies on gut feeling.")
print("   With data, we can make SMARTER predictions.")
print("   This is why DATA is the fuel of AI!")

# Cleanup
if os.path.exists(SAMPLE_CSV):
    os.remove(SAMPLE_CSV)
