## Background Story

Tian looked at the old grade calculator from lesson 4. It was a 150-line mess—input handling, calculations, validation, and display all tangled together in one giant block.

"I need to add a feature to track highest and lowest grades," Tian said, scrolling through the code. "But I'm scared to modify this. Everything is connected. If I change one line, three other things might break. How do professional developers maintain large systems?"

Kuya Miguel pulled up a chair. "They use **modular design**. Look at your phone—the screen, battery, camera, and processor are separate modules. If the screen breaks, you replace just the screen, not the entire phone. Code should work the same way."

"Right now, your calculator is like a jeepney welded together in one piece," Kuya Miguel continued. "Want to upgrade the engine? Good luck, it's fused to the chassis. Professional code is modular—small, independent functions that each do one thing well. Need to change how grades are calculated? Modify just the `calculateAverage()` function. Need better input validation? Update just `getGrades()`. The rest stays untouched."

"Today, we're not learning new syntax," Kuya Miguel said. "We're learning software architecture—how to organize code like a professional. Let's rebuild your calculator the right way!"

---

## Theory & Lecture Content

## The Challenge

Build a **Modular Grade Calculator** that:
1. Accepts multiple subject grades
2. Calculates average
3. Determines pass/fail status
4. Displays final report
5. Tracks total students processed (using `static`)

**Key Requirements:**
- Use **functions** for each task
- Pass data using **parameters**
- Use **return values** for results
- Apply **const references** where appropriate
- Track statistics using **static** variables

---

## Breaking It Down

### Step 1: Input Function

Get grades from the user:

```cpp
void getGrades(double& math, double& science, double& english) {
    cout << "Enter Math grade: ";
    cin >> math;
    
    cout << "Enter Science grade: ";
    cin >> science;
    
    cout << "Enter English grade: ";
    cin >> english;
}
```

**Why pass by reference?**  
We need to **modify** the original variables, so the changes persist in `main()`.

---

### Step 2: Calculate Average Function

```cpp
double calculateAverage(double math, double science, double english) {
    return (math + science + english) / 3.0;
}
```

**Why pass by value?**  
We only need to **read** the grades, not modify them. Pass by value is simpler here.

---

### Step 3: Determine Pass/Fail

```cpp
bool isPassing(double average) {
    const double PASSING_GRADE = 75.0;  // Local constant
    return average >= PASSING_GRADE;
}
```

**Returns:** `true` if passing, `false` otherwise.

---

### Step 4: Display Results

```cpp
void displayReport(const string& studentName, double average, bool passed) {
    cout << "\n========== GRADE REPORT ==========\n";
    cout << "Student: " << studentName << endl;
    cout << "Average: " << average << endl;
    cout << "Status: " << (passed ? "PASSED" : "FAILED") << endl;
    cout << "===================================\n\n";
}
```

**Why `const string&`?**  
- `const` — we don't modify the name
- `&` — avoids copying (efficient for strings)

---

### Step 5: Track Statistics (Static)

```cpp
void updateStatistics(bool passed) {
    static int totalStudents = 0;
    static int passedStudents = 0;
    
    totalStudents++;
    if (passed) {
        passedStudents++;
    }
    
    cout << "[Stats] Total processed: " << totalStudents;
    cout << " | Passed: " << passedStudents;
    cout << " | Failed: " << (totalStudents - passedStudents) << endl;
}
```

**Static variables** keep counts across multiple function calls.

---

## Complete Program

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

// Constants
const double PASSING_GRADE = 75.0;

// Function prototypes
void getGrades(double& math, double& science, double& english);
double calculateAverage(double math, double science, double english);
bool isPassing(double average);
void displayReport(const string& studentName, double average, bool passed);
void updateStatistics(bool passed);
void displayFinalStatistics();

int main() {
    cout << "===== MODULAR GRADE CALCULATOR =====\n\n";
    
    char continueInput = 'y';
    
    while (continueInput == 'y' || continueInput == 'Y') {
        string studentName;
        double math, science, english;
        
        cout << "Enter student name: ";
        cin.ignore();  // Clear buffer
        getline(cin, studentName);
        
        // Step 1: Get grades
        getGrades(math, science, english);
        
        // Step 2: Calculate average
        double average = calculateAverage(math, science, english);
        
        // Step 3: Determine pass/fail
        bool passed = isPassing(average);
        
        // Step 4: Display report
        displayReport(studentName, average, passed);
        
        // Step 5: Update statistics
        updateStatistics(passed);
        
        cout << "\nProcess another student? (y/n): ";
        cin >> continueInput;
        cout << endl;
    }
    
    // Final summary
    displayFinalStatistics();
    
    cout << "Program ended. Thank you!\n";
    return 0;
}

// Function definitions

