# CH-13 Intro to AI — Quality Audit

**Scope:** 25 lessons (`le_01`..`le_25`) under `contracts/ch_13_intro_to_ai/`.
**Date:** 2026-05-05
**Contributor:** new dev

The chapter is well-themed and narratively strong, but has **two chapter-wide blockers** that require revision before merge.

---

## 🚫 Blockers (touch all 25 lessons)

### 1. Answer-key leakage in every `act_1.md`

Every activity ends with a `<details><summary>Answer Key</summary>` block reproducing `act_1.answer.py` verbatim (e.g. `le_01_what_is_ai/act_1.md:128-186`). Students click once and the activity is over. This contradicts the `act_1` / `act_1.answer` split convention used everywhere else in the repo.

**Action:** strip the Answer Key block from all 25 `act_1.md` files.

### 2. `mat_1.md` bloat — fails FreeCodeCamp brevity rule

Median 150 lines vs. `ch_01` baseline of ~70 lines. Lessons read as long-form blog articles rather than the punchy in-editor cards the React-Remix platform expects.

Worst offenders:

| Lesson                                   | Lines |
| ---------------------------------------- | ----- |
| `le_03_ai_vs_ml_vs_dl/mat_1.md`          | 199   |
| `le_25_deploy_ai_app/mat_1.md`           | 178   |
| `le_02_narrow_vs_general_ai/mat_1.md`    | 169   |
| `le_23_build_llm_chatbot_part2/mat_1.md` | 165   |
| `le_21_openai_api_basics/mat_1.md`       | 163   |

Bloat is concentrated in two repeated sections per lesson:

- **"Filipino Culture Cards"** glossary (duplicates across lessons — `Carinderia` is defined nearly every time)
- **"Dan's Journal"** first-person reflection block

**Action:** remove both sections chapter-wide; tighten remaining theory to ch_01 cadence.

---

## ⚠️ Major

- **`le_05_data_in_ai/act_1.answer.py:37`** writes a CSV to disk (`open(SAMPLE_CSV, "w")`). The in-browser React-Remix sandbox has no writable filesystem. Switch to `io.StringIO` like `le_09_working_with_libraries` already does. Same risk in `le_06`.
- **`le_25_deploy_ai_app`** is a Streamlit app (`streamlit run act_1.answer.py`) — not runnable in the in-browser runner. Decide whether it stays as walkthrough-only or gets reworked.
- **`le_15_computer_vision`** — `meta.md` advertises Pillow in `tags`, but neither `act_1.py` nor `act_1.answer.py` imports PIL. Either drop Pillow from tags or add a Pillow task.
- **`le_09_working_with_libraries`** + **`le_17_ethics_in_ai`** depend on `pandas`. Confirm with platform team that Pyodide ships pandas; otherwise these won't run.
- **`le_02_narrow_vs_general_ai/act_1.py:19-34`** — starter is ~60% pre-populated; the "TODO: add 5 more" is trivial copy-paste. Weak scaffolding gradient.

---

## 🔹 Minor

- All 25 lessons share date `2026-04-14` — consider staggering if dates indicate publication order.
- All `quiz.md` files are ~87 lines with the same 7-question + 2-scenario template. Consistent but mechanical — vary difficulty.
- `tags` arrays open with `["markdown", "metadata", "bitskwela", ...]` in every `meta.md`. The first two tags are meaningless metadata-about-metadata; recommend dropping repo-wide.
- `le_03_ai_vs_ml_vs_dl/act_1.py` — 89-line starter is heavy but acceptable; `pass`-stubbed functions make the task structure clear.
- No `act_1.test.py` files in the chapter. Matches `ch_09` convention but worth a deliberate decision.

---

## 🟢 NIT

- `meta.md` description for `le_07` says "carinderia profit calculator"; most other lessons use "Tita Malou's carinderia" — minor consistency improvement.
- `le_10_what_is_an_algorithm/act_1.py` is only 44 lines while the answer is 145 — verify starter has enough scaffolding, not just bare TODOs.
- Permanames all unique; slugs match permanames; types all `ActivityExercise`. `meta.md` hygiene is clean.

---

## ✅ What's working well

- **Filipino theming is strong and consistent**: carinderia, Tita Malou, Marikina, sinigang, GCash, Grab, Shopee, jeepney, barkada, payday, samgyupsal, Diliman dorm setting. No generic Western examples.
- **OpenAI track (`le_21`–`le_25`) uses `MockOpenAI` fallbacks** (`le_21/act_1.answer.py:11`, `le_22/act_1.answer.py:25`, `le_25/act_1.answer.py:23`) — sandbox-safe, no hard dependency on the real `openai` package.
- **`meta.md` hygiene is clean**: unique permanames, matching slugs, correct types.
- **Narrative arc and voice** clearly show the contributor understands the curriculum.

---

## Verdict

**Send back for revision.** The two blockers (answer-key leakage + `mat_1.md` bloat) both touch all 25 lessons and require structural rewrites, not patches. The Filipino theming, code correctness, and `meta.md` hygiene are genuinely strong — the contributor has the voice down. They just need to tighten the format to match `ch_01`.

Once the blockers plus the `le_05` filesystem write and `le_15` Pillow mismatch are fixed, the chapter should merge cleanly.

---

## Suggested fix order

1. Strip `<details>Answer Key</details>` block from all 25 `act_1.md` files (mechanical pass).
2. Remove "Filipino Culture Cards" + "Dan's Journal" sections from all 25 `mat_1.md` files; trim remaining theory to ~70-line ch_01 cadence.
3. Replace filesystem I/O with `io.StringIO` in `le_05` and `le_06`.
4. Resolve Pillow tag mismatch in `le_15` (drop tag or add task).
5. Confirm pandas availability in Pyodide for `le_09` / `le_17`.
6. Decide on Dan Santos vs. existing cast.
7. Strengthen `le_02` scaffolding gradient.
