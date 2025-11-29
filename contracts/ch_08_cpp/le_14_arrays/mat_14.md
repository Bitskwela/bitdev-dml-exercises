## Background Story

The barangay secretary dropped a bombshell: "We need to track monthly dues for 500 residents. Can you update your system?"

Tian opened the code and stared in horror. The current system used individual variables:

```cpp
int resident1_dues = 0;
int resident2_dues = 0;
int resident3_dues = 0;
// ...
```

Creating 500 variables manually was insane. Processing them would require 500 separate if statements. Calculating totals would need 500 additions written out individually.

"Kuya, there has to be a better way," Tian pleaded. "How do real systems handle thousands or millions of records? Facebook doesn't create a separate variable for each user. Games don't declare individual variables for each enemy."

Kuya Miguel grinned. "Welcome to **arrays**—the solution to managing collections of data. Instead of 500 individual variables, you create one array that holds 500 values. Instead of writing 500 lines of processing code, you write one loop. This is the difference between toy programs and real systems."

"Arrays are everywhere," Kuya Miguel explained. "Player inventory in games, student records in schools, product lists in stores, transaction history in banks. You're about to unlock the power to handle massive amounts of data efficiently. Let's do this!"

---

## Theory & Lecture Content

## What is an Array?

An **array** is a collection of elements of the **same type**, stored in **contiguous memory locations**.

Think of it like:
- A **filing cabinet** with numbered drawers
- A **row of houses** on the same street
- A **list** with indexed positions

```cpp
// Instead of:
int age1 = 25;
int age2 = 30;
int age3 = 28;
// ... (painful for 50 residents!)

// Use an array:
int ages[50];  // Can store 50 ages
```

---

## Declaring Arrays

**Syntax:**
```cpp
dataType arrayName[size];
```

**Examples:**
```cpp
int scores[5];           // 5 integers
double prices[10];       // 10 doubles
char grades[20];         // 20 characters
```

**With initialization:**
```cpp
int numbers[5] = {10, 20, 30, 40, 50};
double fees[3] = {50.0, 100.0, 150.0};
char vowels[5] = {'a', 'e', 'i', 'o', 'u'};
```

---

## Array Indexing

Arrays use **zero-based indexing**: the first element is at index `0`.

```cpp
int ages[5] = {25, 30, 28, 35, 40};
//  Index:      0   1   2   3   4

cout << ages[0];  // 25 (first element)
cout << ages[2];  // 28 (third element)
cout << ages[4];  // 40 (last element)
```

**Visual representation:**
```
Index:  [0]  [1]  [2]  [3]  [4]
Value:   25   30   28   35   40
```

---

## Accessing and Modifying Elements

```cpp
int clearanceFees[3] = {50, 100, 150};

// Access
cout << clearanceFees[0];  // 50

// Modify
clearanceFees[1] = 120;    // Change second element
cout << clearanceFees[1];  // 120

// Use in expressions
int total = clearanceFees[0] + clearanceFees[1] + clearanceFees[2];
cout << total;  // 50 + 120 + 150 = 320
```

---

## Common Mistake: Out-of-Bounds Access

```cpp
int numbers[5] = {10, 20, 30, 40, 50};

cout << numbers[5];  // ❌ DANGER! Index 5 doesn't exist (valid: 0-4)
numbers[10] = 100;   // ❌ DISASTER! Accessing memory you don't own
```

**Valid indices for size N:** `0` to `N-1`

C++ **does not check bounds** at runtime — accessing invalid indices causes **undefined behavior** (crashes, corrupted data, security vulnerabilities).

---

## Looping Through Arrays

### Using a For Loop

```cpp
int ages[5] = {25, 30, 28, 35, 40};

// Display all elements
for (int i = 0; i < 5; i++) {
    cout << "Age[" << i << "] = " << ages[i] << endl;
}
```

**Output:**
```
Age[0] = 25
Age[1] = 30
Age[2] = 28
Age[3] = 35
Age[4] = 40
```

### Getting Array Size

```cpp
int numbers[5] = {10, 20, 30, 40, 50};
int size = sizeof(numbers) / sizeof(numbers[0]);

for (int i = 0; i < size; i++) {
    cout << numbers[i] << " ";
}
```

**Explanation:**
- `sizeof(numbers)` — total bytes of the entire array
- `sizeof(numbers[0])` — bytes of one element
- Division gives the number of elements

---

## Inputting Array Data

```cpp
const int SIZE = 5;
int ages[SIZE];

cout << "Enter " << SIZE << " ages:\n";
for (int i = 0; i < SIZE; i++) {
    cout << "Age " << (i + 1) << ": ";
    cin >> ages[i];
}

// Display
cout << "\nAges entered:\n";
for (int i = 0; i < SIZE; i++) {
    cout << ages[i] << " ";
}
```

---

## Array Initialization

### Full Initialization
```cpp
int numbers[5] = {10, 20, 30, 40, 50};  // All elements specified
```

