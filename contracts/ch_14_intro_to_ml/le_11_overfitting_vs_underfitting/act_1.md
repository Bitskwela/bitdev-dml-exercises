# See the See-Saw

Fit polynomial regressions of degree 1 through 9 to the same data. Watch train error fall monotonically and test error U-shape.

---

## Task 1: Polynomial Feature Builder

Open `act_1.py`. Implement `polynomial_features(X, degree)`:

```python
def polynomial_features(x, degree):
    """Given 1D array x, return matrix [x, x^2, x^3, ..., x^degree]."""
    return np.column_stack([x ** d for d in range(1, degree + 1)])
```

---

## Task 2: Fit and Compare Degrees

For each degree in `[1, 2, 3, 4, 5, 6, 7, 8, 9]`:

1. Build polynomial features
2. Fit your `LinearRegressionScratch` from Lesson 9 on TRAIN
3. Predict on TRAIN and TEST
4. Compute train MAE and test MAE
5. Append to a results list

Print a table.

---

## Sample Output

```
   degree    train_MAE      test_MAE          gap
        1       3210.4        3401.8       191.4
        3       2811.2        2940.1       128.9
        5       2230.1        3520.7      1290.6
        9         20.5       18920.4     18899.9

-- Best degree by test MAE: 3
   Train and test errors close, both low.
   This is the Goldilocks zone.
```

---

## Reflection Questions

1. What happens to TRAIN MAE as degree increases? Why?
2. What happens to TEST MAE? Why does it have a U-shape?
3. The gap (train minus test) becomes huge at degree 9. What does that gap measure?

---

## What You've Learned

- Train MAE always falls with complexity
- Test MAE is U-shaped — find the trough
- The GAP between train and test diagnoses overfitting
