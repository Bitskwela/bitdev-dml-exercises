# structure_data.py
# ============================================
# STRUCTURING DATA
# by: <Your Name>
# ============================================
# Take Tita Malou's messy notebook entries
# and convert them into a clean CSV file.
# ============================================

import csv
from io import StringIO

print("=" * 55)
print("  STRUCTURING DATA")
print("  From Tita Malou's messy notebook to clean CSV!")
print("=" * 55)

# ============================================
# PART 1: The Unstructured Data
# ============================================
notebook_entries = [
    "March 1 - Aling Rosa bought Adobo and Rice, paid 70 pesos, cash",
    "March 1 - The guy from the corner, Sinigang + Rice, 85 pesos GCash",
    "March 1 - Mang Pedro, 2 Turon and Buko Juice, 50 pesos cash",
    "March 2 - Group of students, 3 Adobo + Rice, 1 Halo-Halo, 225 total, GCash",
    "March 2 - Regular customer, Bistek + Rice, 90 pesos, cash",
    "March 3 - Rainy today, lots of people bought Sinigang, about 8 orders, 680 total",
]

print("\nTita Malou's Notebook (UNSTRUCTURED):")
print("-" * 55)
for entry in notebook_entries:
    print(f"   >> {entry}")

# ============================================
# PART 2: Manual Conversion to Structured
# ============================================
# TODO: Manually convert each notebook entry into a dict
# with these keys: date, item, quantity, revenue, payment_method
#
# Example:
# {
#     "date": "2026-03-01",
#     "item": "Adobo + Rice",
#     "quantity": 1,
#     "revenue": 70,
#     "payment_method": "cash"
# }

structured_records = [
    # Add your 6+ structured dicts here
]


# ============================================
# PART 3: Write to CSV
# ============================================
# TODO: Use csv.DictWriter to write structured_records to "sales.csv"
# Include a header row.


# ============================================
# PART 4: Read it back
# ============================================
# TODO: Read sales.csv back and print it as a formatted table.


# ============================================
# PART 5: Quick Analysis
# ============================================
# TODO: Compute and print:
#   - Total revenue
#   - Cash vs GCash breakdown
#   - Number of records


print("\n-- Key Insight --")
print("   Structured data is READY for analysis.")
print("   Unstructured data needs processing first.")
print("   That's why we convert whenever possible!")
