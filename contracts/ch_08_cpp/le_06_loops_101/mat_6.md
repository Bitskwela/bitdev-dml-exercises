# Lesson 6: Loops 101 - Repeating with For, While, and Do-While

## Background Story

Tian was helping at the barangay hall one afternoon when Kuya Miguel called him over. "Tian, I need to print 100 ID cards for the new residents. Imagine if I had to write the code to print each one individually!"

Tian laughed. "That would take forever! Isn't there a way to repeat the process?"

Kuya Miguel grinned. "Exactly! That's where **loops** come in. Instead of writing the same code 100 times, we write it once and tell the computer to repeat it. Let me show you the three main types of loops in C++."

## What Are Loops?

**Loops** allow you to execute a block of code repeatedly without writing it multiple times.

### Why Use Loops?

**Without loops:**
```cpp
cout << "Resident ID: 1" << endl;
cout << "Resident ID: 2" << endl;
cout << "Resident ID: 3" << endl;
// ... 97 more lines!
```

**With loops:**
```cpp
for (int i = 1; i <= 100; i++) {
    cout << "Resident ID: " << i << endl;
}
```

Much cleaner and more maintainable!

---

## The Three Types of Loops

### 1. For Loop - "Do This Exactly N Times"

**Syntax:**
```cpp
for (initialization; condition; update) {
    // code to repeat
}
```

**Example: Print numbers 1 to 10**
```cpp
#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 10; i++) {
        cout << i << " ";
    }
    cout << endl;
    return 0;
}
```

**Output:**
```
1 2 3 4 5 6 7 8 9 10
```

**How it works:**
1. **Initialization:** `int i = 1` - Start at 1
2. **Condition:** `i <= 10` - Continue while i is 10 or less
3. **Update:** `i++` - Increment i by 1 after each iteration
4. **Body:** `cout << i << " ";` - Execute this each time

**Barangay Example: Calculate Total Monthly Fees**
```cpp
#include <iostream>
using namespace std;

int main() {
    int totalFees = 0;
    int numResidents = 5;
    int monthlyFee = 150;
    
    for (int i = 1; i <= numResidents; i++) {
        totalFees += monthlyFee;
        cout << "Resident " << i << " paid: PHP " << monthlyFee << endl;
    }
    
    cout << "Total collected: PHP " << totalFees << endl;
    return 0;
}
```

**Output:**
```
Resident 1 paid: PHP 150
Resident 2 paid: PHP 150
Resident 3 paid: PHP 150
Resident 4 paid: PHP 150
Resident 5 paid: PHP 150
Total collected: PHP 750
```

---

### 2. While Loop - "Do This While Condition is True"

**Syntax:**
```cpp
while (condition) {
    // code to repeat
}
```

**Use when:** You don't know in advance how many times to loop

**Example: Password Entry System**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string password;
    string correctPassword = "barangay2025";
    
    cout << "=== Barangay System Login ===" << endl;
    
    while (password != correctPassword) {
        cout << "Enter password: ";
        cin >> password;
        
        if (password != correctPassword) {
            cout << "Incorrect! Try again." << endl;
        }
    }
    
    cout << "Access granted! Welcome." << endl;
    return 0;
}
```

**How it works:**
1. Check condition `password != correctPassword`
2. If true, execute the body
3. Repeat until condition becomes false

**Barangay Example: Queue Management**
```cpp
#include <iostream>
using namespace std;

