## Background Story

The scholarship program had complex eligibility rules that varied by situation: students under 18 needed parental consent, those from Barangay San Roque got priority funding, applicants with GPAs above 3.5 qualified for premium amounts, and special consideration applied to PWD residents. Tian's first attempt at implementing these rules was a disaster—a single massive function that tried to handle every scenario in one tangled mess of conditions.

Rhea Joy reviewed his code and shook her head. "Kuya, this is spaghetti. You're checking age, then checking it again, then checking barangay in three different places. How do you even know if this works correctly?" Tian admitted he wasn't sure—testing had become nearly impossible because every change broke something unexpected.

"You need to branch your logic cleanly," Kuya Miguel explained over a video call. "Start with if. If that's not true, check elif for another case. Use else for everything that doesn't match. And yes, sometimes you need nested conditions, but keep them organized. Think of it like a decision tree—follow one path at a time based on what's true."

They refactored the eligibility checker together: first check age (if under 18, require parental consent), then check GPA (if >= 3.5, premium tier; elif >= 3.0, standard tier; else, conditional admission), finally check special categories (PWD, honor roll, athlete). Each condition was clear, tested, and documented. The logic flowed like a well-organized flowchart. When they tested edge cases—a 17-year-old honor student with 3.7 GPA from San Roque—the system correctly applied all relevant rules. The scholarship system was becoming intelligent, one condition at a time.

---

## Theory & Lecture Content

### 1. Basic if Statement
```python
if age >= 18:
    print("Eligible to vote")
```

### 2. if-else
```python
if approved:
    send_notification()
else:
    log_rejection()
```

### 3. if-elif-else Chain
```python
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"
```

### 4. Truthiness in Conditions
```python
if tags:  # non-empty list?
    process(tags)
```

### 5. Comparison Operators Review
==, !=, <, >, <=, >=

### 6. Logical Operators
```python
if age > 18 and is_resident:
    approve()
if emergency or supervisor_override:
    grant_access()
if not archived:
    display()
```

### 7. Membership Tests
```python
if "PWD" in tags:
    apply_discount()
if user_id not in blacklist:
    allow()
```

### 8. Nested Conditionals
```python
if is_resident:
    if age >= 18:
        register_voter()
    else:
        register_minor()
```
Keep nesting shallow for readability.

### 9. Ternary (Conditional Expression)
```python
status = "Adult" if age >= 18 else "Minor"
```

### 10. Common Pitfalls
- Using = (assignment) instead of == (comparison).
- Forgetting colon after condition.
- Misaligned indentation.
- Empty blocks (use pass if needed).

### 11. Guard Clauses
Early return pattern:
```python
def process(data):
    if not data:
        return None
    # main logic
```

### 12. Story Thread
Refactored eligibility checks: clear branches for age, residency, income thresholds—easier debugging.

### 13. Practice Prompts
1. Write 3-branch grading if-elif-else.
2. Combine two conditions with and.
3. Use in to check tag membership.
4. Demonstrate ternary for even/odd.

### 14. Reflection
Two benefits of guard clauses over deeply nested if.

---

## Closing Story

The scholarship eligibility checker was a nightmare. Nested if statements five levels deep. Tian could barely follow the logic:

```python
# Before: Nested chaos
if age >= 17:
    if is_resident:
        if income < 50000:
            if has_grades:
                if passed_interview:
                    status = "APPROVED"
                else:
                    status = "INTERVIEW_FAILED"
            # ... more nesting
```

"This is unreadable," Rhea Joy said, squinting at the screen. "One missed indent and the whole logic breaks."

Kuya Miguel introduced guard clauses:

```python
# After: Guard clauses + early returns
def check_eligibility(applicant):
    # Handle disqualifications first
    if applicant.age < 17:
        return "TOO_YOUNG"
    
    if not applicant.is_resident:
        return "NOT_RESIDENT"
    
    if applicant.income >= 50000:
        return "INCOME_TOO_HIGH"
    
    if not applicant.has_grades:
        return "MISSING_GRADES"
    
    if not applicant.passed_interview:
        return "INTERVIEW_FAILED"
    
    # If we reach here, all checks passed
    return "APPROVED"
```

"See the difference?" Kuya Miguel highlighted the structure. "Each condition is clear. No nesting. Easy to add new checks. Easy to debug which rule failed."

Tian refactored the entire eligibility module. The deeply nested pyramid of doom became a clean sequence of guard clauses. Test coverage went from 60% to 95%—edge cases were now obvious and testable.

```python
# Ternary for simple cases
status = "Adult" if age >= 18 else "Minor"

# Multi-branch for categories
if score >= 90:
    grade = "Excellent"
elif score >= 75:
    grade = "Passing"
else:
    grade = "Needs Improvement"
```

Rhea Joy ran the test suite: 47 applicants processed. Each one followed the correct logic path. No more hidden bugs from missed indentation.

"Control flow is about making decisions clear," Kuya Miguel said. "Your code should read like the rules you're implementing. If it's hard to follow, it's hard to trust."

Tian committed the refactor: "Simplify: Replace nested if with guard clauses. Clarity wins."

_Next up: Loops—for and while!_ 🔁

**Next:** Quiz then exercises.