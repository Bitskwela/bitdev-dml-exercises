## Background Story

The barangay office had provided Tian with a CSV file containing visitor records—100 entries with names, dates, purposes of visit, and processing status. The goal was to analyze this data: count how many clearance applications were processed, identify the busiest days, and generate a summary report.

Tian opened the file and started writing JavaScript to process the first record:

```javascript
let visitor1Name = "Juan Dela Cruz";
let visitor1Purpose = "Clearance";
let visitor1Status = "Processed";
console.log(visitor1Name + ": " + visitor1Status);
```

Then the second record:

```javascript
let visitor2Name = "Maria Santos";
let visitor2Purpose = "Barangay ID";
let visitor2Status = "Pending";
console.log(visitor2Name + ": " + visitor2Status);
```

Then the third... and suddenly the horrible realization hit. There were 100 records. Writing this code manually would require 300+ lines of repetitive, mind-numbing code. And if the processing logic needed to change, they'd have to update it in 100 different places.

"There has to be a better way," Tian muttered.

Meanwhile, Rhea Joy was building the announcements page. The barangay had 15 active announcements, and she needed to display each one with a title, date, and description. She started manually creating the HTML:

```javascript
document.querySelector('#announcements').innerHTML = `
    <div class="announcement">
        <h3>Announcement 1</h3>
        <p>Date: May 1, 2024</p>
        <p>Description...</p>
    </div>
    <div class="announcement">
        <h3>Announcement 2</h3>
        <p>Date: May 2, 2024</p>
        <p>Description...</p>
    </div>
    ...
`;
```

After writing out three announcements manually, she stopped. This was going to be 15 nearly identical blocks of code. And when new announcements were added, she'd have to manually add more HTML.

"This feels wrong," she thought. "Professional websites don't manually code every item. There must be a programming concept for repeating tasks."

It was Sunday afternoon. Both Tian and Rhea Joy were at the internet cafe, each stuck on the same fundamental problem: how to perform repetitive tasks without writing repetitive code.

Tian pulled up Stack Overflow and found answers mentioning "for loops," "while loops," and "iteration." Rhea Joy googled "how to display array items" and found similar results.

They experimented with a simple example:

```javascript
for (let i = 1; i <= 5; i++) {
    console.log("Count: " + i);
}
```

The console printed:
```
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
```

Five lines of output from three lines of code! The `for` loop had repeated the `console.log` statement five times automatically, with `i` changing each iteration.

"This is it!" Tian exclaimed. "This is how we process 100 records without writing 100 blocks of code. We loop through the data!"

But understanding the basic concept and actually implementing it were different challenges. What's the proper syntax? How do you loop through arrays? When do you use `for`, `while`, or `do...while`? How do you break out of loops early or skip iterations?

That evening, they both called Kuya Miguel.

"Kuya, we've been writing repetitive code—processing multiple records, displaying multiple items. We discovered loops can automate repetition, but we only understand the basic concept. Can you teach us all types of loops, when to use each, and how to loop through arrays and data structures?"

Miguel smiled. "Loops are one of programming's fundamental superpowers. They transform tedious manual repetition into elegant automation. Today we're learning `for` loops, `while` loops, `do...while` loops, `for...of` for arrays, `for...in` for objects, and loop control with `break` and `continue`. By the end of this lesson, you'll process that 100-record dataset with just a few lines of code."

---

## Theory & Lecture Content

## What are Loops?

**Loops** execute a block of code repeatedly until a condition is met.

**Real-life example:**
```
WHILE there are visitors in line:
    Process next visitor
    Check if more visitors remain
```

**Why use loops?**
- Avoid repetitive code
- Process arrays/lists
- Create patterns
- Iterate until condition is met

---

## for Loop

**Best for:** When you know how many times to repeat.

**Syntax:**
```javascript
for (initialization; condition; increment) {
    // Code to repeat
}
```

**Basic example:**
```javascript
for (let i = 1; i <= 5; i++) {
    console.log("Count: " + i);
}
```

