## Dan's Story: The Lucky Split

Saturday afternoon.

> **Dan:** Ate, 88% test accuracy. Up from 86% last week.
>
> **Ate Rina:** Did you do CV bata? Or was that one split?
>
> **Dan:** One split.
>
> **Ate Rina:** Run it 5 times with random_state = 1, 2, 3, 4, 5. Tell me the spread.

Dan ran it. Numbers: 0.84, 0.87, 0.88, 0.83, 0.86. Mean ≈ 0.856, std ≈ 0.020.

> **Dan:** Range is 83 to 88. My 88 was a lucky split.
>
> **Ate Rina:** Tama. One number is one sample. Your real model is 86 ± 2 — that's the honest answer. Always report mean and std across multiple splits.

Dan wrote in his margin: **A confidence interval beats a point estimate every time.**

---

## The Concept: K-Fold Cross Validation

### The Core Idea

Instead of one train/test split, do K splits:

1. Shuffle data
2. Divide into 5 equal folds
3. For each fold i: train on the other 4 folds, test on fold i, record score
4. Mean and std of the 5 scores = your real estimate

Each row appears in test exactly once. You get a 5-element score array, not just one number.

### Stratified CV for Classification

For imbalanced data, *random* folds risk leaving one fold with no minority-class rows. **Stratified K-fold** splits each class separately, preserving class ratios in every fold.

### Reading CV Results

- **Mean of scores** — expected real-world performance
- **Std of scores** — uncertainty in that estimate
- **Approximate 95% CI** ≈ mean ± 2·std

If your model is 0.86 ± 0.02 and a competitor's is 0.87 ± 0.05, they are NOT meaningfully different.

### CV ≠ Test Set

CV is for model selection and hyperparameter tuning. After picking your model via CV, you should STILL evaluate ONCE on a held-out test set. The test number is the final report.

---

## Key Takeaways

- **One score is one sample. K-fold CV gives mean ± std.** The honest report.
- **K = 5 is the industry default.** 5× compute for vastly better evaluation reliability.
- **Always use STRATIFIED folds for classification** — preserves class ratio.
- **A 0.01 difference within a 0.02 std is noise**, not improvement.
- **CV doesn't replace test set.** CV is for tuning; test is the final score.

---

## What's Next?

We've done splitting, modeling, evaluation, tuning, CV piece by piece. Tomorrow we wire them into ONE function — the production-pattern pipeline.

**Next Lesson: Pipeline Building** — one `def run(df, model)` ties it all together.
