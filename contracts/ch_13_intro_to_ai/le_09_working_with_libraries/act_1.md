# Sales Analysis with pandas

Use pandas (and a sprinkle of numpy) to analyze Tita Malou's carinderia sales data. You'll do in 40 lines what would take 200+ lines in raw Python.

---

## Prerequisites

Install the libraries (one-time):
```
pip install pandas numpy
```

---

## Task 1: Load and Explore

The starter generates an inline sample dataset. Your job:

1. Load it into a pandas DataFrame with `pd.read_csv()`
2. Print `.head()`, `.shape`, `.info()`, `.describe()`

---

## Task 2: Find Best-Sellers

Use `groupby` to:
1. Find which dish sold the most by total quantity
2. Find which dish brought the most revenue
3. Print revenue share % for each dish

---

## Task 3: Payday Analysis

Compare average revenue on payday vs non-payday:
```python
by_payday = df.groupby("is_payday")["revenue"].mean()
```

---

## Task 4: Weather Effects

```python
by_weather = df.groupby("weather")["revenue"].agg(["mean", "sum", "count"])
```

---

## Task 5: Day-of-Week Analysis

Find the busiest day:
```python
by_day = df.groupby("day_of_week")["revenue"].sum().reindex(
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
)
```

### Sample Output

```
Best by quantity:  Adobo (124 units)
Best by revenue:   Kare-Kare (P8,400)

Payday boost: 60.2% higher revenue
Sinigang on rainy: avg P1,200 (3.0x sunny days)

Revenue by day:
   Monday    P 2,400 ####
   Friday    P 9,800 ##############
```

---

## Challenge: Business Intelligence Report

Answer these three questions with code:
1. Which item makes the most money on rainy days?
2. How much (%) more revenue on paydays vs normal days?
3. Which day needs the most ingredient prep?

Print your top 3 recommendations for Tita Malou.

---

## What You've Learned

- Loading CSV with `pd.read_csv()`
- DataFrame exploration: `head()`, `shape`, `info()`, `describe()`
- Filtering: `df[df["col"] > value]`
- Sorting: `df.sort_values()`
- Grouping: `df.groupby("col")["target"].sum()`
- Why libraries are 10-100x faster than pure Python

Next up: **What is an Algorithm?** â€” Dan demystifies sorting and searching.
