# Label Days and Build a Confusion Matrix

Two tasks: (1) turn revenue into busy/normal/slow categories via a `label_day` function; (2) evaluate a toy classifier with a confusion matrix.

---

## Task 1: Implement `label_day(revenue)`

Open `act_1.py`. Fill in:

```python
def label_day(revenue):
    if revenue >= 5000: return "busy"
    if revenue >= 2000: return "normal"
    return "slow"
```

Run it against Dan's 20 hand-labeled rows. How many of your auto-labels match Dan's?

---

## Task 2: Build the Confusion Matrix

The starter has a `predict_toy(is_payday, day_of_week, weather)` function with TODOs. Fill it in with simple rules:

- If `is_payday` → predict `"busy"`
- Else if `weather == "rainy"` and weekend → `"busy"`
- Else if `weather == "rainy"` → `"slow"`
- Else → `"normal"`

Then build a 3×3 numpy confusion matrix comparing the toy classifier's predictions vs. Dan's hand labels.

---

## Sample Output

```
======================================================================
  CONFUSION MATRIX
======================================================================
              pred:busy   pred:normal  pred:slow
   true:busy           4            1          0
   true:normal         0            7          1
   true:slow           0            1          6

   Correct (diagonal): 17
   Total:              20
   Accuracy:           85.0%
```

---

## Reflection Questions

1. Which off-diagonal cells in your matrix have the most errors? What does that tell you about the toy classifier?
2. If 90% of days were labeled "normal," a classifier that always predicts "normal" would score 90% accuracy. What's the catch?
3. Why is a confusion matrix more informative than a single accuracy number?

---

## Challenge: Tune the Thresholds

Change the thresholds in `label_day` to `(₱4000, ₱1500)` or `(₱6000, ₱2500)`. Re-run. How does the class distribution change? How does that affect the toy classifier's accuracy?

The lesson: **labels are a design choice.** Changing thresholds changes the problem.

---

## What You've Learned

- Classification predicts a category, not a number
- Confusion matrices show where the model is wrong, not just how often
- Accuracy can lie on imbalanced data
- Label thresholds are a design decision that shapes the whole problem
