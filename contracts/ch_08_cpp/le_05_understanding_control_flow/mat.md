## Background Story: The Crossroads

Tian stared at the screen in disbelief. The calculator displayed: `Result: inf`. The culprit? A user had divided by zero, and the program blindly executed the calculation without checking.

"Kuya Miguel, my calculator just broke!" Tian exclaimed, frustrated. "I spent hours building this, and one wrong input crashes everything. How do real programs handle this?"

Kuya Miguel walked over calmly. "Right now, your program is like a jeepney driver who never looks at the road—just drives straight no matter what. Pedestrian crossing? Keep going. Red light? Keep going. Flooding ahead? Drive right into it."

Tian laughed nervously. "That would be a disaster!"

"Exactly," Kuya Miguel said, pulling up a chair. "Programs that can't make decisions are dangerous. Imagine an ATM that gives money without checking the balance. A game character that takes damage even with a shield equipped. A door that opens for anyone without checking authorization. Every robust program needs the ability to evaluate situations and make intelligent choices."

"You need **control flow**—the ability to look at conditions and decide what to do. Should I execute this code? Should I skip that section? Should I take a different path entirely? Today, we transform your programs from mindless instruction-followers into smart decision-makers!"

---

## Theory & Lecture Content

## What is Control Flow?

**Control flow** is the order in which individual statements, instructions, or function calls are executed in a program. By default, programs execute from top to bottom, but control flow structures allow us to:

1. **Make decisions** (branching)
2. **Repeat actions** (loops - next lesson)
3. **Jump to different parts** of the code

Think of control flow as the decision-making ability of your program. Without it, programs would be like a jeepney driver who never stops, never turns, and never changes speed - not very useful!

### The Flow of Execution

```
Normal Flow (Sequential):
Statement 1
    |
    v
Statement 2
    |
    v
Statement 3

Branching Flow (Decision-Making):
Statement 1
    |
    v
Condition?
   / \
Yes  No
  |   |
  v   v
 Do A Do B
   \  /
    v
Continue
```

## The if Statement

The `if` statement is the most basic decision-making structure. It executes a block of code only if a condition is true.

### Basic Syntax

```cpp
if (condition) {
    // code to execute if condition is true
}
```

### Simple Example

```cpp
#include <iostream>
using namespace std;

int main() {
    int age = 18;
    
    if (age >= 18) {
        cout << "You can vote in Philippine elections!" << endl;
    }
    
    return 0;
}
```

**Output:**
```
You can vote in Philippine elections!
```

### Real-World Example: Checking Jeepney Fare

```cpp
#include <iostream>
using namespace std;

int main() {
    double fare = 13.0;
    double payment = 10.0;
    
    if (payment < fare) {
        cout << "Kulang bayad mo, pare!" << endl;
        cout << "Fare: " << fare << " pesos" << endl;
        cout << "Payment: " << payment << " pesos" << endl;
        cout << "Short: " << (fare - payment) << " pesos" << endl;
    }
    
    return 0;
}
```

**Output:**
```
Kulang bayad mo, pare!
Fare: 13 pesos
Payment: 10 pesos
Short: 3 pesos
```

### Comparison Operators

To make decisions, we need to compare values. C++ provides several comparison operators:

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `==` | Equal to | `5 == 5` | true |
| `!=` | Not equal to | `5 != 3` | true |
| `>` | Greater than | `10 > 5` | true |
| `<` | Less than | `3 < 8` | true |
| `>=` | Greater than or equal to | `5 >= 5` | true |
| `<=` | Less than or equal to | `4 <= 9` | true |

**Important Note:** Don't confuse `=` (assignment) with `==` (comparison)!

```cpp
int x = 5;        // Assignment: x becomes 5
if (x == 5) {     // Comparison: check if x equals 5
    // This will execute
}
```

### Logical Operators

Sometimes we need to combine multiple conditions:

| Operator | Meaning | Example | Description |
|----------|---------|---------|-------------|
| `&&` | AND | `(a > 5) && (b < 10)` | Both must be true |
| `\|\|` | OR | `(a > 5) \|\| (b < 10)` | At least one must be true |
| `!` | NOT | `!(a > 5)` | Reverses the condition |

### Example: PWD and Senior Citizen Discount

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isPWD;
    
    cout << "Enter your age: ";
    cin >> age;
    cout << "Are you a PWD? (1 for Yes, 0 for No): ";
    cin >> isPWD;
    
    double price = 100.0;
    
    // Senior citizens (60+) or PWD get 20% discount
    if (age >= 60 || isPWD) {
        double discount = price * 0.20;
        double finalPrice = price - discount;
        
        cout << "\nOriginal Price: " << price << " pesos" << endl;
        cout << "Discount (20%): " << discount << " pesos" << endl;
        cout << "Final Price: " << finalPrice << " pesos" << endl;
    }
    
    return 0;
}
```

**Sample Output:**
```
Enter your age: 65
Are you a PWD? (1 for Yes, 0 for No): 0

Original Price: 100 pesos
Discount (20%): 20 pesos
Final Price: 80 pesos
```

## The if-else Statement

The `if-else` statement provides an alternative path when the condition is false.

### Syntax

```cpp
if (condition) {
    // code if condition is true
} else {
    // code if condition is false
}
```

### Flow Diagram

```
    Condition?
       / \
     Yes  No
      |    |
   Code A  Code B
       \  /
        v
    Continue
```

### Example: Passing or Failing

```cpp
#include <iostream>
using namespace std;

