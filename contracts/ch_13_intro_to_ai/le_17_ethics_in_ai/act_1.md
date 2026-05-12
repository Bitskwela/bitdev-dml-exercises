# Bias Detector

Build a bias detector for a loan approval dataset. Discover regional discrimination, then build a fair alternative.

---

## Prerequisites

```
pip install pandas
```

---

## Task 1: Generate the Dataset

The starter generates 100 loan applications with fields: `id`, `income`, `age`, `region`, `approved`. The data has hidden bias: NCR applicants approved more often, even at the same income level.

---

## Task 2: Detect Approval Rate by Region

```python
by_region = df.groupby("region")["approved"].mean() * 100
```

If NCR approval is 80%+ while Mindanao is 45%, you have a bias red flag.

---

## Task 3: Control for Income

Filter to a narrow income band and recheck. If the regional gap persists, it's discrimination:

```python
same_income = df[df["income"].between(30000, 45000)]
same_income.groupby("region")["approved"].mean() * 100
```

---

## Task 4: Build a Fair Model

Predict approval based ONLY on income (not region):

```python
def fair_model(income):
    return 1 if income > 35000 else 0
```

Compare accuracy AND regional fairness.

---

## Task 5: Reusable Bias Detector

Write a function that:
- Takes a DataFrame, a protected attribute column, and an outcome column
- Computes outcome rate per group
- Flags groups with >15% gap from the average

---

## Challenge A: Write an AI Ethics Statement

Draft a 5-sentence ethics statement for your hackathon project. Cover fairness, transparency, privacy, accountability, and safety.

---

## Challenge B: Universal Bias Detector

Extend `check_bias()` to work on any categorical column (age groups, gender, region, etc.) and any outcome.

---

## What You've Learned

- Detecting disparate impact across groups
- Controlling for confounders (same income, different regions)
- The accuracy-vs-fairness tradeoff
- Writing responsible AI commitments

Next up: **AI Applications** — Dan brainstorms his hackathon idea.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the full bias detector with generated dataset, income-controlled analysis, fair model comparison, and reusable bias-check function.

</details>
