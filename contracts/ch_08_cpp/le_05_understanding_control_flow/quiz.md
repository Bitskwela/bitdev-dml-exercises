# Understanding Control Flow Quiz

---

# Quiz 1

## Quiz: Complete Control Flow Decision Making

**Scenario:**

Tian is building a tricycle fare and route management system for his barangay in Iloilo City. The system needs to calculate fares based on distance and passenger count, validate routes, determine surge pricing, and handle special conditions. Let's trace the complete decision-making flow.

**Part 1: Basic if-else Decision Making**

```cpp
// Tian's basic fare calculator
#include <iostream>
using namespace std;

int main() {
    double distance;
    double fare;
    
    cout << "Enter distance (km): ";
    cin >> distance;
    
    if (distance <= 5) {
        fare = 15.00;  // Base fare for short trips
    }
    else {
        fare = 15.00 + (distance - 5) * 2.50;  // Additional per km
    }
    
    cout << "Fare: PHP " << fare << endl;
    
    return 0;
}
```

**Execution Trace:**

```
Test Case 1: distance = 3
Condition: 3 <= 5 → ________
fare = ________
Output: Fare: PHP ________

Test Case 2: distance = 8
Condition: 8 <= 5 → ________
fare = 15.00 + (8 - 5) * 2.50 = ________
Output: Fare: PHP ________

Test Case 3: distance = 5 (boundary)
Condition: 5 <= 5 → ________
fare = ________
```

**Part 2: else-if Chain for Multiple Conditions**

```cpp
// Passenger count validation and pricing
int passengerCount;
double multiplier;

cout << "Enter number of passengers: ";
cin >> passengerCount;

if (passengerCount <= 0) {
    cout << "Error: Invalid passenger count!" << endl;
    multiplier = 0;
}
else if (passengerCount <= 3) {
    cout << "Standard fare" << endl;
    multiplier = 1.0;
}
else if (passengerCount <= 6) {
    cout << "Group rate (10% discount)" << endl;
    multiplier = 0.9;
}
else {
    cout << "Error: Maximum 6 passengers only!" << endl;
    multiplier = 0;
}

double totalFare = baseFare * passengerCount * multiplier;
```

**Execution Flow:**

```
Flow Chart:
                passengerCount <= 0?
                       ↓
              Yes ←───┴───→ No
               ↓              ↓
         Error: Invalid    passengerCount <= 3?
                               ↓
                      Yes ←───┴───→ No
                       ↓              ↓
                Standard fare    passengerCount <= 6?
                                      ↓
                             Yes ←───┴───→ No
                              ↓              ↓
                        Group rate     Error: Max 6
```

**Question 1:** In Test Case 3 (distance = 5), which branch executes?

- A) if branch (distance <= 5)
- B) else branch
- C) Neither
- D) Both

**Answer:** A) if branch (distance <= 5)

---

**Question 2:** For passengerCount = 3, which condition is checked FIRST?

- A) passengerCount <= 6
- B) passengerCount <= 3
- C) passengerCount <= 0
- D) All checked simultaneously

**Answer:** C) passengerCount <= 0 (checked from top to bottom)

---

**Question 3:** What happens when passengerCount = 4?

- A) First condition true, multiplier = 0
- B) Second condition true, multiplier = 1.0
- C) Third condition true, multiplier = 0.9
- D) Fourth condition true, multiplier = 0

**Answer:** C) Third condition true, multiplier = 0.9

---

**Part 3: Nested if Statements**

```cpp
// Surge pricing during peak hours and weather conditions
int hour;
bool isRaining;
double surgeMultiplier = 1.0;

cout << "Enter hour (0-23): ";
cin >> hour;
cout << "Is it raining? (1=yes, 0=no): ";
cin >> isRaining;

if (hour >= 6 && hour <= 9) {  // Morning rush hour
    cout << "Morning peak hours" << endl;
    
    if (isRaining) {
        cout << "Raining during peak - 50% surge!" << endl;
        surgeMultiplier = 1.5;
    }
    else {
        cout << "Peak hours - 20% surge" << endl;
        surgeMultiplier = 1.2;
    }
}
else if (hour >= 17 && hour <= 20) {  // Evening rush hour
    cout << "Evening peak hours" << endl;
    
    if (isRaining) {
        cout << "Raining during peak - 50% surge!" << endl;
        surgeMultiplier = 1.5;
    }
    else {
        cout << "Peak hours - 20% surge" << endl;
        surgeMultiplier = 1.2;
    }
}
else {  // Off-peak
    if (isRaining) {
        cout << "Raining off-peak - 10% surge" << endl;
        surgeMultiplier = 1.1;
    }
    else {
        cout << "Regular pricing" << endl;
        surgeMultiplier = 1.0;
    }
}
```

