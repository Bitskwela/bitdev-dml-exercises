# Quiz: Lesson 7 - Nested Control

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What is the output?
```cpp
for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 2; j++) {
        cout << i * j << " ";
    }
}
```

A) `1 2 2 4 3 6`  
B) `1 2 3 4 5 6`  
C) `2 4 6`  
D) `1 2 3`

**Answer: A) `1 2 2 4 3 6`**

**Explanation:**
The outer loop runs 3 times (i=1,2,3), and for each iteration, the inner loop runs 2 times (j=1,2):
- i=1: j=1 → 1×1=1, j=2 → 1×2=2
- i=2: j=1 → 2×1=2, j=2 → 2×2=4
- i=3: j=1 → 3×1=3, j=2 → 3×2=6

Output: `1 2 2 4 3 6`

---

### Question 2
How many times will "Hello" be printed?
```cpp
for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
        cout << "Hello ";
    }
}
```

A) 4 times  
B) 7 times  
C) 12 times  
D) 3 times

**Answer: C) 12 times**

**Explanation:**
Total iterations = outer loop × inner loop = 4 × 3 = 12

The outer loop runs 4 times, and for each of those iterations, the inner loop runs 3 times completely.

---

### Question 3
What pattern does this code create?
```cpp
for (int i = 1; i <= 4; i++) {
    for (int j = 1; j <= i; j++) {
        cout << "*";
    }
    cout << endl;
}
```

A) A square of stars  
B) A right triangle of stars  
C) A single line of stars  
D) An inverted triangle

**Answer: B) A right triangle of stars**

**Explanation:**
The inner loop runs `i` times, where `i` increases from 1 to 4:
```
*
**
***
****
```

Row 1: i=1, j runs 1 time → 1 star
Row 2: i=2, j runs 2 times → 2 stars
Row 3: i=3, j runs 3 times → 3 stars
Row 4: i=4, j runs 4 times → 4 stars

---

### Question 4
What is wrong with this code?
```cpp
for (int i = 0; i < 3; i++) {
    for (int i = 0; i < 3; i++) {
        cout << i;
    }
}
```

A) Nothing, it's correct  
B) Using the same variable name `i` in both loops  
C) Missing semicolon  
D) Infinite loop

**Answer: B) Using the same variable name `i` in both loops**

**Explanation:**
You cannot declare the same variable twice in nested scopes. The inner loop tries to redeclare `i`, which causes a compilation error.

**Fix:**
```cpp
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {  // Use different name
        cout << j;
    }
}
```

---

### Question 5
Given this code, what is the output?
```cpp
for (int i = 1; i <= 3; i++) {
    if (i == 2) {
        continue;
    }
    cout << i << " ";
}
```

A) `1 2 3`  
B) `1 3`  
C) `2`  
D) `1 2`

**Answer: B) `1 3`**

**Explanation:**
When `i == 2`, the `continue` statement skips the `cout`, moving directly to the next iteration. So only 1 and 3 are printed.

---


# Quiz 2

### Question 6
Which code correctly counts residents above age 60?
```cpp
int ages[] = {45, 65, 52, 70, 58};

// Option A
int count = 0;
for (int i = 0; i < 5; i++) {
    if (ages[i] > 60) {
        count++;
    }
}

// Option B
int count = 0;
for (int i = 0; i < 5; i++) {
    if (ages[i] > 60) {
        continue;
    }
    count++;
}

// Option C
int count = 0;
for (int i = 0; i < 5; i++) {
    if (ages[i] <= 60) {
        break;
    }
    count++;
}
```

A) Option A  
B) Option B  
C) Option C  
D) None are correct

**Answer: A) Option A**

**Explanation:**
- **Option A**: Correct. Checks if age > 60, increments count. Result: count = 2 (ages 65 and 70)

- **Option B**: Wrong logic. It continues (skips) when age > 60, but increments for ages ≤ 60. This counts the opposite of what we want.

