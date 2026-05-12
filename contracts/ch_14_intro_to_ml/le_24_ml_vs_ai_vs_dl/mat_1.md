## Dan's Story: The Napkin Venn Diagram

Sunday breakfast. Tita Malou had been hearing "AI", "ML", "Deep Learning" everywhere. She asked Dan.

> **Tita Malou:** Pareho ba 'yan o magkaiba?
>
> **Dan:** Magkakapatid sila ma. Tatlong bilog. AI yung pinaka-malaki — anything that acts smart. ML yung sub-set — AI that learns from data. DL yung pinaka-loob — ML using deep neural networks.

He drew three nested circles on a napkin.

```
                   AI (umbrella)
              ┌─────────────────────┐
              │     ML (subset)     │
              │   ┌─────────────┐   │
              │   │ DL (innermost) │ │
              │   └─────────────┘   │
              └─────────────────────┘
```

> **Tita Malou:** So Luto v2 — ML, hindi DL?
>
> **Dan:** Tama ma. Random Forest. ML. Not DL.

She nodded, served sinigang, and asked when DL would come in. He said: *next course*.

---

## The Concept: The Three Nested Circles

### AI (broadest)

**Any system that makes a computer act intelligently.** Includes:

- Rule-based systems (Luto v1)
- Search algorithms (chess engines)
- Machine learning (the inner circle)
- Deep learning (the innermost circle)

### ML (middle)

**Systems that learn patterns from data instead of being given rules.** All of this course is ML:

- Linear / logistic regression
- Decision trees / Random Forest
- K-Means clustering
- PCA

### DL (innermost)

**ML models that use deep (many-layered) neural networks.**

- CNNs — image recognition
- RNNs / Transformers — language
- Most "modern AI" you read about

DL is OVERKILL for most tabular business problems. Random Forest on 977 rows often beats a small neural net while being faster and more interpretable.

### When to Reach for Each

| Data shape | Use |
|---|---|
| Tabular, < 1M rows | ML (Random Forest, XGBoost) |
| Images, audio | DL (CNNs) |
| Text at scale | DL (Transformers) |
| Hand-written rules sufficient | AI (rule-based — no ML needed) |

---

## Key Takeaways

- **AI > ML > DL** is a nested-circle relationship.
- **Luto v1 = AI** (rules). **Luto v2 = ML** (Random Forest). **Hypothetical Luto v3 = DL** (image recognition).
- **Most production ML is NOT DL.** Tabular + Random Forest / XGBoost rules day-to-day work.
- **DL wins on unstructured data at scale** — images, text, audio.
- **The right algorithm depends on the data shape**, not on what's trendy.

---

## What's Next?

Dan has the map. Tomorrow: the capstone. Ship Luto v2 — an ML-powered ulam forecaster.

**Next Lesson: Mini ML Project** — predict tomorrow's top-selling ulam.