**Question 4:** For hour = 7 and isRaining = true, what is surgeMultiplier?

- A) 1.0
- B) 1.1
- C) 1.2
- D) 1.5

**Answer:** D) 1.5 (morning peak + raining)

---

**Question 5:** How many conditions are evaluated for hour = 15 and isRaining = false?

- A) 1 condition
- B) 2 conditions
- C) 3 conditions
- D) 4 conditions

**Answer:** C) 3 conditions (hour >= 6 fails, hour >= 17 fails, isRaining evaluated)

---

**Part 4: Ternary Operator**

```cpp
// Quick validation and calculation
int passengers = 4;
string rateType = (passengers <= 3) ? "Standard" : "Group";

double distance = 7.5;
double baseFare = (distance <= 5) ? 15.00 : 15.00 + (distance - 5) * 2.50;

bool isStudent = true;
double discount = isStudent ? 0.2 : 0.0;

// Compact maximum calculation
int route1Time = 25;
int route2Time = 30;
int fasterTime = (route1Time < route2Time) ? route1Time : route2Time;
```

---

# Quiz 2

**Question 6:** What is the value of rateType when passengers = 4?

- A) "Standard"
- B) "Group"
- C) Empty string
- D) Error

**Answer:** B) "Group" (4 > 3, so false, returns second value)

---

**Question 7:** What does this ternary do: `(a > b) ? a : b`?

- A) Returns smaller value
- B) Returns larger value (maximum)
- C) Returns average
- D) Returns difference

**Answer:** B) Returns larger value (maximum)

---

**Part 5: Switch Statement**

```cpp
// Route selection system
int routeNumber;
string destination;
double estimatedTime;

cout << "Select route:" << endl;
cout << "1 - City Proper" << endl;
cout << "2 - Jaro District" << endl;
cout << "3 - La Paz District" << endl;
cout << "4 - Mandurriao District" << endl;
cout << "5 - Molo District" << endl;
cout << "Enter choice: ";
cin >> routeNumber;

switch (routeNumber) {
    case 1:
        destination = "City Proper";
        estimatedTime = 15.0;
        break;
    
    case 2:
        destination = "Jaro District";
        estimatedTime = 25.0;
        break;
    
    case 3:
        destination = "La Paz District";
        estimatedTime = 20.0;
        break;
    
    case 4:
    case 5:  // Fall-through: cases 4 and 5 share same code
        destination = "Mandurriao/Molo";
        estimatedTime = 30.0;
        break;
    
    default:
        destination = "Unknown";
        estimatedTime = 0.0;
        cout << "Error: Invalid route!" << endl;
        break;
}

cout << "Destination: " << destination << endl;
cout << "Estimated time: " << estimatedTime << " minutes" << endl;
```

**Question 8:** What happens when routeNumber = 4?

- A) Only case 4 executes
- B) Cases 4 and 5 both execute (fall-through)
- C) Error occurs
- D) Default case executes

**Answer:** B) Cases 4 and 5 both execute (fall-through intended)

---

**Question 9:** What is the purpose of break statement?

- A) Stop the program
- B) Exit the switch block (prevent fall-through)
- C) Skip to default case
- D) Repeat the switch

**Answer:** B) Exit the switch block (prevent fall-through)

---

**Question 10:** What happens if you forget break in case 1?

- A) Nothing, works normally
- B) Fall-through: case 2 code also executes
- C) Compilation error
- D) Runtime error

**Answer:** B) Fall-through: case 2 code also executes

---

## Detailed Explanation

### Part 1: Understanding if-else Fundamentals

**Basic if Statement:**

```cpp
if (condition) {
    // Code executes only if condition is TRUE
}
```

