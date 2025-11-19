# Quiz: Lesson 6 - Loops 101

**Instructions:** Choose the best answer for each question.

---

# Quiz 1

### Question 1
What is the output of this code?
```cpp
for (int i = 1; i <= 5; i++) {
    cout << i * 2 << " ";
}
```

A) `1 2 3 4 5`  
B) `2 4 6 8 10`  
C) `2 3 4 5 6`  
D) `1 3 5 7 9`

**Answer: B) `2 4 6 8 10`**

**Explanation:**
The loop runs from 1 to 5, and each value of `i` is multiplied by 2 before printing:
- i=1: prints 2
- i=2: prints 4
- i=3: prints 6
- i=4: prints 8
- i=5: prints 10

---

### Question 2
Which loop guarantees the body will execute at least once?

A) `for` loop  
B) `while` loop  
C) `do-while` loop  
D) All loops execute at least once

**Answer: C) `do-while` loop**

**Explanation:**
The `do-while` loop checks its condition **after** executing the body, so the body always runs at least once. The `for` and `while` loops check the condition **before** executing, so they might not run at all if the condition is initially false.

Example:
```cpp
int x = 10;

// This while loop won't execute at all
while (x < 5) {
    cout << "Won't print";
}

// This do-while executes once, then stops
do {
    cout << "Prints once";
} while (x < 5);
```

---

### Question 3
How many times will "Hello" be printed?
```cpp
int count = 0;
while (count < 3) {
    cout << "Hello ";
    count++;
}
```

A) 0 times  
B) 2 times  
C) 3 times  
D) Infinite times

**Answer: C) 3 times**

**Explanation:**
The loop runs while `count < 3`:
- count=0: prints "Hello", then count becomes 1
- count=1: prints "Hello", then count becomes 2
- count=2: prints "Hello", then count becomes 3
- count=3: condition `3 < 3` is false, loop stops

Total: 3 times

---

### Question 4
What does the `break` statement do in a loop?

A) Skips the current iteration and continues with the next  
B) Exits the loop immediately  
C) Pauses the loop temporarily  
D) Restarts the loop from the beginning

**Answer: B) Exits the loop immediately**

**Explanation:**
`break` completely exits the loop, ignoring any remaining iterations.

```cpp
for (int i = 1; i <= 10; i++) {
    if (i == 5) {
        break;  // Exit when i equals 5
    }
    cout << i << " ";
}
// Output: 1 2 3 4
```

---

### Question 5
What is the output?
```cpp
for (int i = 1; i <= 5; i++) {
    if (i == 3) {
        continue;
    }
    cout << i << " ";
}
```

A) `1 2 3 4 5`  
B) `1 2 4 5`  
C) `1 2`  
D) `3 4 5`

**Answer: B) `1 2 4 5`**

**Explanation:**
The `continue` statement skips the rest of the current iteration and moves to the next one. When `i == 3`, the `continue` is executed, so the `cout` is skipped for that iteration only. Numbers 1, 2, 4, and 5 are printed normally.

---

### Question 6
Which loop is best for this scenario: "Keep asking for a password until the user enters the correct one"?

A) `for` loop  
B) `while` loop  
C) `do-while` loop  
D) Both B and C

**Answer: D) Both B and C**

**Explanation:**
Both `while` and `do-while` work well here since you don't know in advance how many attempts the user will need. 

**While loop approach:**
```cpp
string password;
while (password != "correct") {
    cout << "Enter password: ";
    cin >> password;
}
```

**Do-while approach:**
```cpp
string password;
do {
    cout << "Enter password: ";
    cin >> password;
} while (password != "correct");
```

Both are valid. The `do-while` might be slightly more intuitive since you always ask at least once.

---

# Quiz 2

### Question 7
What will happen with this code?
```cpp
int i = 1;
while (i <= 5) {
    cout << i << " ";
    // Missing: i++
}
```

A) Prints: 1 2 3 4 5  
B) Prints: 1 and stops  
C) Creates an infinite loop  
D) Compilation error

**Answer: C) Creates an infinite loop**

**Explanation:**
The variable `i` is never updated, so it stays 1 forever. The condition `1 <= 5` is always true, causing the loop to run indefinitely. This is a common mistake - always remember to update your loop counter!

