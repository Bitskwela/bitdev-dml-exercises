## Background Story

Tian's refactored ATM code had a mysterious bug. Sometimes the `balance` variable showed the correct amount, sometimes it was zero, and sometimes it caused errors. Tian had declared `balance` in multiple places and lost track of which one was being used.

"Kuya, my program is possessed!" Tian joked, but the frustration was real. "Variables appear and disappear randomly. I declare `int counter` in one function, try to use it in another, and get errors. But sometimes variables with the same name don't conflict. I'm completely confused!"

Kuya Miguel sat down seriously. "This is **scope**—one of the most important concepts in programming, and one that causes countless bugs when misunderstood. You're not alone; even experienced developers mess this up."

"Think of scope like privacy zones," Kuya Miguel explained. "What happens in the barangay hall stays in the barangay hall. What happens in your bedroom is private. But some information, like your name, is public everywhere. Variables work the same way—some are local to a function, some are global, some live only inside a loop. If you don't understand scope, you'll waste hours debugging ghost variables and mysterious errors. Let's master this once and for all!"

---

## Theory & Lecture Content

## Understanding Scope

**Scope** determines where in your code a variable can be accessed. Think of it like provinces:

```cpp
void barangayOffice() {
    int clearanceFee = 50;  // Only exists here
    cout << clearanceFee;    // ✓ OK
}

void treasurerOffice() {
    cout << clearanceFee;    // ❌ ERROR: clearanceFee doesn't exist here
}
```

Variables in `barangayOffice()` can't be seen from `treasurerOffice()`. They're in different **scopes**.

---

## Local Scope

Variables declared **inside a function or block** have **local scope**:

```cpp
void processClearance() {
    int applicantAge = 25;      // Local variable
    string purpose = "Work";    // Local variable
    
    if (applicantAge >= 18) {
        int processingTime = 30;  // Local to this if-block
        cout << "Processing for " << processingTime << " minutes\n";
    }
    
    // cout << processingTime;  // ❌ ERROR: processingTime no longer exists here
    cout << applicantAge;        // ✓ OK: still in function scope
}
```

**Key Points:**
- Local variables exist **only** in their block `{ }`
- They're created when execution reaches them
- They're destroyed when the block ends
- Cannot be accessed outside their scope

---

## Global Scope

Variables declared **outside all functions** have **global scope**:

```cpp
#include <iostream>
using namespace std;

int totalResidents = 150;  // Global variable

void displayCount() {
    cout << "Total residents: " << totalResidents << endl;  // ✓ Can access
}

void addResident() {
    totalResidents++;  // ✓ Can modify
}

int main() {
    cout << totalResidents << endl;  // ✓ Can access
    addResident();
    displayCount();  // Shows 151
    return 0;
}
```

**Characteristics of Global Variables:**
- Accessible from **any function** in the file
- Exist for the **entire program** duration
- Created when program starts
- Destroyed when program ends

---

## Shadowing (Variable Hiding)

What happens when local and global variables have the same name?

```cpp
int balance = 5000;  // Global

void checkBalance() {
    int balance = 1000;  // Local - shadows the global
    cout << balance;      // Prints 1000 (local)
}

void showGlobal() {
    cout << balance;  // Prints 5000 (global)
}

int main() {
    checkBalance();   // 1000
    showGlobal();     // 5000
    cout << balance;  // 5000 (global)
    return 0;
}
```

The local variable **shadows** (hides) the global one within its scope.

### Accessing Shadowed Global Variables

Use the **scope resolution operator** `::`

```cpp
int residents = 100;  // Global

void updateCount() {
    int residents = 50;  // Local
    
    cout << residents << endl;    // 50 (local)
    cout << ::residents << endl;  // 100 (global, using ::)
    
    ::residents = 150;  // Modify global
}
```

---

## Block Scope

Variables can have scope within **any block** `{ }`:

```cpp
int main() {
    int x = 10;
    
    {  // New block
        int y = 20;
        cout << x << ", " << y << endl;  // ✓ Both accessible
    }
    
    // cout << y;  // ❌ ERROR: y no longer exists
    cout << x;     // ✓ OK
    
    return 0;
}
```

**Loop Example:**

```cpp
for (int i = 0; i < 5; i++) {
    int squared = i * i;  // Created each iteration
    cout << squared << " ";
}
// cout << i;        // ❌ ERROR: i doesn't exist here
// cout << squared;  // ❌ ERROR: squared doesn't exist here
```

---

## Static Variables

**Static local variables** retain their value between function calls:

```cpp
void countVisitors() {
    static int visitorCount = 0;  // Initialized ONCE
    visitorCount++;
    cout << "Visitor #" << visitorCount << endl;
}

int main() {
    countVisitors();  // Visitor #1
    countVisitors();  // Visitor #2
    countVisitors();  // Visitor #3
    return 0;
}
```

**Without `static`:**
```cpp
void countVisitors() {
    int visitorCount = 0;  // Reset to 0 every call
    visitorCount++;
    cout << "Visitor #" << visitorCount << endl;
}

int main() {
    countVisitors();  // Visitor #1
    countVisitors();  // Visitor #1 (reset!)
    countVisitors();  // Visitor #1 (reset!)
    return 0;
}
```

**Key Points:**
- `static` variables are initialized **only once**
- They retain their value between function calls
- Still have local scope (can't be accessed outside function)
- Exist for the entire program duration

---

## Lifetime vs Scope

**Scope** = Where can I access it?  
**Lifetime** = How long does it exist?

| Variable Type | Scope | Lifetime |
|---------------|-------|----------|
| Local | Inside block `{ }` | Block execution |
| Global | Entire file | Entire program |
| Static Local | Inside function | Entire program |

**Example:**

```cpp
int globalCounter = 0;  // Scope: entire file, Lifetime: entire program

void processTransaction() {
    static int transactionID = 1000;  // Scope: this function, Lifetime: entire program
    int amount = 500;                  // Scope: this function, Lifetime: function call
    
    transactionID++;
    amount += 100;
    
    cout << "Transaction #" << transactionID << ", Amount: " << amount << endl;
}

int main() {
    processTransaction();  // Transaction #1001, Amount: 600
    processTransaction();  // Transaction #1002, Amount: 600 (amount reset)
    return 0;
}
```

---

## Practical Example: Barangay Clearance Tracker

```cpp
#include <iostream>
using namespace std;

int totalClearances = 0;  // Global: tracks total clearances issued

void issueClearance(string residentName, int age) {
    // Local variables
    int processingFee = 50;
    
    if (age >= 60) {
        int discount = 20;  // Block scope
        processingFee -= discount;
        cout << "Senior citizen discount applied!\n";
    }
    // discount doesn't exist here
    
    static int clearanceNumber = 1000;  // Static: persists between calls
    clearanceNumber++;
    
    totalClearances++;  // Modify global
    
    cout << "===========================\n";
    cout << "BARANGAY CLEARANCE\n";
    cout << "Clearance #" << clearanceNumber << endl;
    cout << "Name: " << residentName << endl;
    cout << "Fee: P" << processingFee << endl;
    cout << "Total clearances issued: " << totalClearances << endl;
    cout << "===========================\n\n";
}

int main() {
    cout << "Clearances issued today: " << totalClearances << "\n\n";
    
    issueClearance("Juan Dela Cruz", 30);
    issueClearance("Maria Santos", 65);
    issueClearance("Pedro Reyes", 28);
    
    cout << "Final count: " << totalClearances << " clearances\n";
    
    return 0;
}
```

**Output:**
```
Clearances issued today: 0

===========================
BARANGAY CLEARANCE
Clearance #1001
Name: Juan Dela Cruz
Fee: P50
Total clearances issued: 1
===========================

Senior citizen discount applied!
===========================
BARANGAY CLEARANCE
Clearance #1002
Name: Maria Santos
Fee: P30
Total clearances issued: 2
===========================

===========================
BARANGAY CLEARANCE
Clearance #1003
Name: Pedro Reyes
Fee: P50
Total clearances issued: 3
===========================

Final count: 3 clearances
```

**Analysis:**
- `totalClearances` (global): accessible everywhere, tracks all clearances
- `clearanceNumber` (static): keeps incrementing across calls
- `processingFee` (local): created fresh each call
- `discount` (block): only exists inside the if-block

---

## Best Practices

### 1. **Prefer Local Variables**
```cpp
// ✓ GOOD: Local scope
void calculateFee() {
    int baseFee = 50;  // Local
    cout << baseFee;
}

// ❌ AVOID: Unnecessary global
int baseFee = 50;  // Global - risky!
void calculateFee() {
    cout << baseFee;
}
```

### 2. **Use Global Variables Sparingly**
Globals make code harder to debug because any function can change them.

```cpp
// ❌ RISKY
int balance = 1000;  // Global

void mysteryFunction() {
    balance = 0;  // Surprise! Balance changed
}

void withdraw(int amount) {
    balance -= amount;
    // Who else is modifying balance? Hard to track!
}
```

### 3. **Use `const` for Global Constants**
```cpp
const double PI = 3.14159;        // ✓ Safe global constant
const int MAX_RESIDENTS = 500;    // ✓ Safe global constant
```

### 4. **Avoid Shadowing**
```cpp
// ❌ CONFUSING
int fee = 100;  // Global

void process() {
    int fee = 50;  // Shadows global - confusing!
    cout << fee;
}

// ✓ CLEAR
int globalFee = 100;  // Descriptive name

void process() {
    int localFee = 50;
    cout << localFee;
}
```

### 5. **Use Static for Persistent Counters**
```cpp
void generateID() {
    static int nextID = 1000;  // ✓ Good use of static
    cout << "ID: " << nextID++ << endl;
}
```

---

## Common Mistakes

### Mistake 1: Accessing Out-of-Scope Variables
```cpp
void process() {
    int temp = 10;
}

int main() {
    cout << temp;  // ❌ ERROR: temp doesn't exist here
    return 0;
}
```

### Mistake 2: Forgetting Static Initialization
```cpp
void count() {
    static int counter;  // Initialized to 0 automatically
    counter++;           // But better to be explicit:
}

void countBetter() {
    static int counter = 0;  // ✓ Clear
    counter++;
}
```

### Mistake 3: Modifying Global Without Realizing
```cpp
int total = 0;

void addValue(int x) {
    total += x;  // Modifies global - side effect!
}

void display() {
    cout << total;  // Depends on what addValue did
}
```

**Better:** Pass values explicitly:
```cpp
int addValue(int total, int x) {
    return total + x;  // ✓ No side effects
}
```

---

## Scope in Loops

```cpp
// i has loop scope
for (int i = 0; i < 3; i++) {
    cout << i << " ";
}
// cout << i;  // ❌ ERROR

// Multiple loops can reuse variable names
for (int i = 0; i < 5; i++) {
    // Different i from above
}

for (int i = 10; i > 0; i--) {
    // Yet another different i
}
```

---

## Namespace Scope

Variables in a namespace have their own scope:

```cpp
namespace Barangay {
    int population = 500;
}

namespace City {
    int population = 50000;
}

int main() {
    cout << Barangay::population << endl;  // 500
    cout << City::population << endl;      // 50000
    return 0;
}
```

---

## Quick Reference

```cpp
// GLOBAL SCOPE
int globalVar = 100;  // Accessible everywhere

void function1() {
    // LOCAL SCOPE
    int localVar = 50;  // Only in this function
    
    // STATIC LOCAL
    static int counter = 0;  // Persists between calls
    counter++;
    
    if (localVar > 0) {
        // BLOCK SCOPE
        int blockVar = 10;  // Only in this if-block
    }
    // blockVar doesn't exist here
}

void function2() {
    cout << globalVar;  // ✓ Can access global
    // cout << localVar;   // ❌ ERROR: Can't access function1's local
}
```

---

## Summary

Tian stretched. "So scope is like knowing which office a document belongs to!"

"Exactly!" Kuya Miguel nodded. "Remember:
- **Local scope** — variables live in their function/block
- **Global scope** — accessible everywhere (use sparingly!)
- **Static** — keeps value between calls
- **Shadowing** — local hides global with same name
- **Lifetime** — how long a variable exists"

"Next," Kuya Miguel said, "we'll build a **Modular Grade Calculator** combining everything we learned about functions, parameters, and scope!"

---

**Key Takeaways:**
1. Scope determines **where** you can access a variable
2. Lifetime determines **how long** a variable exists
3. Local variables are preferred over global
4. Static variables retain values between function calls
5. Avoid shadowing for clearer code

---

## Closing Story

"This is trippy, Kuya," Tian said, staring at his clearance tracker code. "A variable can exist in the program but not be accessible from where I am?"

"That's scope!" Kuya Miguel explained. "Think of it like rooms in a house. Each function is a room. Local variables are furniture in that room. You can't use the chair from the bedroom while you're in the kitchen, even though it exists."

Tian ran his code again, watching the static clearance counter increment while local variables came and went. "And static is like... a counter on the wall that persists even after I leave the room and come back?"

"Perfect analogy! Static variables have function scope but program lifetime. They remember their value between calls. And global variables? Those are like the foundation of the house. Accessible from every room, but risky because anyone can modify them."

Tian nodded. "So: local first, static when I need memory, global sparingly, and const for safe globals."

"You've got it. Now let's apply everything in a practical project!"

**Next Lesson:** Practical Exercise - Modular Grade Calculator