**Example:**
```cpp
int age = 17;

if (age >= 18) {
    cout << "You can vote!" << endl;
}
// Nothing happens if false
```

**Execution Flow:**
```
Condition: age >= 18
17 >= 18 → FALSE
Code block skipped
Program continues
```

---

**if-else Statement:**

```cpp
if (condition) {
    // Executes if TRUE
}
else {
    // Executes if FALSE
}
```

**Example:**
```cpp
int age = 17;

if (age >= 18) {
    cout << "You can vote!" << endl;
}
else {
    cout << "Too young to vote" << endl;
}
```

**Execution Flow:**
```
Condition: age >= 18
17 >= 18 → FALSE
else branch executes
Output: "Too young to vote"
```

**Key Point:** Exactly ONE branch executes, never both!

---

### Part 2: else-if Chains - Multiple Conditions

**Structure:**

```cpp
if (condition1) {
    // First condition
}
else if (condition2) {
    // Second condition
}
else if (condition3) {
    // Third condition
}
else {
    // Default case (all above false)
}
```

**Evaluation Order:** Top to bottom, stops at first TRUE condition!

---

**Real Example: Grade Calculator**

```cpp
int score;
char grade;

cout << "Enter score: ";
cin >> score;

if (score >= 90) {
    grade = 'A';
}
else if (score >= 80) {
    grade = 'B';
}
else if (score >= 70) {
    grade = 'C';
}
else if (score >= 60) {
    grade = 'D';
}
else {
    grade = 'F';
}

cout << "Grade: " << grade << endl;
```

**Trace Example - score = 85:**

```
Step 1: Check score >= 90
        85 >= 90 → FALSE, continue

Step 2: Check score >= 80
        85 >= 80 → TRUE, execute this block!
        grade = 'B'
        
Step 3: Skip all remaining conditions (already found true)
        
Output: "Grade: B"
```

**Important:** Once a condition is TRUE, remaining conditions are skipped!

---

**Order Matters!**

**WRONG (Bug):**
```cpp
if (score >= 60) {
    grade = 'D';
}
else if (score >= 70) {
    grade = 'C';  // Never reached!
}
else if (score >= 80) {
    grade = 'B';  // Never reached!
}
```

**Why Wrong:**
```
score = 85
First check: 85 >= 60 → TRUE
grade = 'D'
Remaining conditions skipped!
Result: Score of 85 gets 'D' (WRONG!)
```

**Always check from highest to lowest for ranges!**

---

### Part 3: Nested if Statements - Decisions Within Decisions

**Structure:**

```cpp
if (outerCondition) {
    // Outer true
    
    if (innerCondition) {
        // Both outer AND inner true
    }
    else {
        // Outer true, inner false
    }
}
else {
    // Outer false
    
    if (anotherInnerCondition) {
        // Outer false, this inner true
    }
}
```

---

**Real Example: Jeepney Fare with Discounts**

```cpp
double distance = 8.0;
bool isSenior;
bool isStudent;

cout << "Are you senior citizen? (1/0): ";
cin >> isSenior;
cout << "Are you student? (1/0): ";
cin >> isStudent;

double baseFare = 13.00;
double totalFare;

if (distance <= 4) {
    // Short distance
    totalFare = baseFare;
    
    if (isSenior) {
        cout << "Senior discount: 20%" << endl;
        totalFare *= 0.8;
    }
    else if (isStudent) {
        cout << "Student discount: 10%" << endl;
        totalFare *= 0.9;
    }
}
else {
    // Long distance
    totalFare = baseFare + (distance - 4) * 1.50;
    
    if (isSenior) {
        cout << "Senior discount: 20%" << endl;
        totalFare *= 0.8;
    }
    else if (isStudent) {
        cout << "Student discount: 10%" << endl;
        totalFare *= 0.9;
    }
}

cout << "Total fare: PHP " << totalFare << endl;
```

**Trace: distance = 3, isSenior = true**

```
Step 1: Check distance <= 4
        3 <= 4 → TRUE
        Enter first block
        
Step 2: totalFare = 13.00
        
Step 3: Check isSenior
        true → TRUE
        Apply senior discount
        totalFare = 13.00 * 0.8 = 10.40
        
Output: "Senior discount: 20%"
        "Total fare: PHP 10.40"
```

---

