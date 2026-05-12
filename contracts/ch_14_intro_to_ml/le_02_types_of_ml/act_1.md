# Sort Eight Carinderia Problems

Build a small Python helper that classifies a free-form problem statement into one of the three ML types. The helper is itself rule-based — the joke is that you're using rules to teach about *not* using rules. In Lesson 13 you'll replace these keyword checks with an actual classifier.

---

## Task 1: Implement `classify_problem`

Open `act_1.py`. Fill in `classify_problem(description)` so it returns one of:

- `"Supervised regression"` — when the problem asks to predict a NUMBER (`predict revenue`, `forecast quantity`, `how much`...)
- `"Supervised classification"` — when the problem asks to predict a CATEGORY (`classify`, `is this`, `label each`, `busy or slow`...)
- `"Unsupervised"` — when the problem asks to FIND STRUCTURE without labels (`group`, `cluster`, `segment`, `no labels`...)
- `"Reinforcement"` — when the problem learns from FEEDBACK over time (`feedback`, `reward`, `reactions`, `trial and error`...)
- `"Unclear — needs more info"` — fallback

---

## Task 2: Run the Eight Problems

The starter file has 8 problems in a `problems` list. Loop through and print each problem's classification.

Then add 2 more problems of your own (one per type) at the bottom of the list. Run again.

---

## Sample Output

```
=================================================================
  CARINDERIA ML PROBLEM SORTER
=================================================================

   [1] Predict tomorrow's total revenue at the carinderia.
       -> Supervised regression

   [2] Group customers into similar buying types — no labels yet.
       -> Unsupervised

   [3] Classify each sales day as busy, normal, or slow.
       -> Supervised classification

   [4] Make Luto learn which jokes get reactions from Tita Malou.
       -> Reinforcement
   ...
```

---

## Reflection Questions

1. The classifier above is itself a rule-based system. What's brittle about it?
2. If Tita Malou asks *"Find the days that look weirdly different from normal,"* which type is that?
3. Why is *"recommend tomorrow's ulam"* ambiguous — and what extra info would clarify it?

---

## Challenge: A Tricky One

Add this problem to your list: *"Suggest tomorrow's menu items to maximize revenue based on Tita Malou's reactions over a week."*

Will your classifier label it correctly as reinforcement? If not, what keyword would you add to catch it? Notice how easy it is for a rule-based classifier to break.

---

## What You've Learned

- The three ML types and how to spot them from a problem description
- Why rule-based classifiers are brittle (and motivate ML)
- The mapping from "business problem language" to "ML problem type"
