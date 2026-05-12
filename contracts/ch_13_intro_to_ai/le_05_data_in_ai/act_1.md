# Data Explorer

Let's use Python's built-in `csv` module to read and analyze real carinderia sales data. No external libraries needed — just Python!

---

## Task 1: Read and Explore the Data

Open `act_1.py`. The starter code **generates a small sample CSV inline** (so you don't need external files), then provides TODO markers for you to:

1. **Read the CSV** with `csv.DictReader` into a list of dicts called `rows`.
2. **Print how many rows** were loaded and what columns exist.
3. **Peek at the first 5 rows** with nicely formatted output.
4. **Find unique items** using a `set()`.
5. **Calculate total revenue** by summing `int(row["revenue"])`.
6. **Find the best-selling item** by accumulating quantities in a dict.
7. **Compare payday vs non-payday** average revenue.

### How to Run

```
python act_1.py
```

### Key Python Patterns

- **`csv.DictReader(file)`** — each row becomes a dict keyed by column name
- **`set()`** — stores only unique values
- **Dictionary accumulation**: `d[key] = d.get(key, 0) + value` is a common pivot-table pattern
- **`sorted(items, key=lambda x: x[1], reverse=True)`** — sort by the second element, descending
- **f-string alignment**: `f"{item:12s}"` pads to 12 characters

---

## Task 2: Reflect

After running your analyzer, answer:

1. Which dish sold the most (by quantity)?
2. What percentage higher is payday revenue compared to non-payday?
3. If Tita Malou only looked at data from sunny days, what insights would she miss?

---

## Challenge: Weather Analysis and Weekly Trends

### Challenge 1: Weather Effect on Sinigang

Do rainy days really sell more sinigang? Group all sinigang sales by weather condition and compare averages.

### Challenge 2: Revenue by Day of Week

Which day of the week generates the most revenue? Create a text bar chart showing revenue per day.

### Challenge Sample Output

```
CHALLENGE 1: Weather Effect on Sinigang
---------------------------------------------
      rainy: avg 15.0 per sale, 45 total (3 sales)
      sunny: avg  6.0 per sale,  6 total (1 sales)

CHALLENGE 2: Revenue by Day of Week
---------------------------------------------
   Friday     | P 8,160 | ########################
   Saturday   | P 2,360 | ###########
   Thursday   | P 1,520 | #######
   ...

   Best day:  Friday (P8,160)
   Worst day: Monday (P560)
```

---

## What You've Learned

- Reading CSV data with `csv.DictReader`
- Using `set()`, dictionaries, and `sorted()` for analysis
- The dictionary accumulation pattern (like a pivot table)
- Real-world insight extraction from raw data
- Why data quality matters for AI

Next up: **Structured vs Unstructured Data** — Dan discovers why not all data is created equal.

---

<details>
<summary><strong>Answer Key</strong></summary>

See `act_1.answer.py` for the complete solution including the weather-on-sinigang analysis and day-of-week revenue bar chart.

### Reflection Answers

1. **Best seller**: Kare-Kare sold the most in the sample data (50 total units).
2. **Payday boost**: Average payday revenue is significantly higher than non-payday (typically 40–80% depending on weather).
3. **Missing sunny-only data**: She'd miss that sinigang sells 2–3x more on rainy days — one of her strongest patterns.

</details>
