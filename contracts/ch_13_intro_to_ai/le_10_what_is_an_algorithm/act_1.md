# The Algorithm Lab

Implement four classic algorithms on Tita Malou's menu: bubble sort, Python's built-in sort, combo-meal finder, and linear + binary search.

---

## Task 1: Bubble Sort

Open `act_1.py`. Sort the menu by price using bubble sort â€” manually, with nested loops. Count how many swaps happen.

---

## Task 2: Python's Built-in Sort

Replace your bubble sort with `sorted(menu, key=lambda x: x["price"])`. Compare:
- Your bubble sort: O(nÂ²)
- Python's Timsort: O(n log n)

On 10 items both are fast, but on 1,000,000 items bubble sort takes hours â€” Timsort takes seconds.

---

## Task 3: Combo Finder

Write a `find_best_combo(menu, budget)` function that:
- Tries every pair of dishes
- Returns the highest-rated combo that fits the budget
- Uses two nested loops (O(nÂ²))
- Counts how many pairs it checked

---

## Task 4: Linear Search

```python
def linear_search(menu, target_name):
    for item in menu:
        if item["name"].lower() == target_name.lower():
            return item
    return None
```

Test it. On a 10-item menu, worst case = 10 checks.

---

## Task 5: Binary Search

On the sorted menu:

```python
def binary_search(sorted_menu, target_name):
    low, high = 0, len(sorted_menu) - 1
    while low <= high:
        mid = (low + high) // 2
        if sorted_menu[mid]["name"] == target_name:
            return sorted_menu[mid]
        elif sorted_menu[mid]["name"] < target_name:
            low = mid + 1
        else:
            high = mid - 1
    return None
```

On a 10-item sorted menu, worst case = 4 checks (logâ‚‚(10) â‰ˆ 3.3).

---

## Challenge: Triple Combo Finder

Extend the combo finder to find the best 3-dish combo. Use three nested loops. Count how many triples it checked (for 10 items: 10 choose 3 = 120).

### Sample Output

```
Best 3-combo for budget P200:
   Adobo (P60, 4.5â˜…)
   Sinigang (P65, 4.8â˜…)
   Halo-Halo (P60, 4.7â˜…)
   Total: P185
   Avg rating: 4.67â˜…
   Triples checked: 120
```

---

## What You've Learned

- Bubble sort (O(nÂ²)) â€” educational
- Python's `sorted()` â€” use this in real code
- Nested loops for combinatorial problems
- Linear search (O(n)) vs binary search (O(log n))
- The tradeoffs of algorithmic complexity

Next up: **Heuristics vs Learning** â€” Dan compares rule-based vs data-driven systems.