**Output:**
```
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
```

**How it works:**
1. **Initialization:** `let i = 1` (runs once at start)
2. **Condition:** `i <= 5` (checked before each iteration)
3. **Code block:** Executes if condition is true
4. **Increment:** `i++` (runs after each iteration)
5. Repeat steps 2-4 until condition is false

---

## for Loop Examples

### Counting down
```javascript
for (let i = 5; i >= 1; i--) {
    console.log(i);
}
console.log("Blast off!");
```

**Output:**
```
5
4
3
2
1
Blast off!
```

### Skip counting
```javascript
for (let i = 0; i <= 10; i += 2) {
    console.log(i);
}
```

**Output:**
```
0
2
4
6
8
10
```

### Barangay visitor numbers
```javascript
console.log("=== Daily Visitor Log ===");

for (let visitorNumber = 1; visitorNumber <= 5; visitorNumber++) {
    console.log("Processing Visitor #" + visitorNumber);
}

console.log("All visitors processed");
```

**Output:**
```
=== Daily Visitor Log ===
Processing Visitor #1
Processing Visitor #2
Processing Visitor #3
Processing Visitor #4
Processing Visitor #5
All visitors processed
```

---

## while Loop

**Best for:** When you don't know how many times to repeat.

**Syntax:**
```javascript
while (condition) {
    // Code to repeat
    // Must eventually make condition false!
}
```

**Example:**
```javascript
let count = 1;

while (count <= 5) {
    console.log("Count: " + count);
    count++;
}
```

**Output:**
```
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
```

**⚠️ Warning:** Always update the condition variable, or you'll create an **infinite loop**!

```javascript
// BAD - Infinite loop!
let x = 1;
while (x <= 5) {
    console.log(x);
    // Forgot x++; - loop never ends!
}
```

---

## while Loop Examples

### User input validation
```javascript
let password = "";

while (password !== "1234") {
    password = prompt("Enter password:");
}

console.log("Access granted!");
```

### Barangay queue system
```javascript
let queueNumber = 1;
let maxQueue = 5;

console.log("=== Barangay Service Queue ===");

while (queueNumber <= maxQueue) {
    console.log("Now serving: #" + queueNumber);
    queueNumber++;
}

console.log("All queued visitors served");
```

**Output:**
```
=== Barangay Service Queue ===
Now serving: #1
Now serving: #2
Now serving: #3
Now serving: #4
Now serving: #5
All queued visitors served
```

---

## do...while Loop

**Best for:** When code must run at least once.

**Syntax:**
```javascript
do {
    // Code executes at least once
} while (condition);
```

**Example:**
```javascript
let number = 6;

do {
    console.log("Number: " + number);
    number++;
} while (number <= 5);
```

**Output:**
```
Number: 6
```

**Key difference:** Code runs first, THEN checks condition.

---

## do...while Examples

### Menu system
```javascript
let choice;

do {
    console.log("=== Barangay Services ===");
    console.log("1. Clearance");
    console.log("2. Residency");
    console.log("3. Exit");
    
    choice = prompt("Enter choice:");
    
    if (choice === "1") {
        console.log("Barangay Clearance selected");
    } else if (choice === "2") {
        console.log("Residency Certificate selected");
    }
} while (choice !== "3");

console.log("Thank you!");
```

### Validation
```javascript
let age;

do {
    age = prompt("Enter age (must be 18+):");
} while (age < 18);

console.log("Age verified: " + age);
```

---

## break Statement

**Exit loop early:**

```javascript
for (let i = 1; i <= 10; i++) {
    if (i === 5) {
        break;  // Stop loop when i is 5
    }
    console.log(i);
}
console.log("Loop stopped");
```

**Output:**
```
1
2
3
4
Loop stopped
```