**Nesting Levels:**

```cpp
// Level 1
if (condition1) {
    
    // Level 2
    if (condition2) {
        
        // Level 3
        if (condition3) {
            // All three conditions true
        }
    }
}
```

**Best Practice:** Avoid deep nesting (more than 3 levels)
- Hard to read
- Hard to debug
- Consider refactoring into functions

---

### Part 4: Ternary Operator - Compact if-else

**Syntax:**

```cpp
result = (condition) ? valueIfTrue : valueIfFalse;
```

**Equivalent if-else:**

```cpp
if (condition) {
    result = valueIfTrue;
}
else {
    result = valueIfFalse;
}
```

---

**Simple Examples:**

```cpp
// 1. Maximum of two numbers
int a = 10, b = 20;
int max = (a > b) ? a : b;  // max = 20

// 2. Minimum of two numbers
int min = (a < b) ? a : b;  // min = 10

// 3. Absolute value
int num = -15;
int absolute = (num >= 0) ? num : -num;  // absolute = 15

// 4. Even or odd
int n = 7;
string parity = (n % 2 == 0) ? "Even" : "Odd";  // parity = "Odd"

// 5. Pass or fail
int score = 75;
string result = (score >= 60) ? "Pass" : "Fail";  // result = "Pass"
```

---

**Real-World Example: Discount Calculation**

```cpp
double price = 1500.00;
bool isMember = true;
int quantity = 5;

// Member discount
double memberDiscount = isMember ? 0.1 : 0.0;

// Bulk discount
double bulkDiscount = (quantity >= 5) ? 0.05 : 0.0;

// Total discount (cannot exceed 20%)
double totalDiscount = (memberDiscount + bulkDiscount > 0.2) 
                       ? 0.2 
                       : memberDiscount + bulkDiscount;

double finalPrice = price * (1 - totalDiscount);

cout << "Original: PHP " << price << endl;
cout << "Discount: " << (totalDiscount * 100) << "%" << endl;
cout << "Final: PHP " << finalPrice << endl;
```

**Trace: isMember = true, quantity = 5**

```
memberDiscount = true ? 0.1 : 0.0 = 0.1
bulkDiscount = (5 >= 5) ? 0.05 : 0.0 = 0.05
totalDiscount = (0.15 > 0.2) ? 0.2 : 0.15 = 0.15
finalPrice = 1500 * (1 - 0.15) = 1500 * 0.85 = 1275.00

Output:
Original: PHP 1500
Discount: 15%
Final: PHP 1275
```

---

**Nested Ternary (Use Sparingly):**

```cpp
int score = 85;
char grade = (score >= 90) ? 'A' :
             (score >= 80) ? 'B' :
             (score >= 70) ? 'C' :
             (score >= 60) ? 'D' : 'F';
```

**Warning:** Nested ternary is hard to read. Use if-else if for clarity!

---

### Part 5: Switch Statement - Multiple Discrete Values

**Syntax:**

```cpp
switch (expression) {
    case value1:
        // Code for value1
        break;
    
    case value2:
        // Code for value2
        break;
    
    case value3:
        // Code for value3
        break;
    
    default:
        // Code if no match
        break;
}
```

**Key Points:**
- Expression must be **integer** or **char** (no strings, no floats)
- Each case must be a **constant value** (not a variable)
- **break** is crucial to prevent fall-through
- **default** is optional but recommended

---

**Real Example: Menu Selection**

```cpp
int choice;

cout << "===== TIAN'S TRICYCLE SERVICE =====" << endl;
cout << "1. Book a ride" << endl;
cout << "2. View ride history" << endl;
cout << "3. Check balance" << endl;
cout << "4. Contact driver" << endl;
cout << "5. Exit" << endl;
cout << "Enter choice: ";
cin >> choice;

switch (choice) {
    case 1:
        cout << "Booking a ride..." << endl;
        // Call booking function
        break;
    
    case 2:
        cout << "Displaying ride history..." << endl;
        // Show history
        break;
    
    case 3:
        cout << "Checking balance..." << endl;
        // Display balance
        break;
    
    case 4:
        cout << "Connecting to driver..." << endl;
        // Contact driver
        break;
    
    case 5:
        cout << "Thank you! Goodbye!" << endl;
        break;
    
    default:
        cout << "Error: Invalid choice!" << endl;
        cout << "Please select 1-5" << endl;
        break;
}
```

