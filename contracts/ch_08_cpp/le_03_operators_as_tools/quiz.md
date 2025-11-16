# Operators Quiz

---

# Quiz 1

## Quiz: Understanding Arithmetic, Comparison, and Logical Operators

**Scenario:** 

Tian is developing a loyalty points system for a coffee shop chain in Metro Manila called "Kape Tayo". The system needs to calculate points, validate eligibility for rewards, and determine discount tiers. Here's the code Tian wrote:

```cpp
#include <iostream>
using namespace std;

int main() {
    // Customer purchase information
    int purchase_amount = 450;
    int current_points = 85;
    bool is_member = true;
    int consecutive_visits = 7;
    
    // Calculate points earned (10 pesos = 1 point)
    int points_earned = purchase_amount / 10;
    current_points += points_earned;
    
    // Check reward eligibility
    bool qualifies_for_reward = (current_points >= 100) && is_member;
    bool gets_bonus = (consecutive_visits >= 5) || (purchase_amount > 500);
    
    // Discount calculation
    double discount_rate = 0.0;
    if (qualifies_for_reward && gets_bonus) {
        discount_rate = 0.15;  // 15% discount
    } else if (qualifies_for_reward) {
        discount_rate = 0.10;  // 10% discount
    } else if (gets_bonus) {
        discount_rate = 0.05;  // 5% discount
    }
    
    // Apply discount
    double final_amount = purchase_amount * (1 - discount_rate);
    
    // Increment visit counter
    consecutive_visits++;
    
    cout << "Points earned: " << points_earned << endl;
    cout << "Total points: " << current_points << endl;
    cout << "Discount rate: " << (discount_rate * 100) << "%" << endl;
    cout << "Final amount: " << final_amount << " pesos" << endl;
    cout << "Next consecutive visit: " << consecutive_visits << endl;
    
    return 0;
}
```

**Question 1:** What is the value of `current_points` after the calculation?

- A) `85` (unchanged)
- B) `45` (points_earned only)
- C) `130` (85 + 45)
- D) `4500` (multiplication error)

**Question 2:** Given that `qualifies_for_reward` is `true` and `gets_bonus` is `true`, what discount rate is applied?

- A) `0.0` (no discount)
- B) `0.05` (5%)
- C) `0.10` (10%)
- D) `0.15` (15%)

---

# Quiz 2

**Question 3:** What is the difference between `consecutive_visits++` (post-increment) and `++consecutive_visits` (pre-increment)?

- A) No difference, both add 1 to the variable
- B) `consecutive_visits++` adds 1 before using the value, `++consecutive_visits` adds 1 after
- C) `consecutive_visits++` returns the old value then increments, `++consecutive_visits` increments then returns new value
- D) `++consecutive_visits` is not valid C++ syntax

**Answer:**
- **Question 1:** C) `130`
- **Question 2:** D) `0.15` (15%)
- **Question 3:** C) `consecutive_visits++` returns the old value then increments, `++consecutive_visits` increments then returns new value

---

## Detailed Explanation

### Question 1: Arithmetic Operators and Compound Assignment

**Step-by-Step Calculation:**

```cpp
int purchase_amount = 450;
int current_points = 85;

// Points earned calculation
int points_earned = purchase_amount / 10;
// points_earned = 450 / 10 = 45 (integer division)

// Compound assignment
current_points += points_earned;
// This is shorthand for: current_points = current_points + points_earned
// current_points = 85 + 45 = 130
```

**Understanding Compound Assignment Operators:**

```cpp
// Traditional way
current_points = current_points + points_earned;

// Compound assignment (shorter, cleaner)
current_points += points_earned;

// Both do exactly the same thing
```

**All Compound Assignment Operators:**

```cpp
int x = 10;

x += 5;   // x = x + 5  →  x = 15
x -= 3;   // x = x - 3  →  x = 12
x *= 2;   // x = x * 2  →  x = 24
x /= 4;   // x = x / 4  →  x = 6
x %= 5;   // x = x % 5  →  x = 1 (remainder)
```

**Real-World Example: Inventory Management**

```cpp
#include <iostream>
using namespace std;

int main() {
    // Sari-sari store inventory
    int rice_stock = 50;      // sacks
    int sold_today = 8;
    int delivery = 20;
    
    // Update inventory
    rice_stock -= sold_today;   // 50 - 8 = 42
    rice_stock += delivery;     // 42 + 20 = 62
    
    cout << "Current rice stock: " << rice_stock << " sacks" << endl;
    
    // Price adjustment (10% increase)
    double rice_price = 1800.00;  // per sack
    rice_price *= 1.10;           // 1800 * 1.10 = 1980.00
    
    cout << "New price: " << rice_price << " pesos/sack" << endl;
    
    return 0;
}
```

