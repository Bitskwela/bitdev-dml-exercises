## Dan's Story: The 100% Training Accuracy Trap

Sunday afternoon.

> **Dan:** Ate, 100% train accuracy! 78% test! Should I ship this?
>
> **Ate Rina:** *(silence)*  Bata. You did it again.
>
> **Dan:** What po?
>
> **Ate Rina:** You picked the model that fits training data best. Sus. That's the *opposite* of what to do. Sweep `max_depth` from 1 to 15. Record VALIDATION accuracy for each. Pick the depth that maximizes validation, not training.

He rebuilt with a 3-way split: 60% train, 20% validation, 20% test. Swept `max_depth`. Validation peaked at 4 then dropped. He picked 4. Final test accuracy: 82.3%.

Lower than the 78% he'd been bragging about? No — *higher*. The honest number was higher than the dishonest peak. He wrote in the margin: **The most honest number is the lowest one to find.**

---

## The Concept: Parameters vs Hyperparameters

| Term | Meaning | Example |
|---|---|---|
| **Parameters** | What the model LEARNS | Decision tree splits, LinReg weights |
| **Hyperparameters** | What YOU SET before training | `max_depth`, `n_estimators`, `learning_rate` |

Tuning = trying multiple hyperparameter values; picking the best.

### Three-Way Data Split

```
Original data
   ↓
Train: 60%     Validation: 20%     Test: 20%
   ↓               ↓                   ↓
fit model     pick hyperparams     ONE final score
```

The validation set decides hyperparameters. The test set is touched ONCE at the very end.

### Manual Sweep

```python
for depth in [1, 2, 3, 5, 8, 12]:
    tree = DecisionTreeScratch(max_depth=depth).fit(X_train, y_train)
    val_acc = tree.score(X_val, y_val)
    print(depth, val_acc)
```

Simple, transparent, easy to debug.

### What's a Grid Search?

Try every combination of multiple hyperparameters. E.g., `max_depth ∈ {2,4,8}` × `min_samples_leaf ∈ {1,5,10}` = 9 combinations. Pick the best.

### Random Search (Beyond)

For huge search spaces, sample N random combinations. Often finds 95%-as-good results in 10% of the compute. Standard in sklearn (`RandomizedSearchCV`); we won't implement it from scratch.

---

## Key Takeaways

- **Parameters are learned. Hyperparameters are set.** You tune the latter.
- **Three-way split: train / validation / test.** Tune on validation. Touch test only once.
- **The model that maximizes TRAINING accuracy is usually overfit.** Pick by validation.
- **Best hyperparameter values depend on the data.** Always tune for your specific problem.

---

## What's Next?

A single train/validation split has noise — different splits give different "best" values. The fix: average over multiple splits.

**Next Lesson: Cross Validation** — 5-fold CV in 30 lines.
