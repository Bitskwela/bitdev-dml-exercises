# Lesson 11: Parameters and Return Values

## Background Story

"Kuya Miguel, I understand functions now," Tian said, "but I'm confused about how data moves in and out. When I pass a variable to a function, what really happens?"

Kuya Miguel pulled out a notebook. "Great question! There are two ways to pass data: **by value** and **by reference**. It's like giving someone a photocopy of a document versus giving them the actual document. Let me show you the difference."

## Pass by Value vs Pass by Reference

### Pass by Value (Default)

When you pass by value, the function gets a **copy** of the data.

```cpp
#include <iostream>
using namespace std;

void tryToChange(int number) {
    number = 100;  // Changes only the copy
    cout << "Inside function: " << number << endl;
}

int main() {
    int original = 50;
    
    cout << "Before: " << original << endl;
    tryToChange(original);
    cout << "After: " << original << endl;
    
    return 0;
}
```

**Output:**
```
Before: 50
Inside function: 100
After: 50
```

**Why?** The function received a **copy**. Changing the copy doesn't affect the original.

---

### Pass by Reference

When you pass by reference (using `&`), the function works with the **actual variable**.

```cpp
#include <iostream>
using namespace std;

void actuallyChange(int& number) {  // Note the &
    number = 100;  // Changes the original
    cout << "Inside function: " << number << endl;
}

int main() {
    int original = 50;
    
    cout << "Before: " << original << endl;
    actuallyChange(original);
    cout << "After: " << original << endl;
    
    return 0;
}
```

**Output:**
```
Before: 50
Inside function: 100
After: 100
```

**Why?** The `&` makes it a reference. Changes affect the original variable.

---

## Visual Comparison

### Pass by Value (Copy)
```
main():          function():
┌────────┐       ┌────────┐
│ x = 10 │  -->  │ copy=10│
└────────┘       └────────┘
                 copy = 20
┌────────┐       ┌────────┐
│ x = 10 │       │ copy=20│  ← Only copy changed!
└────────┘       └────────┘
```

### Pass by Reference (Alias)
```
main():          function():
┌────────┐       
│ x = 10 │  <--> │  ref  │  ← Points to same location!
└────────┘       └───────┘
                 ref = 20
┌────────┐       
│ x = 20 │  <--> │  ref  │  ← Original changed!
└────────┘       └───────┘
```

---

## When to Use Each?

### Use Pass by Value When:
- You don't want to modify the original
- Working with small data (int, double, bool, char)
- Function just needs to read the value

```cpp
double calculateTax(double price) {  // Pass by value
    return price * 0.12;  // Just reading, not modifying
}
```

### Use Pass by Reference When:
- You need to modify the original
- Working with large data (arrays, objects, strings)
- You want to return multiple values

```cpp
void applyDiscount(double& price) {  // Pass by reference
    price *= 0.8;  // Modify original price
}
```

---

## Barangay Example: Update Resident Balance

```cpp
#include <iostream>
#include <string>
using namespace std;

// Pass by reference to actually modify balance
void deposit(double& balance, double amount) {
    if (amount > 0) {
        balance += amount;
        cout << "✓ Deposited: PHP " << amount << endl;
    } else {
        cout << "✗ Invalid amount" << endl;
    }
}

void withdraw(double& balance, double amount) {
    if (amount > balance) {
        cout << "✗ Insufficient funds" << endl;
    } else if (amount <= 0) {
        cout << "✗ Invalid amount" << endl;
    } else {
        balance -= amount;
        cout << "✓ Withdrawn: PHP " << amount << endl;
    }
}

// Pass by value (read-only)
void displayBalance(double balance) {
    cout << "Current Balance: PHP " << balance << endl;
}

int main() {
    double residentBalance = 5000.0;
    
    displayBalance(residentBalance);
    
    deposit(residentBalance, 2000);
    displayBalance(residentBalance);
    
    withdraw(residentBalance, 1500);
    displayBalance(residentBalance);
    
    return 0;
}
```

**Output:**
```
Current Balance: PHP 5000
✓ Deposited: PHP 2000
Current Balance: PHP 7000
✓ Withdrawn: PHP 1500
Current Balance: PHP 5500
```

---

## Return Values

### Single Return Value

```cpp
int calculateAge(int birthYear, int currentYear) {
    return currentYear - birthYear;
}

int main() {
    int age = calculateAge(1995, 2025);
    cout << "Age: " << age << endl;  // Age: 30
    return 0;
}
```

### Multiple Return Values Using References

```cpp
#include <iostream>
using namespace std;

// Return multiple values using reference parameters
void calculateStats(int numbers[], int size, int& min, int& max, double& avg) {
    min = numbers[0];
    max = numbers[0];
    int sum = 0;
    
    for (int i = 0; i < size; i++) {
        if (numbers[i] < min) min = numbers[i];
        if (numbers[i] > max) max = numbers[i];
        sum += numbers[i];
    }
    
    avg = sum / (double)size;
}

int main() {
    int scores[] = {85, 92, 78, 95, 88};
    int minimum, maximum;
    double average;
    
    calculateStats(scores, 5, minimum, maximum, average);
    
    cout << "Minimum: " << minimum << endl;
    cout << "Maximum: " << maximum << endl;
    cout << "Average: " << average << endl;
    
    return 0;
}
```

**Output:**
```
Minimum: 78
Maximum: 95
Average: 87.6
```

---

## Const References

Use `const` to pass by reference but prevent modifications (efficient + safe):

```cpp
// Efficient: No copying (large string)
// Safe: Cannot be modified
void displayResident(const string& name) {
    cout << "Resident: " << name << endl;
    // name = "Changed";  // ERROR: Cannot modify const reference
}

int main() {
    string resident = "Juan Dela Cruz";
    displayResident(resident);  // Efficient, no copy made
    return 0;
}
```

