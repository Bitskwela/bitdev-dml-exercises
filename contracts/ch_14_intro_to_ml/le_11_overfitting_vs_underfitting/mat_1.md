## Dan's Story: Three Curves at the Coffee Shop

Saturday afternoon. Dan was experimenting with polynomial features.

| Degree | Train MAE | Test MAE |
|---|---|---|
| 1 | 230 | 232 |
| 3 | 215 | 222 |
| 9 | 18 | **614** |

He stared. Degree 9 — train error nearly zero, test error worse than predicting the mean.

> **Dan:** Ate, look at this. Train almost perfect. Test catastrophic.
>
> **Ate Rina:** Bata, you've just hit overfitting. The model memorized training points so precisely it can't generalize. Like a student who memorized one practice exam — gets 100% on that exam, fails every other one.
>
> **Ate Rina:** Find the sweet spot. Plot train AND test error against complexity. Train goes down monotonically. Test goes down, then bottoms out, then explodes. Pick the trough.

Dan plotted it. The picture was textbook.

---

## The Concept: The Bias-Variance See-Saw

### Underfitting (high bias)

Model too simple. Misses the obvious pattern. Hallmarks:

- High training error
- Similar test error (small gap)
- Adding more data doesn't help

### Overfitting (high variance)

Model too complex. Memorizes noise. Hallmarks:

- Very low training error (sometimes near zero)
- Much higher test error
- **The GAP between train and test is the signal**

### The Goldilocks Zone

- Train and test errors close, both modestly low
- Performance stable when you shuffle the data

You find it by plotting train vs test error against complexity. Bottom of the test U-shape is your target.

### Diagnosis Table

| Train error | Test error | Diagnosis |
|---|---|---|
| High | High (close) | Underfit |
| Low | Low (close) | Just right |
| Very low (~0) | High | Overfit |
| Low | High (small gap) | Mild overfit |

### Regularization (briefly)

`Ridge` regression adds a penalty on weight magnitude — keeps complex models from chasing noise. We won't implement Ridge here; just know that adding `+ alpha * ||w||²` to the loss function reins in overfit.

---

## Key Takeaways

- **Underfit:** too simple. Both errors high.
- **Overfit:** too complex. Train error tiny, test error big. **The gap is the signal.**
- **Sweet spot:** bottom of the test-vs-complexity U-shape.
- **More data tolerates more complexity.** Small data demands simple models.

---

## What's Next?

Polynomial degrees changed complexity. But the biggest gains usually come from *better features*, not more complexity. Tomorrow Dan engineers payday / weather / day-of-week flags and watches MAE drop 30% on the same algorithm.

**Next Lesson: Feature Engineering** — better inputs beat fancier models.
