## Dan's Story: The 99% Trap

Friday night. Dan sent Ate Rina a victory screenshot. He had hacked together a quick prediction function on the carinderia data and his Python script printed `Accuracy: 0.989`.

> **Dan:** Ate, 98.9% accuracy on Tita Malou's data. First try!
>
> **Ate Rina:** Did you split your data?
>
> **Dan:** ...
>
> **Ate Rina:** Bata you did not split. Sus. You trained on all 977 rows and then tested on the same 977. That's not a model. That's a memorizer.

She made him stop, undo it, and start over. 80% for training. 20% locked away — never look at it until the very end. With a fixed `random_state` so the split is reproducible.

The new accuracy: 0.71. Not 99%. *That* was the real number.

Dan wrote in his notebook: **The most honest number is the lowest one.**

---

## The Concept: Why We Split

### The Problem

A model evaluated on the same data it was trained on is *guaranteed* to look good. It already saw every row's answer. The 99% means nothing.

### The Fix

Before training, randomly split the data:

```
977 rows
   ↓
Train: 80% (782)    Test: 20% (195) — locked away
```

The model never sees test rows during training. When you finally score on the test set, that number reflects how the model would do on new data.

### The Three Rules of Test Data

1. **Never train on it.**
2. **Never tune hyperparameters against it.** Use a validation set or cross-validation (Lesson 19) for tuning.
3. **Never even peek.** Don't `print(y_test.mean())` to "see what to expect." That biases your design choices.

### Reproducibility with random_state

For numpy's RNG, pass a fixed seed so the "random" shuffle is the same every run:

```python
rng = np.random.default_rng(42)
indices = rng.permutation(len(X))
```

### Stratified Splits for Classification

For imbalanced classes, random splits can leave one fold with too few positive examples. Stratified splits preserve class ratios — split each class into folds separately, then combine. Always use stratified splits for classification.

---

## Key Takeaways

- **Test data is sacred.** Never train on it, never tune against it, never peek.
- **A reproducible split** uses a fixed `random_state` / `seed`.
- **Stratified splits** preserve class balance for classification problems.
- **A single test number is one sample.** Different splits give different numbers (Lesson 19 fixes this with CV).

---

## What's Next?

Dan knows *how* to evaluate honestly. Next he needs the *tools*. Tomorrow: numpy + pandas at the computer lab, plus the from-scratch toolbox we'll use for every algorithm in this chapter.

**Next Lesson: Python for ML** — smoke-test the sandbox stack and load the carinderia data.
