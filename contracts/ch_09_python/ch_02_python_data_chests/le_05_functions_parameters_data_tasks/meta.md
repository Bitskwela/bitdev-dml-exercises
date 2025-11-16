## Lesson 5 Exercises: Designing Clean Functions

---
### 1. Pure vs Impure Classification (5 minutes)
Mark each snippet P (pure) or I (impure) and justify:
1. `def add(a,b): return a+b`
2. `def log(msg): print(msg)`
3. `def append_tag(tags, tag): tags.append(tag); return tags`
4. `def average(path): import json; return sum(json.load(open(path)))/3`

| Snippet | P/I | Justification |
|---------|-----|---------------|
| 1 | | |
| 2 | | |
| 3 | | |
| 4 | | |

---
### 2. Mutable Default Repair (6 minutes)
Repair and test:
```python
def collect(item, bucket=[]):
	bucket.append(item)
	return bucket
```
Show two calls producing independent lists.

---
### 3. Parameter Variety (8 minutes)
Write `def summarize(title, *points, **meta)` returning a dict with keys: `title`, `points` (list), plus all `meta`. Provide call example with 3 points and metadata `author="Tian"`.

---
### 4. Refactor Global Mutation (8 minutes)
Original:
```python
total = 0
def add_score(x):
	global total
	total += x
```
Refactor into a pure version returning new total given current total and increment.

---
### 5. Median Function (8 minutes)
Implement `median(values)` handling even/odd lengths. Test with two sample lists.

---
### 6. Docstring Enhancement (7 minutes)
Add a docstring to `median` describing parameters, return, edge cases.

---
### 7. Decompose Mixed Function (10 minutes)
Split pseudo-code:
1. Read file of numbers.
2. Filter negative values.
3. Compute average.
Produce three functions: `read_numbers(path)`, `filter_negatives(nums)`, `average(nums)`. Show usage pipeline.

---
### 8. Stretch: Tag Index Builder (Optional)
Write `build_tag_index(residents)` pure. Include simple test verifying expected dict.

---
### 9. Reflection (3 minutes)
Three bullets: (a) Hardest concept today, (b) Strategy to keep functions small, (c) Benefit of *args/**kwargs flexibility.

---
**Next:** Lesson 6 (Error Handling & Debugging).
