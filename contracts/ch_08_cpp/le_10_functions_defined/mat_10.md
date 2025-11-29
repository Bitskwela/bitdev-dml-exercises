## Background Story

Tian opened the ATM project file and scrolled... and scrolled... and scrolled. The `main()` function was 243 lines long. Finding a specific piece of code was like searching for a needle in a haystack.

"Kuya, I need to fix the withdrawal validation logic," Tian said, frustrated. "But I can't even find where it is! And when I finally found it, I realized I'm doing the same balance check in three different places. If I update one, I have to remember to update the others. This is a mess!"

Kuya Miguel nodded sympathetically. "You've hit the 'spaghetti code' wall. Your program works, but it's unmaintainable. Imagine if Facebook's entire codebase was one giant file. Imagine if a hospital system's patient management was 10,000 lines in a single function."

"Professional developers never write code like this," Kuya Miguel explained. "They use **functions**—breaking complex systems into small, reusable, testable pieces. Each function does one job and does it well. Need to validate a withdrawal? There's a function for that. Need to check PIN? There's a function for that. Instead of hunting through 200 lines, you just call the function by name."

"Functions are the foundation of organized, maintainable code. Let's refactor your ATM project and transform it from a mess into clean, professional code!"

---

## Theory & Lecture Content

## What Are Functions?

**Functions** are reusable blocks of code that perform a specific task.

### Why Use Functions?

1. **Organization** - Break complex code into manageable pieces
2. **Reusability** - Write once, use many times
3. **Readability** - Easier to understand what code does
4. **Maintenance** - Fix bugs in one place
5. **Testing** - Test each function independently

---

## Function Anatomy

```cpp
returnType functionName(parameters) {
    // Function body
    return value;
}
```

**Parts:**
1. **Return Type** - Data type the function returns (or `void` for none)
2. **Function Name** - Descriptive name (verb + noun)
3. **Parameters** - Input values (optional)
4. **Body** - Code to execute
5. **Return Statement** - Value to send back (if not void)

---

## Simple Function Example

### Function Without Parameters or Return

```cpp
#include <iostream>
using namespace std;

// Function definition
void greet() {
    cout << "Welcome to Barangay System!" << endl;
    cout << "Maligayang pagdating!" << endl;
}

int main() {
    cout << "Starting program..." << endl;
    
    greet();  // Function call
    
    cout << "Program ended." << endl;
    return 0;
}
```

**Output:**
```
Starting program...
Welcome to Barangay System!
Maligayang pagdating!
Program ended.
```

**Key Points:**
- `void` means function returns nothing
- `greet()` has no parameters
- Call the function using its name with `()`

---

## Function With Parameters

### Example: Personalized Greeting

```cpp
#include <iostream>
#include <string>
using namespace std;

// Function with one parameter
void greetResident(string name) {
    cout << "Good morning, " << name << "!" << endl;
    cout << "How can we help you today?" << endl;
}

int main() {
    greetResident("Juan");
    greetResident("Maria");
    greetResident("Pedro");
    
    return 0;
}
```

**Output:**
```
Good morning, Juan!
How can we help you today?
Good morning, Maria!
How can we help you today?
Good morning, Pedro!
How can we help you today?
```

**Key Points:**
- Parameter `string name` receives input
- Same function, different inputs, different outputs
- Reusable code!

---

## Function With Multiple Parameters

### Example: Calculate Monthly Due

```cpp
#include <iostream>
using namespace std;

// Function with multiple parameters
void displayDue(string name, double amount, bool isPaid) {
    cout << "Resident: " << name << endl;
    cout << "Amount Due: PHP " << amount << endl;
    
    if (isPaid) {
        cout << "Status: ✓ PAID" << endl;
    } else {
        cout << "Status: ✗ UNPAID" << endl;
    }
    cout << "------------------------" << endl;
}

int main() {
    displayDue("Juan", 150.00, true);
    displayDue("Maria", 150.00, false);
    displayDue("Pedro", 200.00, true);
    
    return 0;
}
```

**Output:**
```
Resident: Juan
Amount Due: PHP 150
Status: ✓ PAID
------------------------
Resident: Maria
Amount Due: PHP 150
Status: ✗ UNPAID
------------------------
Resident: Pedro
Amount Due: PHP 200
Status: ✓ PAID
------------------------
```

---

## Functions With Return Values

### Example: Calculate Total