**Fix:**
```cpp
int i = 1;
while (i <= 5) {
    cout << i << " ";
    i++;  // Update the counter
}
```

---

### Question 8
What is the output?
```cpp
for (int i = 10; i > 5; i--) {
    cout << i << " ";
}
```

A) `10 9 8 7 6`  
B) `10 9 8 7 6 5`  
C) `6 7 8 9 10`  
D) Infinite loop

**Answer: A) `10 9 8 7 6`**

**Explanation:**
This is a **countdown loop**. It starts at 10 and decrements (`i--`) each iteration. The loop continues while `i > 5`:
- i=10: prints 10
- i=9: prints 9
- i=8: prints 8
- i=7: prints 7
- i=6: prints 6
- i=5: condition `5 > 5` is false, loop stops

Note: 5 is not included because the condition is `i > 5`, not `i >= 5`.

---

### Question 9
In a `for` loop, what is the correct order of execution?

A) Initialization → Body → Condition → Update  
B) Condition → Initialization → Body → Update  
C) Initialization → Condition → Body → Update  
D) Body → Condition → Initialization → Update

**Answer: C) Initialization → Condition → Body → Update**

**Explanation:**
The execution order of a `for` loop is:
1. **Initialization** - Runs once at the start (`int i = 1`)
2. **Condition** - Checked before each iteration (`i <= 10`)
3. **Body** - Executes if condition is true
4. **Update** - Runs after the body (`i++`)
5. Go back to step 2

```cpp
for (int i = 1; i <= 3; i++) {
    cout << i << " ";
}

// Flow:
// 1. i = 1
// 2. Check: 1 <= 3? Yes
// 3. Print: 1
// 4. Update: i becomes 2
// 5. Check: 2 <= 3? Yes
// 6. Print: 2
// 7. Update: i becomes 3
// 8. Check: 3 <= 3? Yes
// 9. Print: 3
// 10. Update: i becomes 4
// 11. Check: 4 <= 3? No - EXIT
```

---

### Question 10
A barangay wants to count how many residents are seniors (age 60+). Which code is correct?

```cpp
// Option A
int seniorCount = 0;
int ages[] = {45, 62, 35, 70, 58};
for (int i = 0; i < 5; i++) {
    if (ages[i] >= 60) {
        seniorCount++;
    }
}

// Option B
int seniorCount = 0;
int ages[] = {45, 62, 35, 70, 58};
for (int i = 0; i < 5; i++) {
    if (ages[i] > 60) {
        seniorCount++;
    }
}

// Option C
int seniorCount = 0;
int ages[] = {45, 62, 35, 70, 58};
while (seniorCount < 5) {
    if (ages[seniorCount] >= 60) {
        seniorCount++;
    }
}
```

A) Option A  
B) Option B  
C) Option C  
D) All are correct

**Answer: A) Option A**

**Explanation:**
- **Option A** is correct: Uses `ages[i] >= 60` to include age 60 and above. Result: seniorCount = 2 (ages 62 and 70)

- **Option B** is wrong: Uses `ages[i] > 60`, which excludes 60. Only counts 62 and 70, but misses anyone exactly 60 years old (senior qualification usually starts at 60)

- **Option C** is wrong: Creates a logic error. The `seniorCount` variable is used both as a loop counter and as the count of seniors, causing incorrect behavior. This will also likely skip elements or go out of bounds.

**Correct approach:**
```cpp
int seniorCount = 0;
int ages[] = {45, 62, 35, 70, 58};

for (int i = 0; i < 5; i++) {
    if (ages[i] >= 60) {  // Include 60 and above
        seniorCount++;
    }
}

cout << "Number of seniors: " << seniorCount << endl;
// Output: Number of seniors: 2
```

---

**Score yourself:**
- 10/10: Loop Master! 🏆
- 8-9: Great understanding!
- 6-7: Good, review break/continue concepts
- Below 6: Reread the lesson and practice more examples

**Key Concepts to Remember:**
1. `for` loops - known iteration count
2. `while` loops - condition-based, check first
3. `do-while` loops - execute first, check after
4. `break` exits the loop completely
5. `continue` skips to next iteration
6. Always update loop counters to avoid infinite loops
