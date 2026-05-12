## Dan's Story: 977 Rows

Monday morning. Dan was at the university computer lab. He had just finished typing Tita Malou's notebook into a CSV — 977 rows, seven columns. He opened a notebook cell:

```python
import pandas as pd
from io import StringIO
df = pd.read_csv(StringIO(SAMPLE_CSV))
df.head()
```

Five rows of his mother's carinderia, formatted as a clean pandas table. He stared.

> **Ate Rina:** Bata. Wait. Before any model — eyeball the data. `.info()`. `.describe()`. `.value_counts()` on every categorical column. Send me the screenshots.

He spent forty minutes reading the output column by column. By the end he had a notebook full of observations: `date` was a string, `is_payday` was a string, weather tilted sunny, no nulls (lucky). Then he fixed the dtypes and saved a cleaned copy.

> **Ate Rina:** Naks bata. *Every* ML project goes wrong because someone skipped the eyeball step. Skip the five minutes — lose a week debugging.

---

## The Concept: Eyeball Before Model

### The Four Functions

| Function | What it tells you |
|---|---|
| `df.head()` / `df.tail()` | What does a real row look like? Columns as expected? |
| `df.info()` | Row count, dtypes, null counts |
| `df.describe()` | Numeric column ranges (min/max/mean/median) |
| `df["col"].value_counts()` | For each categorical column, what's in it and how balanced |

Run these every time, every dataset. Surprises here will become surprises in training.

### dtypes Matter

A column stored as `"True"` (string) does NOT behave like `True` (boolean). Pandas sometimes guesses wrong on CSV load. Common fixes:

```python
df["is_payday"] = df["is_payday"].map({"True": True, "False": False})
df["date"] = pd.to_datetime(df["date"])
```

### Sandbox-Safe Loading

In the bitdev sandbox, there is no writable filesystem. Load data via `io.StringIO` with the CSV string embedded directly:

```python
from io import StringIO
SAMPLE_CSV = """date,item,quantity,revenue,day_of_week,is_payday,weather
2025-08-01,Sinigang,13,910,Friday,False,cloudy
... (more rows) ...
"""
df = pd.read_csv(StringIO(SAMPLE_CSV))
```

The full 977-row dataset lives in the standalone Intro-to-ML repo. For each lesson here, we embed a 30-50 row representative subset inline.

---

## Key Takeaways

- **Eyeball before modeling.** `.head()`, `.info()`, `.describe()`, `.value_counts()` — every time.
- **dtypes are not what you think.** Strings posing as booleans, dates posing as strings — convert early.
- **Use `groupby` to find patterns** the model should also recover.
- **Sandbox-safe data lives inline** as a `StringIO`-fed CSV string.

---

## What's Next?

Dan now has loaded data and good eyeball habits. Next question: how do you actually *evaluate* a model without lying to yourself? Tomorrow Dan brags about a 99% accuracy and Ate Rina catches him testing on the training data.

**Next Lesson: Train vs Test Split** — the three rules of test data.
