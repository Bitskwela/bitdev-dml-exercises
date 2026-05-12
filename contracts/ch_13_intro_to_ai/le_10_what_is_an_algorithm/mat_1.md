## Previously on Dan's AI Journey...

Dan discovered numpy and pandas — Python libraries that turn 50 lines of analysis into 3.

---

## Background Story

Dan was at the UP library trying to study when he overheard Jasper at the next table:

> **Jasper:** "Bro, I'm optimizing my sorting algorithm. O(n log n) beats O(n²) on large datasets. My convolutional filter uses dynamic programming for memoization..."

Dan felt his confidence drain. *Algorithm optimization? Big O notation? Dynamic programming?* Did he miss an entire lecture somewhere?

He grabbed his phone and messaged Kuya JM.

> **Dan:** *"Kuya, what's an algorithm? Like, really? Jasper just said 'O(n log n)' and I felt stupid."*
>
> **Kuya JM:** *"Haha, relax. An algorithm is just a RECIPE. Step-by-step instructions to solve a problem. That's it."*
>
> **Kuya JM:** *"How does Mama make adobo? Marinate the chicken, boil with soy sauce + vinegar, simmer, add bay leaves, reduce. That's an algorithm. Step 1, 2, 3, 4, 5."*
>
> **Kuya JM:** *"Jeepney driver picking up passengers? Algorithm: check for passenger → stop → accept payment → give change → drive on. The driver follows those steps every single trip."*
>
> **Kuya JM:** *"Big O just measures how fast the algorithm is as data grows. O(n²) = slow on big data. O(n log n) = fast. Don't stress the math. Learn the concept first."*

Dan's anxiety faded. An algorithm is a recipe. He'd been writing algorithms since Lesson 1 when he built the ulam recommender. Every if-else chain was a mini-algorithm.

That afternoon, Dan coded bubble sort from scratch. Then he compared it to Python's built-in `sorted()`. Then he built a combo-meal finder for Tita Malou. Then he implemented linear search and binary search. By dinnertime, he wasn't intimidated by "algorithms" anymore.

---

## Theory & Lecture Content

### What is an Algorithm?

**An algorithm is a finite set of well-defined, unambiguous instructions for solving a problem.**

Five core properties:
1. **Input** — Takes some input (could be zero).
2. **Output** — Produces some output.
3. **Definite** — Each step is unambiguous.
4. **Finite** — Must terminate after a finite number of steps.
5. **Effective** — Each step is doable in a reasonable time.

### Real-World Algorithms

| Algorithm | Input | Steps | Output |
|-----------|-------|-------|--------|
| Adobo recipe | Chicken, soy, vinegar | Marinate → boil → simmer | Cooked adobo |
| ATM withdrawal | Card + PIN + amount | Authenticate → check balance → dispense | Cash |
| Jeepney routing | Passenger + destination | Stop → collect fare → drop off | Completed trip |
| Spotify shuffle | Playlist | Random select → play → repeat | Endless music |

### Sorting Algorithms

Sorting is the most common algorithm topic. Example: **Bubble Sort** (simple but slow):

```python
for i in range(n):
    for j in range(0, n - i - 1):
        if arr[j] > arr[j + 1]:
            arr[j], arr[j + 1] = arr[j + 1], arr[j]
```

Python's built-in `sorted()` uses **Timsort** — much faster. Use `sorted()` in real code:

```python
menu = sorted(menu, key=lambda x: x["price"])
```

### Big O Notation (Lite)

| Notation | Meaning | Example |
|----------|---------|---------|
| O(1) | Constant time | Dictionary lookup |
| O(log n) | Logarithmic | Binary search |
| O(n) | Linear | Looking at every item once |
| O(n log n) | Linearithmic | Timsort, quicksort |
| O(n²) | Quadratic | Bubble sort, nested loops |

Rule of thumb: if you see a loop inside a loop (nested), it's probably O(n²). That gets slow fast with big data.

### Search Algorithms

**Linear Search** — check each item one by one:

```python
for item in menu:
    if item["name"] == target:
        return item
```

Worst case: O(n) — might check every item.

**Binary Search** — only works on *sorted* data. Repeatedly cut the search range in half:

```python
low, high = 0, len(sorted_menu) - 1
while low <= high:
    mid = (low + high) // 2
    if sorted_menu[mid]["name"] == target:
        return sorted_menu[mid]
    elif sorted_menu[mid]["name"] < target:
        low = mid + 1
    else:
        high = mid - 1
```

Only O(log n) — ~20 steps to find 1 item in a million.

---

## Key Takeaways

1. **An algorithm is a recipe** — a finite, well-defined sequence of steps to solve a problem.
2. **Every program is a collection of algorithms** — your ulam recommender, carinderia calculator, pandas analysis — all algorithms.
3. **Big O measures how runtime grows with data size.** O(n²) is slow on big data; O(log n) is very fast.
4. **Sorting**: bubble sort (O(n²), educational) vs Python's Timsort (O(n log n), use in real code).
5. **Searching**: linear (check each, O(n)) vs binary (halve the range, O(log n), requires sorted data).
6. **ML is built on algorithms** — gradient descent, backpropagation, k-nearest neighbors — all algorithms.

---

## What's Next?

Dan has written algorithms with hand-coded rules. But what if a program could figure out the rules on its own from data?

**Next Lesson: Heuristics vs Learning** — Dan discovers the difference between experience-based rules (like a jeepney driver) and data-driven patterns (like Waze).

**Next:** Quiz then exercises.