void getGrades(double& math, double& science, double& english) {
    cout << "\n--- Enter Grades ---\n";
    
    cout << "Math: ";
    cin >> math;
    
    cout << "Science: ";
    cin >> science;
    
    cout << "English: ";
    cin >> english;
}

double calculateAverage(double math, double science, double english) {
    return (math + science + english) / 3.0;
}

bool isPassing(double average) {
    return average >= PASSING_GRADE;
}

void displayReport(const string& studentName, double average, bool passed) {
    cout << fixed << setprecision(2);  // Format to 2 decimal places
    
    cout << "\n========== GRADE REPORT ==========\n";
    cout << "Student: " << studentName << endl;
    cout << "Average: " << average << endl;
    cout << "Status: " << (passed ? "PASSED ✓" : "FAILED ✗") << endl;
    cout << "===================================\n";
}

void updateStatistics(bool passed) {
    static int totalStudents = 0;
    static int passedStudents = 0;
    
    totalStudents++;
    if (passed) {
        passedStudents++;
    }
    
    cout << "\n[Statistics]\n";
    cout << "Total students processed: " << totalStudents << endl;
    cout << "Passed: " << passedStudents << endl;
    cout << "Failed: " << (totalStudents - passedStudents) << endl;
}

void displayFinalStatistics() {
    static int totalStudents = 0;
    static int passedStudents = 0;
    
    cout << "\n========== FINAL STATISTICS ==========\n";
    cout << "Total students: " << totalStudents << endl;
    
    if (totalStudents > 0) {
        double passRate = (passedStudents * 100.0) / totalStudents;
        cout << "Pass rate: " << fixed << setprecision(1) << passRate << "%\n";
    } else {
        cout << "No students processed.\n";
    }
    
    cout << "======================================\n\n";
}
```

---

## Sample Run

```
===== MODULAR GRADE CALCULATOR =====

Enter student name: Juan Dela Cruz

--- Enter Grades ---
Math: 85
Science: 90
English: 88

========== GRADE REPORT ==========
Student: Juan Dela Cruz
Average: 87.67
Status: PASSED ✓
===================================

[Statistics]
Total students processed: 1
Passed: 1
Failed: 0

Process another student? (y/n): y

Enter student name: Maria Santos

--- Enter Grades ---
Math: 70
Science: 68
English: 72

========== GRADE REPORT ==========
Student: Maria Santos
Average: 70.00
Status: FAILED ✗
===================================

[Statistics]
Total students processed: 2
Passed: 1
Failed: 1

Process another student? (y/n): n

========== FINAL STATISTICS ==========
Total students: 2
Pass rate: 50.0%
======================================

Program ended. Thank you!
```

---

## Key Concepts Applied

### 1. **Function Decomposition**
Each function has a single, clear purpose:
- `getGrades()` — input
- `calculateAverage()` — calculation
- `isPassing()` — decision
- `displayReport()` — output
- `updateStatistics()` — tracking

### 2. **Parameter Passing Strategies**

| Function | Parameters | Reason |
|----------|------------|--------|
| `getGrades(double&, double&, double&)` | Pass by reference | Need to modify originals |
| `calculateAverage(double, double, double)` | Pass by value | Only reading values |
| `isPassing(double)` | Pass by value | Small, simple data |
| `displayReport(const string&, ...)` | Const reference | Efficient, read-only |

### 3. **Static Variables**
`totalStudents` and `passedStudents` persist across function calls, tracking cumulative data.

### 4. **Constants**
`PASSING_GRADE` is a global constant — safe to use globally because it can't be modified.

---

## Enhancements You Can Add

### 1. **Input Validation**
```cpp
void getGrades(double& math, double& science, double& english) {
    do {
        cout << "Math (0-100): ";
        cin >> math;
    } while (math < 0 || math > 100);
    
    do {
        cout << "Science (0-100): ";
        cin >> science;
    } while (science < 0 || science > 100);
    
    do {
        cout << "English (0-100): ";
        cin >> english;
    } while (english < 0 || english > 100);
}
```

### 2. **Letter Grade Function**
```cpp
char getLetterGrade(double average) {
    if (average >= 90) return 'A';
    if (average >= 80) return 'B';
    if (average >= 75) return 'C';
    if (average >= 70) return 'D';
    return 'F';
}
```

**Usage:**
```cpp
char letterGrade = getLetterGrade(average);
cout << "Letter Grade: " << letterGrade << endl;
```

### 3. **More Subjects**
```cpp
void getGrades(double grades[], int numSubjects) {
    string subjects[] = {"Math", "Science", "English", "Filipino", "History"};
    
    for (int i = 0; i < numSubjects; i++) {
        cout << subjects[i] << ": ";
        cin >> grades[i];
    }
}

