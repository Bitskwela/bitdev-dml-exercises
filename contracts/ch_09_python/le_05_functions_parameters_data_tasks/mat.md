## Background Story

It was one of those frustrating afternoons where nothing seemed to work. Tian's Python script had grown to over 200 lines, and he was copying and pasting the same code blocks over and over—one for validating resident names, another for checking ages, yet another for formatting barangay addresses. Each time he found a bug in the validation logic, he had to hunt down and fix it in five different places.

Rhea Joy, who'd been studying programming tutorials online, watched him struggle. "Kuya Tian, why do you keep copying the same code? That's like writing the same recipe on every page of a cookbook instead of just referencing it." Tian groaned. "I know, I know! But I need the same logic in different places. How else do I do it?"

"Functions," Rhea Joy said simply. "Give your logic a name, put it in one place, and call it whenever you need it. Plus, you can pass different information to it using parameters." Kuya Miguel, overhearing the conversation from across the room, chimed in: "She's absolutely right. Functions are like delegating tasks to a trusted assistant. You tell them what to do once, and they do it reliably every time you ask."

Tian spent the next few hours extracting repeated code into neat, reusable functions: `validate_age(age)`, `format_address(street, barangay)`, `calculate_scholarship_amount(grade, income)`. Each function had clear parameters and returned specific values. By sunset, his 200-line mess had transformed into an elegant 80-line script with a dozen well-named functions. When he later found a bug in age validation, he fixed it in exactly one place—and it worked everywhere. The scholarship system was becoming maintainable, one function at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Tian's code was sprawling—one giant file with global variables, repeated logic, and functions that did too many things. Debugging felt like navigating a maze blindfolded.

"Break it down," Kuya Miguel advised, pulling up a chair. "One function, one job. Make them pure—no side effects, just input and output. Your future self will thank you."

Tian started refactoring:

```python
# Before: One massive function doing everything
def process_everything():
    # 50 lines of mixed concerns...
    pass

# After: Clear, focused functions
def calculate_average(scores):
    return sum(scores) / len(scores)

def filter_passing_scores(scores, threshold=75):
    return [s for s in scores if s >= threshold]

def format_report(name, avg, passing):
    return f"{name}: {avg:.1f}% ({passing} passed)"
```

"Now it's testable," Kuya Miguel noted. "You can verify `calculate_average` works without loading the entire system. Each function has a clear contract—what it takes, what it returns."

Rhea Joy joined them, reviewing the refactored code. "And if something breaks, you know exactly which function to check. No more hunting through hundreds of lines."

Tian ran the tests. All green. The scholarship processing logic that once took 200 lines was now 12 focused functions, each doing one thing well.

"This is how real codebases work," Kuya Miguel said. "Small, composable functions. Pure when possible. Named clearly. Your code becomes self-documenting."

Tian committed the changes with a message: "Refactor: Extract pure functions. Clarity over cleverness."

_Next up: Error Handling and Debugging—because things will break!

**Next:** Quiz then exercises.
