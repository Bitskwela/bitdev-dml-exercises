# Lesson 12 Activities: Scope Rules

---

## Challenge 1: Resident Counter with Static Variables

**Objective:** Practice using `static` variables to maintain state across function calls.

**Task:**  
Create a function `registerResident()` that tracks how many times it's been called using a static variable. Each time it's called, display "Resident #1", "Resident #2", etc.

**Requirements:**
- Use a `static int` variable inside the function to count calls
- Display the resident number each time the function is called
- The counter should persist between function calls

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

void registerResident() {
    // Use static variable to count calls
    
    // Display resident number
}

int main() {
    registerResident();  // Should print: Resident #1
    registerResident();  // Should print: Resident #2
    registerResident();  // Should print: Resident #3
    
    return 0;
}
```

**Expected Output:**
```
Resident #1 registered
Resident #2 registered
Resident #3 registered
```

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

void registerResident() {
    static int residentCount = 0;  // Static: retains value between calls
    residentCount++;
    
    cout << "Resident #" << residentCount << " registered" << endl;
}

int main() {
    registerResident();  // Resident #1
    registerResident();  // Resident #2
    registerResident();  // Resident #3
    registerResident();  // Resident #4
    
    return 0;
}
```

</details>

---

## Challenge 2: Fee Calculator with Discounts and Transaction Counter

**Objective:** Combine global constants, local variables, and static variables for a transaction system.

**Task:**  
Create a fee calculator system that:
- Uses a global constant `BASE_FEE = 100`
- Calculates discounts in block scope (local variables)
- Uses static variable to count total transactions

**Requirements:**
- Global constant: `const int BASE_FEE = 100;`
- Function `calculateFee(int age)` returns fee after discount
  - Senior citizens (age >= 60): 20% discount
  - Students (age < 18): 10% discount
  - Regular: no discount
- Use static variable to track total number of transactions
- Display transaction count with each call

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

const int BASE_FEE = 100;

double calculateFee(int age) {
    // Static transaction counter
    
    // Calculate discount in local scope
    
    // Return final fee
}

int main() {
    cout << "Fee for age 65: " << calculateFee(65) << endl;
    cout << "Fee for age 15: " << calculateFee(15) << endl;
    cout << "Fee for age 30: " << calculateFee(30) << endl;
    
    return 0;
}
```

**Expected Output:**
```
Transaction #1 - Fee for age 65: 80
Transaction #2 - Fee for age 15: 90
Transaction #3 - Fee for age 30: 100
```

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

const int BASE_FEE = 100;

double calculateFee(int age) {
    static int transactionCount = 0;  // Track total transactions
    transactionCount++;
    
    double fee = BASE_FEE;
    double discount = 0;
    
    // Calculate discount in block scope
    {
        if (age >= 60) {
            discount = BASE_FEE * 0.20;  // 20% senior discount
        } else if (age < 18) {
            discount = BASE_FEE * 0.10;  // 10% student discount
        }
    }
    
    fee = BASE_FEE - discount;
    
    cout << "Transaction #" << transactionCount << " - ";
    
    return fee;
}

int main() {
    cout << "Fee for age 65: " << calculateFee(65) << endl;
    cout << "Fee for age 15: " << calculateFee(15) << endl;
    cout << "Fee for age 30: " << calculateFee(30) << endl;
    cout << "Fee for age 70: " << calculateFee(70) << endl;
    
    return 0;
}
```

</details>

---

## Challenge 3: Shadowing Example with Global and Local Balance

**Objective:** Demonstrate variable shadowing and accessing global variables using the scope resolution operator `::`.

**Task:**  
Create a program that:
- Has a global variable `balance = 1000`
- Has a function with a local variable also named `balance = 500`
- Prints both balances, showing how local shadows global
- Uses `::balance` to access the global variable from within the function

**Requirements:**
- Global `int balance = 1000;`
- Function `checkBalance()` with local `int balance = 500;`
- Print both local and global balance from within the function
- Use `::` to explicitly access global variable

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int balance = 1000;  // Global balance

