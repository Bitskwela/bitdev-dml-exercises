# Lesson 8: Logical Operators and Compound Conditions

## Background Story

Tian was working on a barangay clearance system when he got stuck. "Kuya Miguel, I need to check if someone is both a resident AND has paid their dues. How do I check multiple conditions at once?"

Kuya Miguel nodded. "Great question! That's where **logical operators** come in. In real life, we often need to check multiple things: 'Is the person 18 years old OR older?' 'Does the applicant have ID AND proof of residence?' These are compound conditions."

## What Are Logical Operators?

**Logical operators** let you combine multiple conditions into one expression.

### The Three Main Logical Operators

| Operator | Name | Symbol | Meaning |
|----------|------|--------|---------|
| `&&` | AND | `&&` | Both conditions must be true |
| `||` | OR | `||` | At least one condition must be true |
| `!` | NOT | `!` | Reverses the condition |

---

## 1. AND Operator (`&&`)

**Both conditions must be true for the result to be true**

### Truth Table for AND

| Condition A | Condition B | A && B |
|-------------|-------------|--------|
| true | true | **true** |
| true | false | false |
| false | true | false |
| false | false | false |

### Example: Voter Eligibility

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isRegistered;
    
    cout << "Enter age: ";
    cin >> age;
    cout << "Registered voter? (1=Yes, 0=No): ";
    cin >> isRegistered;
    
    if (age >= 18 && isRegistered) {
        cout << "✓ Eligible to vote!" << endl;
    } else {
        cout << "✗ Not eligible to vote." << endl;
        
        if (age < 18) {
            cout << "Reason: Must be 18 or older" << endl;
        }
        if (!isRegistered) {
            cout << "Reason: Must be registered" << endl;
        }
    }
    
    return 0;
}
```

### Barangay Example: Clearance Requirements

```cpp
#include <iostream>
using namespace std;

int main() {
    bool hasID, hasPaidDues, noViolations;
    
    cout << "=== Barangay Clearance Checker ===" << endl;
    cout << "Has valid ID? (1/0): ";
    cin >> hasID;
    cout << "Paid monthly dues? (1/0): ";
    cin >> hasPaidDues;
    cout << "No violations? (1/0): ";
    cin >> noViolations;
    
    if (hasID && hasPaidDues && noViolations) {
        cout << "\n✓ CLEARANCE APPROVED!" << endl;
        cout << "All requirements met." << endl;
    } else {
        cout << "\n✗ CLEARANCE DENIED!" << endl;
        cout << "Missing requirements:" << endl;
        
        if (!hasID) cout << "- Valid ID" << endl;
        if (!hasPaidDues) cout << "- Payment of dues" << endl;
        if (!noViolations) cout << "- Clear violation record" << endl;
    }
    
    return 0;
}
```

---

## 2. OR Operator (`||`)

**At least ONE condition must be true for the result to be true**

### Truth Table for OR

| Condition A | Condition B | A || B |
|-------------|-------------|--------|
| true | true | **true** |
| true | false | **true** |
| false | true | **true** |
| false | false | false |

### Example: Emergency Contact

```cpp
#include <iostream>
using namespace std;

int main() {
    string relationship;
    
    cout << "Relationship to resident: ";
    cin >> relationship;
    
    if (relationship == "spouse" || relationship == "parent" || 
        relationship == "child" || relationship == "sibling") {
        cout << "✓ Authorized as emergency contact" << endl;
    } else {
        cout << "✗ Not authorized. Must be immediate family." << endl;
    }
    
    return 0;
}
```

### Barangay Example: Senior/PWD Discount

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isPWD;
    
    cout << "Enter age: ";
    cin >> age;
    cout << "Person with disability? (1/0): ";
    cin >> isPWD;
    
    if (age >= 60 || isPWD) {
        cout << "\n✓ DISCOUNT QUALIFIED!" << endl;
        cout << "20% discount applied" << endl;
        
        if (age >= 60) {
            cout << "Category: Senior Citizen" << endl;
        }
        if (isPWD) {
            cout << "Category: PWD" << endl;
        }
    } else {
        cout << "\n✗ Regular pricing applies" << endl;
    }
    
    return 0;
}
```

