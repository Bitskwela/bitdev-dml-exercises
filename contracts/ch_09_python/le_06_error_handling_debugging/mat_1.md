## Background Story

The barangay hall was unusually quiet that evening as Tian prepared for a demo of the scholarship system to Captain Cruz and the council. Everything had worked perfectly during testing that afternoon, but now, with VIPs waiting in the conference room, he clicked "Run" and watched in horror as the screen displayed: `KeyError: 'barangay'`. The program crashed completely. His hands went cold.

Rhea Joy, sitting beside him, stayed calm. "Don't panic, Kuya. Let me see the error." She quickly scanned the traceback. "Ah, one of the resident records is missing the barangay field. The program expects it to always be there, but someone's data is incomplete." Tian's mind raced. "So the whole system is broken because of one bad record? That's terrible design!"

"Not if we handle errors properly," Rhea Joy replied, already typing. She wrapped the problematic code in a `try/except` block, adding a fallback value when the barangay was missing and logging the issue for later review. "This way, the system notes the problem but keeps running. We can fix the bad data afterward without crashing everything."

Kuya Miguel, who'd arrived just in time to see the crisis, nodded approvingly. "This is real-world programming. Systems will encounter unexpected data, network failures, missing files. Good code anticipates failure and handles it gracefully." They spent the next hour adding strategic error handling throughout the codebase—catching missing keys, invalid data types, and division-by-zero scenarios. When they ran the demo again, the system smoothly handled all edge cases. Captain Cruz was impressed. The scholarship system was becoming resilient, one exception handler at a time.

---

## Theory & Lecture Content

### 1. Why Handle Errors?
- Prevent total crashes.
- Provide informative messages.
- Maintain data integrity (rollback, safe state).

### 2. Common Exception Types
| Exception | Cause Example |
|-----------|---------------|
| `ValueError` | Invalid conversion (`int("abc")`) |
| `TypeError` | Wrong type operation (`len(5)`) |
| `KeyError` | Missing dict key |
| `IndexError` | Out-of-range list index |
| `ZeroDivisionError` | Division by zero |

### 3. Basic try/except
```python
try:
	value = data["barangay"]
except KeyError:
	value = None
```

### 4. Multiple Excepts
```python
try:
	process()
except (ValueError, TypeError) as e:
	print("Validation issue", e)
except Exception as e:
	print("Unexpected", e)
```

### 5. else / finally
```python
try:
	conn = open_resource()
	result = compute()
except ResourceError:
	recover()
else:
	persist(result)
finally:
	conn.close()
```

### 6. Raising Custom Exceptions
```python
class DataQualityError(Exception):
	pass

def validate(resident):
	if "id" not in resident:
		raise DataQualityError("Missing id")
```

### 7. Assertions (Development)
```python
assert len(tags) < 100, "Tag explosion risk"
```
Use for internal invariants; disable in optimized mode (`python -O`).

### 8. Logging vs Printing
Prefer `logging` for levels & structured output.
```python
import logging
logging.basicConfig(level=logging.INFO)
logging.info("Start")
logging.warning("Slow query")
```

### 9. Debugging Strategies
- Reproduce consistently.
- Isolate minimal failing snippet.
- Add targeted print/log statements.
- Use IDE breakpoints / step-through.
- Check assumptions (types, lengths, boundary values).

### 10. Defensive Patterns
Safely access dict:
```python
barangay = resident.get("barangay")  # None if missing
```
Validate early:
```python
if not isinstance(tags, list): raise TypeError("tags must be list")
```

### 11. Story Thread
KeyError replaced by controlled fallback -> alert log -> data flagged for correction without stopping processing pipeline.

---

## Closing Story

It was 11 PM. Tian's program crashed—again. `KeyError: 'barangay'`. The scholarship processing script stopped halfway through, leaving the data in an inconsistent state.

"This keeps happening," Tian groaned, rubbing tired eyes. "One missing field, and everything breaks."

Kuya Miguel appeared with two cans of Mountain Dew. "Time to learn error handling. Your code needs to be resilient—anticipate problems, handle them gracefully, and keep running."

They refactored together:

```python
# Before: Crashes on missing data
barangay = resident["barangay"]

# After: Defensive with fallback
try:
    barangay = resident["barangay"]
except KeyError:
    logger.warning(f"Resident {resident.get('id')} missing barangay")
    barangay = "UNKNOWN"
    # Flag for manual review but keep processing
```

"Now when data is missing, it logs the issue but doesn't crash," Kuya Miguel explained. "You can review the logs later and fix the data. The other 99 residents still get processed."

Rhea Joy added validation at the entry point:

```python
def process_resident(data):
    required = ["id", "name", "barangay"]
    missing = [f for f in required if f not in data]
    if missing:
        raise ValueError(f"Missing required fields: {missing}")
    # Proceed with clean data
```

Tian ran the script again. This time, it processed all 150 residents. Three warnings appeared in the log about missing barangays—marked for review, but not catastrophic.

"Errors will happen," Kuya Miguel said. "Production systems deal with bad data, network timeouts, disk full errors. The difference between amateur and professional code? Professionals expect failure and handle it."

Tian saved the refactored script. The scholarship system was getting stronger—one error handler at a time.

_Next up: Python Syntax, Indentation, and Code Style!_

**Next:** Quiz then practice exercises.
