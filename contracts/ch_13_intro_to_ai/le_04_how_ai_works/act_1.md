# Carinderia Sales Predictor

Build a simple AI pipeline! You'll create a "Carinderia Sales Predictor" that takes input data (weather, payday, day, events) and predicts whether sales will be HIGH or LOW.

This mimics the **Data â†’ Model â†’ Output** pipeline using simple rules â€” like coding Tita Malou's 15 years of experience.

---

## Task 1: Build the Basic Predictor

Open `act_1.py`. The starter has three clearly labeled sections. Your job:

1. **STEP 1 (Data)** â€” Collect 4 inputs from the user: weather, is_payday, day, has_event.
2. **STEP 2 (Model)** â€” Apply scoring rules based on those inputs.
3. **STEP 3 (Output)** â€” Translate the total score into a prediction + advice.

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
| â‰¥ 6 | VERY HIGH SALES | Cook extra! Order more ingredients from palengke! |
| â‰¥ 4 | HIGH SALES | Cook 50% more than usual. Prepare extra rice! |
| â‰¥ 2 | NORMAL SALES | Cook the usual amount. Standard prep. |
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
   - `temperature` â€” hot (above 33Â°C) means less foot traffic
   - `is_holiday` â€” public holidays are always busy
   - `school_nearby` â€” students = lunch customers
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

ðŸ”¥ Highest predicted sales: Holiday + Payday Combo (score 10)
ðŸ“‰ Lowest predicted sales:  Quiet Monday (score 1)
```

---

## What You've Learned

Through this activity, you have practiced:

- Building the DATA â†’ MODEL â†’ OUTPUT pipeline in Python
- Designing a scoring-based model (simple rule-based AI)
- Processing batch scenarios with a reusable function
- Understanding why real AI learns rules from data instead of hardcoding them

Next up: **Data in AI** â€” Dan discovers he's been sitting on a goldmine of data at the barangay office.
