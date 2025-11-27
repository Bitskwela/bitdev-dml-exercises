# Quiz 26: Looping in JavaScript

Test your understanding of for, while, and do...while loops!

---

## Quiz 1

### Question 1
What is the output?
```javascript
for (let i = 1; i <= 3; i++) {
    console.log(i);
}
```

A) `1 2 3`  
B) `0 1 2`  
C) `1` `2` `3` (on separate lines)  
D) Error

---

### Question 2
How many times does this loop run?
```javascript
for (let i = 0; i < 5; i++) {
    console.log("Hello");
}
```

A) 4 times  
B) 5 times  
C) 6 times  
D) Infinite

---

### Question 3
What is the output?
```javascript
let count = 3;

while (count > 0) {
    console.log(count);
    count--;
}
```

A) `3 2 1`  
B) `1 2 3`  
C) `3 2 1 0`  
D) Infinite loop

---

### Question 4
What happens with this code?
```javascript
let x = 5;

while (x < 5) {
    console.log(x);
    x++;
}
```

A) Prints `5`  
B) Prints nothing  
C) Infinite loop  
D) Error

---

### Question 5
What is the difference between `while` and `do...while`?

A) No difference  
B) `do...while` runs at least once  
C) `while` is faster  
D) `do...while` requires a condition

---

## Quiz 2

### Question 6
What is the output?
```javascript
for (let i = 1; i <= 5; i++) {
    if (i === 3) {
        break;
    }
    console.log(i);
}
```

A) `1 2 3`  
B) `1 2`  
C) `1 2 3 4 5`  
D) `1 2 4 5`

---

### Question 7
What is the output?
```javascript
for (let i = 1; i <= 5; i++) {
    if (i === 3) {
        continue;
    }
    console.log(i);
}
```

A) `1 2 3 4 5`  
B) `1 2 4 5`  
C) `1 2`  
D) `3`

---

### Question 8
What is the output?
```javascript
let sum = 0;

for (let i = 1; i <= 3; i++) {
    sum += i;
}

console.log(sum);
```

A) `3`  
B) `6`  
C) `123`  
D) `0`

---

### Question 9
How many times does this nested loop print "Hello"?
```javascript
for (let i = 0; i < 2; i++) {
    for (let j = 0; j < 3; j++) {
        console.log("Hello");
    }
}
```

A) 2 times  
B) 3 times  
C) 5 times  
D) 6 times

---

### Question 10
What is the output?
```javascript
do {
    console.log("Once");
} while (false);
```

A) Nothing  
B) `Once`  
C) Infinite loop  
D) Error

---

## Answers

1. **C** - `1` `2` `3` (on separate lines)
2. **B** - 5 times
3. **A** - `3 2 1`
4. **B** - Prints nothing
5. **B** - `do...while` runs at least once
6. **B** - `1 2`
7. **B** - `1 2 4 5`
8. **B** - `6`
9. **D** - 6 times
10. **B** - `Once`

---

## Detailed Explanations

### Question 1: Basic for loop
```javascript
for (let i = 1; i <= 3; i++) {
    console.log(i);
}
```

**Answer: C - `1` `2` `3` (on separate lines)**

**Explanation:**
- Start: `i = 1`
- Iteration 1: `1 <= 3` ✓ → Print `1` → `i++` becomes `2`
- Iteration 2: `2 <= 3` ✓ → Print `2` → `i++` becomes `3`
- Iteration 3: `3 <= 3` ✓ → Print `3` → `i++` becomes `4`
- Check: `4 <= 3` ✗ → Stop

**Output:**
```
1
2
3
```

**Barangay visitor numbers:**
```javascript
console.log("=== Queue Numbers ===");

for (let number = 1; number <= 5; number++) {
    console.log("Visitor #" + number);
}
```

**Output:**
```
=== Queue Numbers ===
Visitor #1
Visitor #2
Visitor #3
Visitor #4
Visitor #5
```

