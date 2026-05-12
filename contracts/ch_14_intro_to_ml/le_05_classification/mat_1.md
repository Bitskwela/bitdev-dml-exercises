## Dan's Story: The Sunday Labels

Sunday afternoon. Tita Malou closed the carinderia early and handed Dan a stack of 20 photocopied notebook pages and a marker.

> **Tita Malou:** Anak, label these. Busy, normal, slow. Write it on top.
>
> **Dan:** Sure ma.

He read the first page. *August 1 — Friday — sunny — 23 orders — ₱2,840.* **NORMAL.** Easy. *August 15 — Friday — rainy — payday — 67 orders — ₱8,920.* **BUSY.** Easy. *August 5 — Tuesday — cloudy — 11 orders — ₱1,160.* **SLOW.**

By page 9 his hand was sore. ₱4,200 on a non-payday Wednesday — busy or normal? He revised three earlier labels. By page 20 he was second-guessing himself constantly.

> **Tita Malou:** *Iyon nga, anak.* That's why I never wrote labels in the notebook. The numbers are easy. The labels are hindi.

Twenty hand-labeled days later he had a new respect for what ML researchers actually do most of the time: labeling.

---

## The Concept: Predicting a Category

### What Classification Is

Classification = supervised learning where the label is a *category*. The set of possible labels is fixed and finite.

| Label set | Type |
|---|---|
| `{busy, normal, slow}` | 3-class |
| `{spam, not_spam}` | binary |
| `{fraud, clean}` | binary |
| `{Sinigang, Adobo, Kare-Kare, ...}` | multi-class |

### The Confusion Matrix

For classification we don't track MAE in pesos. We track *which categories the model confuses* — a 2D grid:

```
                    PREDICTED
                busy  normal  slow
        busy  [ 12     2      0  ]   ← 14 actual busy days, 12 correct
TRUE  normal [  1    15      3  ]   ← 19 actual normal, 15 correct
         slow [  0     4     11  ]   ← 15 actual slow, 11 correct
```

Diagonal = correct. Off-diagonal = errors. Shape tells you *what kind* of errors.

### Accuracy and Its Trap

`accuracy = correct / total`. For the matrix above: `38 / 48 = 79.2%`.

But: imagine 95% of days are *normal*. A classifier that always predicts "normal" hits 95% accuracy without learning anything. For imbalanced data, always read the confusion matrix — not just the headline.

---

## Key Takeaways

- **Classification predicts a category.** Binary (2 outcomes) or multi-class (3+).
- **Labels are work.** Most ML effort is collecting and labeling data, not training models.
- **A confusion matrix shows WHERE you're wrong, not just how often.**
- **Accuracy alone can lie** on imbalanced data — always cross-check with the confusion matrix.

---

## What's Next?

Dan has 20 hand-labeled days. The real notebook has 977 rows. Tomorrow he loads the 8-month CSV into pandas and runs the four exploration functions Ate Rina makes him run BEFORE any model.

**Next Lesson: Dataset Basics** — `head()`, `info()`, `describe()`, `value_counts()`. Five minutes of eyeballing before any modeling.
