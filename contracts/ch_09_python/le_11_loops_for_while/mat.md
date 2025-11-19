## Lesson 11: Loops – for and while

Story: Processing 200 scholarship applications manually? Rhea Joy laughs: "Let the machine repeat." They automate with for and while loops.

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

**Next:** Quiz then exercises.