### Partial Initialization
```cpp
int numbers[5] = {10, 20};  // First 2 specified, rest are 0
// Result: {10, 20, 0, 0, 0}
```

### Zero Initialization
```cpp
int numbers[5] = {0};  // All elements set to 0
// Result: {0, 0, 0, 0, 0}
```

### Omit Size (Automatic)
```cpp
int numbers[] = {10, 20, 30, 40, 50};  // Size automatically 5
```

---

## Practical Example: Barangay Dues Tracker

```cpp
#include <iostream>
using namespace std;

int main() {
    const int NUM_RESIDENTS = 5;
    string names[NUM_RESIDENTS];
    double dues[NUM_RESIDENTS];
    
    // Input
    cout << "Enter resident information:\n";
    for (int i = 0; i < NUM_RESIDENTS; i++) {
        cout << "\nResident " << (i + 1) << ":\n";
        cout << "Name: ";
        cin >> names[i];
        cout << "Monthly dues: P";
        cin >> dues[i];
    }
    
    // Calculate total
    double total = 0;
    for (int i = 0; i < NUM_RESIDENTS; i++) {
        total += dues[i];
    }
    
    // Display report
    cout << "\n===== BARANGAY DUES REPORT =====\n";
    for (int i = 0; i < NUM_RESIDENTS; i++) {
        cout << names[i] << ": P" << dues[i] << endl;
    }
    cout << "================================\n";
    cout << "Total collected: P" << total << endl;
    cout << "Average dues: P" << (total / NUM_RESIDENTS) << endl;
    
    return 0;
}
```

**Sample Run:**
```
Enter resident information:

Resident 1:
Name: Juan
Monthly dues: P100

Resident 2:
Name: Maria
Monthly dues: P150

...

===== BARANGAY DUES REPORT =====
Juan: P100
Maria: P150
Pedro: P100
Ana: P200
Jose: P150
================================
Total collected: P700
Average dues: P140
```

---

## Finding Maximum and Minimum

```cpp
int scores[5] = {85, 92, 78, 95, 88};

int max = scores[0];
int min = scores[0];

for (int i = 1; i < 5; i++) {
    if (scores[i] > max) {
        max = scores[i];
    }
    if (scores[i] < min) {
        min = scores[i];
    }
}

cout << "Highest: " << max << endl;  // 95
cout << "Lowest: " << min << endl;   // 78
```

---

## Searching in Arrays

### Linear Search

```cpp
int residentIDs[5] = {101, 205, 303, 412, 509};
int searchID = 303;
int position = -1;

for (int i = 0; i < 5; i++) {
    if (residentIDs[i] == searchID) {
        position = i;
        break;
    }
}

if (position != -1) {
    cout << "Found at index " << position << endl;
} else {
    cout << "Not found" << endl;
}
```

---

## Counting Occurrences

```cpp
int votes[10] = {1, 2, 1, 3, 2, 1, 2, 3, 1, 2};
int candidate = 1;
int count = 0;

for (int i = 0; i < 10; i++) {
    if (votes[i] == candidate) {
        count++;
    }
}

cout << "Candidate 1 got " << count << " votes" << endl;  // 4 votes
```

---

## Reversing an Array

```cpp
int numbers[5] = {10, 20, 30, 40, 50};
int size = 5;

// Reverse
for (int i = 0; i < size / 2; i++) {
    int temp = numbers[i];
    numbers[i] = numbers[size - 1 - i];
    numbers[size - 1 - i] = temp;
}

// Display
for (int i = 0; i < size; i++) {
    cout << numbers[i] << " ";
}
// Output: 50 40 30 20 10
```

---

## Arrays and Functions

### Passing Arrays to Functions

```cpp
void displayArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int numbers[5] = {10, 20, 30, 40, 50};
    displayArray(numbers, 5);
    return 0;
}
```

**Important:** Arrays are **always passed by reference** (technically as pointers). Changes in the function affect the original array.

### Modifying Array in Function

```cpp
void addBonus(int scores[], int size, int bonus) {
    for (int i = 0; i < size; i++) {
        scores[i] += bonus;
    }
}

int main() {
    int scores[3] = {80, 85, 90};
    
    cout << "Before: ";
    for (int i = 0; i < 3; i++) cout << scores[i] << " ";
    
    addBonus(scores, 3, 5);  // Add 5 points bonus
    
    cout << "\nAfter: ";
    for (int i = 0; i < 3; i++) cout << scores[i] << " ";
    // Output: 85 90 95
    
    return 0;
}
```

---

## Calculating Average with Arrays

```cpp
double calculateAverage(int arr[], int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return static_cast<double>(sum) / size;
}

int main() {
    int grades[5] = {85, 90, 78, 92, 88};
    double avg = calculateAverage(grades, 5);
    cout << "Average: " << avg << endl;  // 86.6
    return 0;
}
```

---