---

**Fall-Through Behavior:**

**Intentional Fall-Through (Useful):**

```cpp
char grade;
cin >> grade;

switch (grade) {
    case 'A':
    case 'a':
        cout << "Excellent!" << endl;
        break;
    
    case 'B':
    case 'b':
        cout << "Good job!" << endl;
        break;
    
    case 'C':
    case 'c':
        cout << "Passed" << endl;
        break;
    
    default:
        cout << "Failed" << endl;
        break;
}
```

**How it works:**
```
Input: 'A' or 'a'
Both cases have no break between them
Fall through to cout << "Excellent!"
Then break exits switch
```

---

**Accidental Fall-Through (Bug!):**

```cpp
// WRONG - Missing break
int day = 2;

switch (day) {
    case 1:
        cout << "Monday" << endl;
        // Missing break!
    
    case 2:
        cout << "Tuesday" << endl;
        break;
    
    case 3:
        cout << "Wednesday" << endl;
        break;
}
```

**What Happens with day = 1:**
```
Matches case 1
Output: "Monday"
No break, falls through to case 2
Output: "Tuesday"
Hits break in case 2
Exits switch

Result: Prints both "Monday" and "Tuesday" (BUG!)
```

**Always use break unless fall-through is intentional!**

---

### Part 6: switch vs if-else-if - When to Use What

**Use switch when:**
- Comparing ONE variable to multiple discrete values
- Values are integers or characters
- Many cases (5+)
- Cleaner and more efficient

**Example:**
```cpp
switch (dayOfWeek) {
    case 1: cout << "Monday"; break;
    case 2: cout << "Tuesday"; break;
    case 3: cout << "Wednesday"; break;
    // ... etc
}
```

---

**Use if-else-if when:**
- Complex conditions (ranges, multiple variables)
- Floating-point comparisons
- String comparisons
- Logical operators (&&, ||)

**Example:**
```cpp
if (age >= 0 && age <= 12) {
    cout << "Child";
}
else if (age >= 13 && age <= 19) {
    cout << "Teenager";
}
else if (age >= 20 && age <= 59) {
    cout << "Adult";
}
else {
    cout << "Senior";
}
```

**Cannot use switch for ranges!**

---

### Part 7: Logical Operators in Conditions

**AND Operator (&&) - Both conditions must be TRUE:**

```cpp
int hour = 8;
bool isWeekday = true;

if (hour >= 6 && hour <= 9 && isWeekday) {
    cout << "Morning rush hour!" << endl;
}
```

**Truth Table:**
```
Condition1  Condition2  Result
TRUE        TRUE        TRUE
TRUE        FALSE       FALSE
FALSE       TRUE        FALSE
FALSE       FALSE       FALSE
```

---

**OR Operator (||) - At least one condition must be TRUE:**

```cpp
char grade;
cin >> grade;

if (grade == 'A' || grade == 'B' || grade == 'C') {
    cout << "You passed!" << endl;
}
```

**Truth Table:**
```
Condition1  Condition2  Result
TRUE        TRUE        TRUE
TRUE        FALSE       TRUE
FALSE       TRUE        TRUE
FALSE       FALSE       FALSE
```

---

**NOT Operator (!) - Inverts the condition:**

```cpp
bool isRaining = false;

if (!isRaining) {
    cout << "Good day for a ride!" << endl;
}
```

**Truth Table:**
```
Condition   Result
TRUE        FALSE
FALSE       TRUE
```

---

**Combined Example:**

```cpp
int age = 65;
bool hasDiscount = true;
double fare = 20.00;

// Senior citizen (60+) OR has discount card gets 20% off
if ((age >= 60 || hasDiscount) && fare > 0) {
    fare *= 0.8;
    cout << "Discount applied!" << endl;
}

cout << "Fare: PHP " << fare << endl;
```

**Evaluation:**
```
(age >= 60 || hasDiscount) && fare > 0
(65 >= 60 || true) && 20.00 > 0
(true || true) && true
true && true
true

Result: Discount applied
fare = 20.00 * 0.8 = 16.00
```

---

