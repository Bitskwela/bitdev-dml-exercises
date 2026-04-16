## Previously on Dan's AI Journey...

Dan built a complete carinderia ordering system using lists, loops, and conditionals — proving he could handle real Python projects.

---

## Background Story

It was Sunday afternoon. Dan had a video call with Kuya JM, who was bouncing his baby on his lap while sharing his screen.

> **Kuya JM:** *"Watch this, Dan."*

Kuya JM opened a Python file. He typed three lines:

```python
import pandas as pd
df = pd.read_csv("sales.csv")
print(df.describe())
```

He hit Run. A clean table appeared instantly: count, mean, standard deviation, min, max, percentiles — all the descriptive statistics for the entire sales dataset.

Dan blinked. *"Wait... that's it? Three lines? In raw Python that would be like 50 lines."*

> **Kuya JM:** *"That's why we use libraries. Pandas already wrote the hard code. You just import it and use it. Same with numpy for fast math, matplotlib for charts, scikit-learn for ML, tensorflow for deep learning. Standing on the shoulders of giants."*

Two hours later, Dan was deep in the carinderia sales CSV. Loading data with pandas. Filtering rows. Grouping by item. Calculating revenue shares. Discovering that sinigang sells 3x more on rainy days. Finding that paydays boost overall revenue by 60%. Charts in his head. Patterns everywhere.

He wrote a complete analysis in 40 lines that would have taken 200+ in raw Python.

---

## Theory & Lecture Content

### What is a Library?

A **library** (or "package" or "module") is a collection of pre-built code you can `import` and use. Instead of writing everything from scratch, you reuse code that experts have already perfected.

```python
import numpy as np       # `np` is a common alias
import pandas as pd      # `pd` is universal
import matplotlib.pyplot as plt
```

### Installing Libraries with pip

```
pip install numpy pandas matplotlib
```

You only install once. After that, just `import` in your code.

### The Big Three for AI/Data Science

| Library | Purpose | Killer Feature |
|---------|---------|----------------|
| **numpy** | Fast math on arrays | Vectorized operations (no loops needed) |
| **pandas** | Data analysis | DataFrames — like Excel in code |
| **matplotlib** | Visualization | Charts and graphs in 1-3 lines |

### numpy Quick Tour

```python
import numpy as np

prices = np.array([60, 75, 80, 65, 90])
quantities = np.array([12, 8, 5, 10, 3])

revenue = prices * quantities      # element-wise multiplication, no loop!
print(np.mean(revenue))            # average
print(np.sum(revenue))             # total
print(np.max(revenue))             # max single transaction
```

### pandas Quick Tour

```python
import pandas as pd

df = pd.read_csv("sales.csv")    # load the file
df.head()                          # first 5 rows
df.describe()                      # summary statistics
df.shape                           # (rows, columns)
df.info()                          # column types and counts
df.columns                         # list of column names

# Filtering — get high-revenue rows
big_sales = df[df["revenue"] > 500]

# Sorting — top sellers first
top = df.sort_values("revenue", ascending=False)

# Grouping — total revenue per item
by_item = df.groupby("item")["revenue"].sum()
```

These three lines (`read_csv`, `groupby`, `sum`) replace what would be 30+ lines in raw Python.

### Why Libraries Matter

- **Speed**: numpy is written in C — 100x faster than pure Python loops
- **Correctness**: peer-reviewed, used by millions; bugs are rare
- **Conciseness**: less code = fewer mistakes
- **Standard**: every AI engineer uses these — your code is portable

---

## Dan's Journal

> **March 22, 2026 — Dorm, Sunday night**
>
> Pandas is a superpower. I just analyzed Mama's carinderia CSV — 50 rows of sales data — and pulled out insights I didn't even know to look for:
>
> - Adobo sells the most by quantity
> - Kare-Kare brings the most revenue
> - Payday boosts revenue 60%
> - Sinigang on rainy days sells 3x more than sunny days
> - Friday is the busiest revenue day
>
> All of that with 40 lines of code. In raw Python it would have been hundreds. The library does the heavy lifting.
>
> Kuya JM was right — "standing on the shoulders of giants" is real. Some smart engineers at PyData wrote pandas. I just import it. Beautiful.
>
> Next: actual algorithms.

---

## Key Takeaways

1. **Libraries are pre-built code** you import to avoid reinventing the wheel.
2. **`pip install`** to install once, **`import`** to use in code.
3. **numpy** = fast math on arrays (vectorized, no loops needed).
4. **pandas** = DataFrames for tabular data analysis (read_csv, head, describe, groupby).
5. **matplotlib** = quick visualization (plt.bar, plt.plot, plt.show).
6. **Libraries are 100x faster** than pure Python loops because the heavy work is in compiled C.

---

## Filipino Culture Cards

| Term | Pronunciation | What It Means |
|------|--------------|---------------|
| **Carinderia** | kah-rin-DEH-ryah | A small, family-run eatery — the heart of Filipino street food culture. |
| **Turon** | too-ROHN | Crispy spring roll with banana and jackfruit, caramelized sugar coating. A favorite merienda. |

---

## What's Next?

Dan can analyze data now. But Jasper mentioned "algorithms" — what does that even mean? Time to learn how computers solve problems step by step.

**Next Lesson: What is an Algorithm?** — Dan demystifies algorithms with sorting and searching.

**Next:** Quiz then exercises.