**Best practice:** Use `const&` for read-only large data (strings, arrays, objects).

---

## Default Parameters

Provide default values for parameters:

```cpp
#include <iostream>
using namespace std;

// Last parameters can have default values
void printReceipt(string item, double price, int quantity = 1) {
    double total = price * quantity;
    cout << item << ": PHP " << price << " x " << quantity 
         << " = PHP " << total << endl;
}

int main() {
    printReceipt("Barangay ID", 50.0, 2);   // Uses 2
    printReceipt("Clearance", 100.0);       // Uses default 1
    
    return 0;
}
```

**Output:**
```
Barangay ID: PHP 50 x 2 = PHP 100
Clearance: PHP 100 x 1 = PHP 100
```

**Rules:**
- Default parameters must be rightmost
- `void func(int a = 1, int b)` ❌ Wrong
- `void func(int a, int b = 1)` ✓ Correct

---

## Arrays as Parameters

Arrays are **always passed by reference** (actually, as pointers):

```cpp
#include <iostream>
using namespace std;

// Array parameter (automatically a reference)
void doubleValues(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        arr[i] *= 2;  // Modifies original array
    }
}

int main() {
    int numbers[] = {1, 2, 3, 4, 5};
    
    cout << "Before: ";
    for (int i = 0; i < 5; i++) {
        cout << numbers[i] << " ";
    }
    cout << endl;
    
    doubleValues(numbers, 5);
    
    cout << "After: ";
    for (int i = 0; i < 5; i++) {
        cout << numbers[i] << " ";
    }
    cout << endl;
    
    return 0;
}
```

**Output:**
```
Before: 1 2 3 4 5
After: 2 4 6 8 10
```

---

## Practical Barangay System: Resident Management

```cpp
#include <iostream>
#include <string>
using namespace std;

// Calculate clearance fee (pass by value - read only)
double calculateFee(int age, bool isSenior) {
    double baseFee = 100.0;
    
    if (isSenior || age >= 60) {
        return baseFee * 0.8;  // 20% discount
    } else if (age < 18) {
        return baseFee * 0.5;  // 50% discount
    }
    return baseFee;
}

// Process payment (pass by reference - modify balance)
bool processPayment(double& balance, double amount) {
    if (balance >= amount) {
        balance -= amount;
        return true;
    }
    return false;
}

// Get resident info (multiple "returns" via references)
void getResidentInfo(string& name, int& age, bool& isSenior) {
    cout << "Enter name: ";
    getline(cin, name);
    cout << "Enter age: ";
    cin >> age;
    cout << "Senior citizen? (1/0): ";
    cin >> isSenior;
}

// Display receipt (const reference - read only, efficient)
void displayReceipt(const string& name, double fee, double newBalance) {
    cout << "\n========== RECEIPT ==========" << endl;
    cout << "Name: " << name << endl;
    cout << "Fee: PHP " << fee << endl;
    cout << "Remaining Balance: PHP " << newBalance << endl;
    cout << "=============================" << endl;
}

int main() {
    double accountBalance = 1000.0;
    string residentName;
    int residentAge;
    bool isSenior;
    
    cout << "=== Barangay Clearance System ===" << endl;
    cout << "Account Balance: PHP " << accountBalance << endl;
    
    cin.ignore();  // Clear input buffer
    getResidentInfo(residentName, residentAge, isSenior);
    
    double fee = calculateFee(residentAge, isSenior);
    cout << "\nClearance Fee: PHP " << fee << endl;
    
    if (processPayment(accountBalance, fee)) {
        cout << "✓ Payment successful!" << endl;
        displayReceipt(residentName, fee, accountBalance);
    } else {
        cout << "✗ Insufficient balance!" << endl;
        cout << "Need PHP " << (fee - accountBalance) << " more" << endl;
    }
    
    return 0;
}
```

**Sample Run:**
```
=== Barangay Clearance System ===
Account Balance: PHP 1000
Enter name: Juan Dela Cruz
Enter age: 65
Senior citizen? (1/0): 1

Clearance Fee: PHP 80
✓ Payment successful!

========== RECEIPT ==========
Name: Juan Dela Cruz
Fee: PHP 80
Remaining Balance: PHP 920
=============================
```

---

## Common Mistakes

### Mistake 1: Forgetting & for Reference

```cpp
// ❌ WRONG - Pass by value
void increment(int num) {
    num++;  // Only changes copy
}

// ✓ CORRECT - Pass by reference
void increment(int& num) {
    num++;  // Changes original
}
```

### Mistake 2: Modifying const Reference

```cpp
void process(const int& value) {
    value = 10;  // ❌ ERROR: Cannot modify const
}
```

### Mistake 3: Returning Reference to Local Variable

```cpp
// ❌ DANGEROUS!
int& badFunction() {
    int x = 10;
    return x;  // x destroyed when function ends!
}

// ✓ CORRECT
int goodFunction() {
    int x = 10;
    return x;  // Returns copy (safe)
}
```

---

## Key Takeaways

1. **Pass by value** - Function gets a copy (default)
2. **Pass by reference (`&`)** - Function works with original
3. **const reference** - Efficient + safe for read-only
4. **Arrays** - Always passed by reference
5. **Default parameters** - Must be rightmost
6. **Multiple returns** - Use reference parameters

---

## What's Next?

In **Lesson 12**, you'll learn about **scope rules and variable lifetime** - understanding where variables are accessible and when they're created/destroyed.

**Kuya Miguel:** "You now understand how data flows in and out of functions. Next, we'll explore where variables live and how long they exist!"

**Reading time:** ~10 minutes