int main() {
    double grade;
    
    cout << "Enter your grade: ";
    cin >> grade;
    
    if (grade >= 75.0) {
        cout << "Congratulations! You passed!" << endl;
    } else {
        cout << "Sorry, you failed. Better luck next time." << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: 80
Output: Congratulations! You passed!

Input: 70
Output: Sorry, you failed. Better luck next time.
```

### Example: Even or Odd Number

```cpp
#include <iostream>
using namespace std;

int main() {
    int number;
    
    cout << "Enter a number: ";
    cin >> number;
    
    if (number % 2 == 0) {
        cout << number << " is an even number." << endl;
    } else {
        cout << number << " is an odd number." << endl;
    }
    
    return 0;
}
```

## The else-if Ladder

When you have multiple conditions to check, use the `else-if` ladder.

### Syntax

```cpp
if (condition1) {
    // code if condition1 is true
} else if (condition2) {
    // code if condition2 is true
} else if (condition3) {
    // code if condition3 is true
} else {
    // code if all conditions are false
}
```

### Flow Diagram

```
Condition1?
   / \
 Yes  No
  |    |
Code1  Condition2?
  |       / \
  |     Yes  No
  |      |    |
  |    Code2  Condition3?
  |      |       / \
  |      |     Yes  No
  |      |      |    |
  |      |    Code3  Code4
   \     |      |    /
    \    |      |   /
     \   |      |  /
      \  |      | /
       v v      v v
       Continue
```

### Example: Philippine Grading System

```cpp
#include <iostream>
using namespace std;

int main() {
    double grade;
    
    cout << "Enter your numerical grade: ";
    cin >> grade;
    
    cout << "Letter Grade: ";
    
    if (grade >= 97.5) {
        cout << "1.00 (Excellent!)" << endl;
    } else if (grade >= 94.5) {
        cout << "1.25 (Very Good)" << endl;
    } else if (grade >= 91.5) {
        cout << "1.50 (Very Good)" << endl;
    } else if (grade >= 88.5) {
        cout << "1.75 (Good)" << endl;
    } else if (grade >= 85.5) {
        cout << "2.00 (Good)" << endl;
    } else if (grade >= 82.5) {
        cout << "2.25 (Satisfactory)" << endl;
    } else if (grade >= 79.5) {
        cout << "2.50 (Satisfactory)" << endl;
    } else if (grade >= 76.5) {
        cout << "2.75 (Fair)" << endl;
    } else if (grade >= 75.0) {
        cout << "3.00 (Passing)" << endl;
    } else {
        cout << "5.00 (Failed)" << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: 98
Output: Letter Grade: 1.00 (Excellent!)

Input: 85
Output: Letter Grade: 1.75 (Good)

Input: 74
Output: Letter Grade: 5.00 (Failed)
```

### Example: Taxi Fare Calculator

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance;
    double fare;
    
    cout << "Enter distance traveled (in km): ";
    cin >> distance;
    
    // Base fare: 40 pesos for first 5 km
    // Additional: 13.50 per km after 5 km
    
    if (distance <= 0) {
        cout << "Invalid distance!" << endl;
    } else if (distance <= 5.0) {
        fare = 40.0;
    } else {
        fare = 40.0 + ((distance - 5.0) * 13.50);
    }
    
    if (distance > 0) {
        cout << fixed << setprecision(2);
        cout << "Total Fare: " << fare << " pesos" << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: 3
Output: Total Fare: 40.00 pesos

Input: 10
Output: Total Fare: 107.50 pesos
```

## Nested if Statements

You can place `if` statements inside other `if` statements. This is called nesting.

### Syntax

```cpp
if (condition1) {
    if (condition2) {
        // code if both condition1 and condition2 are true
    }
}
```

### Example: Scholarship Eligibility

```cpp
#include <iostream>
using namespace std;

int main() {
    double gpa;
    int familyIncome;
    
    cout << "Enter your GPA (1.00 - 5.00): ";
    cin >> gpa;
    cout << "Enter family monthly income (in pesos): ";
    cin >> familyIncome;
    
    if (gpa <= 1.75) {
        cout << "\nYou meet the academic requirement!" << endl;
        
        if (familyIncome <= 20000) {
            cout << "You qualify for FULL SCHOLARSHIP!" << endl;
            cout << "Coverage: Tuition + Books + Allowance" << endl;
        } else if (familyIncome <= 40000) {
            cout << "You qualify for PARTIAL SCHOLARSHIP!" << endl;
            cout << "Coverage: 50% Tuition" << endl;
        } else {
            cout << "You qualify for ACADEMIC SCHOLARSHIP!" << endl;
            cout << "Coverage: 25% Tuition" << endl;
        }
    } else {
        cout << "\nSorry, you don't meet the academic requirement." << endl;
        cout << "Required GPA: 1.75 or better" << endl;
        cout << "Your GPA: " << gpa << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: GPA = 1.50, Income = 15000
Output: 
You meet the academic requirement!
You qualify for FULL SCHOLARSHIP!
Coverage: Tuition + Books + Allowance

Input: GPA = 2.00, Income = 10000
Output:
Sorry, you don't meet the academic requirement.
Required GPA: 1.75 or better
Your GPA: 2.00
```

### Example: Movie Ticket Pricing

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isWeekend;
    double price;
    
    cout << "Enter your age: ";
    cin >> age;
    cout << "Is it weekend? (1 for Yes, 0 for No): ";
    cin >> isWeekend;
    
    if (age < 3) {
        price = 0;
        cout << "Free admission for toddlers!" << endl;
    } else {
        if (isWeekend) {
            // Weekend pricing
            if (age < 18) {
                price = 200;
            } else if (age >= 60) {
                price = 180;
            } else {
                price = 250;
            }
        } else {
            // Weekday pricing
            if (age < 18) {
                price = 150;
            } else if (age >= 60) {
                price = 130;
            } else {
                price = 200;
            }
        }
        
        cout << "Ticket Price: " << price << " pesos" << endl;
    }
    
    return 0;
}
```

## The Ternary Operator (Conditional Operator)

The ternary operator is a shorthand way of writing simple `if-else` statements.

### Syntax

```cpp
condition ? value_if_true : value_if_false;
```

### Example: Simple Comparison

```cpp
#include <iostream>
using namespace std;

int main() {
    int a = 10, b = 20;
    
    // Using if-else
    int max1;
    if (a > b) {
        max1 = a;
    } else {
        max1 = b;
    }
    
    // Using ternary operator (much shorter!)
    int max2 = (a > b) ? a : b;
    
    cout << "Maximum value: " << max2 << endl;
    
    return 0;
}
```

**Output:**
```
Maximum value: 20
```

### Example: GCash Transaction Status

```cpp
#include <iostream>
using namespace std;

int main() {
    double balance = 500.0;
    double amount;
    
    cout << "Current Balance: " << balance << " pesos" << endl;
    cout << "Enter amount to send: ";
    cin >> amount;
    
    string status = (amount <= balance) ? "Success" : "Insufficient Funds";
    
    cout << "Transaction Status: " << status << endl;
    
    if (amount <= balance) {
        balance -= amount;
        cout << "New Balance: " << balance << " pesos" << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: 300
Output:
Current Balance: 500 pesos
Enter amount to send: 300
Transaction Status: Success
New Balance: 200 pesos

Input: 600
Output:
Current Balance: 500 pesos
Enter amount to send: 600
Transaction Status: Insufficient Funds
```

### When to Use Ternary Operator

**Good Use Cases:**
- Simple assignments based on a condition
- Return values based on a condition
- Short, clear conditions

**Avoid Using For:**
- Complex conditions
- Multiple statements
- Nested ternary operators (hard to read)

```cpp
// Good - Clear and simple
int age = 20;
string status = (age >= 18) ? "Adult" : "Minor";

// Bad - Too complex, hard to read
string category = (age < 13) ? "Child" : (age < 18) ? "Teen" : (age < 60) ? "Adult" : "Senior";

// Better - Use if-else for complex conditions
string category;
if (age < 13) {
    category = "Child";
} else if (age < 18) {
    category = "Teen";
} else if (age < 60) {
    category = "Adult";
} else {
    category = "Senior";
}
```

## The switch Statement

The `switch` statement is useful when you have multiple possible values for a single variable and want to execute different code for each value.

### Syntax

```cpp
switch (expression) {
    case value1:
        // code for value1
        break;
    case value2:
        // code for value2
        break;
    case value3:
        // code for value3
        break;
    default:
        // code if no case matches
}
```

### Important Notes About switch

1. **Expression must be an integer or character type** (int, char, enum)
2. **Each case must be a constant value** (not a variable or expression)
3. **break statement** is crucial - without it, execution "falls through" to the next case
4. **default case** is optional but recommended

### Example: Menu System

```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    
    cout << "=== Sari-Sari Store Menu ===" << endl;
    cout << "1. Rice" << endl;
    cout << "2. Noodles" << endl;
    cout << "3. Canned Goods" << endl;
    cout << "4. Snacks" << endl;
    cout << "5. Exit" << endl;
    cout << "Enter your choice: ";
    cin >> choice;
    
    switch (choice) {
        case 1:
            cout << "Rice section - 50 pesos per kilo" << endl;
            break;
        case 2:
            cout << "Noodles section - Lucky Me, Payless, Pancit Canton" << endl;
            break;
        case 3:
            cout << "Canned Goods - Sardines, Corned Beef, Tuna" << endl;
            break;
        case 4:
            cout << "Snacks - Chippy, Piattos, Cloud 9" << endl;
            break;
        case 5:
            cout << "Thank you for shopping! Balik kayo!" << endl;
            break;
        default:
            cout << "Invalid choice! Please select 1-5." << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: 2
Output: Noodles section - Lucky Me, Payless, Pancit Canton

Input: 7
Output: Invalid choice! Please select 1-5.
```

### Example: Day of the Week

```cpp
#include <iostream>
using namespace std;

int main() {
    int day;
    
    cout << "Enter day number (1-7): ";
    cin >> day;
    
    switch (day) {
        case 1:
            cout << "Monday - Simula ng week, kaya mo yan!" << endl;
            break;
        case 2:
            cout << "Tuesday - Keep going!" << endl;
            break;
        case 3:
            cout << "Wednesday - Hump day!" << endl;
            break;
        case 4:
            cout << "Thursday - Almost there!" << endl;
            break;
        case 5:
            cout << "Friday - TGIF!" << endl;
            break;
        case 6:
            cout << "Saturday - Weekend na!" << endl;
            break;
        case 7:
            cout << "Sunday - Rest day!" << endl;
            break;
        default:
            cout << "Invalid day! Enter 1-7 only." << endl;
    }
    
    return 0;
}
```

### Fall-Through Behavior

Sometimes you want multiple cases to execute the same code. You can use fall-through (intentionally omit `break`):

```cpp
#include <iostream>
using namespace std;

int main() {
    int month;
    
    cout << "Enter month number (1-12): ";
    cin >> month;
    
    switch (month) {
        case 12:
        case 1:
        case 2:
            cout << "Cool Season (Amihan)" << endl;
            break;
        case 3:
        case 4:
        case 5:
            cout << "Hot Dry Season (Tag-init)" << endl;
            break;
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
            cout << "Rainy Season (Tag-ulan)" << endl;
            break;
        default:
            cout << "Invalid month!" << endl;
    }
    
    return 0;
}
```

**Sample Outputs:**
```
Input: 7
Output: Rainy Season (Tag-ulan)

Input: 12
Output: Cool Season (Amihan)
```

### Example: Grade Letter to Description

```cpp
#include <iostream>
using namespace std;

int main() {
    char grade;
    
    cout << "Enter your letter grade (A, B, C, D, F): ";
    cin >> grade;
    
    // Convert to uppercase in case user enters lowercase
    if (grade >= 'a' && grade <= 'z') {
        grade = grade - 32; // Convert to uppercase
    }
    
    switch (grade) {
        case 'A':
            cout << "Excellent! Outstanding performance!" << endl;
            cout << "Grade Points: 4.0" << endl;
            break;
        case 'B':
            cout << "Very Good! Above average work!" << endl;
            cout << "Grade Points: 3.0" << endl;
            break;
        case 'C':
            cout << "Good! Satisfactory work!" << endl;
            cout << "Grade Points: 2.0" << endl;
            break;
        case 'D':
            cout << "Passed, but needs improvement." << endl;
            cout << "Grade Points: 1.0" << endl;
            break;
        case 'F':
            cout << "Failed. You need to retake this subject." << endl;
            cout << "Grade Points: 0.0" << endl;
            break;
        default:
            cout << "Invalid grade! Use A, B, C, D, or F." << endl;
    }
    
    return 0;
}
```

## When to Use Which?

Choosing the right control structure is important for writing clear, maintainable code.

### Use if Statement When:
- You have a single condition to check
- The condition is complex (uses multiple logical operators)
- You're checking ranges of values

```cpp
if (age >= 18 && age <= 65 && hasValidID) {
    // Complex condition
}
```

### Use if-else When:
- You have two possible paths (binary decision)
- One condition, two outcomes

```cpp
if (grade >= 75) {
    cout << "Passed" << endl;
} else {
    cout << "Failed" << endl;
}
```

### Use else-if Ladder When:
- You have multiple conditions to check in sequence
- Conditions are mutually exclusive
- Checking ranges of values

```cpp
if (score >= 90) {
    grade = 'A';
} else if (score >= 80) {
    grade = 'B';
} else if (score >= 70) {
    grade = 'C';
}
```

### Use Ternary Operator When:
- You have a simple if-else for assignment
- The expression is short and readable
- You want concise code

```cpp
int max = (a > b) ? a : b;
```

### Use switch Statement When:
- You're comparing one variable against multiple constant values
- You have many discrete cases (more than 3-4)
- The variable is an integer or character
- Cases are simple and don't need complex conditions

```cpp
switch (dayOfWeek) {
    case 1: cout << "Monday"; break;
    case 2: cout << "Tuesday"; break;
    // etc.
}
```

### Comparison Table

| Structure | Best For | Example Use Case |
|-----------|----------|------------------|
| `if` | Single condition | Check if age >= 18 |
| `if-else` | Binary choice | Pass or fail |
| `else-if` | Multiple ranges | Grade brackets |
| Ternary | Simple assignment | max = (a > b) ? a : b |
| `switch` | Multiple discrete values | Menu selection |

## Practical Examples

### Example 1: Philippine Income Tax Calculator

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double annualIncome, tax;
    
    cout << "=== Philippine Income Tax Calculator ===" << endl;
    cout << "Enter annual income (in pesos): ";
    cin >> annualIncome;
    
    if (annualIncome <= 250000) {
        tax = 0;
        cout << "\nYou are EXEMPT from income tax!" << endl;
    } else if (annualIncome <= 400000) {
        tax = (annualIncome - 250000) * 0.15;
    } else if (annualIncome <= 800000) {
        tax = 22500 + (annualIncome - 400000) * 0.20;
    } else if (annualIncome <= 2000000) {
        tax = 102500 + (annualIncome - 800000) * 0.25;
    } else if (annualIncome <= 8000000) {
        tax = 402500 + (annualIncome - 2000000) * 0.30;
    } else {
        tax = 2202500 + (annualIncome - 8000000) * 0.35;
    }
    
    cout << fixed << setprecision(2);
    cout << "\nAnnual Income: " << annualIncome << " pesos" << endl;
    cout << "Income Tax: " << tax << " pesos" << endl;
    cout << "Net Income: " << (annualIncome - tax) << " pesos" << endl;
    
    return 0;
}
```

### Example 2: Voting Eligibility Checker

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isFilipino, isRegistered;
    
    cout << "=== Philippine Voting Eligibility Checker ===" << endl;
    cout << "Enter your age: ";
    cin >> age;
    cout << "Are you a Filipino citizen? (1-Yes, 0-No): ";
    cin >> isFilipino;
    cout << "Are you registered as a voter? (1-Yes, 0-No): ";
    cin >> isRegistered;
    
    cout << "\n--- Results ---" << endl;
    
    if (!isFilipino) {
        cout << "Sorry, you must be a Filipino citizen to vote." << endl;
    } else if (age < 18) {
        cout << "You are too young to vote." << endl;
        cout << "You can register when you turn 18." << endl;
    } else if (!isRegistered) {
        cout << "You are eligible to vote but NOT YET REGISTERED!" << endl;
        cout << "Please register at your local COMELEC office." << endl;
    } else {
        cout << "Congratulations! You are eligible to vote!" << endl;
        cout << "Make your voice heard in the next elections!" << endl;
    }
    
    return 0;
}
```

### Example 3: Jeepney Fare Calculator with Discounts

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance, fare;
    int age;
    bool isPWD, isStudent;
    
    cout << "=== Jeepney Fare Calculator ===" << endl;
    cout << "Enter distance (km): ";
    cin >> distance;
    cout << "Enter your age: ";
    cin >> age;
    cout << "Are you PWD? (1-Yes, 0-No): ";
    cin >> isPWD;
    cout << "Are you a student? (1-Yes, 0-No): ";
    cin >> isStudent;
    
    // Base fare calculation
    if (distance <= 4) {
        fare = 12.0;
    } else {
        fare = 12.0 + ((distance - 4) * 1.80);
    }
    
    // Apply discounts
    double discount = 0;
    string discountType = "None";
    
    if (isPWD || age >= 60) {
        discount = fare * 0.20; // 20% discount for PWD/Senior
        discountType = (isPWD) ? "PWD" : "Senior Citizen";
    } else if (isStudent && age >= 5 && age <= 17) {
        discount = fare * 0.10; // 10% discount for students
        discountType = "Student";
    }
    
    double finalFare = fare - discount;
    
    cout << fixed << setprecision(2);
    cout << "\n--- Fare Details ---" << endl;
    cout << "Distance: " << distance << " km" << endl;
    cout << "Regular Fare: " << fare << " pesos" << endl;
    cout << "Discount Type: " << discountType << endl;
    cout << "Discount Amount: " << discount << " pesos" << endl;
    cout << "Final Fare: " << finalFare << " pesos" << endl;
    
    return 0;
}
```

### Example 4: Restaurant Order System

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    int mainChoice, drinkChoice, addOns;
    double total = 0;
    
    cout << "=== Tindahan ni Aling Nena ===" << endl;
    cout << "\n--- Main Dish ---" << endl;
    cout << "1. Adobo - 80 pesos" << endl;
    cout << "2. Sinigang - 90 pesos" << endl;
    cout << "3. Lechon Kawali - 100 pesos" << endl;
    cout << "4. Bicol Express - 85 pesos" << endl;
    cout << "Enter choice: ";
    cin >> mainChoice;
    
    switch (mainChoice) {
        case 1:
            cout << "You ordered: Adobo" << endl;
            total += 80;
            break;
        case 2:
            cout << "You ordered: Sinigang" << endl;
            total += 90;
            break;
        case 3:
            cout << "You ordered: Lechon Kawali" << endl;
            total += 100;
            break;
        case 4:
            cout << "You ordered: Bicol Express" << endl;
            total += 85;
            break;
        default:
            cout << "Invalid choice! No main dish selected." << endl;
            return 1;
    }
    
    cout << "\n--- Drinks ---" << endl;
    cout << "1. Coke - 25 pesos" << endl;
    cout << "2. Pineapple Juice - 30 pesos" << endl;
    cout << "3. Iced Tea - 20 pesos" << endl;
    cout << "4. No drink - 0 pesos" << endl;
    cout << "Enter choice: ";
    cin >> drinkChoice;
    
    switch (drinkChoice) {
        case 1:
            cout << "You ordered: Coke" << endl;
            total += 25;
            break;
        case 2:
            cout << "You ordered: Pineapple Juice" << endl;
            total += 30;
            break;
        case 3:
            cout << "You ordered: Iced Tea" << endl;
            total += 20;
            break;
        case 4:
            cout << "No drink selected." << endl;
            break;
        default:
            cout << "Invalid choice! No drink selected." << endl;
    }
    
    cout << "\n--- Add Extra Rice? ---" << endl;
    cout << "1. Yes (+15 pesos)" << endl;
    cout << "2. No" << endl;
    cout << "Enter choice: ";
    cin >> addOns;
    
    if (addOns == 1) {
        cout << "Extra rice added!" << endl;
        total += 15;
    }
    
    cout << fixed << setprecision(2);
    cout << "\n=== ORDER SUMMARY ===" << endl;
    cout << "Total Amount: " << total << " pesos" << endl;
    cout << "Salamat sa pag-order!" << endl;
    
    return 0;
}
```

## Programming Exercises

### Exercise 1: Number Classifier
Write a program that asks the user for a number and classifies it as:
- Positive, Negative, or Zero
- Even or Odd (if not zero)
- Divisible by 5 or not

**Sample Output:**
```
Enter a number: 10
10 is Positive
10 is Even
10 is divisible by 5
```

### Exercise 2: BMI Calculator
Create a BMI (Body Mass Index) calculator that:
- Gets weight in kg and height in meters
- Calculates BMI = weight / (height * height)
- Classifies the result:
  - Underweight: BMI < 18.5
  - Normal: 18.5 <= BMI < 25
  - Overweight: 25 <= BMI < 30
  - Obese: BMI >= 30

### Exercise 3: Simple Calculator with Menu
Create a calculator program with a menu:
```
1. Addition
2. Subtraction
3. Multiplication
4. Division
5. Exit
```
Use a switch statement and handle division by zero.

### Exercise 4: Electricity Bill Calculator
Create a program that calculates electricity bills based on Meralco's structure:
- 0-100 kWh: 10.50 per kWh
- 101-200 kWh: 11.00 per kWh
- 201-300 kWh: 12.00 per kWh
- Above 300 kWh: 13.50 per kWh

Also add a 5% system loss charge and 12% VAT.

### Exercise 5: Zodiac Sign Finder
Ask for birth month and day, then determine the zodiac sign:
- Aries: Mar 21 - Apr 19
- Taurus: Apr 20 - May 20
- Gemini: May 21 - Jun 20
- Cancer: Jun 21 - Jul 22
- Leo: Jul 23 - Aug 22
- Virgo: Aug 23 - Sep 22
- Libra: Sep 23 - Oct 22
- Scorpio: Oct 23 - Nov 21
- Sagittarius: Nov 22 - Dec 21
- Capricorn: Dec 22 - Jan 19
- Aquarius: Jan 20 - Feb 18
- Pisces: Feb 19 - Mar 20

## Solutions to Exercises

### Solution 1: Number Classifier

```cpp
#include <iostream>
using namespace std;

int main() {
    int number;
    
    cout << "Enter a number: ";
    cin >> number;
    
    // Check positive, negative, or zero
    if (number > 0) {
        cout << number << " is Positive" << endl;
    } else if (number < 0) {
        cout << number << " is Negative" << endl;
    } else {
        cout << number << " is Zero" << endl;
    }
    
    // Check even or odd (only if not zero)
    if (number != 0) {
        if (number % 2 == 0) {
            cout << number << " is Even" << endl;
        } else {
            cout << number << " is Odd" << endl;
        }
        
        // Check divisibility by 5
        if (number % 5 == 0) {
            cout << number << " is divisible by 5" << endl;
        } else {
            cout << number << " is NOT divisible by 5" << endl;
        }
    }
    
    return 0;
}
```

### Solution 2: BMI Calculator

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double weight, height, bmi;
    
    cout << "=== BMI Calculator ===" << endl;
    cout << "Enter weight (in kg): ";
    cin >> weight;
    cout << "Enter height (in meters): ";
    cin >> height;
    
    // Validate input
    if (weight <= 0 || height <= 0) {
        cout << "Invalid input! Weight and height must be positive." << endl;
        return 1;
    }
    
    // Calculate BMI
    bmi = weight / (height * height);
    
    cout << fixed << setprecision(2);
    cout << "\nYour BMI: " << bmi << endl;
    cout << "Classification: ";
    
    if (bmi < 18.5) {
        cout << "Underweight" << endl;
        cout << "Recommendation: Increase calorie intake and consult a nutritionist." << endl;
    } else if (bmi < 25) {
        cout << "Normal" << endl;
        cout << "Recommendation: Maintain your healthy lifestyle!" << endl;
    } else if (bmi < 30) {
        cout << "Overweight" << endl;
        cout << "Recommendation: Increase physical activity and watch your diet." << endl;
    } else {
        cout << "Obese" << endl;
        cout << "Recommendation: Consult a doctor and start a weight loss program." << endl;
    }
    
    return 0;
}
```

### Solution 3: Simple Calculator with Menu

```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    double num1, num2, result;
    
    cout << "=== Simple Calculator ===" << endl;
    cout << "1. Addition" << endl;
    cout << "2. Subtraction" << endl;
    cout << "3. Multiplication" << endl;
    cout << "4. Division" << endl;
    cout << "5. Exit" << endl;
    cout << "Enter your choice: ";
    cin >> choice;
    
    if (choice >= 1 && choice <= 4) {
        cout << "Enter first number: ";
        cin >> num1;
        cout << "Enter second number: ";
        cin >> num2;
    }
    
    switch (choice) {
        case 1:
            result = num1 + num2;
            cout << num1 << " + " << num2 << " = " << result << endl;
            break;
        case 2:
            result = num1 - num2;
            cout << num1 << " - " << num2 << " = " << result << endl;
            break;
        case 3:
            result = num1 * num2;
            cout << num1 << " * " << num2 << " = " << result << endl;
            break;
        case 4:
            if (num2 == 0) {
                cout << "Error! Division by zero is not allowed." << endl;
            } else {
                result = num1 / num2;
                cout << num1 << " / " << num2 << " = " << result << endl;
            }
            break;
        case 5:
            cout << "Thank you for using the calculator!" << endl;
            break;
        default:
            cout << "Invalid choice! Please select 1-5." << endl;
    }
    
    return 0;
}
```

### Solution 4: Electricity Bill Calculator

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double kwh, charge = 0, systemLoss, vat, totalBill;
    
    cout << "=== Meralco Bill Calculator ===" << endl;
    cout << "Enter kWh consumed: ";
    cin >> kwh;
    
    if (kwh < 0) {
        cout << "Invalid input! kWh cannot be negative." << endl;
        return 1;
    }
    
    // Calculate base charge
    if (kwh <= 100) {
        charge = kwh * 10.50;
    } else if (kwh <= 200) {
        charge = (100 * 10.50) + ((kwh - 100) * 11.00);
    } else if (kwh <= 300) {
        charge = (100 * 10.50) + (100 * 11.00) + ((kwh - 200) * 12.00);
    } else {
        charge = (100 * 10.50) + (100 * 11.00) + (100 * 12.00) + ((kwh - 300) * 13.50);
    }
    
    // Calculate additional charges
    systemLoss = charge * 0.05;  // 5% system loss
    vat = (charge + systemLoss) * 0.12;  // 12% VAT
    totalBill = charge + systemLoss + vat;
    
    cout << fixed << setprecision(2);
    cout << "\n=== BILLING SUMMARY ===" << endl;
    cout << "kWh Consumed: " << kwh << endl;
    cout << "Generation Charge: " << charge << " pesos" << endl;
    cout << "System Loss Charge (5%): " << systemLoss << " pesos" << endl;
    cout << "VAT (12%): " << vat << " pesos" << endl;
    cout << "--------------------------------" << endl;
    cout << "TOTAL AMOUNT DUE: " << totalBill << " pesos" << endl;
    
    return 0;
}
```

### Solution 5: Zodiac Sign Finder

```cpp
#include <iostream>
using namespace std;

int main() {
    int month, day;
    string zodiacSign;
    bool validDate = true;
    
    cout << "=== Zodiac Sign Finder ===" << endl;
    cout << "Enter birth month (1-12): ";
    cin >> month;
    cout << "Enter birth day: ";
    cin >> day;
    
    // Validate and determine zodiac sign
    if (month == 1) {
        if (day >= 1 && day <= 19) {
            zodiacSign = "Capricorn";
        } else if (day >= 20 && day <= 31) {
            zodiacSign = "Aquarius";
        } else {
            validDate = false;
        }
    } else if (month == 2) {
        if (day >= 1 && day <= 18) {
            zodiacSign = "Aquarius";
        } else if (day >= 19 && day <= 29) {
            zodiacSign = "Pisces";
        } else {
            validDate = false;
        }
    } else if (month == 3) {
        if (day >= 1 && day <= 20) {
            zodiacSign = "Pisces";
        } else if (day >= 21 && day <= 31) {
            zodiacSign = "Aries";
        } else {
            validDate = false;
        }
    } else if (month == 4) {
        if (day >= 1 && day <= 19) {
            zodiacSign = "Aries";
        } else if (day >= 20 && day <= 30) {
            zodiacSign = "Taurus";
        } else {
            validDate = false;
        }
    } else if (month == 5) {
        if (day >= 1 && day <= 20) {
            zodiacSign = "Taurus";
        } else if (day >= 21 && day <= 31) {
            zodiacSign = "Gemini";
        } else {
            validDate = false;
        }
    } else if (month == 6) {
        if (day >= 1 && day <= 20) {
            zodiacSign = "Gemini";
        } else if (day >= 21 && day <= 30) {
            zodiacSign = "Cancer";
        } else {
            validDate = false;
        }
    } else if (month == 7) {
        if (day >= 1 && day <= 22) {
            zodiacSign = "Cancer";
        } else if (day >= 23 && day <= 31) {
            zodiacSign = "Leo";
        } else {
            validDate = false;
        }
    } else if (month == 8) {
        if (day >= 1 && day <= 22) {
            zodiacSign = "Leo";
        } else if (day >= 23 && day <= 31) {
            zodiacSign = "Virgo";
        } else {
            validDate = false;
        }
    } else if (month == 9) {
        if (day >= 1 && day <= 22) {
            zodiacSign = "Virgo";
        } else if (day >= 23 && day <= 30) {
            zodiacSign = "Libra";
        } else {
            validDate = false;
        }
    } else if (month == 10) {
        if (day >= 1 && day <= 22) {
            zodiacSign = "Libra";
        } else if (day >= 23 && day <= 31) {
            zodiacSign = "Scorpio";
        } else {
            validDate = false;
        }
    } else if (month == 11) {
        if (day >= 1 && day <= 21) {
            zodiacSign = "Scorpio";
        } else if (day >= 22 && day <= 30) {
            zodiacSign = "Sagittarius";
        } else {
            validDate = false;
        }
    } else if (month == 12) {
        if (day >= 1 && day <= 21) {
            zodiacSign = "Sagittarius";
        } else if (day >= 22 && day <= 31) {
            zodiacSign = "Capricorn";
        } else {
            validDate = false;
        }
    } else {
        validDate = false;
    }
    
    if (validDate) {
        cout << "\nYour Zodiac Sign: " << zodiacSign << endl;
    } else {
        cout << "\nInvalid date! Please check your input." << endl;
    }
    
    return 0;
}
```

## Common Mistakes to Avoid

### Mistake 1: Using = Instead of ==

```cpp
// WRONG - Assignment, not comparison
if (x = 5) {  // This assigns 5 to x, always true!
    cout << "x is 5" << endl;
}

// CORRECT - Comparison
if (x == 5) {  // This checks if x equals 5
    cout << "x is 5" << endl;
}
```

### Mistake 2: Missing Braces

```cpp
// WRONG - Only the first statement is in the if block
if (age >= 18)
    cout << "You can vote!" << endl;
    cout << "You are an adult!" << endl;  // Always executes!

// CORRECT - Use braces
if (age >= 18) {
    cout << "You can vote!" << endl;
    cout << "You are an adult!" << endl;
}
```

### Mistake 3: Semicolon After if

```cpp
// WRONG - Semicolon creates empty statement
if (score >= 75);  // Empty if statement!
{
    cout << "You passed!" << endl;  // Always executes!
}

// CORRECT - No semicolon
if (score >= 75) {
    cout << "You passed!" << endl;
}
```

### Mistake 4: Incorrect Logical Operators

```cpp
// WRONG - Can't chain comparisons like math
if (10 < x < 20) {  // This doesn't work as expected!
    cout << "x is between 10 and 20" << endl;
}

// CORRECT - Use logical operators
if (x > 10 && x < 20) {
    cout << "x is between 10 and 20" << endl;
}
```

### Mistake 5: Confusing && and ||

```cpp
// WRONG - This will never be true
if (age < 18 && age > 60) {
    cout << "Discount!" << endl;
}

// CORRECT - Use OR for either condition
if (age < 18 || age > 60) {
    cout << "Discount!" << endl;
}
```

### Mistake 6: Missing break in switch

```cpp
// WRONG - Fall-through without intention
switch (choice) {
    case 1:
        cout << "One" << endl;  // Missing break!
    case 2:
        cout << "Two" << endl;  // This will also execute if choice is 1!
        break;
}

// CORRECT - Add break statements
switch (choice) {
    case 1:
        cout << "One" << endl;
        break;
    case 2:
        cout << "Two" << endl;
        break;
}
```

### Mistake 7: Floating-Point Comparison

```cpp
// WRONG - Comparing floating-point for exact equality
double result = 0.1 + 0.2;
if (result == 0.3) {  // Might fail due to precision!
    cout << "Equal!" << endl;
}

// CORRECT - Use a small tolerance
double epsilon = 0.0001;
if (abs(result - 0.3) < epsilon) {
    cout << "Approximately equal!" << endl;
}
```

### Mistake 8: Overlapping Conditions

```cpp
// WRONG - First condition catches everything
if (grade >= 75) {
    cout << "Passed" << endl;
} else if (grade >= 90) {  // This will never execute!
    cout << "Excellent!" << endl;
}

// CORRECT - Order conditions from specific to general
if (grade >= 90) {
    cout << "Excellent!" << endl;
} else if (grade >= 75) {
    cout << "Passed" << endl;
}
```

## Summary

"So that's control flow!" Kuya Miguel concluded, closing his laptop. "You've learned how to make your programs make decisions."

Tian nodded enthusiastically. "This is powerful! Now I can make my calculator check for division by zero, create a grading system, even make a simple game!"

"Exactly! Let's review what you learned today:"

### Key Takeaways

1. **Control Flow** allows programs to make decisions and branch into different paths
2. **if statement** executes code only when a condition is true
3. **if-else** provides an alternative path when the condition is false
4. **else-if ladder** checks multiple conditions in sequence
5. **Nested if** allows complex decision-making with conditions inside conditions
6. **Ternary operator** is shorthand for simple if-else assignments
7. **switch statement** is best for multiple discrete values of a single variable
8. Always use `==` for comparison, not `=` (assignment)
9. Remember to use `break` in switch statements (unless you want fall-through)
10. Choose the right structure based on your specific needs

### Practice Makes Perfect

"Now go practice!" Kuya Miguel encouraged. "Try making:
- A grade calculator for all your subjects
- A simple ATM menu system
- A discount calculator for your family's sari-sari store
- A voting eligibility checker

The more you practice, the better you'll get at choosing the right control structure for each situation."

### Next Lesson Preview

"Next time," Kuya Miguel said with a smile, "we'll learn about **loops** - how to make your program repeat actions without writing the same code over and over again. Imagine printing all numbers from 1 to 1000 without typing 1000 cout statements!"

Tian's eyes widened. "That sounds amazing! I can't wait!"

"For now, practice what you learned. Make sure you understand how conditions work because loops use them too. See you next time!"

---

## Closing Story

Tian spent the next hour building a complete grading system with if-else statements, then created an ATM menu using switch. "Kuya, this is incredible! My programs can finally think!"

Kuya Miguel laughed. "Well, not exactly think - but they can make logical decisions based on conditions. That's the power of control flow."

"I see why you said this is important," Tian said. "Without conditions, my calculator would divide by zero and crash. Without if-else, my grade calculator couldn't tell pass from fail. Without switch, my menu system would be a mess of if-else chains."

"Exactly! You've mastered the art of decision-making in code. But there's one more crucial skill - what if you need to do something repeatedly? Like calculating grades for 50 students, or printing numbers from 1 to 100?"

Tian's eyes widened. "Don't tell me I have to write the same code 50 times?"

"Never! That's what loops are for - and that's our next lesson. Get ready to make your programs repeat actions efficiently!"

Tian saved his work, already imagining the possibilities.

---

## Quick Reference Card

```cpp
// if statement
if (condition) {
    // code
}

// if-else
if (condition) {
    // code if true
} else {
    // code if false
}

// else-if ladder
if (condition1) {
    // code
} else if (condition2) {
    // code
} else {
    // code
}

// Ternary operator
variable = (condition) ? value_if_true : value_if_false;

// switch statement
switch (variable) {
    case value1:
        // code
        break;
    case value2:
        // code
        break;
    default:
        // code
}

// Comparison operators
==  // equal to
!=  // not equal to
>   // greater than
<   // less than
>=  // greater than or equal to
<=  // less than or equal to

// Logical operators
&&  // AND (both must be true)
||  // OR (at least one must be true)
!   // NOT (reverses the condition)
```

---

**End of Lesson 5**

Keep practicing, and remember: Good programmers make good decisions - both in code and in life!
