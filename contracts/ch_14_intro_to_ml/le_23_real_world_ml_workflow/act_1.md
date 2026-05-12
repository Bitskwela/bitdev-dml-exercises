# The Capstone Workflow

One script that walks the full pipeline end-to-end on Tita Malou's data.

---

## Task: Run the Full Workflow

The starter has stubs marking each phase. Fill in each phase using the building blocks from Lessons 6-22:

1. **Load** the inline CSV
2. **Clean** dtypes
3. **Engineer** features (`is_payday_int`, `is_friday`, `is_rainy`, `is_busy`)
4. **Split** 80/20 train/test
5. **CV** three candidate models with stratified 5-fold
6. **Select** the best by CV mean
7. **Fit** the chosen model on all train+val
8. **Test** ONCE on the held-out test
9. **Serialize** with `pickle.dumps`
10. **Forecast** a sample prediction

Print a comparison table and a final summary.

---

## Sample Output

```
   Loaded 20 rows
   After feature engineering: 20 rows, 4 features

   CV scores (5-fold stratified):
     Dummy(majority)        0.700 ± 0.067
     LogReg                 0.800 ± 0.082
     RandomForest(10,d=4)   0.850 ± 0.071

   Best: RandomForest

   Final test accuracy: 0.875
   Model serialized: 2341 bytes

   Forecast for tomorrow (payday Friday rainy):
     prediction: BUSY (prob 0.91)
```

---

## Reflection Questions

1. Why is "one auditable script" better than 8 exploratory notebooks for a DELIVERABLE?
2. Why must CV run on train data only — never on test?
3. The forecast at the bottom is for non-technical stakeholders. What makes it different from the CV scores above?

---

## What You've Learned

- The full ML workflow in one reviewable script
- The 9-11 standard sections in a real-world pipeline
- The 80/20 audit pattern (Lesson 7 + Lesson 19 combined)
