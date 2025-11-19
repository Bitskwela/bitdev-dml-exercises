## Lesson 7: Syntax, Indentation, and Comments

Story: Tian copies code from an online forum—everything crammed into one line. It fails. Rhea Joy smiles: “Python speaks in spaces and new lines.” Today they orient themselves on the island of Python syntax: whitespace as structure, statements, and purposeful commentary.

### 1. Python Syntax Philosophy
- Readability prioritized (PEP 20: Zen of Python).
- Blocks defined by indentation not braces.
- Consistent style reduces cognitive load in teams.

### 2. Statements & Line Endings
Each logical instruction usually on its own line:
```python
total = 0
for n in [1, 2, 3]:
	total += n
```
Use backslash (`\`) or parentheses for long lines:
```python
message = (
	"Scholarship applicant count: "
	+ str(total)
)
```

### 3. Indentation Rules
- Standard: 4 spaces per level.
- Tabs discouraged (mixing leads to TabError).
- Block starters: if, for, while, def, class, try, with.
```python
if applicant_count > 50:
	print("High volume")
else:
	print("Normal")
```

### 4. Colon Usage
Colon signals a suite (block) follows:
```python
def greet(name):
	return f"Hello {name}"  # block after colon
```

### 5. Whitespace Pitfalls
Misaligned indentation triggers IndentationError:
```python
for r in residents:
  print(r)   # 2 spaces (wrong if rest uses 4)
	print("Done")  # inconsistent → error
```

### 6. Comments
- Single line: # explanation
- Inline (use sparingly): after code.
- Multi-line doc context: surrounding block or docstrings.
```python
# Count approved applicants
approved_total = sum(1 for a in applicants if a["status"] == "Approved")
```

### 7. Docstrings vs Comments
Docstring inside function/class/module → runtime accessible via help().
```python
def add(a, b):
	"""Return sum of two numbers (no side effects)."""
	return a + b
```
Use comments for rationale or non-obvious decisions; docstrings for purpose, parameters, returns.

### 8. Good vs Bad Comments
| Bad | Reason | Improvement |
|-----|--------|------------|
| # increment | Repeats code | Omit |
| # hack | Vague | Explain limitation or TODO |
| Long narrative not related | Noise | Keep concise |

### 9. Style Essentials (PEP 8 Taste)
- Max line length often 79–100 chars.
- Blank lines separate logical sections.
- Spaces after commas: [1, 2, 3].
- No trailing whitespace.

### 10. Naming Snapshot
- snake_case for functions/variables.
- PascalCase for classes.
- UPPER_CASE for constants.
```python
MAX_RETRIES = 3
def compute_total(): ...
class ResidentRecord: ...
```

### 11. Story Thread
Refactoring messy script into neat blocks: indentation clarifies loops vs conditionals, comments highlight only tricky logic.

### 12. Practice Prompts
1. Reformat a one‑line multi‑statement script into readable blocks.
2. Replace a redundant inline comment with a docstring.
3. Demonstrate an IndentationError then correct.
4. Show line continuation using parentheses.

### 13. Reflection
Why does indentation over braces aid quick scanning? Give two reasons.

**Next:** Quiz then exercises.
