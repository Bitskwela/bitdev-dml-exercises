---
title: "Course 14: Intro to Machine Learning with Python"
description: "Pick up where Course 13 left off. Dan Santos goes from rule-based Luto to a data-driven Luto v2 — building every ML algorithm from scratch in numpy on Tita Malou's eight months of carinderia sales. Sandbox-safe end to end."

# This is the date the document was last updated.
date: "2026-05-30"

# For SEO purposes
tags:
  [
    "machine learning",
    "ml",
    "ai",
    "supervised learning",
    "unsupervised learning",
    "linear regression",
    "logistic regression",
    "decision trees",
    "random forest",
    "k-means",
    "pca",
    "cross validation",
    "feature engineering",
    "model deployment",
    "python",
    "numpy",
    "pandas",
    "bitskwela",
  ]

permaname: "course-14-intro-to-machine-learning"

slug: "course-14-intro-to-machine-learning"
---

# Prologue: From Rules to Patterns 🧠

In Course 13, Dan Santos hand-coded **Luto v1** to recommend ulam using `if-elif` rules. It worked — until Tita Malou ignored it. Why? Because her *gut feeling*, trained on 15 years of carinderia data, was already a smarter "model" than anything Dan could type by hand.

This course is the next chapter. **Two weeks after the TechPinas hackathon**, Tita Malou's 8-month sales notebook becomes the workbench. Dan meets a new mentor — **Ate Rina**, a Marikina sari-sari co-op data analyst — and learns the discipline that turns scribbled receipts into a model that predicts tomorrow's top ulam. From-scratch numpy first, then sklearn-style APIs second. Every lesson runs in the in-browser sandbox.

---

## Course Structure: 25 Lessons Across 5 Modules

### **Module 01: From Rules to Patterns (Lessons 1-6)**

_The Mindset Shift_

- L01: What is Machine Learning?
- L02: Types of ML
- L03: Supervised Learning
- L04: Regression
- L05: Classification
- L06: Dataset Basics

**Master:** what ML actually is, the supervised / unsupervised / reinforcement split, features vs. labels, the difference between predicting numbers and categories, eyeballing a dataset with pandas

---

### **Module 02: Your First Models (Lessons 7-11)**

_Splits, Models, Metrics_

- L07: Train vs Test Split
- L08: Python for ML
- L09: Linear Regression (from scratch)
- L10: Model Evaluation
- L11: Overfitting vs Underfitting

**Master:** why test data is sacred, the numpy + pandas stack, the normal equation in one line, MAE / MSE / RMSE / R², and the bias-variance see-saw

---

### **Module 03: Smarter Models (Lessons 12-17)**

_Feature Engineering and the Tree Family_

- L12: Feature Engineering
- L13: Logistic Regression (from scratch)
- L14: Decision Trees (from scratch)
- L15: Random Forest (bagging)
- L16: K-Means Clustering
- L17: Dimensionality Reduction (PCA)

**Master:** better features beat fancier models, gradient-descent logistic regression, Gini-impurity decision trees, ensemble averaging, unsupervised customer clustering, and SVD-based dimensionality reduction

---

### **Module 04: Production Discipline (Lessons 18-22)**

_Tuning, CV, Pipelines, Deployment_

- L18: Model Tuning
- L19: Cross Validation
- L20: Pipeline Building
- L21: Intro to NLP in ML
- L22: Model Deployment

**Master:** hyperparameter sweeps, 5-fold CV for honest evaluation, an end-to-end `run(df, model)` pipeline, bag-of-words on Tita Malou's notebook, and `pickle` + `BytesIO` for sandbox-safe deployment

---

### **Module 05: Ship Luto v2 (Lessons 23-25)**

_End-to-End and Capstone_

- L23: Real-World ML Workflow
- L24: ML vs AI vs DL
- L25: Mini ML Project — Predict Tomorrow's Top Ulam

**Master:** the full pipeline in one auditable script, where ML lives inside the bigger AI family, and a capstone that ships Luto v2 — a ranked ulam forecaster trained on the 8-month carinderia data

---

## What You'll Build

Across the chapter you'll build progressively richer ML projects:

1. **Rules-vs-examples view** (L01) — see the same logic two ways
2. **First regression baselines** (L04, L09) — beat the mean prediction
3. **First classifier** (L13) — gradient-descent logistic regression in 30 lines
4. **Decision tree from scratch** (L14) — recursive Gini splits, Tita-Malou-readable rules
5. **K-Means customer segmenter** (L16) — find barkada / lola / one-off groups without labels
6. **Bag-of-words notebook classifier** (L21) — sort Tita Malou's mixed Tagalog/English jottings
7. **Luto v2 ulam forecaster** (L25) — the capstone: ranked top-3 ulam predictions for any date

---

## Learning Approach

Each lesson features:

