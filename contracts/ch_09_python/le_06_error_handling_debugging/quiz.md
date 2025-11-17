# Lesson 6 Quiz: Error Handling & Debugging

---
# Quiz 1
## Scenario: Stabilizing the Import Script
Script breaks on malformed records. Evaluate handling strategies.

**Question 1:** Catching only specific exceptions improves:
A. Noise reduction & clarity
B. Crash frequency
C. Performance by 100x
D. Automatic data correction

**Question 2:** Using `dict.get("key")` instead of `dict["key"]` avoids:
A. TypeError
B. KeyError
C. ValueError
D. ZeroDivisionError

**Question 3:** `finally` block purpose?
A. Runs only when exception raised
B. Skips on success
C. Always executes cleanup logic
D. Reverses previous changes

**Question 4:** Raising custom `DataQualityError` helps:
A. Slows execution
B. Differentiates quality issues from other failures
C. Prevents logging
D. Eliminates need for try/except

**Question 5:** `assert` used primarily for:
A. Production user messages
B. Internal invariant checks during development
C. Runtime performance optimization
D. Replacing exceptions entirely

---
# Quiz 2
## Scenario: Debug Plan Review
Rhea Joy drafts steps to chase a intermittent crash.

**Question 6:** First debugging action:
A. Random code edits
B. Reproduce issue consistently
C. Delete large sections
D. Add global prints everywhere

**Question 7:** Logging preferable to print because:
A. Prints faster
B. Supports severity levels & formatting
C. Removes need for exceptions
D. Guarantees no performance cost

**Question 8:** Broad `except Exception:` risk?
A. Misses all errors
B. Silences unexpected bugs hiding real issues
C. Prevents code execution
D. Auto fixes invalid values

**Question 9:** Good pattern to ensure file closure?
A. Rely on GC timing
B. Use `finally` or context manager
C. Keep file open indefinitely
D. Ignore errors silently

**Question 10:** Proper early validation does what?
A. Defers error detection
B. Creates unrelated warnings
C. Fails fast with clear messages
D. Eliminates all exceptions

---
## Answers
1: A  
2: B  
3: C  
4: B  
5: B  
6: B  
7: B  
8: B  
9: B  
10: C  

---
## Detailed Explanations
**Q1:** Targeted catch reduces noise & mis-handling.  
**Q2:** `.get` returns None instead of raising KeyError.  
**Q3:** `finally` always runs for cleanup.  
**Q4:** Custom exception classifies problem domain.  
**Q5:** Assertions guard internal assumptions in dev.  
**Q6:** Reproduction isolates scope.  
**Q7:** Logging allows levels & central config.  
**Q8:** Broad catch may swallow critical traces.  
**Q9:** Deterministic cleanup using `finally`/with.  
**Q10:** Validates inputs early → clearer failures.  

---
**Next:** Proceed to Lesson 6 exercises.
