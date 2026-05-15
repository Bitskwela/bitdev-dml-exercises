# CH-14 Intro to ML — Quality Audit

**Scope:** 25 lessons (`le_01`..`le_25`) under `contracts/ch_14_intro_to_ml/`.
**Date:** 2026-05-15

The chapter arrives in much better shape than ch_13's first submission — no Answer Key leakage, no section bloat, sandbox-safe I/O throughout.

---

## ⚠️ Major

### 1. ~~pandas used in 15 of 25 lessons — Pyodide confirmation still open~~ ✅ RESOLVED

**Confirmed 2026-05-15:** pandas is available in Pyodide. The Pyodide project explicitly lists pandas among its supported scientific packages and it is pre-installed in browser-based Pyodide environments. Source: https://pyodide.org

No rewrites required. All 15 ch_14 lessons and the 2 flagged ch_13 lessons (`le_09`, `le_17`) may keep their `import pandas` usage as-is.

**Recommended follow-up (non-blocking):** add a one-line note to `mat_1.md` in affected lessons confirming that `import pandas` works in the sandbox. This prevents future reviewers from re-raising the same question.

### 2. Pyodide compatibility fallback strategy (ch_13 + ch_14) ✅ RESOLVED

Fallback strategy is no longer needed given the pandas confirmation above. Kept below for reference in case a future Pyodide version drops the package.

<details>
<summary>Archived fallback pattern (stdlib csv + io.StringIO)</summary>

**Affected lessons if pandas were unavailable:**

| Chapter | Lessons using pandas |
| ------- | -------------------- |
| ch_13   | `le_09`, `le_17` |
| ch_14   | `le_06`, `le_08`, `le_09`, `le_10`, `le_12`, `le_13`, `le_14`, `le_15`, `le_17`, `le_18`, `le_19`, `le_20`, `le_22`, `le_23`, `le_25` |

```python
# Replace: import pandas as pd / pd.read_csv(...)
import csv, io

raw_csv = """col_a,col_b
1,2
3,4"""

reader = csv.DictReader(io.StringIO(raw_csv))
rows = list(reader)
```

Reference implementation already in `ch_14/le_09_linear_regression/act_1.py`.

</details>

### 3. Starter files in algorithm lessons are too dense

Three lessons pre-populate so much boilerplate that the student's actual implementation surface is hard to find:

| Lesson                          | Starter lines | Answer lines | Ratio |
| ------------------------------- | ------------- | ------------ | ----- |
| `le_15_random_forest/act_1.py`  | 131           | 157          | 83%   |
| `le_18_model_tuning/act_1.py`   | 112           | 139          | 81%   |
| `le_14_decision_trees/act_1.py` | 112           | 152          | 74%   |

Students must read through 100+ lines to locate 3–4 TODOs. Consider splitting the boilerplate into a provided helper module or trimming setup code so the task surface is visible at a glance.

### 4. `le_24_ml_vs_ai_vs_dl` scaffolding gap is too large in the other direction

At 36 lines, this starter is the thinnest in the chapter against a 115-line answer — a 3× gap. The three `pass`-stubbed functions (`predict_rules`, `forward_net`, and an entirely absent logistic regression section) give minimal guidance on how to compose a neural net forward pass. Students who haven't memorised matrix shapes from Lesson 9 will be stuck with no anchor.

**Action:** add at least the weight and bias initialisation as given data (not a TODO) and annotate each `pass` with the expected tensor shapes.

---

## 🔹 Minor

- **Quiz templates are uniform across all 25 lessons** — every `quiz.md` is exactly 90 lines using the same 7-question + 2-scenario format. Lessons in the harder second half (`le_14`–`le_25`) should have questions that require reasoning, not just definition recall. Vary difficulty.
- **"Dan's Story" section in `mat_1.md`** — this is the structural equivalent of ch_13's removed "Dan's Journal" block. At current lengths (max 89 lines, median ~74) it is not a blocker, but once the protagonist is retconned the heading `## Dan's Story: …` needs updating too. Keep an eye on length creep as the chapter matures.
- **No `act_1.test.py` files** — consistent with ch_09 and ch_13. Deliberate, but should be formally documented as a chapter-wide convention decision so reviewers stop flagging it.
- **`mat_1.md` for `le_14_decision_trees` is the longest at 89 lines** — slightly over the ~70 line ch_01 target. Not a blocker at this margin but watch it.

---

## 🟢 NIT

- `le_22_model_deployment/act_1.answer.py:108` includes an inline comment explaining why `pickle.dumps` is used instead of `joblib.dump` — this is good practice; keep it.
- `le_04_regression` is a baseline-arithmetic lesson (mean / median / moving average), not a model lesson. Consider labelling this more clearly in `meta.md` description so it isn't mistaken for a regression model exercise.
- Permanames all unique; slugs match permanames; types all `ActivityExercise`. `meta.md` hygiene is clean.

---

## ✅ What's working well

- **No Answer Key leakage** — zero `<details>` blocks in any `act_1.md`. Clean from day one.
- **No sklearn dependency anywhere** — all ML algorithms are from scratch in numpy: `LinearRegressionScratch`, `LogisticRegressionScratch`, `DecisionTreeScratch`, `RandomForestScratch`, `KMeansScratch`, PCA via `np.linalg.svd`. Excellent for sandbox compatibility and pedagogically stronger than a one-liner `sklearn` call.
- **No filesystem writes** — all CSV data is inline via `io.StringIO` throughout. The ch_13 `le_05`/`le_06` issue does not repeat here.
- **`pickle` usage is sandbox-safe** — `le_22` and `le_25` use `pickle.dumps(model)` to bytes in memory only. No disk writes anywhere.
- **Tags are clean** — the `"markdown"` and `"metadata"` noise tags from ch_13 are gone. Tags start with `["bitskwela", "ai", "ml", …]` and include meaningful tech tokens (`"linear-regression"`, `"random-forest"`, `"pca"`, etc.).
- **Dates are staggered** — one lesson per calendar day from `2026-06-16` onward. The ch_13 "all same date" issue is resolved.
- **Narrative continuity is strong** — Luto v1 (rule-based, ch_13) → Luto v2 (ML-driven, ch_14) is a clear, motivating arc that carries across both chapters.
- **`mat_1.md` lengths are within range** — max 89 lines, no Filipino Culture Cards, no Dan's Journal. The brevity improvement from ch_13 holds.

---

## Verdict

**Approved with two required follow-ups tracked below.** No structural blockers. The technical quality (from-scratch algorithms, sandbox safety, tag hygiene, date staggering) is a genuine step up from ch_13's first submission.

---

## Required fix order

1. ~~**Get platform team confirmation on pandas in Pyodide.**~~ ✅ **RESOLVED 2026-05-15** — pandas is confirmed available in Pyodide. No rewrites needed.
2. Trim dense starters in `le_14`, `le_15`, `le_18` so TODOs are visible without reading 100+ lines.
3. Strengthen `le_24` scaffolding — add weight/bias initialisations as given data and annotate `pass` stubs with expected tensor shapes.
4. Vary quiz difficulty in `le_14`–`le_25` (reason-based questions, not just recall).