int main() {
    int queueNumber = 1;
    int totalInQueue = 5;
    
    cout << "=== Barangay Clearance Queue ===" << endl;
    
    while (queueNumber <= totalInQueue) {
        cout << "Now serving: Queue #" << queueNumber << endl;
        cout << "Processing..." << endl;
        queueNumber++;
    }
    
    cout << "All residents served!" << endl;
    return 0;
}
```

**Output:**
```
=== Barangay Clearance Queue ===
Now serving: Queue #1
Processing...
Now serving: Queue #2
Processing...
Now serving: Queue #3
Processing...
Now serving: Queue #4
Processing...
Now serving: Queue #5
Processing...
All residents served!
```

---

### 3. Do-While Loop - "Do This First, Then Check Condition"

**Syntax:**
```cpp
do {
    // code to repeat
} while (condition);
```

**Key difference:** The body executes **at least once**, even if condition is false

**Example: Menu System**
```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    
    do {
        cout << "\n=== Barangay Service Menu ===" << endl;
        cout << "1. Request Clearance" << endl;
        cout << "2. Request Permit" << endl;
        cout << "3. Pay Monthly Dues" << endl;
        cout << "4. Exit" << endl;
        cout << "Enter choice: ";
        cin >> choice;
        
        if (choice == 1) {
            cout << "Clearance form opened." << endl;
        } else if (choice == 2) {
            cout << "Permit form opened." << endl;
        } else if (choice == 3) {
            cout << "Payment portal opened." << endl;
        } else if (choice == 4) {
            cout << "Thank you for using our system!" << endl;
        } else {
            cout << "Invalid choice. Try again." << endl;
        }
        
    } while (choice != 4);
    
    return 0;
}
```

**Why use do-while here?**
- Menu must display at least once
- User sees options before making a decision
- Perfect for menu-driven programs

---

## Comparing the Three Loops

| Loop Type | When to Use | Condition Check |
|-----------|-------------|-----------------|
| **for** | Known number of iterations | Beginning |
| **while** | Unknown iterations, check first | Beginning |
| **do-while** | Unknown iterations, execute first | End |

**Visual Flow:**

**For Loop:**
```
Initialize → Check Condition → Execute Body → Update → Repeat
```

**While Loop:**
```
Check Condition → Execute Body → Check Condition → Repeat
```

**Do-While Loop:**
```
Execute Body → Check Condition → Repeat
```

---

## Loop Control Statements

### 1. `break` - Exit the Loop Immediately

```cpp
#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 10; i++) {
        if (i == 5) {
            cout << "Breaking at i = 5" << endl;
            break;  // Exit the loop
        }
        cout << i << " ";
    }
    cout << "\nLoop ended." << endl;
    return 0;
}
```

**Output:**
```
1 2 3 4 Breaking at i = 5
Loop ended.
```

**Barangay Use Case: Search for Resident**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string residents[] = {"Juan", "Maria", "Pedro", "Ana", "Luis"};
    string target = "Pedro";
    bool found = false;
    
    for (int i = 0; i < 5; i++) {
        if (residents[i] == target) {
            cout << "Found " << target << " at position " << i << endl;
            found = true;
            break;  // No need to continue searching
        }
    }
    
    if (!found) {
        cout << target << " not found in records." << endl;
    }
    
    return 0;
}
```

---

### 2. `continue` - Skip to Next Iteration

```cpp
#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 10; i++) {
        if (i % 2 == 0) {
            continue;  // Skip even numbers
        }
        cout << i << " ";
    }
    cout << endl;
    return 0;
}
```

**Output:**
```
1 3 5 7 9
```

**Barangay Use Case: Process Only Paid Residents**
```cpp
#include <iostream>
using namespace std;

int main() {
    bool paid[] = {true, false, true, true, false};
    
    cout << "Processing residents who paid dues:" << endl;
    
    for (int i = 0; i < 5; i++) {
        if (!paid[i]) {
            continue;  // Skip unpaid residents
        }
        cout << "Resident " << (i + 1) << " - Status: PAID ✓" << endl;
    }
    
    return 0;
}
```

**Output:**
```
Processing residents who paid dues:
Resident 1 - Status: PAID ✓
Resident 3 - Status: PAID ✓
Resident 4 - Status: PAID ✓
```

---

## Common Loop Patterns

### Pattern 1: Countdown Timer

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Barangay meeting starts in:" << endl;
    
    for (int i = 10; i >= 1; i--) {
        cout << i << "... ";
    }
    
    cout << "\nMeeting has started!" << endl;
    return 0;
}
```

### Pattern 2: Accumulator Pattern

```cpp
#include <iostream>
using namespace std;

