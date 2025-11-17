# Quiz: Lesson 13 - Modular Grade Calculator

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
Why use functions in a grade calculator?

A) To make code longer  
B) To break down tasks into manageable pieces  
C) To avoid using variables  
D) Functions are required in C++

**Answer: B) To break down tasks into manageable pieces**

**Explanation:**
**Modular programming** means dividing a program into focused functions. Each function handles one specific task:
- `getGrades()` — input
- `calculateAverage()` — computation
- `displayReport()` — output

This makes code:
- **Easier to understand** — each function has clear purpose
- **Easier to debug** — test one function at a time
- **Reusable** — use the same function multiple times

---

### Question 2
Which parameter passing is correct for getting user input?

```cpp
// Option A
void getGrades(double math, double science, double english) {
    cin >> math >> science >> english;
}

// Option B
void getGrades(double& math, double& science, double& english) {
    cin >> math >> science >> english;
}
```

A) Option A  
B) Option B  
C) Both work the same  
D) Neither works

**Answer: B) Option B**

**Explanation:**
- **Option A:** Pass by value creates copies. Changes won't affect the original variables in `main()`.
- **Option B:** Pass by reference (`&`) modifies the original variables. ✓

```cpp
int main() {
    double m, s, e;
    getGrades(m, s, e);  // m, s, e are modified
    cout << m;           // Has the value user entered
}
```

---

### Question 3
What should `calculateAverage()` return?

```cpp
double calculateAverage(double math, double science, double english) {
    // What goes here?
}
```

A) Nothing (void)  
B) The average as a double  
C) true or false  
D) The grades array

**Answer: B) The average as a double**

**Explanation:**
The function calculates a numeric average, so it returns a `double`:

```cpp
double calculateAverage(double math, double science, double english) {
    return (math + science + english) / 3.0;
}

// Usage:
double avg = calculateAverage(85, 90, 88);
cout << avg;  // 87.67
```

---

### Question 4
What's the output?
```cpp
bool isPassing(double average) {
    return average >= 75.0;
}

int main() {
    cout << isPassing(80) << endl;
    cout << isPassing(70) << endl;
    return 0;
}
```

A) `true false`  
B) `1 0`  
C) `80 70`  
D) Compilation error

**Answer: B) `1 0`**

**Explanation:**
- `isPassing(80)` returns `true`, which prints as `1`
- `isPassing(70)` returns `false`, which prints as `0`

Booleans print as 1 (true) or 0 (false) by default.

---

### Question 5
Why use `const string&` for the student name parameter?

```cpp
void displayReport(const string& studentName, double average, bool passed) {
    cout << "Student: " << studentName << endl;
}
```

A) To make the string constant  
B) To avoid copying and prevent modification  
C) To make the code compile faster  
D) It's required for strings

**Answer: B) To avoid copying and prevent modification**

**Explanation:**
- `&` (reference) — avoids copying the string (efficient)
- `const` — prevents accidental modification (safe)

```cpp
void display(const string& name) {
    cout << name;   // ✓ Can read
    // name = "X";  // ❌ ERROR: Cannot modify const
}
```

Best for **read-only** parameters, especially large data like strings.

---


# Quiz 2

### Question 6
What's the purpose of `static` in `updateStatistics()`?

```cpp
void updateStatistics(bool passed) {
    static int totalStudents = 0;
    static int passedStudents = 0;
    
    totalStudents++;
    if (passed) passedStudents++;
}
```

A) Make variables global  
B) Keep values between function calls  
C) Delete variables after use  
D) Make variables constant

**Answer: B) Keep values between function calls**

**Explanation:**
`static` local variables are initialized **once** and retain their values across multiple calls.

```cpp
updateStatistics(true);   // totalStudents = 1, passedStudents = 1
updateStatistics(false);  // totalStudents = 2, passedStudents = 1
updateStatistics(true);   // totalStudents = 3, passedStudents = 2
```

Without `static`, counters would reset to 0 every call.

---




### Question 7
What happens if you don't store a return value?

```cpp
double calculateAverage(double a, double b, double c) {
    return (a + b + c) / 3.0;
}

int main() {
    calculateAverage(85, 90, 88);  // Return value ignored
    // What now?
}
```