## Parallel Arrays

Use multiple arrays to store related data:

```cpp
const int SIZE = 3;
string names[SIZE] = {"Juan", "Maria", "Pedro"};
int ages[SIZE] = {25, 30, 28};
double balances[SIZE] = {500.0, 750.0, 1000.0};

for (int i = 0; i < SIZE; i++) {
    cout << names[i] << " (Age " << ages[i] << "): P" << balances[i] << endl;
}
```

**Output:**
```
Juan (Age 25): P500
Maria (Age 30): P750
Pedro (Age 28): P1000
```

---

## Common Array Patterns

### 1. Accumulator (Sum)
```cpp
int sum = 0;
for (int i = 0; i < size; i++) {
    sum += arr[i];
}
```

### 2. Counter (Count specific values)
```cpp
int count = 0;
for (int i = 0; i < size; i++) {
    if (arr[i] > threshold) {
        count++;
    }
}
```

### 3. Max/Min Finder
```cpp
int max = arr[0];
for (int i = 1; i < size; i++) {
    if (arr[i] > max) {
        max = arr[i];
    }
}
```

### 4. Search
```cpp
int index = -1;
for (int i = 0; i < size; i++) {
    if (arr[i] == target) {
        index = i;
        break;
    }
}
```

---

## Best Practices

1. **Use constants for size:**
```cpp
const int SIZE = 10;
int numbers[SIZE];  // ✓ Clear and maintainable
```

2. **Always check bounds:**
```cpp
for (int i = 0; i < SIZE; i++) {  // ✓ Safe
    cout << numbers[i];
}
```

3. **Initialize arrays:**
```cpp
int numbers[5] = {0};  // ✓ All elements start at 0
```

4. **Pass size to functions:**
```cpp
void process(int arr[], int size) {  // ✓ Function knows array size
    for (int i = 0; i < size; i++) {
        // ...
    }
}
```

---

## Common Mistakes

### Mistake 1: Uninitialized Arrays
```cpp
int numbers[5];  // Contains garbage values!
cout << numbers[0];  // ❌ Unpredictable

// ✓ CORRECT
int numbers[5] = {0};  // Initialize to 0
```

### Mistake 2: Off-by-One Error
```cpp
int arr[5];
for (int i = 0; i <= 5; i++) {  // ❌ i=5 is out of bounds!
    arr[i] = 0;
}

// ✓ CORRECT
for (int i = 0; i < 5; i++) {
    arr[i] = 0;
}
```

### Mistake 3: Forgetting Size in Functions
```cpp
void display(int arr[]) {  // ❌ Function doesn't know size
    // How many elements to display?
}

// ✓ CORRECT
void display(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i];
    }
}
```

---

## Challenge Exercises

1. **Attendance Tracker:**
   - Array of 7 elements for days of week
   - Input attendance count for each day
   - Find highest and lowest attendance
   - Calculate average

2. **Clearance Fee Calculator:**
   - Array of 5 resident ages
   - Calculate fee for each (50 for adults, 30 for seniors)
   - Store fees in parallel array
   - Display total revenue

3. **Grade Analyzer:**
   - Array of 10 student grades
   - Count passing (>= 75) and failing
   - Find highest and lowest grade
   - Calculate class average

---

## Summary

Tian practiced creating arrays. "So instead of 50 separate variables, I use one array!"

"Exactly!" Kuya Miguel nodded. "Arrays are your first weapon for managing **collections of data**. Remember:
- Arrays store **multiple values** of the **same type**
- Use **zero-based indexing** (0 to size-1)
- Always **check bounds** to avoid crashes
- Arrays are **passed by reference** to functions
- Use **loops** to process array elements"

"Next," Kuya Miguel said, "we'll explore **strings** — arrays of characters with superpowers!"

---

**Key Takeaways:**
1. Arrays store multiple values of the same type
2. Indexing starts at 0
3. Use loops to process arrays
4. Pass size to functions
5. Always initialize arrays

---

## Closing Story

"Fifty variables would have been insane!" Tian laughed, running his barangay dues tracker. The array held all 50 resident ages cleanly, processed in a simple loop.

Kuya Miguel grinned. "That's why arrays exist. Imagine tracking attendance for 200 residents, or grades for 1000 students. Without arrays, it would be impossible."

Tian practiced finding the maximum age, calculating averages, searching for specific values. "And they're always passed by reference to functions, so changes stick. But I need to always pass the size too, because the function can't determine it automatically."

"Right! And always remember: zero-based indexing. Valid indices are 0 to size minus 1. Go beyond that and you're accessing memory you don't own. That's undefined behavior: crashes, corrupted data, security holes."

Tian nodded seriously. "Initialize arrays, check bounds, use constants for size, pass size to functions. Got it."

"Perfect. Arrays are your first weapon in the Arsenal. Now let's upgrade to strings: arrays of characters with superpowers!"

**Next Lesson:** Strings - Arrays of Characters