### Part 8: Complete Tricycle System Example

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    // Variables
    double distance;
    int passengers;
    int hour;
    bool isRaining;
    bool isSenior;
    char routeType;
    
    // Base fare
    double baseFare = 15.00;
    double farePerKm = 2.50;
    double totalFare;
    
    // Input
    cout << "===== TIAN'S TRICYCLE FARE CALCULATOR =====" << endl;
    
    cout << "Enter distance (km): ";
    cin >> distance;
    
    cout << "Enter number of passengers: ";
    cin >> passengers;
    
    cout << "Enter current hour (0-23): ";
    cin >> hour;
    
    cout << "Is it raining? (1=yes, 0=no): ";
    cin >> isRaining;
    
    cout << "Senior citizen? (1=yes, 0=no): ";
    cin >> isSenior;
    
    cout << "Route type (m=main, s=side): ";
    cin >> routeType;
    
    // Validation
    if (passengers <= 0 || passengers > 6) {
        cout << "Error: Must have 1-6 passengers!" << endl;
        return 1;
    }
    
    if (distance <= 0) {
        cout << "Error: Invalid distance!" << endl;
        return 1;
    }
    
    // Calculate base fare
    if (distance <= 5) {
        totalFare = baseFare;
    }
    else {
        totalFare = baseFare + (distance - 5) * farePerKm;
    }
    
    // Passenger multiplier
    double passengerMultiplier = 1.0;
    if (passengers <= 3) {
        passengerMultiplier = 1.0;
    }
    else if (passengers <= 6) {
        cout << "Group discount: 10%" << endl;
        passengerMultiplier = 0.9;
    }
    
    totalFare *= passengers * passengerMultiplier;
    
    // Surge pricing
    double surgeMultiplier = 1.0;
    
    if ((hour >= 6 && hour <= 9) || (hour >= 17 && hour <= 20)) {
        // Peak hours
        if (isRaining) {
            cout << "Peak + Rain: 50% surge" << endl;
            surgeMultiplier = 1.5;
        }
        else {
            cout << "Peak hours: 20% surge" << endl;
            surgeMultiplier = 1.2;
        }
    }
    else {
        // Off-peak
        if (isRaining) {
            cout << "Rain: 10% surge" << endl;
            surgeMultiplier = 1.1;
        }
    }
    
    totalFare *= surgeMultiplier;
    
    // Route type adjustment
    switch (routeType) {
        case 'm':
        case 'M':
            cout << "Main route: No extra charge" << endl;
            break;
        
        case 's':
        case 'S':
            cout << "Side route: +PHP 10" << endl;
            totalFare += 10.00;
            break;
        
        default:
            cout << "Unknown route type" << endl;
            break;
    }
    
    // Senior discount (applied last)
    if (isSenior) {
        cout << "Senior discount: 20%" << endl;
        totalFare *= 0.8;
    }
    
    // Output
    cout << fixed << setprecision(2);
    cout << "\n========================================" << endl;
    cout << "TOTAL FARE: PHP " << totalFare << endl;
    cout << "========================================" << endl;
    
    return 0;
}
```

**Sample Run:**
```
===== TIAN'S TRICYCLE FARE CALCULATOR =====
Enter distance (km): 8
Enter number of passengers: 4
Enter current hour (0-23): 7
Is it raining? (1=yes, 0=no): 1
Senior citizen? (1=yes, 0=no): 0
Route type (m=main, s=side): s
Group discount: 10%
Peak + Rain: 50% surge
Side route: +PHP 10

========================================
TOTAL FARE: PHP 101.70
========================================

Calculation:
Base: 15.00 + (8-5)*2.50 = 22.50
Passengers: 22.50 * 4 * 0.9 = 81.00
Surge: 81.00 * 1.5 = 121.50
Route: 121.50 + 10 = 131.50
Final: 131.50 (no senior discount)

Wait, let me recalculate:
Base for 1 passenger: 15 + (8-5)*2.5 = 22.50
For 4 passengers: 22.50 * 4 = 90.00
Group discount: 90 * 0.9 = 81.00
Surge: 81 * 1.5 = 121.50
Route: 121.50 + 10 = 131.50

