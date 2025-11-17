## Lesson 4 Exercises: Mastering Core Collections

---
### 1. Structure Selection (5 minutes)
Pick the best structure (List / Tuple / Dict) for each and justify briefly:
1. Daily temperature readings.
2. Mapping resident_id → profile object.
3. Immutable pair (latitude, longitude).
4. Ranking ordered winners (allow later insertion at end).
5. Fast lookup of barangay code descriptions.

| Scenario | Choice | Reason |
|----------|--------|--------|
| Temp readings | | |
| resident_id → profile | | |
| (lat, lon) | | |
| Winners ranking | | |
| Code descriptions | | |

---
### 2. Transform Tuples to Dict (6 minutes)
Given: `pairs = [(101, "Ana"), (102, "Ben"), (103, "Carla")]`
Task: Build dict, then invert mapping (name → id). Verify using membership tests.

---
### 3. Mutable Default Parameter Fix (6 minutes)
Refactor:
```python
def accumulate(item, bucket=[]):
	bucket.append(item)
	return bucket
```
Write a corrected version. Demonstrate two calls producing independent results with printed output.

---
### 4. Frequency Counter (8 minutes)
Input:
```python
tags_stream = ["PWD", "Scholar", "PWD", "Volunteer", "Scholar", "PWD"]
```
Produce a dict counting occurrences. Then produce a sorted list of (tag, count) descending.

---
### 5. Shallow vs Deep Copy (8 minutes)
Construct a nested list of 2 sublists. Show shallow copy side-effect after mutating inner list. Then deep copy solution. Summarize difference in 2 sentences.

---
### 6. Composite Key Dictionary (8 minutes)
Build dict keyed by `(resident_id, date)` mapping to attendance status. Demonstrate retrieval and explain why tuple key is chosen.

---
### 7. Debug Common Errors (7 minutes)
For each error produce a short failing snippet + corrected version:
- `TypeError` assigning to tuple index.
- `KeyError` accessing missing dict key.
- `ValueError` converting string to int.

---
### 8. Stretch: Mini Tag Index (Optional, 10–15 minutes)
Create function `build_tag_index(residents)` returning dict tag → list of resident_ids. Ensure no shared mutation leaks. Include simple test.

---
### 9. Reflection (3 minutes)
Three bullets: (a) Most useful new nuance, (b) Situation for tuple keys, (c) Habit to avoid with defaults.

---
**Next:** Move to Lesson 5 (Functions & Parameters).