**Arithmetic Operators Reference:**

```cpp
// Basic arithmetic
int a = 10, b = 3;

int sum = a + b;         // 13 (addition)
int difference = a - b;  // 7 (subtraction)
int product = a * b;     // 30 (multiplication)
int quotient = a / b;    // 3 (integer division, decimal truncated)
int remainder = a % b;   // 1 (modulo, remainder of 10÷3)

// With floating point
double x = 10.0, y = 3.0;
double division = x / y;  // 3.333... (true division)
```

**Modulo Operator (%) Use Cases:**

```cpp
// Check if even or odd
int number = 45;
if (number % 2 == 0) {
    cout << "Even" << endl;
} else {
    cout << "Odd" << endl;  // This runs (45 % 2 = 1)
}

// Cycle through days of week
int day_number = 10;
int day_of_week = day_number % 7;  // 10 % 7 = 3 (Wednesday)

// Distribute items evenly
int total_items = 47;
int boxes = 5;
int items_per_box = total_items / boxes;  // 9 items per box
int leftover = total_items % boxes;       // 2 items left over

// Format time (convert minutes to hours:minutes)
int total_minutes = 135;
int hours = total_minutes / 60;    // 2 hours
int minutes = total_minutes % 60;  // 15 minutes
// Result: 2:15
```

**Philippine Context: Fare Calculation**

```cpp
#include <iostream>
using namespace std;

int main() {
    // LRT/MRT stored value card
    double card_balance = 150.00;
    double fare_per_ride = 15.00;
    
    // Take a ride
    card_balance -= fare_per_ride;  // 150 - 15 = 135
    
    // Calculate remaining rides
    int rides_left = card_balance / fare_per_ride;  // 135 / 15 = 9
    double excess = card_balance - (rides_left * fare_per_ride);
    // excess = 135 - 135 = 0 (no excess in this case)
    
    cout << "Card balance: " << card_balance << " pesos" << endl;
    cout << "Rides left: " << rides_left << endl;
    
    return 0;
}
```

---

### Question 2: Logical Operators and Boolean Logic

**Evaluating Boolean Expressions:**

Let's trace through Tian's logic step by step:

```cpp
int purchase_amount = 450;
int current_points = 130;  // After adding points_earned
bool is_member = true;
int consecutive_visits = 7;

// First condition
bool qualifies_for_reward = (current_points >= 100) && is_member;
// (130 >= 100) → true
// true && true → true

// Second condition
bool gets_bonus = (consecutive_visits >= 5) || (purchase_amount > 500);
// (7 >= 5) → true
// (450 > 500) → false
// true || false → true

// Discount logic
if (qualifies_for_reward && gets_bonus) {
    // (true && true) → true
    discount_rate = 0.15;  // This branch executes
}
```

**Logical Operators:**

**AND Operator (&&)** - Both conditions must be true
```cpp
bool a = true, b = true, c = false;

bool result1 = a && b;  // true && true → true
bool result2 = a && c;  // true && false → false
bool result3 = c && c;  // false && false → false

// Truth table for AND:
// true  && true  → true
// true  && false → false
// false && true  → false
// false && false → false
```

**OR Operator (||)** - At least one condition must be true
```cpp
bool a = true, b = true, c = false;

bool result1 = a || b;  // true || true → true
bool result2 = a || c;  // true || false → true
bool result3 = c || c;  // false || false → false

// Truth table for OR:
// true  || true  → true
// true  || false → true
// false || true  → true
// false || false → false
```

**NOT Operator (!)** - Inverts the boolean value
```cpp
bool is_raining = true;
bool is_sunny = !is_raining;  // !true → false

bool has_license = false;
bool needs_license = !has_license;  // !false → true

// Double negation
bool x = true;
bool y = !!x;  // !!true → !false → true (same as original)
```

**Short-Circuit Evaluation:**

C++ uses short-circuit evaluation for efficiency:

```cpp
// AND (&&): If first is false, second is never checked
bool result = (5 > 10) && (expensive_function());
// (5 > 10) is false, so expensive_function() never runs

// OR (||): If first is true, second is never checked
bool result = (5 < 10) || (expensive_function());
// (5 < 10) is true, so expensive_function() never runs
```

**Practical Example:**

```cpp
#include <iostream>
using namespace std;

int main() {
    int age = 17;
    bool has_parental_consent = true;
    bool has_valid_id = false;
    
    // Complex eligibility check
    bool can_register = (age >= 18) || (age >= 16 && has_parental_consent);
    // (17 >= 18) → false
    // (17 >= 16 && true) → (true && true) → true
    // false || true → true
    
    bool can_proceed = can_register && has_valid_id;
    // true && false → false
    
    if (can_proceed) {
        cout << "Registration complete!" << endl;
    } else if (can_register && !has_valid_id) {
        cout << "Please present valid ID" << endl;  // This runs
    } else {
        cout << "Not eligible" << endl;
    }
    
    return 0;
}
```