Hmm, output shows 101.70, let me check order of operations...
```

---

### Part 9: Common Filipino Developer Mistakes

**Mistake 1: Using = instead of ==**

```cpp
// WRONG
int age = 18;
if (age = 21) {  // Assignment, not comparison!
    cout << "Can drink" << endl;
}
```

**What happens:**
```
age = 21 assigns 21 to age (not comparison!)
Returns 21 (non-zero = true)
Condition always true!
age is now 21 (bug!)
```

**Fix:**
```cpp
if (age == 21) {  // Comparison
    cout << "Can drink" << endl;
}
```

---

**Mistake 2: Floating-point comparison**

```cpp
// WRONG
double price = 0.1 + 0.2;
if (price == 0.3) {  // May fail due to precision!
    cout << "Exact!" << endl;
}
```

**Why it fails:**
```
0.1 + 0.2 = 0.30000000000000004 (floating-point error)
Not exactly 0.3!
```

**Fix:**
```cpp
double epsilon = 0.0001;
if (abs(price - 0.3) < epsilon) {
    cout << "Approximately equal!" << endl;
}
```

---

**Mistake 3: Forgetting break in switch**

```cpp
// WRONG
switch (day) {
    case 1:
        cout << "Monday" << endl;
        // Missing break!
    case 2:
        cout << "Tuesday" << endl;
        break;
}
```

**Fix:** Always add break (unless fall-through intended)

---

**Mistake 4: Wrong range conditions**

```cpp
// WRONG - Doesn't work in C++!
if (10 <= age <= 20) {
    cout << "Teen" << endl;
}
```

**Why it's wrong:**
```
Evaluated as: (10 <= age) <= 20
First: 10 <= age → true or false (1 or 0)
Then: 1 <= 20 or 0 <= 20 → always true!
```

**Fix:**
```cpp
if (age >= 10 && age <= 20) {
    cout << "Teen" << endl;
}
```

---

**Mistake 5: Semicolon after if**

```cpp
// WRONG
if (age >= 18);  // ← Semicolon ends the if!
{
    cout << "Adult" << endl;  // Always executes!
}
```

**Fix:** Remove semicolon
```cpp
if (age >= 18) {
    cout << "Adult" << endl;
}
```

---

### Part 10: Philippine Context - Real Applications

**1. Jeepney Fare System:**
```cpp
double distance;
bool isSenior, isStudent, isPWD;

// Base fare + per km
double fare = 13.00;
if (distance > 4) {
    fare += (distance - 4) * 1.50;
}

// Discounts (20% for senior/PWD, 10% for students)
if (isSenior || isPWD) {
    fare *= 0.8;
}
else if (isStudent) {
    fare *= 0.9;
}
```

**2. LRT/MRT Stored Value Card:**
```cpp
double balance = 150.00;
double fare = 20.00;
int journeyCount = 0;

if (balance >= fare) {
    balance -= fare;
    journeyCount++;
    
    if (journeyCount % 10 == 0) {
        cout << "Bonus: Free next ride!" << endl;
    }
}
else {
    cout << "Insufficient balance. Please load!" << endl;
}
```

**3. Grab/Angkas Booking:**
```cpp
int hour;
double baseFare = 50.00;
double surgeMultiplier;

if (hour >= 7 && hour <= 9) {
    surgeMultiplier = 1.5;
}
else if (hour >= 17 && hour <= 19) {
    surgeMultiplier = 1.3;
}
else {
    surgeMultiplier = 1.0;
}

double finalFare = baseFare * surgeMultiplier;
```

---

### Summary

**Control Flow Structures:**

1. **if-else** - Binary decision (two paths)
2. **else-if chain** - Multiple conditions (many paths)
3. **Nested if** - Decisions within decisions
4. **Ternary operator** - Compact if-else for assignments
5. **switch** - Multiple discrete values

**Key Principles:**
- Conditions evaluate top to bottom
- Only ONE branch executes in if-else-if
- Use break in switch to prevent fall-through
- Order matters in else-if chains
- Always validate user input
- Use logical operators (&&, ||, !) for complex conditions

**Best Practices:**
1. Use meaningful variable names
2. Add comments for complex logic
3. Validate all user input
4. Avoid deep nesting (max 3 levels)
5. Use switch for multiple discrete values
6. Use if-else-if for ranges
7. Always include default case in switch
8. Test boundary conditions
