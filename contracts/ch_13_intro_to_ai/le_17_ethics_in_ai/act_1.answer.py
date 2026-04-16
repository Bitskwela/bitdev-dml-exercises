# bias_detector.py
# ============================================
# BIAS DETECTOR — Full Solution
# by Dan Santos
# ============================================

import pandas as pd
import random

random.seed(42)

regions = ["NCR", "Luzon", "Visayas", "Mindanao"]
region_bias = {"NCR": 0.85, "Luzon": 0.65, "Visayas": 0.48, "Mindanao": 0.42}

rows = []
for i in range(100):
    region = random.choice(regions)
    income = random.randint(15000, 80000)
    age = random.randint(21, 60)
    base_prob = region_bias[region]
    income_boost = 0.2 if income > 40000 else 0
    approved = 1 if random.random() < (base_prob + income_boost) else 0
    rows.append({"id": i + 1, "income": income, "age": age,
                 "region": region, "approved": approved})

df = pd.DataFrame(rows)

print("=" * 55)
print("  BIAS DETECTOR — Loan Approvals")
print("=" * 55)
print(f"  Applications: {len(df)}")
print(f"  Overall approval rate: {df['approved'].mean()*100:.1f}%")

# Task 2: Approval rate by region
print("\n-- Approval Rate by Region (raw data) --")
by_region = df.groupby("region")["approved"].mean() * 100
for region, rate in by_region.items():
    bar = "#" * int(rate / 3)
    print(f"   {region:10} {rate:>5.1f}% {bar}")

# Task 3: Control for income
print("\n-- Same income range (30k-45k): is there still a gap? --")
same_income = df[df["income"].between(30000, 45000)]
print(f"   Sample size in this band: {len(same_income)}")
if len(same_income) > 0:
    si_by_region = same_income.groupby("region")["approved"].mean() * 100
    for region, rate in si_by_region.items():
        bar = "#" * int(rate / 3)
        print(f"   {region:10} {rate:>5.1f}% {bar}")

# Task 4: Fair model (income only, ignore region)
def fair_model(income):
    return 1 if income > 35000 else 0

df["fair_prediction"] = df["income"].apply(fair_model)

print("\n-- Fair Model (income only) --")
print(f"   Overall approval: {df['fair_prediction'].mean()*100:.1f}%")
print(f"   By region (should be flat):")
fair_by_region = df.groupby("region")["fair_prediction"].mean() * 100
for region, rate in fair_by_region.items():
    bar = "#" * int(rate / 3)
    print(f"   {region:10} {rate:>5.1f}% {bar}")

# Compare accuracy
agreements = (df["approved"] == df["fair_prediction"]).sum()
print(f"\n   Agreement with biased historical labels: {agreements}/{len(df)} = {agreements/len(df)*100:.1f}%")
print(f"   (Lower agreement is EXPECTED — the fair model refuses to inherit bias.)")

# Task 5: Reusable bias checker
print("\n" + "=" * 55)
print("  REUSABLE BIAS DETECTOR")
print("=" * 55)

def check_bias(df, group_col, outcome_col, threshold=0.15):
    group_rates = df.groupby(group_col)[outcome_col].mean()
    overall = df[outcome_col].mean()
    print(f"\n  Group: {group_col} | Outcome: {outcome_col}")
    print(f"  Overall rate: {overall*100:.1f}%")
    flagged = []
    for group, rate in group_rates.items():
        diff = rate - overall
        marker = ""
        if abs(diff) > threshold:
            marker = "  ⚠️  BIAS FLAG"
            flagged.append(group)
        print(f"    {group:15} {rate*100:>5.1f}%  (diff {diff*100:+.1f}%){marker}")
    if flagged:
        print(f"\n  🚨 Flagged groups with >{int(threshold*100)}% gap: {flagged}")
    else:
        print(f"\n  ✅ No groups exceed the {int(threshold*100)}% bias threshold.")

# Check biased original
check_bias(df, "region", "approved")

# Check fair version
check_bias(df, "region", "fair_prediction")

# Also check by age group
df["age_group"] = pd.cut(df["age"], bins=[20, 30, 40, 50, 60], labels=["21-30", "31-40", "41-50", "51-60"])
check_bias(df, "age_group", "approved")

print("\n  💡 Lesson: biased historical data → biased model → unfair decisions.")
print("     The fair model sacrifices a few % of accuracy to prevent discrimination.")
print("     That tradeoff is worth it. Always.")
