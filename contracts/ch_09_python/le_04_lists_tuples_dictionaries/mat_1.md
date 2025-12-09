## Background Story

The barangay tech room—really just a repurposed storage closet with a donated computer and a wobbly electric fan—buzzed with energy as Tian typed furiously. He'd started coding the Python script to manage their scholarship data, but everything was jumbled into one massive list: names mixed with ages mixed with barangay codes mixed with application statuses. "Kuya, I have all the data loaded," he announced proudly, "but finding specific information takes forever!"

Rhea Joy leaned over his shoulder, squinting at the screen. "Wait, are you storing barangay coordinates the same way as student names? And why does everything look the same?" Tian frowned. "What do you mean? They're all just... data, right?" Rhea Joy shook her head. "Coordinates shouldn't change—that's fixed. But names? We might need to correct typos. Different treasures need different chests."

Kuya Miguel, who'd been debugging another script in the corner, rolled his chair over. "She's right, Tian. Python gives you three main containers for different needs. Lists for things that change—like a to-do list you cross off. Tuples for fixed data that shouldn't be modified—like GPS coordinates or a person's birthdate. Dictionaries for fast lookups by name or ID—like a phone directory."

Tian's confusion melted into understanding as Miguel demonstrated each data structure. They spent the afternoon refactoring the code: lists for tracking dynamic scholarship application queues, tuples for storing immutable resident registration timestamps, and dictionaries for lightning-fast lookups of student records by ID. By evening, the script ran smoothly, and Tian finally understood why choosing the right container mattered. The scholarship system was getting smarter, one data structure at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Rhea Joy stared at her refactored code, a satisfied smile spreading across her face. What was once a tangled mess of nested lists had transformed into clean, organized data structures.

"Look at this, Tian," she said, pointing at her screen. "Before, I was searching through lists every time I needed to find a resident. Now with a dictionary keyed by ID? Instant lookup."

Tian leaned over. The difference was obvious:

```python
# Before: O(n) search through list
for resident in resident_list:
    if resident[0] == target_id:
        return resident

# After: O(1) dictionary lookup
resident = residents_dict[target_id]
```

"And these coordinates," Rhea Joy continued, highlighting a tuple, "they're immutable. No one can accidentally change a resident's location. It's protected."

Kuya Miguel walked by, coffee in hand, and glanced at the screen. "Now you're thinking like a developer. Lists for sequences you'll modify. Tuples for data that shouldn't change. Dictionaries for fast lookups. Each structure has its purpose."

Tian opened a new file and started typing. The scholarship data that once lived in confusing nested lists was now a clean dictionary of dictionaries—each resident mapped to their scholarship details, each detail accessible in constant time.

"Next, we wrap this logic in functions," Kuya Miguel said. "Make it reusable, testable, clean."

Rhea Joy saved her file with determination. "From data chaos to data clarity. I'm ready."

_Next up: Functions, Parameters, and Organizing Code!_

**Next:** Quiz then exercises to deepen selection intuition.
