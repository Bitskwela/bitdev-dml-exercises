# Carinderia Profit Calculator

Dan's first real Python project: a profit calculator for Tita Malou's carinderia. This program uses variables, data types, math operations, f-strings, and user input â€” all the basics you need to start coding for AI.

---

## Task 1: Build the Calculator

Open `act_1.py`. The starter has 8 labeled parts. Fill in each TODO:

1. **Part 2** â€” Declare 5 variables (`dish_name`, `cost_per_serving`, `selling_price`, `servings_today`, `is_bestseller`).
2. **Part 3** â€” Print each variable's type using `type(var).__name__`.
3. **Part 4** â€” Calculate `profit_per_serving`, `total_revenue`, `total_cost`, `total_profit`, `markup_percent`.
4. **Part 5** â€” Print a formatted profit report using f-strings.
5. **Part 6** â€” Demonstrate `/`, `//`, `%`, `**`.
6. **Part 7** â€” Show type conversion: `int("60")`, `float("35.50")`, `str(60)`.
7. **Part 8** â€” Interactive input with conditional feedback.

### Sample Output

```
=============================================
  CARINDERIA PROFIT CALCULATOR
=============================================

--- Variable Types ---
   dish_name:        str -> 'Adobo'
   cost_per_serving: float -> 35.5
   selling_price:    int -> 60

--- Profit Report for Adobo ---
   Cost per serving:    P35.50
   Selling price:       P60.00
   Profit per serving:  P24.50
   Markup:              69.0%
   Total Profit:        P294.00
```

---

## Task 2: Reflect

1. What's the difference between `/` and `//` in Python?
2. What does the `%` operator give you?
3. Why does Python have different types (int, float, str, bool)?

---

## Challenge: Full Menu Calculator

Build a calculator that handles Tita Malou's full menu (5 dishes in parallel lists):
- Items: Adobo, Sinigang, Bistek, Tinola, Turon
- Prices: 60, 65, 70, 55, 20
- Costs:  35, 38, 42, 30, 12

For each item, ask the user how many servings sold today. Calculate:
- Profit per item
- Total daily profit
- Most profitable dish (using `max()` + `.index()`)
- Least profitable dish

### Bonus

Add a performance rating:
- > P2000 total profit â†’ "Excellent!"
- > P1000 â†’ "Good day"
- > P0 â†’ "Breaking even-ish"
- else â†’ "Review pricing"

---

## What You've Learned

- Python variables, data types, and math operations
- f-string formatting with `:.2f`, `:.1f`
- `input()` and type conversion
- Writing clean, readable Python code
- Why Python reads like English

Next up: **Python Basics** â€” loops, lists, and conditionals.
