## Lesson 6 Exercises: Error Handling & Debugging Mastery

---
### 1. Safe Parsing (6 minutes)
Function `parse_int(s)` returns int or None with logged warning. Show 3 calls: valid, invalid, empty.

---
### 2. Custom Exception (7 minutes)
Define `DuplicateResidentError`. Simulate detecting duplicate IDs in list; raise on first duplicate; catch and print message.

---
### 3. Graceful Fallback (7 minutes)
Wrap code that retrieves `resident["barangay"]`; if missing, assign `"UNKNOWN"` and append to `missing_log` list.

---
### 4. Timing & Logging (8 minutes)
Instrument a `process(records)` with start/end timestamps using `time.time()` and `logging.info`. Display duration.

---
### 5. File Handling with finally (6 minutes)
Manual pattern:
```python
f = open("data.txt", "w")
try:
	f.write("sample")
finally:
	f.close()
```
Convert to context manager `with` form and explain advantage.

---
### 6. Assertion Use (6 minutes)
Add assertion `assert isinstance(tags, list)` inside tag processing function; trigger failure with wrong type and capture exception output.

---
### 7. Broad vs Specific Catch (8 minutes)
Write two snippets: (a) broad catch swallowing a `ValueError`, (b) refined catch preserving stack trace. Explain difference one sentence.

---
### 8. Mini Debug Session (Optional, 10–15 minutes)
Create intentionally buggy function (`average([])` causing ZeroDivisionError). Show reproduction, add guard, confirm fix.

---
### 9. Reflection (3 minutes)
Three bullets: (a) Most powerful technique learned, (b) When to write custom exception, (c) One debugging step to always start with.

---
**Next:** Chapter 2 recap then onward to Chapter 3 fundamentals.
