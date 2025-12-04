# Lesson 6 Activities: Loops

## From 200 Lines to 3 Lines

Remember Tian typing 20 of 200 reminder messages manually? `cout << "Reminder #1" << endl;` copy-paste, copy-paste, copy-paste... Kuya Miguel stopped her: **"What are you doing? Loops are automation. They turn 200 lines into just 3."**

**This lesson is about efficiency.** Why write repetitive code when you can tell the computer to repeat it for you? Loops are the foundation of automation in programming.

**What makes loops powerful:**
- **`for` loops** – Use when you know exact iterations ("do this 10 times")
- **`while` loops** – Use when condition-based ("keep going until password is correct")
- **`do-while` loops** – Use when you need at least one execution ("show menu, then check if user wants to continue")

Every real application uses loops: Instagram scrolling through posts, Netflix playing episodes, Excel calculating formulas across rows. Today, you automate repetition!

---

## Task 1: Barangay Reminder Notices

**Context:**  
Your barangay needs to print 50 numbered reminder notices for residents about garbage collection. Typing each one manually would take forever.

**Your Challenge:**  
Use a `for` loop to automatically generate 50 numbered reminders.

**What You'll Practice:**
- `for` loop syntax: `for (initialization; condition; update)`
- Loop counter variable
- Automatic iteration
- Print formatting in loops

**Key Concepts:**
```cpp
for (int i = 1; i <= 50; i++) {
    // This code runs 50 times
    // i starts at 1, increments by 1 each time
}
```

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== GARBAGE COLLECTION REMINDERS ===" << endl;
    cout << endl;
    
    // Use for loop to generate 50 reminders
    
    return 0;
}
```

**Expected Output:**
```
=== GARBAGE COLLECTION REMINDERS ===

Reminder #1: Please segregate your waste properly.
Reminder #2: Please segregate your waste properly.
Reminder #3: Please segregate your waste properly.
...
Reminder #50: Please segregate your waste properly.
```

---

## Task 2: Jeepney Fare Table Generator

**Context:**  
Create a fare reference table showing jeepney fares for distances 1 km to 20 km. Base fare is PHP 13 (first 4 km), then PHP 2 per additional kilometer.

**Your Challenge:**  
Use a loop to calculate and display fares for all distances automatically.

**What You'll Practice:**
- Loop with calculations
- Conditional logic inside loops
- Formatted output in loops
- Real-world pricing automation

**Fare Formula:**
- Distance ≤ 4 km: PHP 13.00
- Distance > 4 km: PHP 13.00 + ((distance - 4) × 2.00)

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double fare;
    
    cout << "=== JEEPNEY FARE TABLE ===" << endl;
    cout << "Distance (km)     Fare (PHP)" << endl;
    cout << "-------------------------------" << endl;
    
    // Loop from 1 to 20 km
    // Calculate fare for each distance
    // Display formatted output
    
    return 0;
}
```

**Expected Output:**
```
=== JEEPNEY FARE TABLE ===
Distance (km)     Fare (PHP)
-------------------------------
1                 13.00
2                 13.00
3                 13.00
4                 13.00
5                 15.00
6                 17.00
...
20                45.00
```

---

## Task 3: Sum Accumulator Pattern

**Context:**  
The barangay treasurer needs to calculate total monthly dues collected from all 100 residents. Each resident pays PHP 150. Instead of using a calculator, automate it with a loop!

**Your Challenge:**  
Use the **accumulator pattern** – start with 0, add to it in each loop iteration.

**What You'll Practice:**
- Accumulator pattern (sum = sum + value)
- Loop with addition
- Running total calculation
- Final result display

**Accumulator Pattern:**
```cpp
int sum = 0;           // Start at 0
for (int i = 1; i <= 100; i++) {
    sum += 150;        // Add 150 each time
}
// sum now contains total
```

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int totalDues = 0;
    int monthlyDue = 150;
    int numResidents = 100;
    
    cout << "=== MONTHLY DUES CALCULATOR ===" << endl;
    cout << endl;
    
    // Use loop to accumulate total
    
    // Display result
    
    return 0;
}
```

**Expected Output:**
```
=== MONTHLY DUES CALCULATOR ===

Collecting dues from 100 residents...
Resident 1: PHP 150
Resident 2: PHP 150
Resident 3: PHP 150
...
Resident 100: PHP 150

