# Three Approaches, Side by Side

Run the SAME prediction task using AI (rules), ML (Random Forest concept), and DL (tiny numpy neural net). Compare accuracy, time, interpretability.

---

## Task 1: AI Rule-Based Baseline

Implement `predict_rules(row)` — hard-coded if-statements that mimic Tita Malou's intuition (busy if payday, else if Friday + rainy, etc.).

---

## Task 2: ML — From-scratch LogReg

Use your Lesson 13 logistic regression. Train, predict, score.

---

## Task 3: DL Preview — Tiny Numpy Neural Net

A small 2-hidden-layer feedforward net (numpy only, no torch/tensorflow — just ReLU + sigmoid + SGD). 8-neuron hidden layers. Train 300 epochs.

---

## Sample Output

```
   Approach         Accuracy   Train time   Interp
   AI (rules)         0.760    0 sec       10/10
   ML (LogReg)        0.872    0.2 sec      8/10
   DL (tiny net)      0.840    1.5 sec      2/10
```

---

## Reflection Questions

1. For 20 rows of tabular data, why does ML often BEAT a tiny DL net?
2. Where does DL DOMINATE? Why doesn't that matter for Tita Malou's problem?
3. Why is "interpretability" a real engineering trade-off — not just a nice-to-have?

---

## What You've Learned

- Where ML lives inside the AI/ML/DL nested-circle structure
- When ML is the right tool (most tabular problems)
- When DL is overkill (small structured datasets) and when it's required (images, text at scale)