void checkBalance() {
    int balance = 500;  // Local balance (shadows global)
    
    // Print both local and global balance
}

int main() {
    cout << "From main - Global balance: " << balance << endl;
    checkBalance();
    
    return 0;
}
```

**Expected Output:**
```
From main - Global balance: 1000
Local balance: 500
Global balance (using ::): 1000
```

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

int balance = 1000;  // Global balance

void checkBalance() {
    int balance = 500;  // Local balance (shadows global)
    
    cout << "Local balance: " << balance << endl;
    cout << "Global balance (using ::): " << ::balance << endl;
}

int main() {
    cout << "From main - Global balance: " << balance << endl;
    cout << endl;
    
    checkBalance();
    
    cout << endl;
    cout << "After function - Global balance: " << balance << endl;
    
    return 0;
}
```

</details>

---

## Bonus Challenge: Complete Scope Demonstration

**Objective:** Create a comprehensive program that demonstrates all scope concepts in one example.

**Task:**  
Build a barangay clearance tracking system that demonstrates:
- Global constants (fee amounts)
- Static variables (clearance counter)
- Local variables (temporary calculations)
- Variable shadowing
- Block scope

**Features:**
- Track total clearances issued (static)
- Global clearance fee constant
- Local discount calculations
- Display clearance number and fee

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
using namespace std;

// Global constants
const double BASE_CLEARANCE_FEE = 150.00;
const double SENIOR_DISCOUNT = 0.30;  // 30%

// Global variable (generally avoid, but showing for demo)
int totalRevenue = 0;

double issueClearance(string name, int age) {
    static int clearanceNumber = 1000;  // Static: persistent counter
    clearanceNumber++;
    
    double fee = BASE_CLEARANCE_FEE;
    
    // Block scope for discount calculation
    {
        if (age >= 60) {
            double discount = BASE_CLEARANCE_FEE * SENIOR_DISCOUNT;
            fee = BASE_CLEARANCE_FEE - discount;
            cout << "Senior discount applied: -" << discount << endl;
        }
    }
    
    cout << "Clearance #" << clearanceNumber << " issued to " << name << endl;
    cout << "Fee: PHP " << fee << endl;
    cout << "------------------------" << endl;
    
    // Update global revenue (shadowing example)
    int totalRevenue = fee;  // Local totalRevenue shadows global
    ::totalRevenue += totalRevenue;  // Use :: to access global
    
    return fee;
}

void displayStatistics() {
    cout << "\n=== TOTAL REVENUE ===" << endl;
    cout << "PHP " << ::totalRevenue << endl;
}

int main() {
    cout << "=== BARANGAY CLEARANCE SYSTEM ===" << endl;
    cout << endl;
    
    issueClearance("Juan Dela Cruz", 35);
    issueClearance("Maria Santos", 65);
    issueClearance("Pedro Reyes", 70);
    issueClearance("Ana Lopez", 28);
    
    displayStatistics();
    
    return 0;
}
```

</details>

---

## Reflection Questions

After completing these challenges:

1. **What's the difference between local and global scope?**
   - Local: Variables exist only within their function/block
   - Global: Variables accessible from anywhere in the program

2. **When should you use static variables?**
   - When you need a variable to retain its value between function calls
   - Example: counters, state tracking

3. **What is variable shadowing?**
   - When a local variable has the same name as a global variable
   - Local variable "hides" the global one within that scope

4. **Why should global variables be used sparingly?**
   - Hard to track where they're modified
   - Can cause unexpected side effects
   - Makes code harder to test and debug

---

## Key Takeaways

- **Local scope:** Variables exist only in their function/block
- **Global scope:** Accessible everywhere (use const for constants)
- **Static variables:** Retain values between function calls
- **Shadowing:** Local variables hide global ones with same name
- **`::` operator:** Access global variables when shadowed
- **Block scope:** Variables inside `{}` blocks

**Next Lesson:**  
You'll learn about **modular programming** - organizing your code into focused, reusable functions!