Total dues collected: PHP 15,000
```

---

## Task 4: Password Validator with While Loop

**Context:**  
Your barangay portal needs a secure login system. Users should keep trying until they enter the correct password. You don't know how many attempts they'll need—use a `while` loop!

**Your Challenge:**  
Keep asking for password until user enters "Barangay2025". Count failed attempts.

**What You'll Practice:**
- `while` loop for condition-based repetition
- String comparison in loops
- Attempt counter
- Input validation

**While Loop Logic:**
```cpp
while (condition is true) {
    // Keep doing this
}
// Exit when condition becomes false
```

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string password;
    string correctPassword = "Barangay2025";
    int attempts = 0;
    
    cout << "=== SECURE BARANGAY PORTAL ===" << endl;
    cout << endl;
    
    // Use while loop to keep asking for password
    // Count attempts
    // Show error message on incorrect password
    
    return 0;
}
```

**Expected Output:**
```
=== SECURE BARANGAY PORTAL ===

Enter password: hello
    Incorrect password! Try again.
Attempts: 1

Enter password: 1234
    Incorrect password! Try again.
Attempts: 2

Enter password: Barangay2025
    Access granted!
Total attempts: 3
```

---

## Task 5: Countdown Timer with For Loop

**Context:**  
The barangay assembly meeting starts soon! Create a countdown timer that counts from 10 to 1, then announces the meeting start.

**Your Challenge:**  
Use a `for` loop that counts DOWN (decrements) instead of up.

**What You'll Practice:**
- Decrementing for loop (`i--`)
- Countdown logic
- Reverse iteration
- Real-time simulation

**Countdown Pattern:**
```cpp
for (int i = 10; i >= 1; i--) {
    // Starts at 10, decrements, stops at 1
}
```

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== BARANGAY ASSEMBLY MEETING ===" << endl;
    cout << "Meeting starts in..." << endl;
    cout << endl;
    
    // Countdown from 10 to 1
    
    cout << endl;
    cout << "MEETING STARTS NOW!" << endl;
    
    return 0;
}
```

**Expected Output:**
```
=== BARANGAY ASSEMBLY MEETING ===
Meeting starts in...

10... 9... 8... 7... 6... 5... 4... 3... 2... 1... 

MEETING STARTS NOW!
```

---

## Task 6: Menu System with Do-While Loop

**Context:**  
Barangay service centers need a menu that displays at least once, then keeps running until the user chooses to exit. Perfect for `do-while` loops!

**Your Challenge:**  
Create an interactive menu system using `do-while` that shows options, processes choices, and loops until user exits.

**What You'll Practice:**
- `do-while` loop (executes at least once)
- Menu-driven program
- Choice validation
- Loop control with exit condition

**Do-While Pattern:**
```cpp
do {
    // This ALWAYS runs at least once
    // Show menu, get choice
} while (condition);  // Check if should repeat
```

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    
    // Use do-while for menu system
    
    return 0;
}
```

**Expected Output:**
```
========================================
     BARANGAY SERVICE CENTER
========================================
1. Request Barangay Clearance
2. Pay Monthly Dues
3. File Complaint
4. Exit
========================================
Enter choice (1-4): 1

Clearance request form opened.
Please proceed to Window 3.

========================================
     BARANGAY SERVICE CENTER
========================================
1. Request Barangay Clearance
2. Pay Monthly Dues
3. File Complaint
4. Exit
========================================
Enter choice (1-4): 4

Thank you for using Barangay services!
```

---

## Task 7: Multiplication Table Generator

**Context:**  
Elementary students need multiplication practice. Generate a complete multiplication table for any number using loops.

**Your Challenge:**  
Ask user for a number, then display its multiplication table from 1 to 10.

**What You'll Practice:**
- User input with loops
- Arithmetic in loops
- Formatted table display
- Educational tool creation

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int number;
    
    cout << "=== MULTIPLICATION TABLE GENERATOR ===" << endl;
    cout << "Enter a number: ";
    cin >> number;
    cout << endl;
    
    // Generate multiplication table
    
    return 0;
}
```

**Expected Output:**
```
=== MULTIPLICATION TABLE GENERATOR ===
Enter a number: 7

