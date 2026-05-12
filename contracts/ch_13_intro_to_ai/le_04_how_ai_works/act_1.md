# Carinderia Sales Predictor

Build a simple AI pipeline! You'll create a "Carinderia Sales Predictor" that takes input data (weather, payday, day, events) and predicts whether sales will be HIGH or LOW.

This mimics the **Data → Model → Output** pipeline using simple rules — like coding Tita Malou's 15 years of experience.

---

## Task 1: Build the Basic Predictor

Open `act_1.py`. The starter has three clearly labeled sections. Your job:

1. **STEP 1 (Data)** — Collect 4 inputs from the user: weather, is_payday, day, has_event.
2. **STEP 2 (Model)** — Apply scoring rules based on those inputs.
3. **STEP 3 (Output)** — Translate the total score into a prediction + advice.

### Scoring Rules

| Condition | Points |
|-----------|--------|
| It's payday | +3 |
| Weekend (Sat/Sun) | +2 |
| Friday | +1 |
| Rainy or sunny weather | +1 |
| Event nearby | +3 |

### Prediction Thresholds

| Score | Prediction | Advice |
|-------|-----------|--------|
| ≥ 6 | VERY HIGH SALES | Cook extra! Order more ingredients from palengke! |
| ≥ 4 | HIGH SALES | Cook 50% more than usual. Prepare extra rice! |
| ≥ 2 | NORMAL SALES | Cook the usual amount. Standard prep. |
| < 2 | LOW SALES | Cook less to avoid food waste. Focus on bestsellers. |

### Test Scenarios

Try your predictor with these inputs:

| Scenario | Weather | Payday | Day | Event | Expected |
|----------|---------|--------|-----|-------|----------|
| Rainy payday Friday | rainy | yes | friday | no | HIGH |
| Regular Tuesday | sunny | no | tuesday | no | NORMAL |
| Fiesta weekend | sunny | no | saturday | yes | VERY HIGH |
| Payday + Fiesta | sunny | yes | friday | yes | VERY HIGH |
| Quiet Monday | cloudy | no | monday | no | LOW |

---

## Task 2: Identify the Pipeline

After running your predictor, label each part of your code:

1. Which lines are the **DATA** step?
2. Which lines are the **MODEL** step?
3. Which lines are the **OUTPUT** step?
4. How would real AI be different? (Hint: who writes the rules?)

---

## Challenge: Enhanced Predictor with Batch Scenarios

Level up your sales predictor! Add more input factors AND make it run multiple scenarios automatically.

### Requirements

1. Add three new input factors:
   - `temperature` — hot (above 33°C) means less foot traffic
   - `is_holiday` — public holidays are always busy
   - `school_nearby` — students = lunch customers
2. Create a list of 5 pre-defined scenarios (as dictionaries)
3. Create a `predict_sales(scenario)` function that runs the model
4. Run predictions on all 5 scenarios automatically
5. Display results in a formatted table
6. Report which scenario has the highest/lowest predicted sales

### Challenge Sample Output

```
Scenario                  Score Prediction
---------------------------------------------
Rainy Payday Friday          6  HIGH
Fiesta Weekend               7  VERY HIGH
Quiet Monday                 1  LOW
Holiday + Payday Combo      10  VERY HIGH
Hot Tuesday                  1  LOW
---------------------------------------------

🔥 Highest predicted sales: Holiday + Payday Combo (score 10)
📉 Lowest predicted sales:  Quiet Monday (score 1)
```

---

## What You've Learned

Through this activity, you have practiced:

- Building the DATA → MODEL → OUTPUT pipeline in Python
- Designing a scoring-based model (simple rule-based AI)
- Processing batch scenarios with a reusable function
- Understanding why real AI learns rules from data instead of hardcoding them

Next up: **Data in AI** — Dan discovers he's been sitting on a goldmine of data at the barangay office.

---

<details>
<summary><strong>Answer Key</strong></summary>

### Task 1: Basic Predictor

See the complete Step 1/2/3 implementation in the starter file. Key structure:

```python
# Step 1: Data
weather = input("   What's the weather? (sunny/rainy/cloudy): ").lower().strip()
is_payday = input("   Is it payday today? (yes/no): ").lower().strip() == "yes"
day = input("   What day is it? (monday-sunday): ").lower().strip()
has_event = input("   Is there a fiesta or event nearby? (yes/no): ").lower().strip() == "yes"

# Step 2: Model (scoring)
score = 0
if is_payday: score += 3
if day in ["saturday", "sunday"]: score += 2
elif day == "friday": score += 1
if weather == "rainy": score += 1
elif weather == "sunny": score += 1
if has_event: score += 3

# Step 3: Output
if score >= 6:
    print("Prediction: VERY HIGH SALES")
elif score >= 4:
    print("Prediction: HIGH SALES")
elif score >= 2:
    print("Prediction: NORMAL SALES")
else:
    print("Prediction: LOW SALES")
```

### Task 2: Pipeline Mapping

1. **DATA**: The `input()` calls and variable assignments at the top.
2. **MODEL**: The scoring if-elif chain in the middle.
3. **OUTPUT**: The final prediction print statements.
4. **Real AI difference**: In real AI, the machine would learn these scoring weights from historical data (e.g., 15 years of Tita Malou's sales records), not have them hardcoded by a programmer.

### Challenge: Enhanced Predictor

See `act_1.answer.py` for the full batch scenario processor with the `predict_sales()` function, 5 scenarios, and max/min reporting.

</details>