- **Story-driven content** — follow Dan, Tita Malou, Kuya JM, and Ate Rina through the post-hackathon ML journey
- **Locally-themed examples** — Tita Malou's 8-month sales notebook, GCash transactions, weather and payday patterns, jeepney rides
- **From-scratch numpy first** — every algorithm is built up from `np.linalg.solve`, gradient descent, recursive Gini, EM loops, SVD. No black boxes.
- **Hands-on Python practice** — every lesson ships starter code (`act_1.py`) and a sandbox-safe worked solution (`act_1.answer.py`)
- **Self-check quizzes** — 7 questions per lesson with inline answers and explanations
- **Sandbox-safe code** — `io.StringIO` for CSV-style data, `pickle.dumps` for in-memory model serialization, no filesystem writes anywhere

---

## Who Is This For?

**Perfect for:**

- Graduates of Course 13 (Intro to AI) ready for the ML deep dive
- Self-taught coders who want to actually understand what's happening inside `sklearn`
- Filipino learners who want concrete examples, not abstract academic data

**Prerequisites:**

- Course 13: Intro to AI (or equivalent comfort with Python loops, conditionals, lists, dicts, CSV)
- Willingness to keep a notebook next to your laptop while you work

---

## Your Learning Companions

**Dan Santos** — same protagonist as Course 13. Now post-hackathon, slightly humbler, building Luto v2.

**Ate Rina** *(new)* — Marikina sari-sari co-op data analyst Dan met at the hackathon afterparty. Direct, dry, calls Dan "bata." Always asks *"what's your data look like?"* before any model talk.

**Tita Malou** — Dan's mom. Her carinderia notebook is the chapter's main dataset. Her gut feeling is the baseline every model has to beat.

**Kuya JM** — Software-dev cousin. Casual mentor. Returns with Filipino-life analogies (overfitting = memorizing one exam's answer key).

---

## Technologies You'll Touch

**Core (Pyodide-shipped):**

- Python 3 stdlib (csv, io, pickle, math, random, collections)
- `numpy` for all from-scratch ML math
- `pandas` for data loading and feature engineering

**Concepts:**

- Supervised regression and classification
- Unsupervised clustering and dimensionality reduction
- Train/test split, cross-validation, hyperparameter tuning
- Feature engineering and pipeline composition
- Bag-of-words NLP and model serialization

**Explicitly NOT used** (sandbox-incompatible):

- `sklearn`, `scikit-learn` — we build every algorithm from numpy instead
- `tensorflow`, `torch` — deep learning is a separate course
- `streamlit`, `flask` — deployment via `pickle` + `BytesIO` instead

---

## Learning Path

```
Lessons 1-6    → From rules to patterns: the ML mindset
Lessons 7-11   → Splits, first model, first metric, first overfitting
Lessons 12-17  → Feature engineering, trees, clustering, PCA
Lessons 18-22  → Tuning, CV, pipelines, NLP, deployment
Lessons 23-25  → End-to-end workflow + capstone (Luto v2)
```

---

## What Makes This Course Different?

- **Filipino context throughout** — Tita Malou's carinderia, payday rhythms, weather patterns, Marikina co-ops
- **From-scratch first, library second** — you'll implement linear regression, logistic regression, decision trees, k-means, and PCA *by hand* in numpy before any abstraction
- **Sandbox-safe end to end** — every `.answer.py` runs in the browser; no `sklearn`, no disk writes, no streamlit
- **Honest evaluation** — every model is held against a baseline (mean, dummy, Tita Malou's gut); accuracy without a cross-validation std is treated as a lie
- **Continuity from Course 13** — Dan's hackathon arc continues into the post-launch "make Luto smarter" arc

---

## Time Commitment

- **25 lessons** → ~8-12 minutes reading each = 4-5 hours of instruction
- Practice exercises and capstone: 10-15 hours
- **Total estimated time:** 14-20 hours to complete
- **Recommended pace:** 3-5 lessons per week = 5-8 weeks

---

## After This Course

You'll be able to:

- ✅ Implement linear regression, logistic regression, decision trees, random forests, k-means, and PCA from scratch in numpy
- ✅ Split data honestly (train/test/CV) and avoid data leakage
- ✅ Engineer features that move accuracy 30% without changing the algorithm
- ✅ Tune hyperparameters via grid search on a validation set
- ✅ Build an end-to-end ML pipeline in one auditable script
- ✅ Apply bag-of-words classification to Tagalog/English mixed text
- ✅ Serialize and reload models for deployment
- ✅ Ship a working ulam forecaster (Luto v2) trained on 8 months of carinderia data

---

## Let's Begin Your Journey

From "Luto types rules" to "Luto learns from data" in 25 lessons.

It starts with one question Dan asked Ate Rina on a Sunday afternoon: **"What if Luto could find patterns Tita Malou's notebook is hiding from me?"**

And it ends with you shipping **Luto v2** — an ML-powered ulam forecaster Tita Malou actually uses every Sunday.

**Sigi, bata. Start tayo.** 🚀