Multiplication Table for 7:
7 × 1 = 7
7 × 2 = 14
7 × 3 = 21
7 × 4 = 28
7 × 5 = 35
7 × 6 = 42
7 × 7 = 49
7 × 8 = 56
7 × 9 = 63
7 × 10 = 70
```

---

## Reflection Questions

After completing these tasks, think deeply about loop mechanics:

1. **The 200 Lines Problem**: Imagine you needed to print 1000 reminders without loops. How long would that take? Now with loops? What's the productivity gain?

2. **For vs While Choice**: Task 1 used `for`, Task 4 used `while`. When do you know EXACT iterations (for) vs CONDITIONAL iterations (while)?

3. **The Accumulator Pattern**: In Task 3, why start `sum = 0`? What happens if you start at 1? Trace the loop manually for 3 residents.

4. **Do-While Guarantee**: Why does menu systems use `do-while` instead of `while`? What's the difference? Test: what if user wants to exit immediately?

5. **Loop Counter Purpose**: In Task 1, `i` counts reminders. In Task 2, `i` represents distance. Same loop syntax, different meanings. How does context change loop variable purpose?

6. **Infinite Loop Danger**: What happens if you write `while (true)` with no break? How do you recognize infinite loops? Have you created one accidentally?

7. **Countdown Logic**: Task 5 uses `i--` instead of `i++`. Draw the loop: what's `i` on each iteration? Why `i >= 1` not `i > 0`?

8. **Real-World Loop Scale**: Tian's 200 reminders became 3 lines. Think of Facebook loading 500 posts—that's ONE loop. Instagram stories? Loop. Excel formulas? Loops. How many loops run when you open your phone?

---

## What You've Learned

You've unlocked **automation**—the heart of programming efficiency. Loops eliminate repetitive code and handle tasks at massive scale.

**Core Skills Unlocked:**
- **`for` loops** – Exact iterations with counter
- **`while` loops** – Condition-based repetition
- **`do-while` loops** – Guaranteed first execution
- **Accumulator pattern** – Building totals in loops
- **Loop counters** – Tracking progress
- **Decrementing loops** – Counting backwards

**Real-World Applications:**
- **Social Media**: Scrolling feeds (loop through posts)
- **E-commerce**: Processing cart items (loop through products)
- **Banking**: Monthly interest calculation (loop through accounts)
- **Gaming**: Enemy spawning, frame rendering (loops every frame)
- **Data Processing**: Excel formulas across 10,000 rows (loops)

**The Transformation:**
```cpp
// Before (Lesson 1-5): Manual repetition
cout << "Reminder #1" << endl;
cout << "Reminder #2" << endl;
cout << "Reminder #3" << endl;
// ... 197 more lines ...
cout << "Reminder #200" << endl;

// After (Lesson 6): Automated with loop
for (int i = 1; i <= 200; i++) {
    cout << "Reminder #" << i << endl;
}
// 200 lines → 3 lines. Same result. 99% less code.
```

As Kuya Miguel said: **"Loops turn 200 lines into just 3. That's the power of automation."** You've transformed from manual coder to automation engineer.

Next lesson: **Nested Control**—putting loops inside loops, creating multi-dimensional logic for complex real-world problems!

---

<details>
<summary><strong>📝 Answer Key for All Tasks</strong></summary>

### Task 1: Barangay Reminder Notices

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== GARBAGE COLLECTION REMINDERS ===" << endl;
    cout << endl;
    
    for (int i = 1; i <= 50; i++) {
        cout << "Reminder #" << i << ": Please segregate your waste properly." << endl;
    }
    
    return 0;
}
```

**Key Points:**
- `for (int i = 1; i <= 50; i++)` creates loop counter from 1 to 50
- `i++` increments counter after each iteration
- Loop body runs 50 times automatically
- This replaces 50 lines of manual `cout` statements!

---

### Task 2: Jeepney Fare Table Generator

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double fare;
    
    cout << "=== JEEPNEY FARE TABLE ===" << endl;
    cout << "Distance (km)     Fare (PHP)" << endl;
    cout << "-------------------------------" << endl;
    
    for (int distance = 1; distance <= 20; distance++) {
        // Calculate fare based on distance
        if (distance <= 4) {
            fare = 13.00;
        } else {
            fare = 13.00 + ((distance - 4) * 2.00);
        }
        
        // Display formatted output
        cout << fixed << setprecision(2);
        cout << left << setw(18) << distance;
        cout << fare << endl;
    }
    
    return 0;
}
```

**Key Points:**
- Loop variable `distance` represents kilometers (1 to 20)
- `if/else` inside loop calculates different fares
- Combines loops (Lesson 6) with conditions (Lesson 5)
- Automated pricing table generation

---

### Task 3: Sum Accumulator Pattern

```cpp
#include <iostream>
using namespace std;

