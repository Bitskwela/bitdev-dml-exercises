## Lesson 6: Error Handling and Debugging

Story: Evening deployment rehearsal. A script crashes: `KeyError: 'barangay'`. Tian panics. Rhea Joy calmly wraps access in `try/except`, logs context, and the system continues gracefully. They learn strategic error handling and pragmatic debugging.

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

### 12. Practice Prompts
1. Wrap integer parsing with graceful fallback.
2. Create custom exception for duplicate resident ID.
3. Add logging around function measuring execution time.
4. Demonstrate `finally` closing resource after an exception.

### 13. Reflection
Describe difference between catching broad `Exception` vs specific types. Provide 2 pros, 2 cons.

**Next:** Quiz then practice exercises.
