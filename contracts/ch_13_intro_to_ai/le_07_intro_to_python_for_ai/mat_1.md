## Previously on Dan's AI Journey...

Dan structured Tita Malou's messy notebook data into clean CSV files using Python's csv module.

---

## Background Story

It was a Tuesday afternoon, and the university computer lab smelled like floor wax and old air conditioning. Dan had claimed his usual spot — third row, corner seat, next to the window that didn't quite close all the way.

He had a mission today: learn Python properly.

Every AI tutorial he'd found online started the same way. Kaggle: "Step 1: Learn Python." Coursera: "Prerequisites: Python basics." Even the TechPinas hackathon FAQ said: "Recommended: Python proficiency."

He opened a group chat with Kuya JM.

> **Dan:** *"Kuya, why Python? Why not Java or C++? Java is what they teach us in school."*
>
> **Kuya JM:** *"Good question. Java is great for enterprise apps. C++ is great for speed. But for AI, Python is king. Three reasons: READABILITY — Python reads like English. LIBRARIES — numpy, pandas, scikit-learn, tensorflow, pytorch all live here. Think of it like a palengke — all the ingredients are right there. COMMUNITY — guaranteed someone already posted a solution on StackOverflow."*

Dan opened the terminal and typed `python --version`. Nothing. A red error message. After a PATH fix from lab assistant Kuya Ronnie, Python 3.11 was running.

He opened a new file, saved it as `hello_ai.py`, and typed:

```python
print("Hello, AI!")
```

He pressed Run. The terminal displayed:

```
Hello, AI!
```

His first real Python program. Clean output. He was officially a programmer.

His phone buzzed. Jasper had posted a screenshot of his own 40-line C++ program with pointers and memory allocation. *"Real programmers use C++,"* Jasper had captioned.

Dan looked at his single line of Python. *"Real programmers solve problems,"* he thought. *"And I'm going to solve Mama's carinderia problem."*

---

## Theory & Lecture Content

### Why Python Dominates AI

**1. Readability** — Python reads like English.

```python
# Python
for dish in menu:
    if dish.price > 50:
        print(dish.name)
```

vs Java's 10-line equivalent with `for (int i = 0; i < menu.size(); i++)` — Python uses indentation instead of curly braces, no semicolons, fewer symbols.

**2. Libraries (Packages)**

| Library | Purpose |
|---------|---------|
| **numpy** | Fast math on arrays |
| **pandas** | Load, clean, analyze CSV/Excel data |
| **matplotlib** | Create charts and graphs |
| **scikit-learn** | Classification, regression, clustering |
| **tensorflow / pytorch** | Build neural networks |

Think of libraries like a palengke — pre-made ingredients so you don't have to grow the garlic yourself.

**3. Community** — Millions of Python devs, thousands of tutorials, StackOverflow for every stuck moment.

**4. Free and Open Source** — A student in Marikina has access to the same tools as a Google engineer.

### Python Basics

| Concept | Example |
|---------|---------|
| `print()` | `print("Hello!")` |
| Variables | `price = 60` |
| Data types | `int`, `float`, `str`, `bool` |
| `type()` | `type(price)` → `<class 'int'>` |
| f-strings | `f"Price: {price}"` |
| `input()` | `name = input("Name: ")` |
| Comments | `# This is a comment` |

### Math Operators

```
+    Addition          5 + 3    = 8
-    Subtraction       5 - 3    = 2
*    Multiplication    5 * 3    = 15
/    Division          5 / 3    = 1.6667
//   Floor Division    5 // 3   = 1
%    Modulo            5 % 3    = 2  (remainder)
**   Exponent          5 ** 3   = 125
```

### Type Conversion

- `int("60")` → 60 (string to int)
- `float("35.50")` → 35.5
- `str(60)` → "60"

---

## Key Takeaways

1. **Python dominates AI** because of readability, libraries, community, and being free.
2. **Libraries are pre-built tools** — numpy (math), pandas (data), matplotlib (charts), scikit-learn (ML), tensorflow/pytorch (DL).
3. **Python basics**: print(), variables, data types (int/float/str/bool), type(), f-strings, input(), comments, math operators.
4. **f-strings** are the modern way to format output: `f"Price: {price:.2f}"` gives 2 decimal places.
5. **Dynamic typing**: you don't declare types — Python figures them out.
6. **Math operators beyond +-*/**: `//` (floor division), `%` (modulo), `**` (exponent).

---

## What's Next?

Dan can write Python! But real AI developers don't build everything from scratch — they use loops to avoid repetition and conditionals to make decisions.

**Next Lesson: Python Basics** — Dan discovers loops and conditionals while building a complete ordering system for the carinderia.

**Next:** Quiz then exercises.
