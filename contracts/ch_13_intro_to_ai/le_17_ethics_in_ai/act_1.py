# bias_detector.py
# ============================================
# BIAS DETECTOR
# by: <Your Name>
# ============================================
# Run: pip install pandas

import pandas as pd
import random

random.seed(42)

# Generate biased loan application data
regions = ["NCR", "Luzon", "Visayas", "Mindanao"]
# Bias: NCR applicants approved at 85% regardless of income,
# others approved based on income but with regional penalties
region_bias = {"NCR": 0.85, "Luzon": 0.65, "Visayas": 0.48, "Mindanao": 0.42}

rows = []
for i in range(100):
    region = random.choice(regions)
    income = random.randint(15000, 80000)
    age = random.randint(21, 60)

    # Biased approval logic
    base_prob = region_bias[region]
    income_boost = 0.2 if income > 40000 else 0
    approved = 1 if random.random() < (base_prob + income_boost) else 0

    rows.append({
        "id": i + 1,
        "income": income,
        "age": age,
        "region": region,
        "approved": approved,
    })

df = pd.DataFrame(rows)

print("=" * 55)
print("  BIAS DETECTOR — Loan Approvals")
print("=" * 55)
print(f"  Applications: {len(df)}")

# TODO: Task 2 — Approval rate by region
# by_region = df.groupby("region")["approved"].mean() * 100


# TODO: Task 3 — Control for income
# Filter to a narrow income band (30000-45000) and check regional rates


# TODO: Task 4 — Fair model
# def fair_model(income): return 1 if income > 35000 else 0
# Add a column and compare accuracy + fairness


# TODO: Task 5 — Reusable bias check function
# def check_bias(df, group_col, outcome_col, threshold=0.15):
#     Report groups whose outcome rate differs > threshold from average