---

## 3. NOT Operator (`!`)

**Reverses a boolean value**

### Truth Table for NOT

| Condition A | !A |
|-------------|-----|
| true | **false** |
| false | **true** |

### Example: Access Restriction

```cpp
#include <iostream>
using namespace std;

int main() {
    bool isBanned;
    
    cout << "Is user banned? (1/0): ";
    cin >> isBanned;
    
    if (!isBanned) {
        cout << "✓ Access granted" << endl;
    } else {
        cout << "✗ Access denied - Account banned" << endl;
    }
    
    return 0;
}
```

### Barangay Example: Outstanding Balance Check

```cpp
#include <iostream>
using namespace std;

int main() {
    double balance;
    
    cout << "Enter outstanding balance: PHP ";
    cin >> balance;
    
    if (!(balance > 0)) {  // Same as: balance <= 0
        cout << "✓ No outstanding balance" << endl;
        cout << "Account is clear!" << endl;
    } else {
        cout << "✗ Outstanding balance: PHP " << balance << endl;
        cout << "Please settle to proceed." << endl;
    }
    
    return 0;
}
```

---

## 4. Combining Operators

You can combine multiple logical operators in complex conditions.

### Example: Loan Eligibility

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    double income;
    bool hasCollateral;
    
    cout << "=== Barangay Loan Application ===" << endl;
    cout << "Age: ";
    cin >> age;
    cout << "Monthly income (PHP): ";
    cin >> income;
    cout << "Has collateral? (1/0): ";
    cin >> hasCollateral;
    
    // Complex condition:
    // Must be 21-65 years old
    // AND (income >= 15000 OR has collateral)
    if ((age >= 21 && age <= 65) && (income >= 15000 || hasCollateral)) {
        cout << "\n✓ LOAN APPROVED!" << endl;
        cout << "Proceed to next step." << endl;
    } else {
        cout << "\n✗ LOAN DENIED" << endl;
        cout << "Reasons:" << endl;
        
        if (age < 21) {
            cout << "- Age must be 21 or older" << endl;
        }
        if (age > 65) {
            cout << "- Age must be 65 or younger" << endl;
        }
        if (income < 15000 && !hasCollateral) {
            cout << "- Need income ≥ PHP15,000 OR collateral" << endl;
        }
    }
    
    return 0;
}
```

### Operator Precedence

When combining operators, precedence matters:

1. **`!`** (NOT) - Highest precedence
2. **`&&`** (AND)
3. **`||`** (OR) - Lowest precedence

**Example:**
```cpp
bool a = true, b = false, c = true;

// Evaluated as: (!b) && c
bool result1 = !b && c;  // true && true = true

// Evaluated as: a && (b || c)
bool result2 = a && b || c;  // (true && false) || true = true

// Use parentheses for clarity
bool result3 = (a && b) || c;  // false || true = true
```

---

## 5. Short-Circuit Evaluation

C++ uses **short-circuit evaluation** - it stops checking as soon as the result is determined.

### For AND (`&&`):
If the first condition is false, don't check the rest (result is already false)

```cpp
int x = 5;

// Second condition won't execute if first is false
if (x > 10 && x < 20) {
    // x > 10 is false, so x < 20 is never checked
}
```

### For OR (`||`):
If the first condition is true, don't check the rest (result is already true)

```cpp
int age = 65;

// Second condition won't execute if first is true
if (age >= 60 || isPWD) {
    // age >= 60 is true, so isPWD is never checked
}
```

### Practical Use: Avoiding Errors

```cpp
#include <iostream>
using namespace std;