**Barangay search:**
```javascript
let visitors = ["Juan", "Maria", "Pedro", "Rosa", "Jose"];
let searchName = "Pedro";
let found = false;

for (let i = 0; i < visitors.length; i++) {
    if (visitors[i] === searchName) {
        console.log("Found: " + searchName + " at position " + i);
        found = true;
        break;  // Stop searching once found
    }
}

if (!found) {
    console.log(searchName + " not found");
}
```

---

## continue Statement

**Skip current iteration, continue to next:**

```javascript
for (let i = 1; i <= 5; i++) {
    if (i === 3) {
        continue;  // Skip when i is 3
    }
    console.log(i);
}
```

**Output:**
```
1
2
4
5
```

**Skip even numbers:**
```javascript
for (let i = 1; i <= 10; i++) {
    if (i % 2 === 0) {
        continue;  // Skip even numbers
    }
    console.log(i);
}
```

**Output:**
```
1
3
5
7
9
```

**Barangay fee calculation (skip seniors):**
```javascript
let ages = [25, 30, 65, 40, 70, 22];
let regularFee = 50;
let totalRevenue = 0;

console.log("=== Fee Collection ===");

for (let i = 0; i < ages.length; i++) {
    if (ages[i] >= 60) {
        console.log("Senior citizen - Free service");
        continue;  // Skip fee calculation for seniors
    }
    
    console.log("Age " + ages[i] + ": ₱" + regularFee);
    totalRevenue += regularFee;
}

console.log("\nTotal Revenue: ₱" + totalRevenue);
```

**Output:**
```
=== Fee Collection ===
Age 25: ₱50
Age 30: ₱50
Senior citizen - Free service
Age 40: ₱50
Senior citizen - Free service
Age 22: ₱50

Total Revenue: ₱200
```

---

## Looping Through Arrays

**Arrays and loops work perfectly together:**

```javascript
let services = ["Clearance", "Residency", "Indigency", "Business Permit"];

console.log("=== Available Services ===");

for (let i = 0; i < services.length; i++) {
    console.log((i + 1) + ". " + services[i]);
}
```

**Output:**
```
=== Available Services ===
1. Clearance
2. Residency
3. Indigency
4. Business Permit
```

**Calculate total:**
```javascript
let fees = [50, 30, 20, 100];
let total = 0;

for (let i = 0; i < fees.length; i++) {
    total += fees[i];
}

console.log("Total fees: ₱" + total);
// Output: Total fees: ₱200
```

---

## Nested Loops

**Loop inside a loop:**

```javascript
for (let row = 1; row <= 3; row++) {
    for (let col = 1; col <= 3; col++) {
        console.log("Row " + row + ", Col " + col);
    }
}
```

**Multiplication table:**
```javascript
for (let i = 1; i <= 3; i++) {
    let line = "";
    for (let j = 1; j <= 3; j++) {
        line += (i * j) + " ";
    }
    console.log(line);
}
```

**Output:**
```
1 2 3 
2 4 6 
3 6 9 
```

**Barangay schedule:**
```javascript
let days = ["Monday", "Wednesday", "Friday"];
let timeSlots = ["9:00 AM", "2:00 PM", "4:00 PM"];

console.log("=== Barangay Service Schedule ===");

for (let i = 0; i < days.length; i++) {
    console.log("\n" + days[i] + ":");
    for (let j = 0; j < timeSlots.length; j++) {
        console.log("  - " + timeSlots[j]);
    }
}
```

---

## Complete Barangay System