```cpp
#include <iostream>
using namespace std;

// Function that returns an integer
int calculateTotal(int quantity, int pricePerUnit) {
    int total = quantity * pricePerUnit;
    return total;  // Send result back
}

int main() {
    int qty1 = 5;
    int price1 = 50;
    
    int result = calculateTotal(qty1, price1);
    
    cout << "Total: PHP " << result << endl;
    
    // Can use directly in expression
    cout << "Total for 10 items: PHP " << calculateTotal(10, 50) << endl;
    
    return 0;
}
```

**Output:**
```
Total: PHP 250
Total for 10 items: PHP 500
```

**Key Points:**
- Function returns `int` value
- Use `return` to send value back
- Can store result in variable OR use directly

---

## Barangay Example: Clearance Fee Calculator

```cpp
#include <iostream>
using namespace std;

// Function to calculate clearance fee
double calculateClearanceFee(int age, bool isSenior, bool isPWD) {
    double baseFee = 100.0;
    
    if (isSenior || isPWD) {
        return baseFee * 0.8;  // 20% discount
    } else if (age < 18) {
        return baseFee * 0.5;  // 50% discount for minors
    } else {
        return baseFee;
    }
}

// Function to display fee breakdown
void displayFeeBreakdown(string name, int age, bool isSenior, bool isPWD) {
    cout << "\n=== Barangay Clearance Fee ===" << endl;
    cout << "Applicant: " << name << endl;
    cout << "Age: " << age << endl;
    
    double fee = calculateClearanceFee(age, isSenior, isPWD);
    double baseFee = 100.0;
    
    cout << "Base Fee: PHP " << baseFee << endl;
    
    if (fee < baseFee) {
        double discount = baseFee - fee;
        cout << "Discount: PHP " << discount << endl;
        
        if (isSenior) {
            cout << "Reason: Senior Citizen (20% off)" << endl;
        } else if (isPWD) {
            cout << "Reason: PWD (20% off)" << endl;
        } else if (age < 18) {
            cout << "Reason: Minor (50% off)" << endl;
        }
    }
    
    cout << "Total Fee: PHP " << fee << endl;
    cout << "=============================" << endl;
}

int main() {
    // Test different residents
    displayFeeBreakdown("Juan", 65, true, false);
    displayFeeBreakdown("Maria", 25, false, false);
    displayFeeBreakdown("Pedro", 15, false, false);
    displayFeeBreakdown("Ana", 40, false, true);
    
    return 0;
}
```

**Output:**
```
=== Barangay Clearance Fee ===
Applicant: Juan
Age: 65
Base Fee: PHP 100
Discount: PHP 20
Reason: Senior Citizen (20% off)
Total Fee: PHP 80
=============================

=== Barangay Clearance Fee ===
Applicant: Maria
Age: 25
Base Fee: PHP 100
Total Fee: PHP 100
=============================

=== Barangay Clearance Fee ===
Applicant: Pedro
Age: 15
Base Fee: PHP 100
Discount: PHP 50
Reason: Minor (50% off)
Total Fee: PHP 50
=============================

=== Barangay Clearance Fee ===
Applicant: Ana
Age: 40
Base Fee: PHP 100
Discount: PHP 20
Reason: PWD (20% off)
Total Fee: PHP 80
=============================
```

---

## Function Declaration vs Definition

### Forward Declaration

When you want to define a function after `main()`, use **forward declaration**:

```cpp
#include <iostream>
using namespace std;

// Forward declaration (tells compiler function exists)
int add(int a, int b);
void displayResult(int result);

int main() {
    int sum = add(5, 3);
    displayResult(sum);
    return 0;
}

// Function definitions (actual implementation)
int add(int a, int b) {
    return a + b;
}

void displayResult(int result) {
    cout << "Result: " << result << endl;
}
```

**Why?**
- C++ reads code top-to-bottom
- If function is defined after `main()`, compiler doesn't know it exists yet
- Forward declaration tells compiler "trust me, this function exists"

---

## Function Overloading

**Function overloading** allows multiple functions with the same name but different parameters.

```cpp
#include <iostream>
using namespace std;

// Calculate area of square
double calculateArea(double side) {
    return side * side;
}

// Calculate area of rectangle (overloaded)
double calculateArea(double length, double width) {
    return length * width;
}

// Calculate area of circle (overloaded)
double calculateArea(double radius, bool isCircle) {
    if (isCircle) {
        return 3.14159 * radius * radius;
    }
    return 0;
}

int main() {
    cout << "Square area (side=5): " << calculateArea(5.0) << endl;
    cout << "Rectangle area (4x6): " << calculateArea(4.0, 6.0) << endl;
    cout << "Circle area (r=3): " << calculateArea(3.0, true) << endl;
    
    return 0;
}
```