double calculateAverage(double grades[], int numSubjects) {
    double sum = 0;
    for (int i = 0; i < numSubjects; i++) {
        sum += grades[i];
    }
    return sum / numSubjects;
}
```

### 4. **Highest and Lowest**
```cpp
void findExtremes(double math, double science, double english, 
                  double& highest, double& lowest) {
    highest = math;
    if (science > highest) highest = science;
    if (english > highest) highest = english;
    
    lowest = math;
    if (science < lowest) lowest = science;
    if (english < lowest) lowest = english;
}
```

### 5. **Save to File (Preview)**
```cpp
#include <fstream>

void saveToFile(const string& studentName, double average, bool passed) {
    ofstream file("grades.txt", ios::app);  // Append mode
    file << studentName << "," << average << "," 
         << (passed ? "PASSED" : "FAILED") << endl;
    file.close();
}
```

---

## Common Mistakes to Avoid

### Mistake 1: Forgetting to Pass by Reference
```cpp
// ❌ WRONG
void getGrades(double math, double science, double english) {
    cin >> math >> science >> english;
    // Values changed here won't affect main()
}

// ✓ CORRECT
void getGrades(double& math, double& science, double& english) {
    cin >> math >> science >> english;
}
```

### Mistake 2: Not Using Return Values
```cpp
// ❌ WRONG (return value ignored)
calculateAverage(85, 90, 88);
cout << average;  // average is undefined!

// ✓ CORRECT
double average = calculateAverage(85, 90, 88);
cout << average;
```

### Mistake 3: Modifying Const Parameters
```cpp
void displayReport(const string& name, double avg, bool passed) {
    // name = "Test";  // ❌ ERROR: Can't modify const
    cout << name;      // ✓ OK: Can read
}
```

### Mistake 4: Static Variable Confusion
```cpp
void count() {
    static int counter = 0;
    counter++;
    cout << counter;
}

// Each call increments the SAME counter
count();  // 1
count();  // 2
count();  // 3
```

---

## Testing Your Program

Test these scenarios:
1. **All passing grades** (85, 90, 88)
2. **All failing grades** (60, 65, 70)
3. **Mixed grades** (80, 70, 75)
4. **Edge case: exactly 75** (75, 75, 75)
5. **Multiple students** to verify statistics

---

## Debugging Tips

### Use Print Statements
```cpp
void getGrades(double& math, double& science, double& english) {
    cin >> math >> science >> english;
    cout << "[DEBUG] Got grades: " << math << ", " << science << ", " << english << endl;
}
```

### Check Return Values
```cpp
double avg = calculateAverage(85, 90, 88);
cout << "[DEBUG] Average calculated: " << avg << endl;
```

### Verify Static Variables
```cpp
void updateStatistics(bool passed) {
    static int total = 0;
    total++;
    cout << "[DEBUG] Total now: " << total << endl;
}
```

---

## Architecture Diagram

```
main()
  |
  |-- getGrades() -----------------> Modifies math, science, english
  |
  |-- calculateAverage() -----------> Returns average
  |
  |-- isPassing() -------------------> Returns true/false
  |
  |-- displayReport() ---------------> Displays formatted output
  |
  |-- updateStatistics() ------------> Updates static counters
  |
  |-- displayFinalStatistics() -----> Shows summary
```

---

## Summary

Tian saved the program. "This is so much cleaner than my first grade calculator!"

Kuya Miguel smiled. "That's the power of **modular programming**. Each function is:
- **Focused** — does one thing well
- **Reusable** — can be used multiple times
- **Testable** — easy to debug
- **Readable** — clear purpose"

"Next," Kuya Miguel said, pulling out another stack of papers, "we'll enter the **Warrior's Arsenal** — arrays, strings, and pointers. Get ready for Chapter 4!"

---

**Key Takeaways:**
1. Break programs into focused functions
2. Choose correct parameter passing (value vs reference vs const reference)
3. Use return values for results
4. Apply static variables for persistent data
5. Keep functions small and single-purpose

---

## Closing Story

Tian ran his modular grade calculator for the fifth time, processing student after student. The statistics tracked automatically, each function doing its one job perfectly.

"This is so much better than my first version!" Tian said, comparing the old monolithic code to his new modular design. "Each function is small, focused, easy to understand. And if I need to change how I calculate the average, I just update one function!"

Kuya Miguel nodded with pride. "That's modular programming. Your code is now maintainable, testable, and reusable. Each function is a building block you can combine in different ways."

Tian looked at the clean architecture. Input, calculation, decision, output, statistics. Five clear responsibilities. "And the static variables tracking total students worked perfectly. They persisted across all the calls."

"Exactly. You've mastered functions, parameters, scope, and modularity. Now we enter the Warrior's Arsenal. Arrays will let you manage collections of data, strings will handle text efficiently, and pointers... well, pointers will give you true power over memory."

Tian saved his grade calculator with satisfaction. Chapter 3 complete. Time to arm up.

**Next Chapter:** The Warrior's Arsenal — Arrays, Strings, and Pointers!