A) Compilation error  
B) The average is lost  
C) Automatically stored in a variable  
D) Printed to console

**Answer: B) The average is lost**

**Explanation:**
If you don't capture the return value, it's calculated but then discarded.

```cpp
// ❌ WRONG - Result is lost
calculateAverage(85, 90, 88);

// ✓ CORRECT - Store the result
double avg = calculateAverage(85, 90, 88);
cout << avg;
```

---

### Question 8
Which function decomposition is better?

```cpp
// Option A: One big function
void processStudent() {
    // Get input
    // Calculate average
    // Determine pass/fail
    // Display report
    // Update statistics
}

// Option B: Multiple focused functions
void getGrades(...) { }
double calculateAverage(...) { }
bool isPassing(...) { }
void displayReport(...) { }
void updateStatistics(...) { }
```

A) Option A (simpler)  
B) Option B (modular)  
C) Both are equal  
D) Neither is good

**Answer: B) Option B (modular)**

**Explanation:**
**Option B** follows the **Single Responsibility Principle** — each function does **one thing** well.

**Benefits:**
- **Easier to test** — test each function independently
- **Easier to debug** — locate problems quickly
- **Reusable** — use `calculateAverage()` in other programs
- **Readable** — clear function names explain what code does

---

### Question 9
What's wrong with this code?

```cpp
void displayReport(const string& name, double avg, bool passed) {
    name = "Anonymous";  // Change name if not passed
    if (!passed) {
        name = "FAILED STUDENT";
    }
    cout << name << ": " << avg << endl;
}
```

A) Nothing wrong  
B) Cannot modify const reference  
C) Missing return statement  
D) Wrong parameter order

**Answer: B) Cannot modify const reference**

**Explanation:**
`const` means **read-only**. You cannot modify a const parameter.

**Fix:**
```cpp
// Option 1: Remove const (if modification is needed)
void displayReport(string& name, double avg, bool passed) {
    if (!passed) name = "FAILED STUDENT";
    cout << name << ": " << avg << endl;
}

// Option 2: Keep const and work with a copy
void displayReport(const string& name, double avg, bool passed) {
    string displayName = name;  // Copy
    if (!passed) displayName = "FAILED STUDENT";
    cout << displayName << ": " << avg << endl;
}
```

---


# Quiz 1

### Question 10
A barangay wants to track clearance statistics. Which design is best?

```cpp
// Option A: Global variables
int totalClearances = 0;
int seniorDiscounts = 0;

void issueClearance(int age) {
    totalClearances++;
    if (age >= 60) seniorDiscounts++;
}

// Option B: Static variables in function
void issueClearance(int age) {
    static int totalClearances = 0;
    static int seniorDiscounts = 0;
    
    totalClearances++;
    if (age >= 60) seniorDiscounts++;
}

// Option C: Regular local variables
void issueClearance(int age) {
    int totalClearances = 0;
    int seniorDiscounts = 0;
    
    totalClearances++;
    if (age >= 60) seniorDiscounts++;
}
```

A) Option A (global variables)  
B) Option B (static local variables)  
C) Option C (regular local variables)  
D) All are equivalent

**Answer: B) Option B (static local variables)**

**Explanation:**
- **Option A:** Works but uses globals — risky, can be modified anywhere
- **Option B:** ✓ Best! Static keeps values between calls, but variables are **encapsulated** in the function
- **Option C:** Wrong! Variables reset to 0 every call — counters won't work

```cpp
// Option B usage:
issueClearance(30);  // totalClearances = 1
issueClearance(65);  // totalClearances = 2, seniorDiscounts = 1
issueClearance(70);  // totalClearances = 3, seniorDiscounts = 2
```

**Why B is best:**
- Data persists (static)
- Encapsulated (not global)
- Safe from external modification

---

**Score yourself:**
- 10/10: Modular Master! 🏆
- 8-9: Excellent design skills!
- 6-7: Good understanding, review parameter passing
- Below 6: Re-read functions and modular programming

**Key Concepts:**
1. Break programs into focused functions
2. Pass by reference to modify originals
3. Pass by value for read-only (or const reference for efficiency)
4. Always capture return values
5. Use static for persistent counters
6. Modular code is testable, reusable, and maintainable