---

### Question 2: Loop iteration count
```javascript
for (let i = 0; i < 5; i++) {
    console.log("Hello");
}
```

**Answer: B - 5 times**

**Explanation:**
- `i = 0`: `0 < 5` ✓ → Print "Hello"
- `i = 1`: `1 < 5` ✓ → Print "Hello"
- `i = 2`: `2 < 5` ✓ → Print "Hello"
- `i = 3`: `3 < 5` ✓ → Print "Hello"
- `i = 4`: `4 < 5` ✓ → Print "Hello"
- `i = 5`: `5 < 5` ✗ → Stop

**Total: 5 iterations**

**Key:** `i < 5` means "while i is less than 5" (not "less than or equal to")

**Barangay service days:**
```javascript
let services = ["Mon", "Tue", "Wed", "Thu", "Fri"];

for (let day = 0; day < services.length; day++) {
    console.log("Day " + (day + 1) + ": " + services[day]);
}
// Runs 5 times (0, 1, 2, 3, 4)
```

---

### Question 3: while loop countdown
```javascript
let count = 3;

while (count > 0) {
    console.log(count);
    count--;
}
```

**Answer: A - `3 2 1`**

**Explanation:**
- Start: `count = 3`
- Iteration 1: `3 > 0` ✓ → Print `3` → `count--` becomes `2`
- Iteration 2: `2 > 0` ✓ → Print `2` → `count--` becomes `1`
- Iteration 3: `1 > 0` ✓ → Print `1` → `count--` becomes `0`
- Check: `0 > 0` ✗ → Stop

**Output:**
```
3
2
1
```

**Barangay closing announcement:**
```javascript
let minutesLeft = 5;

console.log("Office closing in:");

while (minutesLeft > 0) {
    console.log(minutesLeft + " minutes");
    minutesLeft--;
}

console.log("CLOSED");
```

---

### Question 4: while loop that never runs
```javascript
let x = 5;

while (x < 5) {
    console.log(x);
    x++;
}
```

**Answer: B - Prints nothing**

**Explanation:**
- Initial check: `5 < 5` is `false`
- Loop body never executes
- No output

**Key:** while loops check condition BEFORE running code.

**Barangay queue example:**
```javascript
let queueLength = 0;

while (queueLength > 0) {
    console.log("Processing visitor");
    queueLength--;
}

console.log("No visitors in queue");
// Output: No visitors in queue (loop never ran)
```

---

### Question 5: while vs do...while
**Answer: B - `do...while` runs at least once**

**Explanation:**

**while:**
- Checks condition FIRST
- May never run if condition is false

```javascript
let x = 10;

while (x < 5) {
    console.log(x);  // Never runs
}
```

**do...while:**
- Runs code FIRST
- Checks condition AFTER
- Always runs at least once

```javascript
let x = 10;

do {
    console.log(x);  // Runs once
} while (x < 5);
```

**Barangay menu example:**
```javascript
// User must see menu at least once
let choice;

do {
    console.log("=== Services ===");
    console.log("1. Clearance");
    console.log("2. Exit");
    choice = prompt("Choose:");
} while (choice !== "2");
```

---

### Question 6: break statement
```javascript
for (let i = 1; i <= 5; i++) {
    if (i === 3) {
        break;
    }
    console.log(i);
}
```

**Answer: B - `1 2`**

**Explanation:**
- `i = 1`: Not 3, print `1`
- `i = 2`: Not 3, print `2`
- `i = 3`: Equals 3, **break** → Exit loop
- Loop stops, never reaches 4 or 5

**Output:**
```
1
2
```

**Barangay search:**
```javascript
let visitors = ["Juan", "Maria", "Pedro", "Rosa"];
let target = "Pedro";

for (let i = 0; i < visitors.length; i++) {
    if (visitors[i] === target) {
        console.log("Found at position " + i);
        break;  // Stop searching
    }
}
// Output: Found at position 2
```

