## Dan's Story: The Notebook, Column by Column

Wednesday evening. Dan was on a Discord call with Ate Rina. Tita Malou's notebook open on the kitchen counter. He had finally finished typing out August into a Google Sheet earlier that week.

> **Ate Rina:** Show me the columns.
>
> **Dan:** `date, item, quantity, revenue, day_of_week, is_payday, weather.`
>
> **Ate Rina:** Now: if I asked you to predict revenue for tomorrow — which columns are inputs and which one is the answer?
>
> **Dan:** Inputs: date, item, day_of_week, payday, weather. Answer: revenue.
>
> **Ate Rina:** Tama. Inputs are *features*, written as `X`. Answer is *label*, written as `y`. Capital X (matrix), lowercase y (vector). That's the math convention.
>
> **Ate Rina:** Careful though — don't put `quantity` in the features. `revenue = quantity × price`. If quantity is a feature, the model basically copies the answer. That's data leakage.

Dan wrote in his margin: **What am I predicting? Then everything else is a feature — except things computed from the answer.**

---

## The Concept: Features and Labels

### The Basic Setup

```
Training rows:    (X_1, y_1), (X_2, y_2), ..., (X_n, y_n)
                   ↓
Train a model:    f(X) ≈ y
                   ↓
New unseen row:    X_new
Model predicts:    y_predicted = f(X_new)
```

### Features vs. Labels — Same Data, Different Labels

| Predict... | Label (y) | Features (X) | Forbidden (leakage) |
|---|---|---|---|
| Tomorrow's revenue | `revenue` | date, item, day_of_week, weather, is_payday | `quantity` |
| Is tomorrow busy? | `revenue > 5000` | date, day_of_week, weather, is_payday | `revenue`, `quantity` |
| How many sinigang? | `quantity` (sinigang only) | date, day_of_week, weather, is_payday | `revenue` |

### The Golden Rule: No Time-Travel Features

A feature must be knowable *before* the label exists.

- ✅ Allowed: date, weather forecast, day_of_week, is_payday — known the morning before.
- ❌ Forbidden: `quantity_sold` for revenue prediction — known *during* the day, not before.
- ❌ Forbidden: anything computed from the label itself.

When this rule is broken, it's called **data leakage**. The model looks brilliant during training and embarrassing in production.

---

## Key Takeaways

- **Supervised learning is `(features, label)` per row.** Features = X. Label = y.
- **The same dataset supports many problems** — pick a label, the rest becomes features.
- **Watch for leakage.** Features must be knowable before the label exists.
- **Capital X, lowercase y.** Matrix of features, vector of labels. Universal convention.

---

## What's Next?

Now Dan can split features from labels. Next question: *what kind of label?* If it's a number → regression. If it's a category → classification. Tomorrow he rides home on a Marikina jeepney and sees regression in the wild on his phone's data widget.

**Next Lesson: Regression** — predict next-week sinigang sales with three numpy baselines (mean, median, moving average).