int main() {
    int totalDues = 0;  // Accumulator starts at 0
    int monthlyDue = 150;
    int numResidents = 100;
    
    cout << "=== MONTHLY DUES CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Collecting dues from " << numResidents << " residents..." << endl;
    
    for (int i = 1; i <= numResidents; i++) {
        cout << "Resident " << i << ": PHP " << monthlyDue << endl;
        totalDues += monthlyDue;  // Add to accumulator
    }
    
    cout << endl;
    cout << "Total dues collected: PHP " << totalDues << endl;
    
    return 0;
}
```

**Key Points:**
- **Accumulator pattern**: Start at 0, add in each iteration
- `totalDues += monthlyDue` is same as `totalDues = totalDues + monthlyDue`
- After loop, `totalDues` contains sum of all iterations
- Classic pattern for calculating totals, averages, counts

---

### Task 4: Password Validator with While Loop

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string password;
    string correctPassword = "Barangay2025";
    int attempts = 0;
    
    cout << "=== SECURE BARANGAY PORTAL ===" << endl;
    cout << endl;
    
    while (password != correctPassword) {
        cout << "Enter password: ";
        cin >> password;
        attempts++;
        
        if (password != correctPassword) {
            cout << "❌ Incorrect password! Try again." << endl;
            cout << "Attempts: " << attempts << endl;
            cout << endl;
        }
    }
    
    cout << "✅ Access granted!" << endl;
    cout << "Total attempts: " << attempts << endl;
    
    return 0;
}
```

**Key Points:**
- `while (password != correctPassword)` keeps looping until correct
- Don't know how many attempts needed—condition-based
- `attempts++` counts failed tries
- Loop exits when condition becomes false (correct password entered)

---

### Task 5: Countdown Timer with For Loop

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== BARANGAY ASSEMBLY MEETING ===" << endl;
    cout << "Meeting starts in..." << endl;
    cout << endl;
    
    for (int i = 10; i >= 1; i--) {
        cout << i << "... ";
    }
    
    cout << endl;
    cout << endl;
    cout << "🔔 MEETING STARTS NOW!" << endl;
    
    return 0;
}
```

**Key Points:**
- `i--` decrements counter (10, 9, 8... down to 1)
- `i >= 1` ensures loop runs until i reaches 1 (inclusive)
- Countdown pattern: start high, decrement, stop at target
- Same loop structure as incrementing, just reversed

---

### Task 6: Menu System with Do-While Loop

```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    
    do {
        cout << "========================================" << endl;
        cout << "     BARANGAY SERVICE CENTER" << endl;
        cout << "========================================" << endl;
        cout << "1. Request Barangay Clearance" << endl;
        cout << "2. Pay Monthly Dues" << endl;
        cout << "3. File Complaint" << endl;
        cout << "4. Exit" << endl;
        cout << "========================================" << endl;
        cout << "Enter choice (1-4): ";
        cin >> choice;
        cout << endl;
        
        if (choice == 1) {
            cout << "✅ Clearance request form opened." << endl;
            cout << "Please proceed to Window 3." << endl;
        } else if (choice == 2) {
            cout << "✅ Payment portal opened." << endl;
            cout << "Please pay at Cashier Window." << endl;
        } else if (choice == 3) {
            cout << "✅ Complaint form opened." << endl;
            cout << "Please write your concern." << endl;
        } else if (choice == 4) {
            cout << "Thank you for using Barangay services!" << endl;
        } else {
            cout << "❌ Invalid choice. Please select 1-4." << endl;
        }
        
        cout << endl;
        
    } while (choice != 4);
    
    return 0;
}
```

**Key Points:**
- `do { } while (condition);` executes body FIRST, checks condition AFTER
- Menu always displays at least once
- Loop continues while `choice != 4` (user hasn't chosen exit)
- Perfect for interactive menus that need to show before checking

---

### Task 7: Multiplication Table Generator

```cpp
#include <iostream>
using namespace std;

int main() {
    int number;
    
    cout << "=== MULTIPLICATION TABLE GENERATOR ===" << endl;
    cout << "Enter a number: ";
    cin >> number;
    cout << endl;
    
    cout << "Multiplication Table for " << number << ":" << endl;
    
    for (int i = 1; i <= 10; i++) {
        cout << number << " × " << i << " = " << (number * i) << endl;
    }
    
    return 0;
}
```

**Key Points:**
- User input determines what to multiply
- Loop multiplies number by 1, 2, 3... up to 10
- `(number * i)` calculates result for each row
- Dynamic table generation based on input

---

</details>

---

**Next Steps:**  
Test countdown timer—does it stop at 1 or 0? Try menu system—can you exit immediately? Break the password validator—what if you type correct password first try? Understanding edge cases makes you a better programmer. Get ready for Lesson 7—**nested loops** for multi-dimensional problems!
