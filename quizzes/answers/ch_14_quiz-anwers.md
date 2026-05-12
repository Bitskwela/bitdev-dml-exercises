# Chapter 14 - Intro to ML: Quiz Answer Key

Source: 25 per-lesson `quiz.md` files in `contracts/ch_14_intro_to_ml/le_*/`.
This file aggregates every question, answer, and explanation in one place for instructors and reviewers.

## Table of Contents
1. [Lesson 1 - What is Machine Learning?](#lesson-1---what-is-machine-learning)
2. [Lesson 2 - Types of ML](#lesson-2---types-of-ml)
3. [Lesson 3 - Supervised Learning](#lesson-3---supervised-learning)
4. [Lesson 4 - Regression](#lesson-4---regression)
5. [Lesson 5 - Classification](#lesson-5---classification)
6. [Lesson 6 - Dataset Basics](#lesson-6---dataset-basics)
7. [Lesson 7 - Train vs Test Split](#lesson-7---train-vs-test-split)
8. [Lesson 8 - Python for ML](#lesson-8---python-for-ml)
9. [Lesson 9 - Linear Regression](#lesson-9---linear-regression)
10. [Lesson 10 - Model Evaluation](#lesson-10---model-evaluation)
11. [Lesson 11 - Overfitting vs Underfitting](#lesson-11---overfitting-vs-underfitting)
12. [Lesson 12 - Feature Engineering](#lesson-12---feature-engineering)
13. [Lesson 13 - Logistic Regression](#lesson-13---logistic-regression)
14. [Lesson 14 - Decision Trees](#lesson-14---decision-trees)
15. [Lesson 15 - Random Forest](#lesson-15---random-forest)
16. [Lesson 16 - K-Means Clustering](#lesson-16---k-means-clustering)
17. [Lesson 17 - Dimensionality Reduction (PCA)](#lesson-17---dimensionality-reduction-pca)
18. [Lesson 18 - Model Tuning](#lesson-18---model-tuning)
19. [Lesson 19 - Cross Validation](#lesson-19---cross-validation)
20. [Lesson 20 - Pipeline Building](#lesson-20---pipeline-building)
21. [Lesson 21 - Intro to NLP in ML](#lesson-21---intro-to-nlp-in-ml)
22. [Lesson 22 - Model Deployment](#lesson-22---model-deployment)
23. [Lesson 23 - Real-world ML Workflow](#lesson-23---real-world-ml-workflow)
24. [Lesson 24 - ML vs AI vs DL](#lesson-24---ml-vs-ai-vs-dl)
25. [Lesson 25 - Mini ML Project](#lesson-25---mini-ml-project)

---

## Lesson 1 - What is Machine Learning?

---
### Quiz 1
#### Scenario: Dan's First DM to Ate Rina

Two weeks after the hackathon, Dan messages Ate Rina about Tita Malou's notebook. He wants Luto to learn from data instead of from typed rules. Help him check his understanding.

**Question 1:** Which statement BEST describes Machine Learning?
A. A way to write better if-elif chains
B. A way for a computer to discover rules from examples instead of being given them
C. A specific Python library
D. Any program that uses random numbers

**Answer:** B
**Explanation:** ML is exactly the inversion of traditional programming. Instead of you writing rules, you give the computer examples and let it learn the rules.

---

**Question 2:** Tita Malou knows that rainy Fridays sell more sinigang. Ate Rina says she is "already a model." What does she mean?
A. Tita Malou is literally a computer
B. Tita Malou has been "trained" by 15 years of carinderia data — she infers rules from experience the same way ML does
C. Tita Malou wrote the rules down somewhere
D. Tita Malou's intuition is random

**Answer:** B
**Explanation:** Tita Malou's gut feeling is the human version of an ML model — patterns extracted from years of observations.

---

**Question 3:** Which of these is NOT one of the three steps every ML project has?
A. Get data
B. Train a model
C. Use the model
D. Re-write the rules every Monday

**Answer:** D
**Explanation:** The three steps are: get data, train a model, use the model. Re-writing rules is the *opposite* of ML.

---

**Question 4:** Lazada's search bar interprets "pang work na sapatos" as a query for office shoes. How did it learn that mapping?
A. A Lazada engineer typed every Filipino-English phrase by hand
B. From billions of past clicks: people who searched that way ended up clicking on office shoes
C. It's a coincidence
D. From a Tagalog-English dictionary lookup

**Answer:** B
**Explanation:** Search models learn from user behavior. The mapping from query to product comes from data, not hand-coded translations.

---

### Quiz 2
#### Scenario: Scaling Up Luto

Dan considers what it would take to scale Luto's logic to 12 dishes, 4 weather types, 7 days of the week, and a payday flag. He has to decide between the rules approach and the examples approach.

**Question 5:** Roughly how many if-elif cases would Dan need to cover every combination?
A. 12
B. About 70
C. About 670
D. Just one — `if anything: return "Adobo"`

**Answer:** C
**Explanation:** 4 × 7 × 2 × 12 = 672 combinations. Writing each one as a rule is impractical — exactly the scaling problem ML solves.

---

**Question 6:** Which approach is easier when Tita Malou adds a brand-new dish, "Pansit Palabok"?
A. Rule-based — Dan just adds a new if-statement
B. Example-based — Dan adds a few rows of `(features, "Pansit Palabok")` to the training data
C. They're equally hard
D. Neither — Dan has to start from scratch

**Answer:** B
**Explanation:** With examples, you simply add new rows; the model retrains. With rules, you'd have to carefully insert if-statements in the right places to avoid breaking other paths.

---

**Question 7:** In the rule-based approach, where do the rules come from? In the ML approach, where do they come from?
A. Both come from the data
B. Both come from the programmer
C. Rule-based: from the programmer. ML: from the data.
D. Rule-based: from the data. ML: from the programmer.

**Answer:** C
**Explanation:** That's the central inversion. Traditional programming = humans encode rules. ML = the computer extracts rules from data.

---

---

## Lesson 2 - Types of ML

---
### Quiz 1
#### Scenario: The Paper Napkin

Dan and Ate Rina are sorting 8 carinderia problems on a paper napkin. Help him classify each one correctly.

**Question 1:** "Predict tomorrow's total revenue in pesos." Which ML type?
A. Supervised classification
B. Supervised regression
C. Unsupervised
D. Reinforcement

**Answer:** B
**Explanation:** Predicting a NUMBER (pesos) with past labeled data → supervised regression.

---

**Question 2:** "Group customers into similar buying patterns — no labels exist yet." Which ML type?
A. Supervised classification
B. Supervised regression
C. Unsupervised
D. Reinforcement

**Answer:** C
**Explanation:** No labels + find structure = unsupervised clustering.

---

**Question 3:** "Classify each day as busy, normal, or slow." Which ML type?
A. Supervised regression
B. Supervised classification
C. Unsupervised
D. Reinforcement

**Answer:** B
**Explanation:** Predicting a CATEGORY (busy/normal/slow) with labeled training rows → supervised classification.

---

**Question 4:** "Make Luto adjust its jokes based on Tita Malou's reactions over a week." Which ML type?
A. Supervised regression
B. Supervised classification
C. Unsupervised
D. Reinforcement

**Answer:** D
**Explanation:** No static dataset; agent acts, receives feedback, adjusts → reinforcement learning.

---

### Quiz 2
#### Scenario: Naming the Sub-Types

Supervised learning has two sub-flavors. Make sure Dan can tell them apart.

**Question 5:** Which of these is REGRESSION (not classification)?
A. "Is this email spam or not?"
B. "What is the expected delivery time in minutes for this order?"
C. "Which of the 5 menu items will this customer buy?"
D. "Is this day a holiday?"

**Answer:** B
**Explanation:** A continuous number (minutes) → regression. The other three predict categories.

---

**Question 6:** Which of these is CLASSIFICATION (not regression)?
A. "Predict tomorrow's revenue in pesos."
B. "Forecast next month's flour expense."
C. "Will this customer come back next week — yes or no?"
D. "What temperature will Manila reach tomorrow?"

**Answer:** C
**Explanation:** Yes/no is a 2-class categorical label → binary classification. The other three predict numbers.

---

**Question 7:** Why is *"recommend tomorrow's ulam"* an ambiguous problem statement?
A. It's never useful
B. It could be supervised (predict the top revenue-generating ulam — regression on revenue per item) OR unsupervised (cluster similar past days and pick that cluster's top ulam) — the answer depends on what data you have
C. It's always classification
D. It's always reinforcement

**Answer:** B
**Explanation:** Real-world ML problems often fit multiple types. Picking the right framing is part of the engineer's job — and depends on what data is available.

---

---

## Lesson 3 - Supervised Learning

---
### Quiz 1
#### Scenario: Decomposing the Notebook

Dan and Ate Rina walk through Tita Malou's notebook columns to pick features and label for tomorrow's revenue prediction.

**Question 1:** In supervised learning, what does `X` typically represent?
A. The label vector
B. A matrix of features (one row per training example, one column per feature)
C. The prediction
D. The Python variable for "test"

**Answer:** B
**Explanation:** Capital X is a feature matrix; lowercase y is the label vector. Universal convention.

---

**Question 2:** Dan wants to predict `revenue` from the notebook. Which column would cause data leakage if included in features?
A. `weather`
B. `is_payday`
C. `quantity`
D. `day_of_week`

**Answer:** C
**Explanation:** `revenue = quantity × price`. Quantity is computed alongside revenue at the row level — including it lets the model effectively copy the answer.

---

**Question 3:** The "Golden Rule" of supervised features says:
A. Always include every column
B. Features must be knowable BEFORE the label exists
C. Features must be numeric
D. The label must come first in the CSV

**Answer:** B
**Explanation:** Tomorrow's weather forecast is allowed (you can know it the morning before). Today's actual revenue is not allowed for tomorrow's revenue prediction.

---

**Question 4:** What is the technical term for "accidentally using a feature that contains information about the label"?
A. Overfitting
B. Underfitting
C. Data leakage
D. Bias

**Answer:** C
**Explanation:** Data leakage. The model looks great during training and embarrassing in production.

---

### Quiz 2
#### Scenario: Multiple Problems, Same Data

Tita Malou's 6-row notebook can serve as the input to many different supervised problems.

**Question 5:** If the LABEL is `is_busy = revenue > 1200`, which columns must be DROPPED from features?
A. Only `revenue`
B. Both `revenue` and `quantity` (because revenue is derived from quantity, and is_busy is derived from revenue)
C. Only `quantity`
D. None — they're allowed

**Answer:** B
**Explanation:** `is_busy` is computed from `revenue`. `revenue` is computed from `quantity`. Both leak the answer.

---

**Question 6:** Dan wants to predict the quantity of sinigang sold. What's the right pre-processing step?
A. Use all 977 rows with `quantity` as label
B. Filter to rows where `item == "Sinigang"`, then use `quantity` as label and drop `revenue` (leakage)
C. Drop the `item` column entirely
D. Predict for every item at once with one model

**Answer:** B
**Explanation:** Predicting quantity per item works best as item-specific subsets. Revenue still leaks (revenue ≈ quantity × price) so it must be dropped.

---

**Question 7:** What convention does the ML community use for feature/label variable names?
A. `data` and `target`
B. `X` (capital, matrix) and `y` (lowercase, vector)
C. `inputs` and `outputs`
D. `features` and `targets`

**Answer:** B
**Explanation:** Capital X for matrices, lowercase y for vectors. Older than both you and Dan.

---

---

## Lesson 4 - Regression

---
### Quiz 1
#### Scenario: The Marikina Jeepney

Dan rides a jeepney home and notices regression running silently in every signboard he passes.

**Question 1:** Which of these is a regression problem (not classification)?
A. "Is this email spam?"
B. "Predict how many bowls of sinigang will sell tomorrow."
C. "Which menu item will be most popular?"
D. "Is the customer a barkada or a lola?"

**Answer:** B
**Explanation:** Quantity of bowls is a number. Regression. The others are classification.

---

**Question 2:** What is a "baseline" in ML?
A. The final, deployed model
B. A simple prediction (mean / median / moving average) your real model must beat
C. The training data
D. The test set

**Answer:** B
**Explanation:** A floor for your real model. If your fancy model can't beat the baseline, the fancy model is useless.

---

**Question 3:** Which baseline is usually the best of the three for time-series data with a trend?
A. Mean baseline
B. Median baseline
C. Moving-average baseline (e.g., average of last 7 days)
D. Always-predict-zero baseline

**Answer:** C
**Explanation:** Moving average tracks recent shifts the mean can't.

---

**Question 4:** What does MAE stand for, and what are its units?
A. Mean Absolute Error — same units as the label (e.g., pesos)
B. Maximum Average Error — squared units
C. Mathematical Algorithm Estimation — unitless
D. Median Absolute Estimation — squared units

**Answer:** A
**Explanation:** MAE = average of `|predicted - actual|`. Same units as the label. Most readable for non-technical audiences.

---

### Quiz 2
#### Scenario: Beating the Floor

Dan's moving-average baseline gets MAE 4.36 on the held-out test. He wants to know if a smarter approach can beat it.

**Question 5:** Why does a "rainy payday Friday" lookup beat the moving-average baseline by 1-2 bowls?
A. Because Tita Malou typed faster
B. Because context (payday + rainy + Friday) carries more signal than a blind moving average
C. Because of randomness
D. Because moving averages are always wrong

**Answer:** B
**Explanation:** Context-aware predictions beat blind averages. This is the core insight that motivates feature engineering in Lesson 12.

---

**Question 6:** What's the relationship between MSE and RMSE?
A. RMSE = MSE
B. RMSE = MSE / 2
C. RMSE = `sqrt(MSE)` — back in original units
D. RMSE = MSE squared

**Answer:** C
**Explanation:** Take the square root of MSE to get back to readable original units (e.g., pesos).

---

**Question 7:** When backtesting a baseline, why is it important to compute the baseline value from TRAIN data only?
A. It's not — both sets are fine
B. So the baseline doesn't "cheat" by averaging over rows it's about to be tested on (data leakage)
C. To save memory
D. Because test data is smaller

**Answer:** B
**Explanation:** Including test rows in the baseline's mean would give it information it wouldn't have at prediction time. Even baselines must follow the no-leakage rule.

---

---

## Lesson 5 - Classification

---
### Quiz 1
#### Scenario: The Sunday Labels

Tita Malou hands Dan a stack of notebook pages and a sharpie. He labels each day busy / normal / slow.

**Question 1:** Which problem is classification (not regression)?
A. "Predict tomorrow's revenue in pesos"
B. "Classify each day as busy, normal, or slow"
C. "Forecast next month's flour expense"
D. "Estimate the delivery ETA in minutes"

**Answer:** B
**Explanation:** Categorical label (busy/normal/slow) → classification. The others are continuous numbers.

---

**Question 2:** How many CLASSES does Dan's busy/normal/slow problem have?
A. 1
B. 2 (binary)
C. 3 (multi-class)
D. As many as there are rows

**Answer:** C
**Explanation:** Three possible categories → 3-class classification.

---

**Question 3:** A confusion matrix shows:
A. How confused Dan is
B. Counts of (true label × predicted label) pairs — diagonal = correct, off-diagonal = errors
C. Only the accuracy number
D. The model's source code

**Answer:** B
**Explanation:** A 2D grid where rows are true labels and columns are predictions. Reading it shows where the model is wrong, not just how often.

---

**Question 4:** Accuracy = correct / total. If 95% of days are normal and a model always predicts normal, what is its accuracy?
A. ~50%
B. ~95% (without learning anything)
C. 100%
D. 0%

**Answer:** B
**Explanation:** That's the classic imbalanced-data trap. Always-predict-majority is a strong dummy baseline — and exposes why accuracy alone is misleading.

---

### Quiz 2
#### Scenario: Threshold Design

Dan picks ₱5000 as his "busy" threshold and ₱2000 as his "normal" threshold.

**Question 5:** What happens if Dan changes the busy threshold from ₱5000 to ₱4000?
A. Nothing changes
B. More days get labeled "busy" — the class distribution shifts toward "busy"
C. Fewer days get labeled "busy"
D. The model becomes more accurate automatically

**Answer:** B
**Explanation:** Lower threshold → more rows above it → more "busy" labels. Threshold is a design choice that shapes the problem.

---

**Question 6:** Why is a CONFUSION MATRIX more informative than a single accuracy number?
A. It is not
B. It shows which classes get confused with which — diagnostic info you can't get from one number
C. It's just prettier
D. It's faster to compute

**Answer:** B
**Explanation:** A 79% accuracy could come from many shapes — confused busy/normal vs. confused slow/normal. The matrix reveals the structure of errors.

---

**Question 7:** What's the difference between BINARY and MULTI-CLASS classification?
A. Binary uses Python booleans; multi-class uses strings
B. Binary has exactly 2 possible labels; multi-class has 3 or more
C. There's no difference
D. Multi-class is always harder

**Answer:** B
**Explanation:** Binary = 2 outcomes (spam/not). Multi-class = 3+ outcomes (Sinigang/Adobo/Kare-Kare/Bistek/...).

---

---

## Lesson 6 - Dataset Basics

---
### Quiz 1
#### Scenario: First Eyeball of Tita Malou's Data

Dan loads 977 rows into pandas for the first time. Ate Rina makes him run the four exploration functions before any modeling.

**Question 1:** Which pandas function shows row count, dtypes, and null counts at a glance?
A. `df.head()`
B. `df.info()`
C. `df.describe()`
D. `df.tail()`

**Answer:** B
**Explanation:** `.info()` is the structural summary — row count, dtypes, null counts per column.

---

**Question 2:** Which function shows min, max, mean, median for numeric columns?
A. `df.head()`
B. `df.info()`
C. `df.describe()`
D. `df.shape`

**Answer:** C
**Explanation:** `.describe()` is the statistical summary for numeric columns.

---

**Question 3:** After loading the CSV, `df["is_payday"]` is stored as strings `"True"`/`"False"`. Why is this a problem?
A. It's not — pandas handles it fine
B. Numeric operations like `.sum()` on these strings will concatenate text, not count booleans
C. The file is corrupted
D. Pandas can't read CSVs at all

**Answer:** B
**Explanation:** dtypes matter. String `"True"` does not behave like Python `True`. Convert before modeling.

---

**Question 4:** Which function tells you how many of each category appear in a column?
A. `df["col"].value_counts()`
B. `df["col"].sum()`
C. `df["col"].head()`
D. `df["col"].dtype`

**Answer:** A
**Explanation:** `.value_counts()` is the categorical column inspector.

---

### Quiz 2
#### Scenario: Patterns Before Models

Dan uses `groupby` to confirm patterns Tita Malou already knows.

**Question 5:** Why is it useful to find patterns via `groupby` BEFORE training a model?
A. It's not useful
B. So you know what patterns the model should at minimum recover — if it misses them, the model is broken
C. To save memory
D. Because pandas requires it

**Answer:** B
**Explanation:** `groupby` patterns are the "sanity check" baseline. Any model that fails to recover obvious patterns is broken.

---

**Question 6:** In the sandbox, why do we load data via `pd.read_csv(StringIO(SAMPLE_CSV))` instead of `pd.read_csv("data.csv")`?
A. It's faster
B. The Pyodide sandbox has no writable filesystem; files would need to ship inside the lesson — StringIO lets us embed data as a Python string instead
C. It's a pandas requirement
D. Random preference

**Answer:** B
**Explanation:** Sandbox-safe data loading. The same pattern appears throughout the chapter.

---

**Question 7:** What's the safest first step on ANY new dataset?
A. Train a Random Forest immediately
B. Run head / info / describe / value_counts and fix any dtype surprises
C. Delete columns with weird names
D. Convert everything to strings

**Answer:** B
**Explanation:** Eyeball first. Skip the five minutes — lose a week debugging.

---

---

## Lesson 7 - Train vs Test Split

---
### Quiz 1
#### Scenario: The 99% Trap

Dan brags about 99% accuracy. Ate Rina asks one question that exposes the trap.

**Question 1:** Why is training on all your data and testing on the same data a bad idea?
A. It's not — it's the most accurate evaluation
B. The model already saw every answer during training, so test accuracy is meaningless
C. It uses too much memory
D. It's slow

**Answer:** B
**Explanation:** A model evaluated on its training data is guaranteed to look good. The number reflects memorization, not generalization.

---

**Question 2:** What is the standard train/test split ratio?
A. 50/50
B. 60/40
C. 80/20 (or sometimes 70/30, 75/25)
D. 99/1

**Answer:** C
**Explanation:** 80% train, 20% test is the industry default — enough training signal, enough test rows for honest evaluation.

---

**Question 3:** Why do we set `random_state=42` (or any fixed seed) when splitting?
A. Tradition
B. So the split is reproducible — re-running the code gives the same split every time
C. It speeds up training
D. It makes the model more accurate

**Answer:** B
**Explanation:** Reproducibility is a core ML discipline. Comparable results require identical splits.

---

**Question 4:** Which of these is NOT one of the Three Rules of Test Data?
A. Never train on test rows
B. Never tune hyperparameters against test
C. Never peek at test labels before final evaluation
D. Always shuffle test rows before predicting

**Answer:** D
**Explanation:** Shuffling test rows doesn't help or hurt. The three real rules are: don't train on it, don't tune on it, don't peek at it.

---

### Quiz 2
#### Scenario: Stratified Splits

Dan's busy/not_busy data is imbalanced — only 31% of days are busy. He wants the test set to look like the full data.

**Question 5:** What does a STRATIFIED split do that a random split doesn't?
A. Nothing useful
B. Preserves the class ratio in both train and test — important for imbalanced data
C. Sorts the data
D. Splits chronologically

**Answer:** B
**Explanation:** Stratified split = split each class separately so both halves have the same class ratio as the full dataset.

---

**Question 6:** Why should you NEVER tune hyperparameters against the held-out test set?
A. It's slow
B. Doing so leaks test information into your modeling decisions — your final test score becomes optimistically biased
C. The test set is too small
D. It causes memory errors

**Answer:** B
**Explanation:** Tuning on test = peeking at test = biased final estimate. Use a validation set or cross-validation (Lesson 19) instead.

---

**Question 7:** A single train/test split gives a single accuracy number. Is that a reliable estimate of real-world performance?
A. Yes — one number is enough
B. No — a different random split could give a meaningfully different number; you need multiple splits (cross-validation) for a reliable estimate
C. It depends on the model
D. Only for classification

**Answer:** B
**Explanation:** One number is one sample. Different splits give different numbers. Cross-validation (Lesson 19) averages over multiple splits for a reliable estimate.

---

---

## Lesson 8 - Python for ML

---
### Quiz 1
#### Scenario: The Sandbox Stack

Dan smoke-tests the bitdev sandbox to make sure his ML stack works end-to-end.

**Question 1:** Which libraries are AVAILABLE in the bitdev sandbox for ch_14?
A. numpy, pandas, sklearn, tensorflow
B. numpy, pandas, plus stdlib (csv, io, pickle, math, random)
C. Only pandas
D. Only numpy

**Answer:** B
**Explanation:** Sandbox ships numpy + pandas + Python stdlib. No sklearn, no DL frameworks. We build algorithms from scratch.

---

**Question 2:** Why is sklearn NOT in the sandbox?
A. It's banned
B. The Pyodide environment doesn't ship it, so we implement every algorithm from numpy — which is the pedagogical point anyway
C. It's deprecated
D. Random choice

**Answer:** B
**Explanation:** Pyodide constraints. Bonus: implementing from scratch teaches the math, not just the API.

---

**Question 3:** What does `pd.get_dummies(df["day_of_week"], prefix="day")` produce?
A. A single integer-encoded column
B. N new 0/1 columns (one per unique value)
C. The same column unchanged
D. An error

**Answer:** B
**Explanation:** One-hot encoding: one column with N values → N new boolean columns. The model can learn a separate weight per category.

---

**Question 4:** What is a DUMMY baseline?
A. A model that's broken
B. A model that always predicts the majority class — useful as the floor your real model must beat
C. A neural network
D. The dataset

**Answer:** B
**Explanation:** "Always predict majority" is the simplest possible baseline. If your real model doesn't beat it, the real model adds nothing.

---

### Quiz 2
#### Scenario: Class Imbalance and Baselines

Tita Malou's data has 31% busy days and 69% not-busy days. Dan trains a dummy that always predicts "not-busy."

**Question 5:** What accuracy would the always-predict-"not-busy" dummy achieve?
A. ~50%
B. ~31%
C. ~69%
D. 100%

**Answer:** C
**Explanation:** It correctly labels all the non-busy days (69% of rows). It misses all busy days, but they're only 31%.

---

**Question 6:** Why is reaching only 70% accuracy with a real model NOT impressive on this dataset?
A. It is impressive
B. The dummy hits 69% by predicting majority — a 1pp gain isn't meaningfully better
C. 70% is a perfect score
D. Accuracy is irrelevant

**Answer:** B
**Explanation:** Real models must beat the dummy by a meaningful margin. Otherwise, you've added complexity without value.

---

**Question 7:** Which stdlib function lets you serialize a Python object (including trained models) to bytes for storage or transfer?
A. `print()`
B. `pickle.dumps()`
C. `json.dumps()` (limited — can't handle arbitrary Python objects)
D. `str()`

**Answer:** B
**Explanation:** `pickle.dumps` serializes any Python object to bytes. We use it (instead of `joblib.dump` which writes to disk) in Lesson 22 for sandbox-safe model deployment.

---

---

## Lesson 9 - Linear Regression

---
### Quiz 1
#### Scenario: One Line of Linear Algebra

Dan implements linear regression from scratch and finds the math is simpler than he expected.

**Question 1:** What is the closed-form solution for linear-regression weights?
A. Gradient descent
B. `w = (X^T · X)^(-1) · X^T · y` — the normal equation
C. Random initialization
D. A neural network

**Answer:** B
**Explanation:** The normal equation is the closed-form solution. No iteration needed.

---

**Question 2:** Which numpy call is the entire training step?
A. `np.mean(X)`
B. `np.linalg.solve(X.T @ X, X.T @ y)`
C. `np.random.randn(...)`
D. `np.sort(X)`

**Answer:** B
**Explanation:** Solves the normal equation. Faster and more numerically stable than computing the inverse directly.

---

**Question 3:** Why do we prepend a column of 1s to X before training?
A. Padding
B. So the intercept (b) can be absorbed into the weight vector — the formula `y = X·w` then handles both slope and intercept
C. To increase dimension count
D. It's not necessary

**Answer:** B
**Explanation:** The all-1s column lets `X·w` represent both `m·x + b` in one matrix multiply.

---

**Question 4:** Linear regression cannot capture which kind of relationship without explicit feature engineering?
A. Additive effects of features
B. Multiplicative INTERACTIONS between features (e.g., "payday AND Friday is special, not just the sum of payday + Friday")
C. Monotonic trends
D. Constant effects

**Answer:** B
**Explanation:** Linear regression is additive in its features. To capture interactions you must create interaction columns (e.g., `payday × friday`). Decision trees (Lesson 14) capture interactions natively.

---

### Quiz 2
#### Scenario: Reading the Weights

Dan's fitted model says: `revenue ≈ 795 + 0.65·day_of_month + 288·is_payday + 65·is_friday`.

**Question 5:** What does the weight `288` on `is_payday` mean in plain English?
A. Payday days have 288 customers
B. On payday rows, the model adds ₱288 to the predicted revenue (compared to non-payday rows with the same other features)
C. The payday flag costs ₱288
D. Nothing — coefficients are not interpretable

**Answer:** B
**Explanation:** Linear regression weights are *interpretable*. Each weight is the additive contribution of that feature, holding others constant.

---

**Question 6:** Why does the model's weight on `is_payday` end up being the largest?
A. Random
B. Because payday days really do have significantly higher revenue in the training data — the model learned what Tita Malou already knew
C. Because of feature ordering
D. Because of numerical precision

**Answer:** B
**Explanation:** The algorithm finds the weights that minimize squared error. Payday's strong effect on revenue makes its weight dominant. Tita Malou and the model agree.

---

**Question 7:** Why is `np.linalg.solve(A, b)` preferred over `np.linalg.inv(A) @ b`?
A. They give different answers
B. `solve` is more numerically stable and slightly faster — it doesn't actually compute the inverse, just the solution
C. `inv` doesn't exist
D. No reason

**Answer:** B
**Explanation:** Direct solvers avoid the numerical instability of explicit matrix inversion. Industry-standard practice.

---

---

## Lesson 10 - Model Evaluation

---
### Quiz 1
#### Scenario: Three Ways to Be Wrong

Ate Rina makes Dan implement MAE, MSE, RMSE, and R² by hand so he understands what each one measures.

**Question 1:** What does MAE stand for?
A. Mean Absolute Error
B. Maximum Average Error
C. Mean Algorithm Error
D. Median Absolute Error

**Answer:** A
**Explanation:** MAE = mean of |y - prediction|. Robust to outliers, in original units.

---

**Question 2:** What is RMSE in terms of MSE?
A. RMSE = MSE × 2
B. RMSE = `sqrt(MSE)` — back in original units
C. RMSE = MSE squared
D. They're unrelated

**Answer:** B
**Explanation:** Take the square root of MSE to recover original-unit interpretability.

---

**Question 3:** Which metric punishes large errors MORE than many small errors?
A. MAE (linear in error size)
B. RMSE / MSE (squared, so big errors dominate)
C. R²
D. None — all metrics treat errors equally

**Answer:** B
**Explanation:** Squaring amplifies large errors. One ₱1000 miss contributes 1M to MSE; ten ₱100 misses contribute only 10K each.

---

**Question 4:** A model achieves R² = -0.5 on test. What does that mean?
A. The model is great
B. The model is WORSE than predicting the mean
C. R² can't be negative
D. The model has 50% accuracy

**Answer:** B
**Explanation:** R² < 0 means the model is *worse than predicting the mean*. Something is broken — debug before continuing.

---

### Quiz 2
#### Scenario: Reading the Gap

Dan's model has MAE = 228, RMSE = 297. Ratio ≈ 1.30.

**Question 5:** What does the MAE-to-RMSE GAP tell you?
A. Nothing useful
B. When RMSE > 1.5 × MAE, a few large errors are inflating the squared average — possible outliers
C. The model is overfit
D. The model is underfit

**Answer:** B
**Explanation:** Big RMSE/MAE ratio = outlier-driven errors. A free diagnostic.

---

**Question 6:** Which metric would you quote to Tita Malou ("how accurate is the model in plain language?")?
A. R² because it's unitless
B. MAE in pesos because she immediately understands "typically off by ₱228"
C. MSE because it's mathematically rigorous
D. None — don't bother

**Answer:** B
**Explanation:** Pick the metric that matches your audience. MAE in original units is the most readable for non-technical readers.

---

**Question 7:** Why is it best practice to ALWAYS report MULTIPLE metrics?
A. To pad the report
B. Each metric tells a different story; a single number hides outlier patterns and audience-relevant context
C. It's faster
D. Sklearn requires it

**Answer:** B
**Explanation:** MAE + RMSE + R² together give a complete picture. A single number is one perspective.

---

---

## Lesson 11 - Overfitting vs Underfitting

---
### Quiz 1
#### Scenario: The Three Polynomials

Dan fits polynomial degrees 1, 3, and 9 to the same 12 data points.

**Question 1:** A model with TRAIN MAE = 18 and TEST MAE = 614. What's wrong?
A. The model is underfit
B. The model is overfit — it memorized training points
C. The data is noise
D. Nothing — those numbers look fine

**Answer:** B
**Explanation:** Tiny train error + huge test error = classic overfitting. The model can't generalize.

---

**Question 2:** What is the technical name for "model too simple to capture the pattern"?
A. Overfitting
B. Underfitting
C. Just-right fitting
D. Random fitting

**Answer:** B
**Explanation:** Underfitting (high bias). Both train and test errors are high and similar.

---

**Question 3:** As polynomial degree increases, what happens to TRAIN MAE?
A. Goes up
B. Goes down monotonically (more flexibility = better training fit)
C. Stays the same
D. Random

**Answer:** B
**Explanation:** More flexibility can only fit training data tighter — never worse.

---

**Question 4:** As polynomial degree increases, what happens to TEST MAE?
A. Goes down monotonically
B. U-shape: decreases, bottoms out at the sweet spot, then increases as overfitting kicks in
C. Stays the same
D. Always increases

**Answer:** B
**Explanation:** Classic bias-variance see-saw. The trough of the U is your target complexity.

---

### Quiz 2
#### Scenario: Diagnosing a Model

Dan reads a model report: TRAIN MAE = 240, TEST MAE = 250 (gap = 10). Another report: TRAIN MAE = 50, TEST MAE = 280 (gap = 230).

**Question 5:** Which report shows healthier fitting?
A. First (small gap)
B. Second (low train MAE)
C. Both are equivalent
D. Neither

**Answer:** A
**Explanation:** A small gap means the model generalizes well. The second model overfit — low train error, big gap.

---

**Question 6:** What does "more data tolerates more complexity" mean?
A. Always train on as much data as possible
B. With small datasets, overfitting kicks in at low complexity. With big datasets, you can use more complex models without overfitting as easily
C. Data quantity doesn't matter
D. Big data needs deep learning

**Answer:** B
**Explanation:** Sample size buys you complexity room. 100 rows + degree-3 polynomial = OK. 30 rows + degree-9 = overfit.

---

**Question 7:** What is regularization (e.g., Ridge)?
A. A way to make training faster
B. Adding a penalty on weight magnitude to constrain models from chasing noise — common production fix for overfitting
C. A type of decision tree
D. A library

**Answer:** B
**Explanation:** Regularization penalizes large weights. Keeps complex models from memorizing. Production-standard technique.

---

---

## Lesson 12 - Feature Engineering

---
### Quiz 1
#### Scenario: The Notebook Margin

Tita Malou tells Dan: *"Anak, alam ko 'yan — payday yan, rainy yan."* Dan codes the same intuitions as features.

**Question 1:** Roughly what proportion of a real ML practitioner's time goes into FEATURES vs. ALGORITHM tuning?
A. 50/50
B. 80% algorithm, 20% features
C. 80% features (cleaning, engineering, labeling), 20% modeling
D. 100% algorithms

**Answer:** C
**Explanation:** The 80/20 rule. Most gains come from data and features, not from switching algorithms.

---

**Question 2:** Why does adding `is_payday_int`, `is_rainy`, `is_friday` help linear regression even with no algorithm change?
A. It doesn't help
B. The model can now weigh each Filipino-context flag separately — patterns that were buried in raw columns become explicit
C. It speeds up training
D. It increases the dataset size

**Answer:** B
**Explanation:** Linear regression weights features. Better features = stronger signal.

---

**Question 3:** What kind of feature is `payday_rainy = is_payday × is_rainy`?
A. A one-hot
B. An INTERACTION feature — captures the multiplicative effect that linear models can't find on their own
C. A scalar
D. A bug

**Answer:** B
**Explanation:** Linear regression is additive in its features. To capture "A AND B is special, not just A + B," you build the interaction column.

---

**Question 4:** What's a "lag" feature?
A. A bug
B. A feature derived from a PAST value (e.g., yesterday's revenue) for time-series prediction
C. A slow feature
D. A categorical encoding

**Answer:** B
**Explanation:** Lag features are the foundation of time-series forecasting. They give the model history without needing a special model.

---

### Quiz 2
#### Scenario: Domain Knowledge Is Gold

Tita Malou knows 15 years of carinderia patterns. Dan turns each insight into a model column.

**Question 5:** Why is domain knowledge such a powerful source of features?
A. It's not — features should come from automated tools
B. People who understand the problem know which columns matter — the model can only weigh features that exist
C. Random
D. Pure tradition

**Answer:** B
**Explanation:** A model can only learn what's in the data. Engineering the right columns is half the battle.

---

**Question 6:** A model with no `is_payday` feature cannot learn that paydays matter — EVEN IF the underlying truth is obvious. What does this teach us?
A. ML is broken
B. Features ARE the model's vocabulary. If a pattern isn't representable in features, the model can't capture it. Engineering matters.
C. Use more data
D. Use a deeper algorithm

**Answer:** B
**Explanation:** This is the fundamental insight that motivates feature engineering. The model only sees what you let it see.

---

**Question 7:** A 30% MAE reduction from feature engineering vs. 5% from switching to a fancier algorithm — which would you prioritize learning?
A. The fancier algorithm
B. Feature engineering — bigger ROI, more transferable across problems
C. Both equally
D. Neither

**Answer:** B
**Explanation:** Algorithm changes often give marginal gains. Better features routinely give double-digit MAE improvements. Engineer first; tune later.

---

---

## Lesson 13 - Logistic Regression

---
### Quiz 1
#### Scenario: Yes or No

Tita Malou wants a yes/no answer for tomorrow's prep. Dan builds his first classifier.

**Question 1:** What does the sigmoid function do?
A. Adds two numbers
B. Squashes any real number into the range (0, 1) — interpreted as a probability
C. Subtracts
D. Multiplies

**Answer:** B
**Explanation:** Sigmoid(z) = 1/(1 + e^-z). Maps the real line to (0, 1). Output is treated as P(y=1).

---

**Question 2:** What is the gradient of binary cross-entropy in matrix form?
A. `X.T @ X`
B. `(1/n) · X.T · (sigmoid(X·w) - y)` — one numpy line
C. `np.linalg.solve(X, y)`
D. There is no closed form

**Answer:** B
**Explanation:** Beautifully simple gradient. Update weights with `w -= lr * gradient`. That's the entire training step.

---

**Question 3:** Why does logistic regression use GRADIENT DESCENT instead of the normal equation?
A. Tradition
B. There's no closed-form solution because the sigmoid breaks linearity — we iterate to find the minimum
C. It's faster
D. The math doesn't exist

**Answer:** B
**Explanation:** Sigmoid is non-linear. No closed form. Gradient descent is the standard solution.

---

**Question 4:** What does PRECISION measure?
A. Of all rows labeled "busy" by the model, what fraction were ACTUALLY busy
B. Of all actually-busy rows, what fraction the model caught
C. The overall accuracy
D. The training time

**Answer:** A
**Explanation:** Precision = TP / (TP + FP). Penalizes false positives.

---

### Quiz 2
#### Scenario: Choosing the Right Threshold

Default threshold is 0.5. Tita Malou cares more about not running out of food than about over-prepping.

**Question 5:** What does RECALL measure?
A. Of all "busy" predictions, what fraction were correct
B. Of all actually-busy rows, what fraction the model caught — penalizes false negatives
C. Speed
D. Memory

**Answer:** B
**Explanation:** Recall = TP / (TP + FN). High recall = few missed positives. Important when missing a positive is costly.

---

**Question 6:** Tita Malou hates running out of food. Should she LOWER or RAISE the decision threshold from 0.5?
A. Raise to 0.7 — fewer "busy" predictions
B. Lower to 0.3 — more "busy" predictions, catches more real busy days (higher recall) at the cost of more over-preps (lower precision)
C. Keep at 0.5
D. Doesn't matter

**Answer:** B
**Explanation:** Lower threshold → more "busy" predictions → higher recall. She'd rather over-prep occasionally than run out.

---

**Question 7:** What does the WEIGHT on a feature mean in logistic regression?
A. Nothing interpretable
B. The change in log-odds of class 1 per unit increase in that feature (holding others constant)
C. The accuracy
D. The number of training rows

**Answer:** B
**Explanation:** Like linear regression, logistic regression weights are interpretable — they act on log-odds rather than directly on probability.

---

---

## Lesson 14 - Decision Trees

---
### Quiz 1
#### Scenario: The Jeepney Flowchart

Dan realizes Tita Malou's gut isn't a sum — it's a flowchart. Decision trees encode flowcharts directly.

**Question 1:** A decision tree's structure is closest to what?
A. A neural network
B. A flowchart of yes/no questions ending in leaf predictions
C. A linear equation
D. A random forest

**Answer:** B
**Explanation:** Internal nodes ask feature/threshold questions; leaves predict the class. Walk root-to-leaf for any new row.

---

**Question 2:** What does GINI IMPURITY measure?
A. The dataset size
B. How "mixed" the classes are in a node — 0 means pure, 0.5 means 50/50 for binary
C. The depth of the tree
D. The accuracy

**Answer:** B
**Explanation:** Gini = 1 - (p1² + p2² + ...). Used to score candidate splits — we minimize the weighted child Gini.

---

**Question 3:** Without depth limits, what tends to happen to a decision tree's training error?
A. It stays high
B. It approaches zero — the tree memorizes every training row (overfitting)
C. It oscillates
D. It increases with depth

**Answer:** B
**Explanation:** Unrestricted trees can fit any training data perfectly. That's why `max_depth` matters.

---

**Question 4:** Why do decision trees find FEATURE INTERACTIONS automatically without explicit interaction columns?
A. They don't
B. After splitting on feature A, the left and right branches can each split on B differently — this captures A × B
C. They use neural networks internally
D. Magic

**Answer:** B
**Explanation:** Hierarchical structure naturally encodes interactions. Linear models can't — they need explicit `A × B` columns.

---

### Quiz 2
#### Scenario: Reading the Tree

The tree's root split is `is_payday`. Tita Malou nods because she'd do the same.

**Question 5:** The algorithm chose `is_payday` as the root split because:
A. It was alphabetically first
B. It produces the lowest weighted Gini among all candidate splits — it's the most informative feature
C. Random choice
D. The user told it to

**Answer:** B
**Explanation:** The algorithm tries every feature/threshold and picks the one that minimizes weighted child Gini. Payday's strong signal makes it win.

---

**Question 6:** What is the MOST IMPORTANT hyperparameter to set on a decision tree?
A. The number of features
B. `max_depth` — controls overfitting; shallow = simple + interpretable
C. The dataset size
D. The seed

**Answer:** B
**Explanation:** `max_depth` is THE knob. Unset = overfits. Too low = underfits. Tune on validation (Lesson 18).

---

**Question 7:** What is one BIG advantage of decision trees over linear models for non-technical audiences?
A. Faster training
B. The fitted tree can be PRINTED as plain-English if-else rules — Tita Malou can read it
C. Higher accuracy always
D. They never overfit

**Answer:** B
**Explanation:** Interpretability is decision trees' superpower for business problems.

---

---

## Lesson 15 - Random Forest

---
### Quiz 1
#### Scenario: Ten Trees, One Vote

Dan's single decision tree plateaus at 81%. The forest hits 86% — same data, just averaging.

**Question 1:** A Random Forest is composed of:
A. One very deep decision tree
B. Many shallow decision trees that VOTE on each prediction
C. A neural network
D. Linear regressions

**Answer:** B
**Explanation:** Many shallow trees, each trained on a bootstrap sample, majority-vote per prediction.

---

**Question 2:** What does BOOTSTRAP SAMPLING mean?
A. Sampling without replacement
B. Drawing N samples WITH replacement from N training rows — each tree sees a slightly different subset
C. Sampling from the test set
D. Random sampling for the entire forest

**Answer:** B
**Explanation:** With replacement. About 63% of unique rows appear in each tree's training data on average.

---

**Question 3:** What does RANDOM SUBSPACE mean in Random Forest?
A. The training data is random
B. At each split, the tree considers only a RANDOM SUBSET of features (e.g., sqrt(p) features) — this decorrelates trees
C. The model is random
D. Random predictions

**Answer:** B
**Explanation:** Decorrelating trees by limiting their feature view is the "random" in Random Forest.

---

**Question 4:** Why does a forest of 10 weak trees often BEAT a single strong tree?
A. It doesn't
B. Errors of individual trees average out; bias stays low while variance drops
C. The forest is deeper
D. Magic

**Answer:** B
**Explanation:** Each tree has noise. Averaging votes cancels uncorrelated errors. Ensemble = lower variance.

---

### Quiz 2
#### Scenario: When and Why to Use Forests

Dan reaches for a Random Forest as his default.

**Question 5:** What is OOB (Out-of-Bag) score?
A. A bug
B. For each row, predict using only trees that didn't see it during training — gives a free validation estimate without a separate test set
C. The model's accuracy on the bootstrap
D. The test set

**Answer:** B
**Explanation:** ~37% of trees don't see any given row. Use them to score that row. Free, no-cost validation metric.

---

**Question 6:** Adding more trees to a Random Forest:
A. Hurts test accuracy
B. Helps a lot up to ~100 trees, then plateaus — more trees beyond that buy stability, not accuracy
C. Has no effect
D. Always helps

**Answer:** B
**Explanation:** Diminishing returns after ~100 trees. Beyond that, you're paying compute for marginal stability.

---

**Question 7:** Random Forest is BEST suited for which kind of data?
A. Images
B. Long text documents
C. Tabular structured data with mixed feature types — its natural habitat
D. Audio

**Answer:** C
**Explanation:** Forests dominate tabular ML in 2026. For images, text, audio, deep learning wins.

---

---

## Lesson 16 - K-Means Clustering

---
### Quiz 1
#### Scenario: Customers Tita Malou Almost Has Names For

Dan clusters 60 customers and recovers Tita Malou's intuitive types — without ever being told them.

**Question 1:** What kind of learning is K-Means?
A. Supervised regression
B. Supervised classification
C. UNSUPERVISED — no labels needed; finds structure from features alone
D. Reinforcement learning

**Answer:** C
**Explanation:** K-Means is the canonical unsupervised algorithm. No labels go in.

---

**Question 2:** The K-Means algorithm in 2 steps:
A. Train and predict
B. E-step (assign each point to nearest center) + M-step (move centers to cluster means); repeat
C. Forward pass + backward pass
D. Sort and pick

**Answer:** B
**Explanation:** Iterative EM loop. Each iteration reduces inertia.

---

**Question 3:** Why MUST you standardize features before K-Means?
A. You don't
B. K-Means uses Euclidean distance; without standardization, large-range features dominate over small-range ones
C. Pandas requires it
D. Speed

**Answer:** B
**Explanation:** Distance metrics are scale-sensitive. Subtract mean, divide by std before clustering.

---

**Question 4:** What is the ELBOW METHOD?
A. Stretching while you wait for training
B. Plot inertia vs K; find the K where adding more clusters stops reducing inertia meaningfully — that "elbow" suggests the natural K
C. A bug
D. An accuracy metric

**Answer:** B
**Explanation:** Inertia always falls with more clusters. The elbow point is where extra clusters add little — natural K.

---

### Quiz 2
#### Scenario: Naming and Limitations

The algorithm returns clusters. You name them.

**Question 5:** Why do K-Means cluster IDs (0, 1, 2) MEAN NOTHING by themselves?
A. They're random
B. They're arbitrary labels — what matters is the CENTROIDS and which points fell into each cluster. You inspect those and give business names.
C. The algorithm is broken
D. They should be alphabetical

**Answer:** B
**Explanation:** "Cluster 0" in one run = "cluster 2" in another. The labels are arbitrary; interpret by inspecting the centroids.

---

**Question 6:** K-Means can converge to a LOCAL MINIMUM (not globally best). What's the standard fix?
A. Ignore the problem
B. Run K-Means multiple times with different random initializations; keep the result with the lowest inertia
C. Increase K
D. Use a different algorithm

**Answer:** B
**Explanation:** `n_init=10` runs 10 separate K-Means with different starts and picks the best. Standard practice.

---

**Question 7:** K-Means assumes clusters are roughly spherical and similar-sized. For long thin clusters or rings, it will:
A. Work perfectly
B. Struggle — distance-to-center isn't the right notion of similarity for non-spherical shapes (use DBSCAN or hierarchical clustering instead)
C. Be twice as fast
D. Crash

**Answer:** B
**Explanation:** Algorithm assumptions matter. K-Means is great for spherical blobs; other shapes need different tools.

---

---

## Lesson 17 - Dimensionality Reduction (PCA)

---
### Quiz 1
#### Scenario: Eight Dimensions on a Napkin

Dan engineers 8 features and wants to plot them. PCA compresses to 2.

**Question 1:** What does PCA stand for?
A. Python Classification Algorithm
B. Principal Component Analysis
C. Predictive Class Aggregator
D. Probabilistic Cluster Analysis

**Answer:** B
**Explanation:** Principal Component Analysis. Find directions of maximum variance; project onto them.

---

**Question 2:** Which numpy function does the heavy lifting in PCA?
A. `np.mean`
B. `np.linalg.solve`
C. `np.linalg.svd` (Singular Value Decomposition)
D. `np.linalg.det`

**Answer:** C
**Explanation:** SVD decomposes the centered matrix; the rows of Vt are the principal components.

---

**Question 3:** Before running SVD for PCA, you must:
A. Train a classifier
B. Mean-center the data (and ideally standardize each feature)
C. Convert to integers
D. Sort the rows

**Answer:** B
**Explanation:** Mean-center is required (or you get a "first component points at the mean" artifact). Standardize for scale-sensitive PCA.

---

**Question 4:** What does the "explained variance ratio" of PC1 tell you?
A. The accuracy of the model
B. What fraction of total data variance PC1 captures — e.g., 0.42 means 42% of total spread is along PC1
C. The number of rows
D. The number of features

**Answer:** B
**Explanation:** Each PC captures some fraction of variance. Together, the first few usually cover most of the structure.

---

### Quiz 2
#### Scenario: Reading the Components

PC1's largest-magnitude loadings are `is_payday`, `quantity`, `is_friday`.

**Question 5:** What does that combination of loadings tell you PC1 "represents"?
A. Nothing — PCs are uninterpretable
B. PC1 acts as a "busy-payday axis" — points with high values on PC1 are payday days with high quantities, often Fridays
C. PC1 represents weather
D. PC1 represents customer ID

**Answer:** B
**Explanation:** PCs are interpretable via their loadings. Identifying the axis tells you what variation it captures.

---

**Question 6:** Why would you keep only 2 PCs out of 8 original features?
A. To save memory
B. For VISUALIZATION (you can't plot 8D) AND to remove redundant or noisy dimensions while keeping most variance
C. Random preference
D. To increase accuracy

**Answer:** B
**Explanation:** Reduce to 2D for plotting; keep the variance that matters; drop noisy dimensions.

---

**Question 7:** PCA finds LINEAR projections. For wildly non-linear structure (rings, spirals, manifolds), use:
A. More PCs
B. t-SNE or UMAP (non-linear dimensionality reduction)
C. Random Forest
D. Linear Regression

**Answer:** B
**Explanation:** PCA can only find linear axes. Non-linear data needs non-linear methods like t-SNE.

---

---

## Lesson 18 - Model Tuning

---
### Quiz 1
#### Scenario: The 100% Training Accuracy Trap

Dan picks the model with the lowest training error. Ate Rina catches him.

**Question 1:** What's the difference between a PARAMETER and a HYPERPARAMETER?
A. They're the same
B. Parameters are LEARNED from data (weights, tree splits); hyperparameters are SET before training (max_depth, learning_rate)
C. Hyperparameters are bigger
D. Random

**Answer:** B
**Explanation:** `fit()` learns parameters. You set hyperparameters before calling fit.

---

**Question 2:** Tuning hyperparameters should be done on:
A. The training set
B. A separate VALIDATION set (or via cross-validation)
C. The test set
D. The entire dataset

**Answer:** B
**Explanation:** Train fits the model. Validation tunes hyperparameters. Test gives the final score (once).

---

**Question 3:** Why do you NEVER tune hyperparameters against the test set?
A. Speed
B. Doing so leaks test information into your modeling decisions — your final test accuracy becomes optimistically biased
C. It's slow
D. Random

**Answer:** B
**Explanation:** Tuning on test = peeking at test = biased final score. Always use validation or CV.

---

**Question 4:** What is a "grid search"?
A. A search engine
B. Try every COMBINATION of multiple hyperparameter values (max_depth × min_samples_leaf × ...); pick the best on validation
C. A type of model
D. A bug

**Answer:** B
**Explanation:** Multi-dimensional sweep. Standard production pattern (`GridSearchCV` in sklearn).

---

### Quiz 2
#### Scenario: Sweeping max_depth

Dan sweeps `max_depth ∈ [1..15]` and watches the curves.

**Question 5:** As `max_depth` rises, what does TRAIN accuracy do?
A. Goes down
B. Monotonically rises (more flexibility = better training fit)
C. U-shape
D. Constant

**Answer:** B
**Explanation:** More flexibility can only fit training better — never worse. Train accuracy is always monotonically improving with complexity.

---

**Question 6:** As `max_depth` rises, what does VALIDATION accuracy do?
A. Monotonically rises
B. U-shape (rises, peaks at sweet spot, then falls as overfitting kicks in)
C. Constant
D. Random

**Answer:** B
**Explanation:** Validation reflects generalization. Initially improves with complexity, then degrades as the model memorizes noise.

---

**Question 7:** What is the BIG distinction between manual sweep and `GridSearchCV`?
A. Nothing
B. GridSearchCV uses CROSS-VALIDATION (multiple folds) for each hyperparameter combo — more reliable than a single validation split. Plus it parallelizes.
C. Manual is faster
D. Grid search is wrong

**Answer:** B
**Explanation:** CV inside the sweep reduces variance in the validation estimate. Standard production tooling.

---

---

## Lesson 19 - Cross Validation

---
### Quiz 1
#### Scenario: The Lucky Split

Dan brags about 88% accuracy. Ate Rina makes him run 5 different splits.

**Question 1:** Why is "88% on one train/test split" misleading?
A. It's not — it's perfectly fine
B. A different random split could have given 83% or 86%; one number is one sample without context
C. 88% is always lying
D. Random

**Answer:** B
**Explanation:** Single splits have noise. Different seeds = different numbers. CV averages that out.

---

**Question 2:** What is K-fold cross validation?
A. Running the model K times in production
B. Shuffle, divide into K folds, train on K-1 folds + test on 1, repeat K times, average the scores
C. Random sampling
D. A bug

**Answer:** B
**Explanation:** Each row appears in test exactly once. You get K scores, not one. Mean and std together.

---

**Question 3:** What's the industry-default value of K?
A. 1
B. 2
C. 5 (or sometimes 10)
D. The number of rows

**Answer:** C
**Explanation:** K=5 is the workhorse. Reasonable variance reduction at 5× compute.

---

**Question 4:** STRATIFIED K-fold differs from regular K-fold how?
A. It's slower
B. It preserves the class ratio in every fold — essential for imbalanced classification problems
C. It uses more memory
D. No difference

**Answer:** B
**Explanation:** Stratified splits each class separately so both halves of every fold have the right ratio.

---

### Quiz 2
#### Scenario: Reporting Honestly

After CV: mean=0.856, std=0.020.

**Question 5:** What's the approximate 95% confidence interval for the model's real-world accuracy?
A. [0.856, 0.856] — point estimate
B. mean ± 2·std ≈ [0.816, 0.896]
C. The training accuracy
D. 0.5

**Answer:** B
**Explanation:** Rough normal-distribution rule. Real performance is likely between 0.82 and 0.90.

---

**Question 6:** Model A: mean=0.86 ± 0.02. Model B: mean=0.87 ± 0.05. Are they meaningfully different?
A. Yes — B is 0.01 higher
B. NO — the difference (0.01) is much smaller than the std (0.02-0.05); the comparison is within noise
C. Yes — B is always better
D. Cannot tell

**Answer:** B
**Explanation:** Stat 101. Differences within the uncertainty band aren't meaningful. Always look at std before claiming "X beats Y."

---

**Question 7:** Does CV replace the held-out test set?
A. Yes, no test set needed
B. NO — CV is for model selection and tuning; you STILL evaluate ONCE on a held-out test for the final report
C. Sometimes
D. Test sets are obsolete

**Answer:** B
**Explanation:** CV gives mean ± std during model selection. The final test set is touched once, after picking the model, for the reported score.

---

---

## Lesson 20 - Pipeline Building

---
### Quiz 1
#### Scenario: Eight Scripts Become One Function

Dan's project folder is a mess. Ate Rina makes him refactor.

**Question 1:** What is the main purpose of an ML "pipeline" in code?
A. To make code longer
B. To wire clean → engineer → split → fit → evaluate into ONE function for consistency, leak prevention, and deployment
C. A type of model
D. A database concept

**Answer:** B
**Explanation:** Pipelines collapse repetitive workflow into one reproducible function. Standard production pattern.

---

**Question 2:** Without a pipeline, what's a common LEAKAGE mistake?
A. Forgetting to save the model
B. `StandardScaler().fit_transform(X)` on ALL data BEFORE splitting — leaks test info into the scaler
C. Using too many features
D. Random initialization

**Answer:** B
**Explanation:** Preprocessing must be fit on train ONLY. Pipelines enforce this automatically.

---

**Question 3:** How do pipelines prevent leakage?
A. They're stricter
B. Each preprocessing step is FIT on train only; the same step then TRANSFORMS both train and test (using train-fit params)
C. They check your code
D. They add randomness

**Answer:** B
**Explanation:** Fit on train, transform both. The pipeline structure makes this the natural pattern.

---

**Question 4:** What's the apples-to-apples benefit of a pipeline?
A. Speed
B. Same data + same engineering + same split — swap only the model, and you get directly comparable scores
C. Lower memory
D. Compactness

**Answer:** B
**Explanation:** Without a pipeline, models compete with different preprocessing. With a pipeline, only the model varies.

---

### Quiz 2
#### Scenario: Deployment as a Pipeline

After fitting, Dan wants to deploy. A pipeline makes that one artifact.

**Question 5:** Why do production ML teams save the entire pipeline (preprocessing + model) as one object?
A. Aesthetics
B. So when a new row comes in at predict time, the SAME preprocessing applies — no risk of training/serving skew
C. To save memory
D. Random

**Answer:** B
**Explanation:** Training/serving skew (preprocessing differs between train and inference) is a common production bug. One-artifact deployment prevents it.

---

**Question 6:** A pipeline function has signature `def run(df, model_factory, cv=5)`. Why `model_factory` (a callable) and not `model` (an instance)?
A. Cosmetic
B. So each CV fold creates a FRESH model — without sharing parameters across folds (which would be leakage)
C. Faster
D. Random

**Answer:** B
**Explanation:** Each fold needs independent training. Passing a factory ensures freshness.

---

**Question 7:** What's the typical SIZE of a well-written `def run(df, model)` pipeline function?
A. 500+ lines
B. ~40-60 lines for a complete workflow (clean + engineer + CV + return)
C. 1 line
D. 5,000 lines

**Answer:** B
**Explanation:** Tight, focused. The whole pipeline reads top-to-bottom. Most of the lines are helpers.

---

---

## Lesson 21 - Intro to NLP in ML

---
### Quiz 1
#### Scenario: Reading the Notebook

Tita Malou's notebook has 20 mixed Tagalog/English entries. Dan turns them into vectors.

**Question 1:** What does bag-of-words do?
A. Sorts words alphabetically
B. Converts each document into a vector of WORD COUNTS — order is lost, counts are kept
C. Encrypts text
D. Compresses text

**Answer:** B
**Explanation:** BOW = unordered word counts per document. Simple but surprisingly effective baseline for text classification.

---

**Question 2:** With bag-of-words, why does "order 3 sinigang" still classify correctly even though we don't know "order" came BEFORE "sinigang"?
A. It doesn't
B. The presence of "order" alone is strongly correlated with the "order" class — counts matter, not order
C. Random luck
D. Position is preserved secretly

**Answer:** B
**Explanation:** Many classification problems are well-served by word presence/absence. Word order is bonus information, not always required.

---

**Question 3:** Why is mixing Tagalog and English in one sentence NOT a problem for BOW?
A. It is a problem
B. The vocabulary just collects every unique token regardless of language; the classifier learns weights for each — language-agnostic
C. The classifier translates
D. Random

**Answer:** B
**Explanation:** BOW treats all tokens as opaque symbols. The vocabulary is whatever the data contains.

---

**Question 4:** What is TF-IDF?
A. A type of model
B. A weighting scheme that down-weights words appearing in MANY documents and up-weights rare informative words
C. A tokenizer
D. A neural network

**Answer:** B
**Explanation:** TF-IDF reweights raw counts. Common words like "the" get small weights; rare informative words get bigger weights.

---

### Quiz 2
#### Scenario: Filipino-Specific NLP

Dan classifies Filipino/English mixed text. Some standard NLP techniques need adjustment.

**Question 5:** Why might you NOT want to remove "stopwords" (po, na, ng, the, a) on Filipino notebook entries?
A. They're too short
B. Filipino small words often carry meaning (formality, plurals, conjunctions) — removing them can hurt classifier performance for Filipino text
C. They're alphabetical
D. There are no stopwords

**Answer:** B
**Explanation:** English NLP often strips stopwords, but Filipino's grammatical particles carry semantic weight. Defaults aren't universal.

---

**Question 6:** What are N-GRAMS in BOW?
A. Single words only
B. Sequences of N consecutive words (bigrams = pairs, trigrams = triples) — preserves some local word order
C. The number of documents
D. The number of classes

**Answer:** B
**Explanation:** N-grams capture short phrases. Useful for short documents (like notebook entries) where local order matters.

---

**Question 7:** Which classifier did Dan use on the BOW features?
A. A brand-new neural network
B. The same logistic regression from Lesson 13 (one-vs-rest for 3 classes)
C. K-Means
D. Decision Tree (impossible)

**Answer:** B
**Explanation:** Once text becomes numeric vectors, the same classifiers you've already built apply. The "new" part of NLP is the vectorization, not the model.

---

---

## Lesson 22 - Model Deployment

---
### Quiz 1
#### Scenario: The Model Survives a Restart

Dan trains a model, serializes it, reloads it. The reloaded model gives identical predictions.

**Question 1:** What does `pickle.dumps(model)` produce?
A. A string
B. A `bytes` object that represents the model — can be stored anywhere
C. A list
D. A file

**Answer:** B
**Explanation:** `pickle.dumps` returns bytes in memory. You can email them, post to an API, store in a DB.

---

**Question 2:** What does `pickle.loads(bytes)` do?
A. Saves to disk
B. Deserializes the bytes back into the original Python object
C. Hashes the bytes
D. Compresses them

**Answer:** B
**Explanation:** `pickle.loads` is the inverse — bytes back to a model object you can predict with.

---

**Question 3:** Why use `pickle` + `BytesIO` in the bitdev sandbox instead of `joblib.dump('model.pkl')`?
A. Speed
B. The sandbox has no writable filesystem; `pickle.dumps` returns bytes in memory, no disk needed
C. pickle is more accurate
D. Random preference

**Answer:** B
**Explanation:** Sandbox constraint. `joblib.dump` would fail; `pickle.dumps` works because it stays in memory.

---

**Question 4:** What's the typical TWO-SCRIPT pattern for deployment?
A. `data.py` + `viz.py`
B. `train.py` (fit + serialize, runs once) + `predict.py` (load + predict, runs every prediction)
C. `dev.py` + `prod.py`
D. There is no pattern

**Answer:** B
**Explanation:** Training is rare; prediction is frequent. They share only the serialized model — clean separation.

---

### Quiz 2
#### Scenario: Production Discipline

Dan ships v1. Two weeks later, v2 (different model). What happens?

**Question 5:** Why do production ML teams VERSION their model artifacts?
A. Aesthetics
B. So you can roll back instantly if v2 turns out worse than v1 — without retraining
C. Tradition
D. Random

**Answer:** B
**Explanation:** Model artifacts are like code: bug fixes, regressions, rollbacks. Versioning enables safe deployment.

---

**Question 6:** What's the risk of training with one sklearn version and loading with another?
A. None
B. Internal data structures may differ between versions — you can get warnings or outright errors
C. Lower accuracy
D. Speed

**Answer:** B
**Explanation:** Pin versions in production. `requirements.txt` is your friend.

---

**Question 7:** What does it mean that "deployment" can be EMAILING a `bytes` blob?
A. It's a joke
B. Once a model is serialized to bytes, you can transport it any way — email, API, database. That's the whole "deployment" abstraction.
C. Emails are required
D. Random

**Answer:** B
**Explanation:** Serialization is the deployment abstraction. The bytes are portable; how you transport them is an implementation detail.

---

---

## Lesson 23 - Real-world ML Workflow

---
### Quiz 1
#### Scenario: The Capstone Notebook

Dan collapses 22 lessons into one auditable script.

**Question 1:** How many sections does a typical end-to-end ML script have?
A. 1
B. 100
C. ~9-11: imports, constants, load, clean, engineer, split, CV, select, fit, test, serialize
D. As many as possible

**Answer:** C
**Explanation:** Standard production workflow has ~9-11 distinct sections in a specific order.

---

**Question 2:** What should the test set be used for?
A. Tuning hyperparameters
B. ONE final evaluation at the very end, after model selection and tuning are complete
C. Training
D. Cross-validation

**Answer:** B
**Explanation:** Touch test ONCE. Tuning and selection happen on train+val with CV.

---

**Question 3:** Why is EVERY section's output printed in the script?
A. To make it longer
B. Output IS the audit trail — a reviewer can read top to bottom and verify each step ran correctly
C. Required by Python
D. Random

**Answer:** B
**Explanation:** A reviewable script has visible output at every step. No "did that work?" silently.

---

**Question 4:** Why do "deliverable" scripts prefer ONE file vs. multiple notebooks?
A. Notebooks are slow
B. One auditable script can be read top to bottom; multiple notebooks risk silent drift between cells across runs
C. Notebooks are obsolete
D. Random

**Answer:** B
**Explanation:** For deliverables and production, one auditable script wins. Notebooks are great for exploration but harder to review.

---

### Quiz 2
#### Scenario: The Forecast at the Bottom

The final section of the script prints a forecast — for Tita Malou, not for the engineer.

**Question 5:** What's the difference between CV scores (top of script) and the forecast (bottom)?
A. They're the same
B. CV scores are for the engineer's confidence; the forecast is the BUSINESS deliverable (what the model says about tomorrow) — stakeholders read this
C. CV is wrong
D. Forecast is wrong

**Answer:** B
**Explanation:** Different audiences. CV is for engineers; forecast is for Tita Malou and her menu decisions.

---

**Question 6:** Why is `random_state` (or fixed seed) set as a CONSTANT at the top?
A. Tradition
B. Reproducibility — running the script twice gives the same output, makes review possible
C. It's slower without
D. Mandatory

**Answer:** B
**Explanation:** Fixed seed = reproducible run = trustworthy results.

---

**Question 7:** In the capstone workflow, where does the test set get touched?
A. Multiple times throughout
B. ONCE at the end, after model selection via CV
C. In every fold
D. Never

**Answer:** B
**Explanation:** The Three Rules of Test Data. Touch test exactly once.

---

---

## Lesson 24 - ML vs AI vs DL

---
### Quiz 1
#### Scenario: The Napkin Venn Diagram

Dan explains the nested circles to Tita Malou.

**Question 1:** Which is the relationship between AI, ML, DL?
A. They're synonyms
B. AI > ML > DL (nested circles — DL is inside ML is inside AI)
C. They're unrelated
D. ML > AI > DL

**Answer:** B
**Explanation:** AI is the broadest; ML is the subset that learns from data; DL is the subset that uses deep neural networks.

---

**Question 2:** Luto v1 (rules) is an example of what?
A. ML
B. AI (rule-based system) — not ML, because no learning is happening
C. DL
D. None

**Answer:** B
**Explanation:** All ML is AI, but not all AI is ML. Rule-based systems are AI without learning.

---

**Question 3:** Luto v2 (Random Forest on carinderia data) is an example of what?
A. ML (specifically supervised learning on tabular data)
B. DL
C. Pure AI (rules)
D. Random number generation

**Answer:** A
**Explanation:** ML uses Random Forest, KMeans, etc. — algorithms that learn from data. Not deep learning.

---

**Question 4:** A hypothetical Luto v3 that classifies leftover-dish PHOTOS would be:
A. AI only
B. ML only
C. ALL THREE: it's AI, it's ML, and it's DL (image recognition typically needs CNNs)
D. None of the above

**Answer:** C
**Explanation:** Nested circles. Image recognition = DL → which is ML → which is AI.

---

### Quiz 2
#### Scenario: Picking the Right Tool

Different data shapes need different algorithms.

**Question 5:** For 30 rows of tabular carinderia data, what's the RIGHT first algorithm?
A. A deep neural network
B. Random Forest or Logistic Regression — tabular + small → ML wins
C. GPT-4
D. K-Means

**Answer:** B
**Explanation:** DL is overkill for small tabular data. ML is the right tool.

---

**Question 6:** Where does DL UNAMBIGUOUSLY beat ML?
A. Tabular data with 100 rows
B. Image recognition, speech, large-scale language — wherever the data is unstructured and abundant
C. Database queries
D. Everywhere

**Answer:** B
**Explanation:** DL's strength is unstructured data at scale. Images, audio, text. Tabular is ML's home turf.

---

**Question 7:** "Most production ML in 2026 is NOT deep learning." Is that true or false?
A. False — DL is everything
B. TRUE — Tabular ML (Random Forest, XGBoost, logistic regression) dominates day-to-day business problems
C. Half true
D. Cannot tell

**Answer:** B
**Explanation:** Headlines are about DL; production is mostly classical ML. Both matter; pick by data shape.

---

---

## Lesson 25 - Mini ML Project

---
### Quiz 1
#### Scenario: Shipping Luto v2

Dan's final project: predict top-3 ulam given tomorrow's date + weather + payday.

**Question 1:** What's the INPUT to Luto v2's forecaster?
A. The full 977-row dataset
B. A single tuple: (date, weather, is_payday)
C. Just the date
D. Just the weather

**Answer:** B
**Explanation:** Tita Malou doesn't have tomorrow's data — she has tomorrow's *features*. The forecaster takes those.

---

**Question 2:** What's the OUTPUT?
A. A single ulam prediction
B. Top 3 ulam ranked by EXPECTED REVENUE
C. Yes/no
D. A confusion matrix

**Answer:** B
**Explanation:** Top 3 ranked = a list of three menu recommendations. The actionable deliverable.

---

**Question 3:** Why does the model predict EXPECTED REVENUE per ulam (not just "this ulam will sell")?
A. It doesn't
B. Because Tita Malou cares about peso revenue when deciding what to push — the regression target matches the business goal
C. Random
D. Convention

**Answer:** B
**Explanation:** Frame the ML target to match the business question. "Top revenue" is what she optimizes.

---

**Question 4:** Why are the acceptance criteria more important than the choice of algorithm?
A. They're not
B. Acceptance criteria are the CONTRACT (what the deliverable must do). The algorithm is the implementation choice; many algorithms can satisfy the same contract.
C. Algorithms are useless
D. Random

**Answer:** B
**Explanation:** This is engineering vs research. Engineers contract on outputs; implementation is taste. Models can be swapped.

---

### Quiz 2
#### Scenario: The Whole Course in One Project

The mini project reuses everything from Lessons 6 to 22.

**Question 5:** Which Lesson 9 numpy idiom does the project's `LinRegScratch.fit` use?
A. Gradient descent
B. The normal equation: `np.linalg.solve(X.T @ X, X.T @ y)`
C. Random sampling
D. Pickle

**Answer:** B
**Explanation:** Closed-form linear regression. One numpy line. Lesson 9's main insight.

---

**Question 6:** Which Lesson 22 idiom packages the trained model for deployment?
A. print()
B. `pickle.dumps(model)` — serialize to bytes
C. Email
D. There's no packaging

**Answer:** B
**Explanation:** Sandbox-safe serialization. Same idea as `joblib.dump` for non-sandbox environments.

---

**Question 7:** What's the final message of the course?
A. "Use sklearn for everything"
B. "This is the end of Dan's ML story — but the beginning of yours" — you have the foundation; go build for your community
C. "ML is impossible"
D. "Only PhDs can do ML"

**Answer:** B
**Explanation:** The course's purpose was to build the foundation. The Filipino dev community in 2026 needs more people who can build, not just talk about it.

---