```javascript
// Barangay visitor processing system
const visitors = [
    { name: "Juan Dela Cruz", age: 25, service: "Clearance" },
    { name: "Maria Santos", age: 65, service: "Residency" },
    { name: "Pedro Reyes", age: 30, service: "Indigency" },
    { name: "Rosa Garcia", age: 70, service: "Clearance" },
    { name: "Jose Ramos", age: 22, service: "Business Permit" }
];

const serviceFees = {
    "Clearance": 50,
    "Residency": 30,
    "Indigency": 20,
    "Business Permit": 100
};

console.log("=== BARANGAY SERVICE PROCESSING ===\n");

let totalRevenue = 0;
let seniorCount = 0;

for (let i = 0; i < visitors.length; i++) {
    let visitor = visitors[i];
    let baseFee = serviceFees[visitor.service];
    let finalFee = baseFee;
    
    console.log("Visitor #" + (i + 1) + ": " + visitor.name);
    console.log("Service: " + visitor.service);
    console.log("Base Fee: ₱" + baseFee);
    
    // Check for senior discount
    if (visitor.age >= 60) {
        finalFee = baseFee * 0.8;  // 20% discount
        seniorCount++;
        console.log("🎉 Senior Discount (20%): -₱" + (baseFee - finalFee));
    }
    
    console.log("Final Fee: ₱" + finalFee);
    totalRevenue += finalFee;
    console.log("---");
}

console.log("\n=== DAILY SUMMARY ===");
console.log("Total Visitors: " + visitors.length);
console.log("Senior Citizens: " + seniorCount);
console.log("Total Revenue: ₱" + totalRevenue);
```

---

## Common Patterns

### Sum of numbers
```javascript
let sum = 0;

for (let i = 1; i <= 10; i++) {
    sum += i;
}

console.log("Sum: " + sum);  // 55
```

### Find maximum
```javascript
let numbers = [23, 45, 12, 67, 34];
let max = numbers[0];

for (let i = 1; i < numbers.length; i++) {
    if (numbers[i] > max) {
        max = numbers[i];
    }
}

console.log("Maximum: " + max);  // 67
```

### Count occurrences
```javascript
let services = ["Clearance", "Residency", "Clearance", "Indigency", "Clearance"];
let searchService = "Clearance";
let count = 0;

for (let i = 0; i < services.length; i++) {
    if (services[i] === searchService) {
        count++;
    }
}

console.log(searchService + " count: " + count);  // 3
```

---

## Best Practices

### 1. Choose the right loop
```javascript
// Known iterations - use for
for (let i = 0; i < 10; i++) {
    console.log(i);
}

// Unknown iterations - use while
while (userInput !== "quit") {
    userInput = prompt("Enter command:");
}

// Must run once - use do...while
do {
    choice = showMenu();
} while (choice !== "exit");
```

### 2. Avoid infinite loops
```javascript
// Bad - infinite loop
let x = 0;
while (x < 10) {
    console.log(x);
    // Forgot x++
}

// Good - will end
let x = 0;
while (x < 10) {
    console.log(x);
    x++;
}
```

### 3. Use meaningful variable names
```javascript
// Bad
for (let i = 0; i < arr.length; i++) {
    console.log(arr[i]);
}

// Good
for (let visitorIndex = 0; visitorIndex < visitors.length; visitorIndex++) {
    console.log(visitors[visitorIndex]);
}
```

---

## Summary

Tian reviewed the loops:

**for loop (known iterations):**
```javascript
for (let i = 0; i < 5; i++) {
    // Code
}
```

**while loop (unknown iterations):**
```javascript
while (condition) {
    // Code
    // Update condition!
}
```

**do...while (run at least once):**
```javascript
do {
    // Code
} while (condition);
```

**break (exit loop):**
```javascript
if (condition) {
    break;
}
```

**continue (skip iteration):**
```javascript
if (condition) {
    continue;
}
```

Rhea Joy smiled. "Now we can process hundreds of visitors automatically!"

---

## What's Next?

In the next lesson, you'll learn about **Functions**—how to organize and reuse your code efficiently.

---

---

## Closing Story

Tian wrote a `for` loop to display all barangay residents. One line of code. Fifty residents listed. No copy-paste. No manual repetition. Just clean, efficient iteration.

"Loops are power," Kuya Miguel said. "Never repeat yourself. Let the computer do it."

Tian added a `while` loop for pagination, a `for...of` loop for arrays. The code was concise. The output was perfect. Programming was starting to feel natural.

_Next up: Functions and Scopingorganizing code!_