**Output:**
```
Square area (side=5): 25
Rectangle area (4x6): 24
Circle area (r=3): 28.2743
```

**Compiler decides which function to call based on arguments passed!**

---

## Common Function Patterns

### 1. Validation Function

```cpp
bool isValidAge(int age) {
    return age >= 0 && age <= 120;
}

// Usage
int age;
cout << "Enter age: ";
cin >> age;

if (!isValidAge(age)) {
    cout << "Invalid age!" << endl;
}
```

### 2. Conversion Function

```cpp
double celsiusToFahrenheit(double celsius) {
    return (celsius * 9.0 / 5.0) + 32.0;
}

// Usage
double tempC = 25.0;
double tempF = celsiusToFahrenheit(tempC);
cout << tempC << "°C = " << tempF << "°F" << endl;
```

### 3. Formatting Function

```cpp
string formatCurrency(double amount) {
    return "PHP " + to_string(amount);
}

// Usage
double price = 1500.50;
cout << "Price: " << formatCurrency(price) << endl;
```

### 4. Menu Display Function

```cpp
void displayMenu() {
    cout << "\n========= MENU =========" << endl;
    cout << "1. Register Resident" << endl;
    cout << "2. View Records" << endl;
    cout << "3. Exit" << endl;
    cout << "========================" << endl;
    cout << "Enter choice: ";
}

// Usage - cleaner main function
int main() {
    int choice;
    
    do {
        displayMenu();
        cin >> choice;
        
        // Process choice...
        
    } while (choice != 3);
    
    return 0;
}
```

---

## Refactoring ATM with Functions

**Before (all in main):**
```cpp
int main() {
    // 200 lines of authentication code
    // 100 lines of deposit code
    // 100 lines of withdrawal code
    // ... very long!
}
```

**After (with functions):**
```cpp
bool authenticate();
void checkBalance(double balance);
void deposit(double& balance);
void withdraw(double& balance);
void displayMenu();

int main() {
    double balance = 5000.0;
    
    if (!authenticate()) {
        return 0;
    }
    
    int choice;
    do {
        displayMenu();
        cin >> choice;
        
        if (choice == 1) checkBalance(balance);
        else if (choice == 2) deposit(balance);
        else if (choice == 3) withdraw(balance);
        
    } while (choice != 4);
    
    return 0;
}

// Each function is 20-30 lines max - much more readable!
```

---

## Key Takeaways

1. **Functions organize code** into logical, reusable pieces
2. **`void` functions** perform actions without returning values
3. **Return type functions** compute and return values
4. **Parameters** pass data into functions
5. **Forward declarations** allow defining functions after `main()`
6. **Overloading** allows same name, different parameters
7. **Good function names** are verbs describing what they do

---

## Best Practices

✅ **DO:**
- Use descriptive names (`calculateTotal`, not `ct`)
- Keep functions short (< 50 lines ideal)
- One function = one responsibility
- Add comments for complex logic

❌ **DON'T:**
- Make giant functions (100+ lines)
- Use vague names (`doStuff`, `x`, `temp`)
- Mix multiple unrelated tasks in one function

---

## What's Next?

You've learned function basics! In **Lesson 11**, you'll dive deeper into **parameters and return values** - learning about pass by value, pass by reference, and how data flows in and out of functions.

**Kuya Miguel:** "Functions are the building blocks of clean code, Tian. Master them, and your programs will be elegant and maintainable!"

---

## Closing Story

Tian refactored the ATM code into clean, organized functions. "Kuya, this is so much better! Each function has one job, and my main function is only 20 lines now instead of 200!"

"That's modular programming," Kuya Miguel said proudly. "Professional developers don't write giant monolithic code. They break problems into small, testable, reusable functions."

"I get it now," Tian said. "Functions are like tools in a toolbox. You don't throw all your tools in one pile - you organize them, label them, and use each one for its specific purpose."

"Perfect analogy! Next lesson, we'll dive deeper into parameters and return values - how data flows into and out of functions. You'll learn about pass-by-value, pass-by-reference, and more."

Tian was ready to become a true function master.

**Reading time:** ~10 minutes
