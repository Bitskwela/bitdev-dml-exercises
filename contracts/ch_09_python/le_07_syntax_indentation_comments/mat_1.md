## Background Story

Tian had been coding for three weeks straight, and his enthusiasm sometimes outpaced his attention to detail. One morning, he proudly showed Rhea Joy a new feature he'd added overnight—automatic scholarship amount calculation. "Look! It works perfectly!" he declared. Rhea Joy squinted at the screen, trying to decipher the wall of text. "Kuya... I literally can't tell where one function ends and another begins. And what does this part do?"

Tian shrugged. "I know what it does. I wrote it last night." Rhea Joy raised an eyebrow. "But will you remember in three months? Will I understand it when you're busy and I need to fix a bug?" She had a point. The code was a tangled mess—inconsistent spacing, missing comments, random indentation that somehow still ran but looked chaotic.

Kuya Miguel happened to call via video chat that afternoon to check their progress. When Tian screenshared his code, Miguel winced visibly. "Tian, pare, code is written once but read a hundred times. Python isn't just about making it work—it's about making it readable. Indentation isn't optional styling; it defines your code structure. And comments? They're notes to your future self and your teammates."

They spent the evening refactoring: properly indenting code blocks to show hierarchy, adding meaningful comments explaining the 'why' not just the 'what', using consistent spacing around operators. Rhea Joy could suddenly read the code like a well-structured essay. When they later onboarded a volunteer from the neighboring barangay to help with development, he understood the codebase immediately thanks to clear syntax and helpful comments. The scholarship system was becoming maintainable, one properly indented line at a time.

---

## Theory & Lecture Content

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

---

## Closing Story

Rhea Joy opened Tian's code from last week and immediately winced. No blank lines. Comments everywhere explaining obvious things. Inconsistent indentation. It was technically correct Python, but reading it felt like wading through mud.

"Your code works," she said diplomatically, "but... it's hard to follow."

Tian looked at the screen and saw what she meant. The logic was buried under noise.

Kuya Miguel pulled up PEP 8—Python's style guide. "Code is read far more often than it's written. Clean syntax isn't about being fancy. It's about being kind to the next person who reads this. And that next person is usually you, three months later."

They refactored together:

```python
# Before: Messy, cramped
def calc(x,y):
 if x>0:
  return x+y#add them
 else:return 0

# After: Clean, readable  
def calculate_total(amount, bonus):
    """Calculate total payment including bonus."""
    if amount > 0:
        return amount + bonus
    return 0
```

"See the difference?" Kuya Miguel pointed. "Proper spacing. Descriptive names. Docstring explains what it does. The code reads like a story."

Tian ran a linter—16 style violations flagged. One by one, they fixed them: trailing whitespace removed, line lengths adjusted, consistent indentation throughout.

"Python's beauty is in its readability," Rhea Joy said, reviewing the cleaned code. "Indentation isn't just syntax—it's visual structure. Your eyes follow the logic naturally."

Tian committed the changes: "Refactor: Apply PEP 8 style guide. Code clarity over brevity."

The scholarship script looked professional now. Clean. Maintainable. Ready for others to read and understand.

_Next up: Variables, Data Types, and Operators—Python fundamentals!_ 

**Next:** Quiz then exercises.