int main() {
    int numbers[] = {10, 20, 30};
    int index;
    
    cout << "Enter index (0-2): ";
    cin >> index;
    
    // Check bounds BEFORE accessing array
    if (index >= 0 && index < 3 && numbers[index] > 15) {
        cout << "Number at index " << index << " is greater than 15" << endl;
    }
    
    // If index is out of bounds, numbers[index] is never accessed!
    // This prevents crashes
    
    return 0;
}
```

---

## 6. DeMorgan's Laws

These rules help simplify complex conditions:

**Law 1:** `!(A && B)` is the same as `!A || !B`
**Law 2:** `!(A || B)` is the same as `!A && !B`

### Example:

```cpp
int age = 17;
bool hasPermit = false;

// These are equivalent:
if (!(age >= 18 && hasPermit)) {
    cout << "Cannot drive" << endl;
}

// Same as:
if (age < 18 || !hasPermit) {
    cout << "Cannot drive" << endl;
}
```

---

## 7. Practical Barangay System: Event Registration

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name;
    int age;
    bool isResident;
    bool hasPaidDues;
    
    cout << "=== Barangay Sports Fest Registration ===" << endl;
    cout << "Name: ";
    cin >> name;
    cout << "Age: ";
    cin >> age;
    cout << "Barangay resident? (1/0): ";
    cin >> isResident;
    cout << "Paid annual dues? (1/0): ";
    cin >> hasPaidDues;
    
    cout << "\n=== Registration Result ===" << endl;
    
    // Eligibility rules:
    // 1. Must be resident OR pay guest fee
    // 2. Age must be 7-60
    // 3. If resident, must have paid dues
    
    bool ageOK = (age >= 7 && age <= 60);
    bool residencyOK = isResident || !isResident;  // Guest allowed
    bool paymentOK = !isResident || hasPaidDues;   // Non-residents don't need dues
    
    if (ageOK && paymentOK) {
        cout << "✓ REGISTRATION APPROVED!" << endl;
        cout << "Participant: " << name << endl;
        cout << "Category: ";
        
        if (age < 18) {
            cout << "Youth Division" << endl;
        } else if (age <= 40) {
            cout << "Adult Division" << endl;
        } else {
            cout << "Senior Division" << endl;
        }
        
        if (!isResident) {
            cout << "Note: Guest fee PHP 200 applies" << endl;
        }
    } else {
        cout << "✗ REGISTRATION DENIED" << endl;
        
        if (!ageOK) {
            cout << "- Age must be between 7-60 years old" << endl;
        }
        if (!paymentOK) {
            cout << "- Residents must pay annual dues first" << endl;
        }
    }
    
    return 0;
}
```

---

## Common Mistakes to Avoid

### Mistake 1: Using `=` instead of `==`

```cpp
// ❌ WRONG - Assignment, not comparison
if (age = 18) {  // Assigns 18 to age!
    cout << "Adult";
}

// ✅ CORRECT
if (age == 18) {
    cout << "Adult";
}
```

### Mistake 2: Confusing AND with OR

```cpp
int age = 70;

// ❌ WRONG - Too strict (impossible condition)
if (age >= 60 && age >= 65) {  // Redundant
    cout << "Senior";
}

// ✅ CORRECT
if (age >= 60 || age >= 65) {  // At least one true
    cout << "Senior";
}
```

### Mistake 3: Extra Semicolon

```cpp
// ❌ WRONG - Semicolon ends the if statement
if (age >= 18);  // <- Empty if body
{
    cout << "Adult";  // Always executes
}

// ✅ CORRECT
if (age >= 18) {
    cout << "Adult";
}
```

---

## Key Takeaways

1. **`&&` (AND)** - All conditions must be true
2. **`||` (OR)** - At least one condition must be true
3. **`!` (NOT)** - Reverses the condition
4. **Short-circuit** - Evaluation stops when result is determined
5. **Parentheses** - Use them for clarity in complex conditions
6. **DeMorgan's Laws** - Help simplify negated conditions

---

## What's Next?

You've mastered combining conditions! Next lesson is a **Mini Project: ATM Simulator** where you'll use loops, conditions, and logical operators to build a complete working system.

**Kuya Miguel:** "You're ready to build something real, Tian! Let's put everything together in a practical project."

**Reading time:** ~10 minutes
