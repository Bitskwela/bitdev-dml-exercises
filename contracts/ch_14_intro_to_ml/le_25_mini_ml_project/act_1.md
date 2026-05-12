# Ship Luto v2: Top-3 Ulam Forecaster

The capstone. One script. CSV in, ranked top-3 ulam predictions out.

---

## Acceptance Criteria

- [ ] Loads the inline carinderia CSV
- [ ] Engineers features (`is_payday_int`, `is_friday`, `is_rainy`, `day_of_month`, item one-hots)
- [ ] Splits data 80/20 for honest test evaluation
- [ ] Trains a numpy LinearRegression (Lesson 9) to predict per-row revenue
- [ ] Computes test MAE
- [ ] For tomorrow's `(date, weather, is_payday)`, predicts expected revenue for EACH of 7 ulam items
- [ ] Prints top-3 ranked
- [ ] Sandbox-safe (no sklearn, no disk writes)

---

## The Reference Solution

The starter file has stubs; the answer file ships ~120 lines that meet every acceptance criterion. Your version doesn't have to match — as long as the contract is satisfied.

---

## Sample Output

```
   Loaded 20 rows, engineered 8 features, trained LinRegScratch
   Test MAE: P189 (average revenue P871 → ~22% relative error)

   Forecast for tomorrow (Friday 2026-07-15, payday, rainy):
     1. Sinigang        — expected P1,470  ★
     2. Kare-Kare       — expected P1,318  ★
     3. Adobo           — expected P  990  ★
     4. Lechon Kawali   — expected P  871
     5. Bistek          — expected P  720
     6. Tinola          — expected P  613
     7. Pinakbet        — expected P  482

   ★ Tita Malou, push these tomorrow.
```

---

## Variations Welcome

Your version could:

1. **Use a classifier** instead — for each ulam, predict "will this be a top-3 item tomorrow?"
2. **Train one regressor per ulam** — 7 models, each item-specialized
3. **Add lag features** — yesterday's revenue, last-week mean
4. **Compute confidence intervals** — predict + a ± range

Pick a variation, justify it, ship it.

---

## Reflection Questions

1. The acceptance criteria don't specify which algorithm to use. Why is that — and is that a feature or a bug?
2. Why ship the model serialized rather than just printing predictions inside `act_1.answer.py`?
3. After this course, what's the one Filipino ML problem you'd build for next?

---

## What You've Learned

- The full ML workflow applied to a real business problem
- Acceptance criteria as the contract; algorithm as the implementation choice
- How to ship an ML feature from CSV to ranked prediction

**This is the end of Dan's ML story — but the beginning of yours.**
