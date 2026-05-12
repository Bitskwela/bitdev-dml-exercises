## Dan's Story: The Sandbox Stack

Saturday morning. Computer lab.

> **Ate Rina:** Bata, you're about to need real tools. Up to now you've used pandas and a sprinkle of numpy. From here on we need the full stack.
>
> **Dan:** Anong stack po?
>
> **Ate Rina:** Inside the bitdev sandbox: **numpy** for math, **pandas** for tables, plus stdlib (`csv`, `io`, `pickle`, `math`, `random`). That's the kit. Locally on your own laptop you can also use scikit-learn — but in this course, we build every algorithm from numpy so you understand what's actually happening.
>
> **Dan:** No tensorflow? No pytorch?
>
> **Ate Rina:** Sus. Not yet. Deep learning is a separate course. For 95% of real ML jobs you ship something useful with numpy + pandas — and never touch a neural net. Build with what's here. Master it. Then add complexity if a problem actually needs it.

Dan smoke-tested the stack. Imports worked. The carinderia data loaded. The DummyClassifier-style baseline (always predict the majority) hit ~68%. *That's the floor every real model has to beat.*

---

## The Concept: What Ships in the Sandbox

| Library | Status | Use it for |
|---|---|---|
| `numpy` | ✅ | All from-scratch ML math, arrays, RNG |
| `pandas` | ✅ | DataFrame loading, `groupby`, feature engineering |
| `csv`, `io`, `pickle`, `math`, `random`, `collections` | ✅ stdlib | CSV via StringIO, model serialization via BytesIO |
| `sklearn` | ❌ not in sandbox | Reimplemented from scratch in numpy in this course |
| `tensorflow`, `torch`, `xgboost` | ❌ | Out of scope for ch_14 |
| `streamlit`, `flask` | ❌ | Out of scope; deploy via `pickle` + `BytesIO` instead |

### The Categorical Encoding Pattern

ML algorithms operate on numbers. To use a string column like `day_of_week`, we need to encode it. The simplest approach: **one-hot encoding** with `pd.get_dummies`:

```python
day_dummies = pd.get_dummies(df["day_of_week"], prefix="day")
df = pd.concat([df, day_dummies], axis=1)
```

One column with 7 string values → 7 new 0/1 columns. The model can now learn a weight per day.

### The Dummy Baseline

Before any real model, train a dummy that always predicts the majority class. Its accuracy is the FLOOR your real model must beat. If your fancy Random Forest gets 67% and the dummy gets 68%, your model is *worse than guessing*.

---

## Key Takeaways

- **The sandbox stack:** numpy + pandas + stdlib (`csv`, `io`, `pickle`, `math`, `random`, `collections`).
- **Sklearn is NOT in the sandbox** — we build every algorithm from scratch in numpy this course.
- **`pd.get_dummies`** is the easy way to one-hot-encode categorical columns.
- **Always train a dummy baseline** before any real model. If you can't beat it, the real model is overhead.

---

## What's Next?

The stack is ready. Dummy baseline hits 68%. Time to build a *real* model — and from scratch in numpy. Tomorrow Dan implements linear regression with `np.linalg.solve` in one line.

**Next Lesson: Linear Regression** — fit a line via the normal equation in ~15 lines of numpy.