- **Option C**: Wrong. The `break` exits the entire loop when it finds the first age ≤ 60, so it doesn't check all residents.

---




### Question 7
What does this nested loop output?
```cpp
for (int i = 1; i <= 2; i++) {
    for (int j = 1; j <= 3; j++) {
        if (j == 2) {
            break;
        }
        cout << i << "," << j << " ";
    }
}
```

A) `1,1 1,2 1,3 2,1 2,2 2,3`  
B) `1,1 2,1`  
C) `1,1 1,3 2,1 2,3`  
D) `1,1`

**Answer: B) `1,1 2,1`**

**Explanation:**
The `break` exits the inner loop when `j == 2`:
- i=1: j=1 → prints "1,1", j=2 → break (exits inner loop)
- i=2: j=1 → prints "2,1", j=2 → break (exits inner loop)

The inner loop never reaches j=3 because break is triggered at j=2.

---

### Question 8
A 2D array `seats[3][4]` represents theater seats (3 rows, 4 seats per row). How many total iterations to check all seats?

```cpp
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
        // Check seat
    }
}
```

A) 7 iterations  
B) 12 iterations  
C) 3 iterations  
D) 4 iterations

**Answer: B) 12 iterations**

**Explanation:**
Total iterations = rows × columns = 3 × 4 = 12

The outer loop runs 3 times, and for each outer iteration, the inner loop runs 4 times.

---

### Question 9
What is the purpose of this code?
```cpp
int numbers[] = {10, 20, 30, 40};
int target = 50;

for (int i = 0; i < 4; i++) {
    for (int j = i + 1; j < 4; j++) {
        if (numbers[i] + numbers[j] == target) {
            cout << numbers[i] << " + " << numbers[j] << endl;
        }
    }
}
```

A) Find the sum of all numbers  
B) Find pairs that sum to target  
C) Find the largest number  
D) Sort the array

**Answer: B) Find pairs that sum to target**

**Explanation:**
This is a classic "pair sum" algorithm. It checks every possible pair of numbers (without duplicates) to see if they add up to the target value (50).

For this array:
- 10 + 40 = 50 ✓
- 20 + 30 = 50 ✓

The inner loop starts at `j = i + 1` to avoid checking the same pair twice and to avoid pairing a number with itself.

---


# Quiz 1

### Question 10
Given this code for a barangay survey, what does it calculate?
```cpp
int responses[4][3] = {
    {5, 4, 5},   // Resident 1 ratings
    {3, 4, 4},   // Resident 2 ratings
    {5, 5, 4},   // Resident 3 ratings
    {4, 5, 5}    // Resident 4 ratings
};

for (int i = 0; i < 4; i++) {
    int total = 0;
    for (int j = 0; j < 3; j++) {
        total += responses[i][j];
    }
    double average = total / 3.0;
    cout << "Resident " << (i+1) << ": " << average << endl;
}
```

A) Total score for all residents  
B) Average rating per question  
C) Average rating per resident  
D) Highest rating

**Answer: C) Average rating per resident**

**Explanation:**
The code calculates the average rating for each resident across 3 questions:

- Resident 1: (5+4+5)/3 = 14/3 = 4.67
- Resident 2: (3+4+4)/3 = 11/3 = 3.67
- Resident 3: (5+5+4)/3 = 14/3 = 4.67
- Resident 4: (4+5+5)/3 = 14/3 = 4.67

The outer loop goes through each resident (row), and the inner loop sums up their answers (columns). Then it calculates the average by dividing by the number of questions (3).

---

**Score yourself:**
- 10/10: Nesting Master! 🏆
- 8-9: Excellent understanding!
- 6-7: Good, review nested loop patterns
- Below 6: Practice more nested examples

**Key Concepts to Remember:**
1. Nested loops multiply iterations (outer × inner)
2. Use different variable names (i, j, k)
3. `break` exits the innermost loop only
4. `continue` skips to next iteration of innermost loop
5. Nested loops are useful for 2D data (grids, tables)
6. Watch performance with deep nesting
