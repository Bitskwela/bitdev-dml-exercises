## Dan's Story: One Function from CSV to Score

Late Saturday night. Computer lab. Dan's project folder had become a mess — eight scripts, all loading the same CSV, all engineering the same features, all slightly out of sync.

> **Ate Rina:** Bata, you need a pipeline. One function that takes the raw DataFrame and a model, returns a CV-evaluated, ready-to-deploy result.

He collapsed eight files into one `def run(df, model)`. Forty-five lines. Replaced eight scripts. Now to compare LinReg vs LogReg vs Forest, he called `run(df, LinReg())`, `run(df, LogReg())`, `run(df, Forest())` — same data, same engineering, same split, only the model changes.

He wrote in his notebook: **ML engineering is mostly making yourself replaceable.**

---

## The Concept: One Function from CSV to Score

### Why Pipelines Matter

1. **Consistency.** Every run preprocesses the same way.
2. **Avoidance of leakage.** Fit scalers on train only; transform both train and test with train-fit params.
3. **Reproducibility.** One function = one git commit = one auditable workflow.
4. **Deployment.** Save the entire fitted pipeline as one object — preprocessing + model together.

### The Pattern

```python
def run(df, model, cv=5):
    df = clean(df)
    X, y = engineer(df)
    scores = stratified_kfold_cv(X, y, lambda: clone_of(model), k=cv)
    model.fit(X, y)
    return model, scores.mean(), scores.std()
```

5 lines of actual work. Everything else is helpers.

### Why Pipelines Prevent Leakage

A common mistake:

```python
# WRONG — leakage
X_scaled = StandardScaler().fit_transform(X)   # uses ALL data
X_train, X_test = split(X_scaled, ...)
```

Right approach:

```python
X_train, X_test = split(X, ...)
scaler = StandardScaler().fit(X_train)        # fit on TRAIN only
X_train_s = scaler.transform(X_train)
X_test_s  = scaler.transform(X_test)          # use train-fit params!
```

A pipeline does this automatically — preprocessing steps fit only during training, transform both halves.

---

## Key Takeaways

- **A pipeline turns 8 scripts into 1 function.** Less drift, fewer bugs.
- **Pipelines prevent leakage** by fitting preprocessing on train only.
- **Same data, swap models, apples-to-apples** comparison.
- **Saved pipelines deploy cleanly** — preprocessing + model in one artifact (Lesson 22).

---

## What's Next?

So far: numbers and categories. Tomorrow: TEXT. Tita Malou's mixed Tagalog/English notebook entries. Bag-of-words turns text into numbers; then any classifier you've built works.

**Next Lesson: Intro to NLP in ML** — bag-of-words on Filipino notebook entries.
