# Smoke Test the Sandbox Stack

Confirm numpy + pandas + stdlib work end-to-end on a carinderia sample.

---

## Task 1: Smoke Test

Open `act_1.py`. Import numpy, pandas, plus stdlib (`io`, `csv`, `pickle`). Print their versions where possible.

Load the inline CSV into a DataFrame. One-hot encode `day_of_week`, `weather`, `item`. Derive `is_busy = revenue >= 1200`.

Print:
- `df.shape` after encoding
- Class balance: `is_busy` count vs `not_busy` count

---

## Task 2: Dummy Baseline

Implement:

```python
def dummy_predict_majority(y_train, y_test):
    """Always predict the most-frequent class."""
    majority = ...   # the class that appears most often in y_train
    predictions = np.full_like(y_test, majority)
    return predictions
```

Split data 80/20 (random seed 42), train the dummy, predict on test, compute accuracy.

---

## Sample Output

```
   numpy:  1.26.x
   pandas: 2.2.x
   pickle: stdlib (no version)
   io:     stdlib

   After encoding: 30 rows, 14 columns
   Class balance: busy=8, not_busy=22

   Dummy (majority class) accuracy on test: 0.683
```

---

## Reflection Questions

1. The dummy hits ~68%. What is the next number every real model in this course needs to beat?
2. Why does `pd.get_dummies(drop_first=True)` produce N-1 columns instead of N for a column with N unique values?
3. If you tried `import sklearn` in this sandbox, what would happen?

---

## What You've Learned

- The five-library sandbox stack and why sklearn is intentionally absent
- How to one-hot encode categorical columns with `pd.get_dummies`
- How to compute a dummy baseline as the floor for real models
