## Lesson 4: Lists, Tuples, and Dictionaries

Story: Morning in the barangay tech room. Tian dumps mixed resident data into one giant list. Rhea Joy raises an eyebrow: “Are we storing immutable coordinates the same way as mutable attendance notes?” Today they unlock Python’s core collection trio and choose the right chest for each kind of treasure.

### 1. Overview
- List: Ordered, mutable sequence. Common for dynamic collections you add/remove from.
- Tuple: Ordered, immutable sequence. Ideal for fixed structure data (coordinates, (id, date) pairs).
- Dictionary: Key → value mapping (hash table). Ideal for fast lookups by unique identifiers.

### 2. Syntax Quick Look
```python
lst = ["Ana", "Ben", "Carla"]
tpl = ("Sto. Niño", 2025)
resident = {"id": 101, "name": "Ana", "tags": ["PWD", "Scholar"]}
```

### 3. Comparison Table
| Feature | List | Tuple | Dictionary |
|---------|------|-------|------------|
| Mutability | Mutable | Immutable | Mutable (structure & values) |
| Order | Preserved | Preserved | Preserved (Python 3.7+) |
| Typical Use | Dynamic sequence | Fixed record | Keyed access |
| Lookup Cost | O(n) linear search | O(n) | O(1) average by key |
| Memory | Slight overhead | Slightly smaller | Higher per entry |
| Hashable? | No | Yes (if elements hashable) | Keys must be hashable |

### 4. Core Operations
Lists:
```python
lst.append("Dora")      # add
lst.extend(["Eli", "Faye"])  # bulk add
lst.insert(1, "Bea")    # position insert
removed = lst.pop()      # remove last
```
Tuples (cannot modify in place):
```python
tpl2 = tpl + ("Expansion",)  # create new tuple
```
Dictionary:
```python
resident["age"] = 23
tags = resident.get("tags", [])
del resident["age"]
for key, value in resident.items():
	print(key, value)
```

### 5. Slicing & Unpacking
```python
first_two = lst[:2]
name1, name2, name3 = lst[:3]
id_, name = (101, "Ana")
```

### 6. Comprehensions (Taste)
```python
upper_names = [n.upper() for n in lst]
id_to_name = {r["id"]: r["name"] for r in [resident]}
lengths = tuple(len(n) for n in lst)
```

### 7. Mutability & Copies
Pitfall: Copying references vs values.
```python
original = [["Ana"], ["Ben"]]
shallow = original[:]           # top-level copy only
deep = [sub[:] for sub in original]  # manual deep copy
original[0].append("Extra")
print(shallow[0])  # reflects change
print(deep[0])     # independent
```
Use `import copy; copy.deepcopy(obj)` for nested structures.

### 8. Dictionary Internals (Concept)
- Uses hashing of keys for O(1) average access.
- Collisions resolved internally; performance degrades if many collisions but Python manages rehash/resizing.
- Keys must be immutable & hashable (e.g., str, int, tuple of hashables).

### 9. Choosing the Right Structure
| Scenario | Best Choice | Reason |
|----------|-------------|--------|
| Mutable attendee list | List | Frequent additions/removals |
| Coordinate pair (lat, lon) | Tuple | Fixed two-value record |
| Lookup resident by ID | Dict | O(1) key access |
| Sequence of scholarship statuses | List | Ordered progression |
| Composite key (resident_id, date) | Tuple key in dict | Hashable compound key |

### 10. Common Pitfalls
- Using list where dict needed: slow lookups.
- Forgetting tuple immutability—attempting item assignment errors.
- Mutable default argument: `def f(data=[])` (shared list across calls). Use `None` sentinel.
- Using non-hashable types (list) as dict keys.

### 11. Story Thread
Rhea Joy refactors: resident caches become `dict` keyed by ID; static coordinate sets stored as tuples; dynamic tag lists remain lists. Tian measures improved lookup speed.

### 12. Mini Performance Hint
List append: amortized O(1). Dict lookup: average O(1). Linear search in list: O(n). For large N, prefer dict for membership tests.

### 13. Practice Prompts
1. Convert a list of `(id, name)` tuples to a dict.
2. Show code that mistakenly mutates shared default list and fix it.
3. Build a frequency dict of tag counts from list of resident dicts.
4. Replace nested list-of-lists with list-of-dicts and explain clarity gain.

### 14. Reflection
When will you deliberately choose a tuple over a list? List two reasons.

**Next:** Quiz then exercises to deepen selection intuition.