int main() {
    int sum = 0;
    
    for (int i = 1; i <= 10; i++) {
        sum += i;
    }
    
    cout << "Sum of 1 to 10: " << sum << endl;
    return 0;
}
```

### Pattern 3: Input Validation Loop

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    
    do {
        cout << "Enter your age (1-120): ";
        cin >> age;
        
        if (age < 1 || age > 120) {
            cout << "Invalid age. Try again." << endl;
        }
    } while (age < 1 || age > 120);
    
    cout << "Age recorded: " << age << endl;
    return 0;
}
```

---

## Practical Barangay Exercise: Attendance Counter

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    int totalResidents = 5;
    int presentCount = 0;
    string response;
    
    cout << "=== Barangay Assembly Attendance ===" << endl;
    
    for (int i = 1; i <= totalResidents; i++) {
        cout << "Is Resident " << i << " present? (yes/no): ";
        cin >> response;
        
        if (response == "yes") {
            presentCount++;
        }
    }
    
    cout << "\n=== Attendance Summary ===" << endl;
    cout << "Total Residents: " << totalResidents << endl;
    cout << "Present: " << presentCount << endl;
    cout << "Absent: " << (totalResidents - presentCount) << endl;
    
    double percentage = (presentCount * 100.0) / totalResidents;
    cout << "Attendance Rate: " << percentage << "%" << endl;
    
    return 0;
}
```

**Sample Run:**
```
=== Barangay Assembly Attendance ===
Is Resident 1 present? (yes/no): yes
Is Resident 2 present? (yes/no): no
Is Resident 3 present? (yes/no): yes
Is Resident 4 present? (yes/no): yes
Is Resident 5 present? (yes/no): no

=== Attendance Summary ===
Total Residents: 5
Present: 3
Absent: 2
Attendance Rate: 60%
```

---

## Common Loop Mistakes to Avoid

### Mistake 1: Infinite Loop (Forgot to Update)

```cpp
// ❌ WRONG - Never ends!
int i = 1;
while (i <= 10) {
    cout << i << " ";
    // Missing: i++
}
```

**Fix:**
```cpp
// ✅ CORRECT
int i = 1;
while (i <= 10) {
    cout << i << " ";
    i++;  // Update the counter
}
```

### Mistake 2: Off-by-One Error

```cpp
// ❌ WRONG - Only prints 1 to 9
for (int i = 1; i < 10; i++) {
    cout << i << " ";
}
```

**Fix:**
```cpp
// ✅ CORRECT - Prints 1 to 10
for (int i = 1; i <= 10; i++) {
    cout << i << " ";
}
```

### Mistake 3: Wrong Semicolon Placement

```cpp
// ❌ WRONG - Empty loop body
for (int i = 1; i <= 10; i++);  // <- Extra semicolon!
{
    cout << i << " ";  // This only runs once after loop
}
```

**Fix:**
```cpp
// ✅ CORRECT - No semicolon after for statement
for (int i = 1; i <= 10; i++) {
    cout << i << " ";
}
```

---

## Key Takeaways

1. **For loops** - Best when you know how many times to repeat
2. **While loops** - Best when condition determines repetition
3. **Do-while loops** - Best when body must execute at least once
4. **break** - Exit loop immediately
5. **continue** - Skip to next iteration
6. Always update your loop counter to avoid infinite loops
7. Use meaningful variable names (`i` is okay for simple counters, but `residentCount` is better for clarity)

---

## What's Next?

Now that you understand basic loops, in the next lesson you'll learn about **nested control structures** - putting loops inside loops and conditions inside loops. This is where things get really powerful!

**Kuya Miguel:** "Great job, Tian! You can now make your programs repeat actions efficiently. Next, we'll combine loops with if statements to create even more complex logic. Handa ka na ba?"

**Reading time:** ~10 minutes
