# Eyeball the Carinderia Data

Run the four exploration functions on a sample of Tita Malou's sales. Find three patterns *without* training a model.

---

## Task 1: Load and Eyeball

Open `act_1.py`. The starter has a 30-row CSV string embedded inline. Use pandas to:

1. `pd.read_csv(StringIO(SAMPLE_CSV))` into `df`
2. Print `df.head()`
3. Print `df.info()`
4. Print `df.describe()`
5. Print `df["item"].value_counts()` and `df["weather"].value_counts()`

---

## Task 2: Fix dtypes

`is_payday` will load as strings `"True"`/`"False"`. Convert to real booleans:

```python
df["is_payday"] = df["is_payday"].map({"True": True, "False": False})
```

Convert `date` to datetime:

```python
df["date"] = pd.to_datetime(df["date"])
```

Print the new dtypes.

---

## Task 3: Find Three Patterns

Use `groupby` to confirm three patterns Tita Malou already knows:

1. Average revenue on payday rows vs non-payday rows
2. Top-selling item on rainy days (by total quantity)
3. Most-busy day-of-week × payday combination by total revenue

---

## Sample Output

```
======================================================================
  HEAD
======================================================================
        date        item  quantity  revenue day_of_week  is_payday weather
   2025-08-01      Bistek         7      665      Friday      False  cloudy
   ...

  Avg revenue: payday=1240, non-payday=830
  Sinigang dominates rainy days.
  Payday Fridays are the busiest combination.
```

---

## Reflection Questions

1. Which `.info()` output suggested you needed dtype fixes?
2. Why are `value_counts()` results useful for ML?
3. Pick a pattern Tita Malou would already know. Did `groupby` confirm it?

---

## What You've Learned

- The four pandas exploration functions every project starts with
- How to fix common dtype mismatches on CSV load
- Why `groupby` confirms intuitions before any model is trained