**Comparison Operators:**

```cpp
int a = 10, b = 20;

bool equal = (a == b);          // false (10 == 20)
bool not_equal = (a != b);      // true (10 != 20)
bool less = (a < b);            // true (10 < 20)
bool greater = (a > b);         // false (10 > 20)
bool less_equal = (a <= b);     // true (10 <= 20)
bool greater_equal = (a >= b);  // false (10 >= 20)
```

**Common Pitfall - Assignment vs Comparison:**

```cpp
int x = 5;

// Wrong! This assigns 10 to x, then evaluates as true
if (x = 10) {  // Assignment, not comparison!
    cout << "This always runs" << endl;
}

// Correct! This compares x to 10
if (x == 10) {  // Comparison
    cout << "x is 10" << endl;
}
```

**Philippine Context: Voter Eligibility**

```cpp
#include <iostream>
using namespace std;

int main() {
    int age = 21;
    bool is_filipino = true;
    bool is_registered = true;
    bool has_criminal_case = false;
    
    // Voter eligibility logic (simplified)
    bool can_vote = (age >= 18) && is_filipino && 
                    is_registered && !has_criminal_case;
    
    // (21 >= 18) → true
    // true && true && true && !false
    // true && true && true && true → true
    
    if (can_vote) {
        cout << "You are eligible to vote!" << endl;
    } else {
        cout << "Not eligible. Reasons:" << endl;
        if (age < 18) cout << "- Must be 18 or older" << endl;
        if (!is_filipino) cout << "- Must be Filipino citizen" << endl;
        if (!is_registered) cout << "- Must be registered voter" << endl;
        if (has_criminal_case) cout << "- Criminal case pending" << endl;
    }
    
    return 0;
}
```

---

### Question 3: Increment and Decrement Operators

**Understanding Pre and Post Increment:**

```cpp
int x = 5;

// Post-increment: x++
int a = x++;
// 1. Store current value of x (5) to a
// 2. Increment x to 6
// Result: a = 5, x = 6

x = 5;  // Reset

// Pre-increment: ++x
int b = ++x;
// 1. Increment x to 6
// 2. Store new value of x (6) to b
// Result: b = 6, x = 6
```

**Visual Demonstration:**

```cpp
#include <iostream>
using namespace std;

int main() {
    int counter = 10;
    
    cout << "Initial: " << counter << endl;  // 10
    cout << "Post-increment: " << counter++ << endl;  // Prints 10, then becomes 11
    cout << "After post: " << counter << endl;  // 11
    
    counter = 10;  // Reset
    
    cout << "Pre-increment: " << ++counter << endl;  // Becomes 11, then prints 11
    cout << "After pre: " << counter << endl;  // 11
    
    return 0;
}

/* Output:
Initial: 10
Post-increment: 10
After post: 11
Pre-increment: 11
After pre: 11
*/
```

**When It Matters:**

```cpp
// Scenario 1: Standalone statement (no difference)
int x = 5;
x++;    // x becomes 6
++x;    // x becomes 7
// Both do the same thing when used alone

// Scenario 2: In assignment (big difference!)
int y = 5;
int a = y++;  // a = 5, y = 6
int b = ++y;  // b = 7, y = 7

// Scenario 3: In function calls
print(counter++);  // Prints current value, then increments
print(++counter);  // Increments first, then prints new value

// Scenario 4: In loops (usually no difference)
for (int i = 0; i < 10; i++) {   // Post-increment
    cout << i << endl;
}

for (int i = 0; i < 10; ++i) {   // Pre-increment
    cout << i << endl;
}
// Both produce same output: 0, 1, 2, ..., 9
```

**Decrement Works the Same Way:**

```cpp
int x = 10;

// Post-decrement
int a = x--;  // a = 10, x = 9

x = 10;  // Reset

// Pre-decrement
int b = --x;  // b = 9, x = 9
```

**Real-World Example: Queue System**

```cpp
#include <iostream>
using namespace std;

int main() {
    // Government office queue system
    int current_ticket = 100;
    int serving_now = 0;
    
    // Issue tickets (post-increment)
    serving_now = current_ticket++;
    cout << "Now serving: " << serving_now << endl;      // 100
    cout << "Next ticket: " << current_ticket << endl;   // 101
    
    // Next customer (pre-increment)
    cout << "Now serving: " << ++serving_now << endl;    // 101
    
    return 0;
}
```

**Philippine Context: Tricycle Queue**

