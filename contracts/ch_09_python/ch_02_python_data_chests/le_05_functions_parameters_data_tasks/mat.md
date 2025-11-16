## Lesson 5: Functions and Parameters – Organizing Data Tasks

Story: Bug triage afternoon. Tian’s script repeats logic copying resident tag lists. Rhea Joy says: “Extract that into a function—give logic a name.” They tame duplication and improve clarity using parameters, returns, and proper scope.

### 1. Why Functions?
- Encapsulate a reusable action.
- Improve readability & testability.
- Reduce duplication → easier maintenance.

### 2. Basic Definition
```python
def greet(name):
	return f"Hello, {name}!"
```
Call: `greet("Ana")`

### 3. Parameter Types
- Positional: Order matters (`process(a, b)`)
- Keyword: Specify by name (`process(a=1, b=2)`)
- Default values: Provide fallback
```python
def enroll(resident_id, program="Scholarship"):
	return resident_id, program
```
- `*args`: Variable positional tuple
- `**kwargs`: Variable keyword dict
```python
def log_events(tag, *ids, **meta):
	print(tag, ids, meta)
```

### 4. Return Values
Multiple return via tuple:
```python
def split_full_name(full):
	parts = full.split()
	return parts[0], parts[-1]
first, last = split_full_name("Ana Cruz")
```

### 5. Pure vs Impure
- Pure: output depends only on input; no side effects (e.g., formatting).
- Impure: interacts with external state (I/O, global mutation, DB writes).
Prefer pure for logic; isolate impure boundaries.

### 6. Scope & Local Variables
Variables defined inside function are local; avoid reliance on global variables for clarity.
```python
counter = 0
def increment():
	global counter
	counter += 1
```
Use global sparingly—alternative is returning new value.

### 7. Docstrings & Clarity
```python
def calculate_gpa(grades):
	"""Compute average from list of numeric grades.
	Returns float or None if empty."""
	return sum(grades)/len(grades) if grades else None
```

### 8. Mutable Default Danger
```python
def add_tag(tag, tags=[]):  # BAD
	tags.append(tag)
	return tags
```
Fix:
```python
def add_tag(tag, tags=None):
	if tags is None:
		tags = []
	tags.append(tag)
	return tags
```

### 9. Argument Unpacking
```python
values = [1, 2, 3]
print(sum(values))
print(sum((*values, 4)))
def combine(a, b, c): return a + b + c
print(combine(*values))
```

### 10. Designing Functions for Readability
Name expresses intent (verb + object): `calculate_average`, `load_residents`.
Keep parameters few; group related ones (maybe pass a config dict).

### 11. Small vs Large Functions
Rule of thumb: One clear responsibility. Split if multiple unrelated concerns appear.

### 12. Story Thread
Refactoring yields `build_tag_index(residents)` pure logic separated from file reading (impure). Tests simplified.

### 13. Practice Prompts
1. Write pure function computing median of list.
2. Convert global-modifying function to return new value instead.
3. Show example using `*args` to collect resident IDs.
4. Use `**kwargs` for flexible metadata logging.

### 14. Reflection
List two benefits of pure function design in collaborative projects.

**Next:** Quiz then exercises.
