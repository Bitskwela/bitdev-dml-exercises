# Quiz: Loops

---

# Quiz 1

## Scenario

Tian needs to process multiple students' grades and automate repetitive tasks. Kuya Miguel tests his understanding of for and while loops.

---

## Question 1

What's the output?

```python
for i in range(5):
    print(i)
```

**Choices:**
- A) 1 2 3 4 5
- B) 0 1 2 3 4
- C) 0 1 2 3 4 5
- D) 1 2 3 4

**Correct Answer:** B

**Explanation:**
`range(5)` generates numbers from 0 to 4 (5 numbers total, but stops before 5). Python uses zero-based indexing by default. To get 1-5, use `range(1, 6)`.

---

## Question 2

Tian wants to print 1 to 10. Which is correct?

**Choices:**
- A) `for i in range(10):`
- B) `for i in range(1, 10):`
- C) `for i in range(1, 11):`
- D) `for i in range(11):`

**Correct Answer:** C

**Explanation:**
`range(start, stop)` generates numbers from start to stop-1. To include 10, you need `range(1, 11)`:
- Option A: 0-9
- Option B: 1-9
- Option C: 1-10 ✓
- Option D: 0-10 (includes 0)

---

## Question 3

What's the output?

```python
count = 0
while count < 3:
    print(count)
    count += 1
```

**Choices:**
- A) 0 1 2
- B) 1 2 3
- C) 0 1 2 3
- D) Infinite loop

**Correct Answer:** A

**Explanation:**
The loop runs while `count < 3`:
1. count=0, print 0, count=1
2. count=1, print 1, count=2
3. count=2, print 2, count=3
4. count=3, condition False, exit

Prints: 0, 1, 2

---

## Question 4

What happens with this code?

```python
count = 0
while count < 5:
    print(count)
```

**Choices:**
- A) Prints 0 1 2 3 4
- B) Prints 0 only
- C) Infinite loop (prints 0 forever)
- D) Error

**Correct Answer:** C

**Explanation:**
The loop never updates `count`, so it stays 0 forever. `count < 5` is always True, creating an infinite loop. Always remember to update the loop variable in while loops!

Correct version:
```python
while count < 5:
    print(count)
    count += 1
```

---

## Question 5

What's the output?

```python
for i in range(10):
    if i == 5:
        break
    print(i)
```

**Choices:**
- A) 0 1 2 3 4 5
- B) 0 1 2 3 4
- C) 5 6 7 8 9
- D) 0 1 2 3 4 5 6 7 8 9

**Correct Answer:** B

**Explanation:**
The `break` statement exits the loop immediately:
1. i=0: print 0
2. i=1: print 1
3. i=2: print 2
4. i=3: print 3
5. i=4: print 4
6. i=5: break (exit loop, don't print 5)

---

## Question 6

What's the output?

```python
for i in range(5):
    if i % 2 == 0:
        continue
    print(i)
```

**Choices:**
- A) 0 2 4
- B) 1 3
- C) 0 1 2 3 4
- D) 1 2 3 4

**Correct Answer:** B

**Explanation:**
`continue` skips the rest of the current iteration:
- i=0: even, skip (don't print)
- i=1: odd, print 1
- i=2: even, skip
- i=3: odd, print 3
- i=4: even, skip

Only odd numbers print: 1, 3

---

# Quiz 2

## Scenario

Tian continues learning loops with more advanced patterns and nested loops. Kuya Miguel tests his mastery of iteration.

---

## Question 1

Tian calculates sum of 1 to 100:

```python
total = 0
for i in range(1, 101):
    total = total + i
print(total)
```

**What's the output?**

**Choices:**
- A) 100
- B) 5050
- C) 10100
- D) 5000

**Correct Answer:** B

**Explanation:**
The loop adds all numbers from 1 to 100:
1 + 2 + 3 + ... + 100 = 5050

This is a famous formula: sum = n(n+1)/2 = 100(101)/2 = 5050

---

## Question 8

What's the output?

```python
for i in range(2, 10, 2):
    print(i)
```

**Choices:**
- A) 2 3 4 5 6 7 8 9
- B) 2 4 6 8
- C) 2 4 6 8 10
- D) 0 2 4 6 8

**Correct Answer:** B

**Explanation:**
`range(start, stop, step)` with step=2 means increment by 2:
- Start at 2
- Stop before 10
- Increment by 2

Result: 2, 4, 6, 8

---

## Question 9

Tian loops through a string. What's the output?

```python
name = "Tian"
for letter in name:
    print(letter)
```

**Choices:**
- A) Tian
- B) T i a n (each on separate line)
- C) 0 1 2 3
- D) Error: can't loop through string

**Correct Answer:** B

**Explanation:**
Strings are iterable in Python. The loop goes through each character:
```
T
i
a
n
```

Each print adds a newline, so letters appear on separate lines.

---

## Question 10

What happens with the else clause?

```python
for i in range(3):
    print(i)
else:
    print("Done!")
```

**Choices:**
- A) 0 1 2 Done!
- B) 0 1 2
- C) Done! only
- D) Error: else not allowed with for

**Correct Answer:** A

**Explanation:**
Python allows `else` with loops. The else block runs if the loop completes normally (no break):
```
0
1
2
Done!
```

If there's a break, the else doesn't run.

---

## Question 11

What's the output?

```python
for i in range(3):
    if i == 1:
        break
    print(i)
else:
    print("Complete!")
```

**Choices:**
- A) 0 Complete!
- B) 0 1 Complete!
- C) 0 (no Complete!)
- D) 0 1 2 Complete!

**Correct Answer:** C

**Explanation:**
Since `break` is encountered when i=1, the loop exits early. The else clause only runs if the loop completes normally (no break), so "Complete!" doesn't print.

Output: 0 only

---

## Question 12

Tian creates a multiplication table. What's printed for i=3, j=4?

```python
for i in range(1, 4):
    for j in range(1, 4):
        print(f"{i} x {j} = {i * j}")
```

**What line appears in the output?**

**Choices:**
- A) 3 x 4 = 12
- B) 4 x 3 = 12
- C) This combination doesn't appear
- D) 3 x 3 = 9

**Correct Answer:** C

**Explanation:**
The outer loop goes 1, 2, 3. The inner loop also goes 1, 2, 3. So we get:
- 1x1, 1x2, 1x3
- 2x1, 2x2, 2x3
- 3x1, 3x2, 3x3

The combination i=3, j=4 never occurs because j only goes up to 3. The last line printed is "3 x 3 = 9".

---

## Summary

**Key Points Tested:**

**Quiz 1:**
- `range(stop)` → 0 to stop-1
- `range(start, stop)` → start to stop-1
- While loops need condition update to avoid infinite loop
- `break` exits loop immediately
- `continue` skips to next iteration
- Zero-based indexing in Python

**Quiz 2:**
- `range(start, stop, step)` with custom increment
- Calculating sums with loops
- Looping through strings (iterable)
- Loop `else` runs if loop completes normally (no break)
- Nested loops (loop inside loop)
- Break prevents else from running

Excellent work! Loops are essential for automation and repetitive tasks. Ready to learn about lists next?
