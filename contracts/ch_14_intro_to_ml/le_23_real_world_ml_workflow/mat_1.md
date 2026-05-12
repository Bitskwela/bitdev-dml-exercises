## Dan's Story: The Capstone Notebook

Saturday morning. Ate Rina at tapsilog breakfast near the bus terminal.

> **Ate Rina:** Bata, you've learned the parts. Now show me the whole. One script. Load CSV. Engineer features. Cross-validate three models. Pick the best. Train on full data. Evaluate on held-out test. Serialize. Print a forecast. *Everything from Lessons 6 to 22, top to bottom, in one auditable file.*
>
> **Dan:** Like a final exam?
>
> **Ate Rina:** Sus, no. Like a DELIVERABLE. Six months from now you'll open this file and remember everything. That's the point.

He spent the afternoon on it. 150 lines. Every section in order. The reviewer can read it top to bottom without questions.

---

## The Concept: One Script, All the Parts

### Anatomy of a Reviewable Workflow

| Section | Purpose | Lines |
|---|---|---|
| Imports | Dependencies | 10 |
| Constants | Paths, seeds, hyperparams | 5 |
| Load | CSV → DataFrame, audit | 10 |
| Clean | dtype fixes | 5 |
| Engineer | Feature columns | 15 |
| Split | Train / test split | 5 |
| Models | Candidate models + CV | 20 |
| Select | Pick best by CV mean | 5 |
| Fit + Test | Touch test ONCE | 10 |
| Serialize | pickle.dumps | 3 |
| Forecast | Demo prediction | 15 |
| **Total** | | **~100-150** |

Every section prints its result. The output is the audit trail.

### Three-Set Discipline

1. **Train** (60%) — fit models
2. **Validation** (20%) — pick hyperparameters via CV
3. **Test** (20%) — touched ONCE at the very end

Or: train (80%) with 5-fold CV inside + test (20%) once.

### Why One Script?

In exploratory work, multiple notebooks are fine. For deliverables and production, ONE auditable script wins:

- Reviewer can read top to bottom
- No "did the engineering step actually run?" doubts
- Re-running gives the same output (with the same seed)

---

## Key Takeaways

- **A real ML script has 9-11 sections** in a specific order: imports → constants → load → clean → engineer → split → CV → select → fit → test → serialize → forecast.
- **Every section prints its result.** Output IS the audit trail.
- **Cross-validation happens on train+val only.** Test set is touched once.
- **The deliverable is the script + the forecast** — what reviewers and stakeholders read.

---

## What's Next?

Dan has the workflow. Before the capstone project, one last zoom-out: where does ML fit in the bigger AI picture? Tomorrow: AI > ML > DL on a paper napkin over Sunday breakfast.

**Next Lesson: ML vs AI vs DL** — the three nested circles.
