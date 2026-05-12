## Dan's Story: A Flowchart, Not a Sum

Thursday morning. Dan was on a jeepney from Marikina to Diliman. He scribbled three lines in his pocket notebook:

```
Tita Malou's gut isn't a sum.
It's a flowchart.
  Payday? --YES--> Big batch
            --NO--> Rainy? --YES--> Sinigang heavy
                            --NO--> Normal
```

Linear and logistic regression are *additive*. Decision trees are *hierarchical*. Each node's question depends on which branch you came from — so interactions emerge for free.

> **Ate Rina:** Trees are more powerful AND more interpretable. You can read the tree out loud to Tita Malou and she'll nod along.

---

## The Concept: A Tree of If-Statements

### Structure

Each internal node asks a yes/no question about a feature. Each leaf predicts a class. To predict for a new row, walk from root to leaf following the answers.

```
                  is_payday?
                  /         \
                YES           NO
                /              \
        is_friday?         is_rainy?
        /        \         /        \
      YES        NO      YES         NO
       |          |       |          |
     BUSY      BUSY     BUSY      NOT_BUSY
```

### Gini Impurity

For a node containing rows from class distribution `(p_busy, p_not_busy)`:

```
Gini = 1 - (p_busy² + p_not_busy²)
```

- Gini = 0 → perfectly pure (all same class)
- Gini = 0.5 → 50/50 (maximally mixed)

### Picking a Split

For each candidate (feature, threshold):

1. Split rows into left (`feature <= threshold`) and right
2. Compute `gini_left` and `gini_right`
3. Weighted average: `(n_left/n) · gini_left + (n_right/n) · gini_right`

Pick the split with the LOWEST weighted Gini. Recurse on left and right.

### Stopping Conditions

Without limits, the tree memorizes (overfits). Stop when:

- Max depth reached
- Min samples per leaf falls below a threshold
- Node is already pure (gini = 0)
- Splitting wouldn't improve gini enough

`max_depth` is the most important knob. Shallow = simple + interpretable. Deep = complex + overfit-prone.

### Why Trees Find Interactions for Free

A linear model adds features. A tree's deeper levels are *conditional on earlier splits*. After splitting on `is_payday`, the left and right branches can each make a different `is_friday` decision — which is exactly the `payday × Friday` interaction.

---

## Key Takeaways

- **Decision trees are flowcharts.** Each node = a feature/threshold test. Each leaf = a prediction.
- **Gini impurity** measures node mixedness; we split to minimize weighted child Gini.
- **Trees find interactions automatically** — no need to engineer `a × b` columns.
- **`max_depth`** is the key complexity knob. Shallow trees are interpretable AND less overfit.
- **The first split is data-driven, not designed.** Our tree picks `is_payday` on its own.

---

## What's Next?

A single deep tree overfits. Many shallow trees averaged together don't. Tomorrow: bag 10 shallow trees and majority-vote.

**Next Lesson: Random Forest** — ensemble of weak trees beats one strong tree.
