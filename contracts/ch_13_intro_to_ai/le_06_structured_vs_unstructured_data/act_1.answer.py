# structure_data.py
# ============================================
# STRUCTURING DATA — Full Solution
# by Dan Santos
# ============================================

import csv
import os

print("=" * 55)
print("  STRUCTURING DATA")
print("  From Tita Malou's messy notebook to clean CSV!")
print("=" * 55)

# Part 1: Unstructured input
notebook_entries = [
    "March 1 - Aling Rosa bought Adobo and Rice, paid 70 pesos, cash",
    "March 1 - The guy from the corner, Sinigang + Rice, 85 pesos GCash",
    "March 1 - Mang Pedro, 2 Turon and Buko Juice, 50 pesos cash",
    "March 2 - Group of students, 3 Adobo + Rice, 1 Halo-Halo, 225 total, GCash",
    "March 2 - Regular customer, Bistek + Rice, 90 pesos, cash",
    "March 2 - Aling Rosa again! Tinola + Rice, 75 pesos, cash",
    "March 3 - Rainy today, lots of people bought Sinigang, about 8 orders, 680 total",
    "March 3 - The kid next door, just a Banana Cue, 10 pesos, cash",
]

print("\nTita Malou's Notebook (UNSTRUCTURED):")
print("-" * 55)
for entry in notebook_entries:
    print(f"   >> {entry}")

# Part 2: Manual conversion to structured
structured_records = [
    {"date": "2026-03-01", "item": "Adobo + Rice", "quantity": 1, "revenue": 70, "payment_method": "cash"},
    {"date": "2026-03-01", "item": "Sinigang + Rice", "quantity": 1, "revenue": 85, "payment_method": "GCash"},
    {"date": "2026-03-01", "item": "Turon + Buko Juice", "quantity": 2, "revenue": 50, "payment_method": "cash"},
    {"date": "2026-03-02", "item": "Adobo + Rice + Halo-Halo (group)", "quantity": 4, "revenue": 225, "payment_method": "GCash"},
    {"date": "2026-03-02", "item": "Bistek + Rice", "quantity": 1, "revenue": 90, "payment_method": "cash"},
    {"date": "2026-03-02", "item": "Tinola + Rice", "quantity": 1, "revenue": 75, "payment_method": "cash"},
    {"date": "2026-03-03", "item": "Sinigang (bulk)", "quantity": 8, "revenue": 680, "payment_method": "mixed"},
    {"date": "2026-03-03", "item": "Banana Cue", "quantity": 1, "revenue": 10, "payment_method": "cash"},
]

# Part 3: Write to CSV
CSV_FILE = "sales.csv"
with open(CSV_FILE, "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["date", "item", "quantity", "revenue", "payment_method"])
    writer.writeheader()
    writer.writerows(structured_records)

print(f"\n✅ Wrote {len(structured_records)} records to {CSV_FILE}")

# Part 4: Read back and display as table
print("\nStructured Data (readable table):")
print("-" * 75)
print(f"{'Date':12} {'Item':32} {'Qty':>4} {'Revenue':>8} {'Payment':>10}")
print("-" * 75)

with open(CSV_FILE, "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(f"{row['date']:12} {row['item']:32} {row['quantity']:>4} "
              f"P{row['revenue']:>6} {row['payment_method']:>10}")

# Part 5: Quick analysis
total_revenue = sum(int(r["revenue"]) for r in structured_records)
cash_total = sum(int(r["revenue"]) for r in structured_records if r["payment_method"] == "cash")
gcash_total = sum(int(r["revenue"]) for r in structured_records if r["payment_method"] == "GCash")

print(f"\n📊 Analysis:")
print(f"   Total records:   {len(structured_records)}")
print(f"   Total revenue:   P{total_revenue:,}")
print(f"   Cash revenue:    P{cash_total:,}")
print(f"   GCash revenue:   P{gcash_total:,}")
print(f"   Cash %:          {cash_total / total_revenue * 100:.1f}%")
print(f"   GCash %:         {gcash_total / total_revenue * 100:.1f}%")

# Part 6: Data type classifier demo
print("\n" + "=" * 55)
print("  DATA TYPE CLASSIFIER")
print("=" * 55)

samples = [
    ("Tita Malou's handwritten notebook", "Unstructured"),
    ("GCash CSV export", "Structured"),
    ("Facebook menu board photo", "Unstructured (image)"),
    ("JSON from a delivery API", "Semi-structured"),
    ("Voice message on Messenger", "Unstructured (audio)"),
    ("Excel sales report", "Structured"),
    ("Customer review tweet", "Unstructured (text)"),
    ("Barangay resident database", "Structured"),
    ("HTML menu page", "Semi-structured"),
    ("CCTV footage of the carinderia", "Unstructured (video)"),
]

for sample, data_type in samples:
    print(f"   {sample:42} → {data_type}")

# Cleanup
if os.path.exists(CSV_FILE):
    os.remove(CSV_FILE)
