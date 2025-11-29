## Background Story

The scholarship application deadline had just passed, and the barangay received 287 applications. Tian stared at his computer screen in despair. His current system processed applications one at a time—he literally had to run the eligibility checker 287 separate times, manually entering each applicant's ID. "There has to be a better way," he muttered. "I'll be here until next year at this rate."

Rhea Joy, who'd been practicing Python loops from online tutorials, smiled. "Kuya, this is exactly what loops are for. Instead of running the code once, make it run for every applicant automatically. Loop through the list." Tian looked skeptical. "Just... tell it to repeat? Won't it loop forever?"

"Not if you control it properly," Kuya Miguel explained, pulling up his laptop. "Use a `for` loop when you know exactly what you're iterating over—like a list of applicants. Use a `while` loop when you're waiting for a condition—like 'while there are unprocessed applications'. Python handles the repetition; you just focus on what happens each time."

They rewrote the application processor: a `for` loop that iterated through all 287 applicant records, checking eligibility, calculating scholarship amounts, and generating approval letters automatically. They added a progress counter so Tian could watch it work. Within seconds, what would have taken days of manual work was done—all applicants processed, sorted, and ready for review. Rhea Joy added a `while` loop for the interactive menu that kept running until the user chose to exit. The scholarship system was becoming efficient, one iteration at a time.

---

## Theory & Lecture Content

### 1. for Loop Basics
```python
for name in ["Ana", "Ben", "Carla"]:
    print(name)
```

### 2. range() Function
```python
for i in range(5):        # 0..4
    print(i)
for i in range(2, 7):     # 2..6
    print(i)
for i in range(0, 10, 2): # 0,2,4,6,8
    print(i)
```

### 3. Iterating Over Strings
```python
for char in "Barangay":
    print(char)
```

### 4. Iterating Over Dictionary
```python
for key in resident:
    print(key, resident[key])
for key, value in resident.items():
    print(key, value)
```

### 5. while Loop
```python
count = 0
while count < 5:
    print(count)
    count += 1
```

### 6. break Statement
```python
for n in range(100):
    if n == 10:
        break
    print(n)  # stops at 9
```

### 7. continue Statement
```python
for n in range(10):
    if n % 2 == 0:
        continue
    print(n)  # odd only
```

### 8. else Clause (Loop Completion)
```python
for item in search_list:
    if item == target:
        break
else:
    print("Not found")
```

### 9. Nested Loops
```python
for barangay in barangays:
    for resident in barangay["residents"]:
        process(resident)
```
Watch complexity (O(n*m)).

### 10. enumerate() for Index + Value
```python
for i, name in enumerate(names):
    print(i, name)
```

### 11. zip() for Parallel Iteration
```python
for name, score in zip(names, scores):
    print(name, score)
```

### 12. Infinite Loop Prevention
```python
while condition:
    # ensure condition changes or break exists
    update_condition()
```

### 13. List Comprehensions (Preview)
```python
squares = [x**2 for x in range(10)]
```

### 14. Story Thread
Batch approval: for loop over applicants; while loop for retries on API failures.

### 15. Practice Prompts
1. Sum numbers 1-100 using for/range.
2. Find first even number > 50 with while + break.
3. Use enumerate to add line numbers.
4. Zip two lists and build dict.

### 16. Reflection
When to choose for vs while? Give two criteria.

---

## Closing Story

Tian needed to process 150 scholarship applications. Manually checking each one would take days. But with loops? Minutes.

```python
applicants = load_applications("data.json")

# Process each applicant
approved_count = 0
for applicant in applicants:
    if check_eligibility(applicant):
        send_approval_email(applicant)
        approved_count += 1

print(f"Processed {len(applicants)} applications")
print(f"Approved: {approved_count}")
```

Rhea Joy was working on the retry logic for database connections:

```python
max_retries = 3
attempt = 0
connected = False

while attempt < max_retries and not connected:
    try:
        db = connect_to_database()
        connected = True
        print("✓ Connected to database")
    except ConnectionError:
        attempt += 1
        print(f"Retry {attempt}/{max_retries}...")
        time.sleep(2)

if not connected:
    raise RuntimeError("Failed to connect after retries")
```

"When you know how many times to iterate, use `for`," Kuya Miguel explained. "When you're waiting for a condition to change, use `while`."

Tian discovered `enumerate()` and `zip()`:

```python
# Add line numbers to report
for line_num, applicant in enumerate(applicants, start=1):
    print(f"{line_num:3d}. {applicant.name}")

# Match names with scores
for name, score in zip(names, scores):
    print(f"{name}: {score}%")
```

"These are Pythonic patterns," Kuya Miguel noted. "They make common tasks clean and readable."

Rhea Joy added a progress indicator:

```python
total = len(applicants)
for i, applicant in enumerate(applicants, start=1):
    process(applicant)
    percent = (i / total) * 100
    print(f"\rProgress: {percent:.1f}%", end="", flush=True)
print("
✓ Complete!")
```

The scholarship system now processed all 150 applications in under 30 seconds. Eligibility checked. Emails sent. Database updated. Progress tracked.

"Loops are how computers excel," Kuya Miguel said. "Humans get tired after 10 repetitions. Computers can do 10 million without complaint. Learn to delegate repetitive work to loops, and your productivity multiplies."

Tian watched the progress bar fill: 100%. Every applicant processed correctly. No fatigue. No errors. Just reliable, repeated logic.

_Next up: String Formatting and Manipulation!_ 📝

**Next:** Quiz then exercises.