```cpp
#include <iostream>
using namespace std;

int main() {
    int passengers_waiting = 15;
    int tricycle_capacity = 4;
    int trips = 0;
    
    cout << "Initial passengers: " << passengers_waiting << endl;
    
    // First trip (post-decrement in condition, pre-increment counter)
    while (passengers_waiting >= tricycle_capacity) {
        passengers_waiting -= tricycle_capacity;
        cout << "Trip " << ++trips << ": Carried 4 passengers" << endl;
        cout << "Remaining: " << passengers_waiting << endl;
    }
    
    if (passengers_waiting > 0) {
        cout << "Last trip " << ++trips << ": Carried " 
             << passengers_waiting << " passengers" << endl;
    }
    
    cout << "Total trips: " << trips << endl;
    
    return 0;
}

/* Output:
Initial passengers: 15
Trip 1: Carried 4 passengers
Remaining: 11
Trip 2: Carried 4 passengers
Remaining: 7
Trip 3: Carried 4 passengers
Remaining: 3
Last trip 4: Carried 3 passengers
Total trips: 4
*/
```

**Complex Expression Example:**

```cpp
int x = 5, y = 10;

int result = x++ + ++y;
// Step 1: x++ returns 5 (x becomes 6)
// Step 2: ++y makes y = 11, returns 11
// Step 3: 5 + 11 = 16
// Final: result = 16, x = 6, y = 11

x = 5; y = 10;  // Reset

int result2 = ++x + y++;
// Step 1: ++x makes x = 6, returns 6
// Step 2: y++ returns 10 (y becomes 11)
// Step 3: 6 + 10 = 16
// Final: result2 = 16, x = 6, y = 11
```

**Best Practices:**

```cpp
// Prefer standalone increment (clearer intent)
counter++;
++counter;

// Avoid in complex expressions (confusing)
int bad = x++ + ++y - z--;  // Hard to read!

// Better: Break into separate statements
++y;
int good = x + y - z;
x++;
z--;

// In loops: Use what feels natural (both work)
for (int i = 0; i < 10; i++) { }   // Common convention
for (int i = 0; i < 10; ++i) { }   // Slightly more efficient (negligible)
```

---

## Key Concepts Summary

**1. Arithmetic Operators:**

```cpp
+    // Addition
-    // Subtraction
*    // Multiplication
/    // Division (integer division if both operands are int)
%    // Modulo (remainder)
```

**2. Compound Assignment:**

```cpp
+=   // Add and assign
-=   // Subtract and assign
*=   // Multiply and assign
/=   // Divide and assign
%=   // Modulo and assign
```

**3. Comparison Operators:**

```cpp
==   // Equal to
!=   // Not equal to
<    // Less than
>    // Greater than
<=   // Less than or equal to
>=   // Greater than or equal to
```

**4. Logical Operators:**

```cpp
&&   // AND (both must be true)
||   // OR (at least one must be true)
!    // NOT (inverts boolean value)
```

**5. Increment/Decrement:**

```cpp
++x  // Pre-increment (increment first, then use)
x++  // Post-increment (use first, then increment)
--x  // Pre-decrement
x--  // Post-decrement
```

**6. Operator Precedence (High to Low):**

```
1. ++, -- (post)
2. ++, --, ! (pre and not)
3. *, /, %
4. +, -
5. <, <=, >, >=
6. ==, !=
7. &&
8. ||
9. =, +=, -=, *=, /=, %=
```

Use parentheses to clarify intent:
```cpp
int result = a + b * c;      // b*c first, then add a
int result = (a + b) * c;    // a+b first, then multiply by c
```

**7. Common Patterns:**

**Accumulator:**
```cpp
int total = 0;
total += value;  // Add to running total
```

**Counter:**
```cpp
int count = 0;
count++;  // Increment counter
```

**Toggle:**
```cpp
bool flag = true;
flag = !flag;  // Toggle between true and false
```

**Validation:**
```cpp
bool is_valid = (age >= 18) && (age <= 65) && has_id;
```

**8. Philippine Developer Context:**

Common use cases in local applications:
- **E-commerce:** Price calculations, discounts, tax (VAT)
- **Point-of-Sale:** Change calculation, inventory updates
- **Banking:** Interest calculations, balance updates
- **Transportation:** Fare computation, distance-based pricing
- **Utilities:** Bill computation, usage tracking
- **Government:** Age verification, eligibility checks
- **Gaming:** Score calculation, level progression

**9. Tips:**
- Use `==` for comparison, not `=` (assignment)
- Integer division truncates: `5 / 2 = 2`, not `2.5`
- Use `%` for cyclical patterns and remainders
- Logical operators short-circuit (optimize accordingly)
- Prefer clear expressions over clever one-liners
- Use parentheses when precedence is unclear
