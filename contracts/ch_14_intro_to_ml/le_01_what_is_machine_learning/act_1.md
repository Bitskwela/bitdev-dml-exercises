# Rules vs. Examples — Your First ML Mindset Shift

Today's activity is short. The goal is to *feel* the shift from rules to examples. You will not train a model yet — you will look at the same problem two different ways.

---

## Task 1: Code the Rule-Based Brain

Open `act_1.py`. The starter has a function called `recommend_ulam_rule_based(weather, is_payday, day)` with TODOs.

Fill in the if-elif chain so the function returns:

| Conditions | Returned dish |
|---|---|
| `is_payday=True` and `weather="sunny"` | `"Kare-Kare"` |
| `is_payday=True` and `weather="rainy"` | `"Sinigang"` |
| `weather="rainy"` | `"Sinigang"` |
| `day="Friday"` | `"Kare-Kare"` |
| `day="Sunday"` | `"Lechon Kawali"` |
| (anything else) | `"Adobo"` |

Run it on the three test rows printed at the bottom of the file and check the output.

---

## Task 2: Build the Example-Based View

The same logic can be expressed as a list of `(features, label)` tuples. Tita Malou's 15 years of carinderia memory looks like this — except with thousands of rows.

Fill in the `examples` list with **at least 6 rows** in the format:

```python
("weather", is_payday, "day_of_week", "ulam_chosen")
```

Then print the unique labels found in your examples (use `set()`).

---

## Sample Output

```
==================================================
  RULE-BASED LUTO (Approach 1)
==================================================
   Friday     | sunny  | payday=True  ->  Kare-Kare
   Tuesday    | rainy  | payday=False ->  Sinigang
   Monday     | cloudy | payday=True  ->  Adobo

==================================================
  EXAMPLE-BASED VIEW (Approach 2)
==================================================
   Number of training examples: 8
   Unique labels: ['Adobo', 'Kare-Kare', 'Lechon Kawali', 'Sinigang']
   Features per example: 3
```

---

## Reflection Questions

1. If Tita Malou opens a new dish (`Pinakbet`), which approach is easier to update — typing a new if-statement or adding new example rows?
2. Imagine the notebook has 5,000 entries across 4 weathers, 7 days, 2 payday states, and 12 dishes. Roughly how many `if-elif` cases would you need to cover every combination?
3. Where do the *rules* in the rule-based approach come from? Where do the *rules* in a future ML model come from?

---

## Challenge: Scale-Test the Approaches

In Python, simulate adding 100 new training examples to the `examples` list (use a loop with synthetic random tuples). Notice how trivial that is compared with writing 100 new if-statements.

This is a thought experiment — the point is to feel that **adding a row is easier than adding a rule**. That's why ML eats the world.

---

## What You've Learned

- ML replaces hand-written rules with learned patterns from data
- Examples can express the same logic as rules — and scale better
- This is the conceptual shift behind every model in the rest of the course
