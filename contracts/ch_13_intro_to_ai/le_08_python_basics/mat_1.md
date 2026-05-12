## Previously on Dan's AI Journey...

Dan wrote his first real Python program — a carinderia profit calculator using variables, math, and f-strings.

---

## Background Story

It was raining sideways in Manila. The kind of rain that turned EDSA into a parking lot and made every coffee shop suddenly full of people pretending to be productive. Dan had taken refuge in Coffee Project near his university. His secondhand laptop hummed at 47% battery. His brain hummed at maximum capacity.

He was stuck on a problem.

His Lesson 7 profit calculator worked perfectly — for ONE dish. But Tita Malou's carinderia had 20+ dishes on the menu. He'd have to copy-paste the calculator code 20 times? Change all the variable names manually? That couldn't be right.

He messaged Kuya JM.

> **Dan:** *"Kuya, my profit calculator works for one dish. How do I make it work for the WHOLE menu without copy-pasting code 20 times?"*
>
> **Kuya JM:** *"Welcome to LOOPS, my friend. Loops are how programmers say 'do this thing for every item in a list.' It's literally everywhere. When Mama serves customers one by one — that's a loop. When you scroll through TikTok — that's a loop. When the jeepney driver picks up passengers along the route — that's a loop with conditionals (stop when full, accept payment, give change)."*
>
> **Kuya JM:** *"And conditionals — if/elif/else — are how programs make DECISIONS. Senior citizen? Apply 20% discount. Order over P500? Free dessert. Out of stock? Suggest alternative. Every program with intelligence uses conditionals."*

Dan looked at his laptop. The rain pattered on the window. He cracked his knuckles, opened a new file, and started typing. By 11 PM, he had a complete carinderia ordering system — menu display, customer ordering loop, senior discount logic, formatted receipt printing. He grinned at the screen.

He was actually building things now.

---

## Theory & Lecture Content

### Lists — Containers for Multiple Items

```python
menu = ["Adobo", "Sinigang", "Bistek", "Tinola", "Turon"]
print(menu[0])      # First item: "Adobo"
print(menu[-1])     # Last item: "Turon"
menu.append("Lumpia")  # Add to end
```

### Dictionaries — Key-Value Pairs

```python
dish = {"name": "Adobo", "price": 60, "category": "main"}
print(dish["name"])     # "Adobo"
print(dish["price"])    # 60
```

A list of dicts is a common pattern for menus, customers, etc.

```python
menu = [
    {"name": "Adobo", "price": 60, "category": "main"},
    {"name": "Turon", "price": 20, "category": "dessert"},
]
```

### For Loops — Do Something for Each Item

```python
for item in menu:
    print(f"{item['name']}: P{item['price']}")
```

Or with a counter:

```python
for i, item in enumerate(menu, 1):
    print(f"{i}. {item['name']}")
```

### While Loops — Repeat Until Condition Is False

```python
while True:
    choice = input("What to order (or 'done')? ")
    if choice == "done":
        break
```

### Conditionals — Make Decisions

```python
if is_senior:
    discount = total * 0.20
elif total > 500:
    discount = 50
else:
    discount = 0
```

### Comparison & Logical Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `==` | equal | `age == 18` |
| `!=` | not equal | `name != ""` |
| `<` `>` | less/greater than | `total > 500` |
| `<=` `>=` | less/greater or equal | `age >= 60` |
| `and` | both true | `is_senior and total > 500` |
| `or` | either true | `is_payday or is_holiday` |
| `not` | invert | `not is_open` |

### Useful String Methods

```python
"Adobo".lower()      # "adobo"
"  hello  ".strip()  # "hello"
"a,b,c".split(",")   # ["a", "b", "c"]
```

### Break and Continue

- `break` — exit the loop immediately
- `continue` — skip to the next iteration

---

## Key Takeaways

1. **Lists** hold multiple items in order. Access by index: `menu[0]`.
2. **Dictionaries** hold key-value pairs. Access by key: `dish["name"]`.
3. **For loops** iterate through every item in a collection.
4. **While loops** repeat until a condition becomes false (use `break` to exit).
5. **Conditionals** (if/elif/else) let your program make decisions.
6. **Comparison and logical operators** combine to express complex conditions.
7. **A list of dictionaries** is the foundational structure for almost every dataset and menu.

---

## What's Next?

Dan can write Python — but real AI developers don't build everything from scratch. They use libraries. Three lines of pandas can do what 50 lines of raw Python would.

**Next Lesson: Working with Libraries** — Dan meets numpy and pandas.

**Next:** Quiz then exercises.
