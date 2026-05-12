## Dan's Story: One Line of Linear Algebra

Friday night. Dan plotted *revenue vs. day_of_month* for the carinderia sample. The scatter was noisy but two patterns jumped out: vertical spikes on the 15th and 30th (payday), plus a faint upward drift.

> **Dan:** Ate, can I fit a line through this?
>
> **Ate Rina:** Tama bata. Linear regression. Find `m` and `b` so `revenue = m·day + b` minimizes total squared error to the points.
>
> **Dan:** How does it find the best line?
>
> **Ate Rina:** One numpy line. `w = np.linalg.solve(X.T @ X, X.T @ y)`. Memorize it. That's literally the math.

Dan wrote 15 lines of class definition. Ran it. The fitted weights matched the closed-form solution exactly. *That's the whole magic.* Not magic. Linear algebra.

---

## The Concept: A Line That Minimizes Squared Error

### The Model

For one feature: `y = m·x + b`. For multiple features: `y = w·X + b`. With a clever trick — prepend a column of all 1s to X — the intercept `b` absorbs into the weight vector. The formula becomes simply `y = X·w`.

### The Normal Equation

Given an `(n × p)` feature matrix X (after adding the all-1s column) and an `(n,)` label vector y, the optimal weights are:

```
w = (Xᵀ · X)⁻¹ · Xᵀ · y
```

In numpy:

```python
w = np.linalg.solve(X.T @ X, X.T @ y)
```

`np.linalg.solve(A, b)` returns `x` such that `A·x = b`. Faster and more numerically stable than computing the inverse.

### When Linear Regression Works

| Works | Fails |
|---|---|
| Roughly linear relationships | Wildly non-linear (sin, log) |
| Numeric features (or one-hot) | Many features mean different things and one-hots blow up |
| Few extreme outliers | Heavy outliers dominate the fit |

For carinderia revenue, linear regression captures payday bumps and Friday boosts *additively* — but can't capture the multiplicative interaction "payday AND Friday is special." Decision trees (Lesson 14) handle that natively.

### Reading the Weights

Each weight has a plain-English meaning. After training:

```
revenue ≈ 795
        + 0.65 × day_of_month
        + 288 × is_payday      ← payday adds ₱288 per row
        + 65 × is_friday        ← Friday adds ₱65
```

You can show this to Tita Malou. That's linear regression's superpower: readable weights.

---

## Key Takeaways

- **Linear regression = weighted sum of features + intercept.** Each weight has plain-English meaning.
- **The normal equation `w = solve(XᵀX, Xᵀy)`** is the entire training algorithm in one numpy call.
- **No iteration needed** — closed-form solution, exact.
- **Captures additive effects** of features. Cannot find interactions without explicit interaction columns.

---

## What's Next?

Dan has a model. But how does he know it's any good? Tomorrow: MAE, MSE, RMSE. The three metrics every regression model is judged by.

**Next Lesson: Model Evaluation** — compute MAE, MSE, RMSE by hand. When to use which.