---

### Question 7: continue statement
```javascript
for (let i = 1; i <= 5; i++) {
    if (i === 3) {
        continue;
    }
    console.log(i);
}
```

**Answer: B - `1 2 4 5`**

**Explanation:**
- `i = 1`: Not 3, print `1`
- `i = 2`: Not 3, print `2`
- `i = 3`: Equals 3, **continue** → Skip print, go to `i = 4`
- `i = 4`: Not 3, print `4`
- `i = 5`: Not 3, print `5`

**Output:**
```
1
2
4
5
```

**Key:** `continue` skips current iteration, loop continues.

**Barangay fee collection (skip seniors):**
```javascript
let ages = [25, 30, 65, 40];
let fee = 50;

for (let i = 0; i < ages.length; i++) {
    if (ages[i] >= 60) {
        console.log("Senior - Free");
        continue;  // Skip fee calculation
    }
    console.log("Fee: ₱" + fee);
}
```

**Output:**
```
Fee: ₱50
Fee: ₱50
Senior - Free
Fee: ₱50
```

---

### Question 8: Accumulating sum
```javascript
let sum = 0;

for (let i = 1; i <= 3; i++) {
    sum += i;
}

console.log(sum);
```

**Answer: B - `6`**

**Explanation:**
- Start: `sum = 0`
- `i = 1`: `sum = 0 + 1 = 1`
- `i = 2`: `sum = 1 + 2 = 3`
- `i = 3`: `sum = 3 + 3 = 6`
- Print: `6`

**Barangay total fees:**
```javascript
let fees = [50, 30, 20, 100];
let total = 0;

for (let i = 0; i < fees.length; i++) {
    total += fees[i];
}

console.log("Total revenue: ₱" + total);
// Output: Total revenue: ₱200
```

---

### Question 9: Nested loops
```javascript
for (let i = 0; i < 2; i++) {
    for (let j = 0; j < 3; j++) {
        console.log("Hello");
    }
}
```

**Answer: D - 6 times**

**Explanation:**

**Outer loop runs 2 times:**
- `i = 0`: Inner loop runs 3 times
- `i = 1`: Inner loop runs 3 times

**Total: 2 × 3 = 6 prints**

**Detailed trace:**
```
i=0, j=0: Hello
i=0, j=1: Hello
i=0, j=2: Hello
i=1, j=0: Hello
i=1, j=1: Hello
i=1, j=2: Hello
```

**Barangay schedule:**
```javascript
let days = ["Monday", "Wednesday"];
let slots = ["9 AM", "2 PM", "4 PM"];

for (let d = 0; d < days.length; d++) {
    for (let s = 0; s < slots.length; s++) {
        console.log(days[d] + " at " + slots[s]);
    }
}
```

**Output (6 lines):**
```
Monday at 9 AM
Monday at 2 PM
Monday at 4 PM
Wednesday at 9 AM
Wednesday at 2 PM
Wednesday at 4 PM
```

---

### Question 10: do...while with false condition
```javascript
do {
    console.log("Once");
} while (false);
```

**Answer: B - `Once`**

**Explanation:**
1. Execute code block first: Print `"Once"`
2. Check condition: `false`
3. Don't repeat

**Key:** `do...while` always runs at least once, even if condition is false.

**Comparison with while:**
```javascript
// while - never runs
while (false) {
    console.log("Never");
}
// Output: (nothing)

// do...while - runs once
do {
    console.log("Once");
} while (false);
// Output: Once
```

**Barangay form:**
```javascript
let validInput = false;

do {
    console.log("Please enter your name:");
    let name = prompt("Name:");
    
    if (name !== "") {
        console.log("Thank you, " + name);
        validInput = true;
    }
} while (!validInput);
// Form always shows at least once
```

---

**Great job!** You now understand how to repeat code efficiently with loops!

---
