## Background Story

Tian was building a barangay dues calculator. Residents owed 500 pesos monthly, but some paid partial amounts, others had penalties, and some had discounts.

"I have all these numbers stored in variables," Tian said, staring at the screen, "but they're just sitting there! How do I actually calculate who owes what?"

Kuya Miguel laughed. "You've got the ingredients but no cooking tools! In programming, **operators** are your mathematical and logical tools. Think of them as the jeepney driver's skills—knowing when to add speed, when to subtract by braking, when to multiply distance by time, or when to divide the fare among passengers."

"Every calculation you see in games—damage reduction, score multipliers, health regeneration—uses these operators. Every financial system, every physics engine, every data analysis tool. Master these fundamental operations, and you can build anything that involves computation. Let's turn those static variables into dynamic calculations!"

---

## Theory & Lecture Content

## What are Operators?

**Operators** are special symbols that perform operations on variables and values (called **operands**).

**Analogy:** Operators are like mathematical symbols (+, -, ×, ÷) but more powerful. They help you build **expressions** - combinations of values and operations that produce a result.

**Simple expression:**
```cpp
int result = 5 + 3;  // + is the operator, 5 and 3 are operands
```

## Types of Operators in C++

1. **Arithmetic Operators** - Math operations
2. **Comparison Operators** - Compare values
3. **Logical Operators** - Combine conditions
4. **Assignment Operators** - Assign values
5. **Increment/Decrement Operators** - Change by 1

Let's explore each type!

## 1. Arithmetic Operators

### Basic Arithmetic

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `10 - 4` | `6` |
| `*` | Multiplication | `7 * 3` | `21` |
| `/` | Division | `20 / 4` | `5` |
| `%` | Modulo (Remainder) | `10 % 3` | `1` |

### Addition (`+`)

```cpp
int x = 10;
int y = 5;
int sum = x + y;     // 15

double price1 = 25.50;
double price2 = 30.00;
double total = price1 + price2;  // 55.50
```

**String concatenation** (joining strings):
```cpp
string firstName = "Tian";
string lastName = "Reyes";
string fullName = firstName + " " + lastName;  // "Tian Reyes"
```

### Subtraction (`-`)

```cpp
int balance = 1000;
int withdrawal = 250;
int remaining = balance - withdrawal;  // 750

int score = 100;
int penalty = 15;
int finalScore = score - penalty;  // 85
```

### Multiplication (`*`)

```cpp
int price = 50;
int quantity = 3;
int total = price * quantity;  // 150

double hours = 8.5;
double hourlyRate = 150.00;
double salary = hours * hourlyRate;  // 1275.00
```

### Division (`/`)

**Important:** Integer division vs decimal division!

```cpp
// Integer division (both operands are int)
int a = 10;
int b = 3;
int result = a / b;  // 3 (not 3.333... - decimal part is lost!)

// Decimal division (at least one operand is double/float)
double x = 10.0;
double y = 3.0;
double result2 = x / y;  // 3.33333...

// Mixed (int divided by double)
int num = 10;
double denom = 3.0;
double result3 = num / denom;  // 3.33333...
```

**Common mistake:**
```cpp
int average = (80 + 90 + 85) / 3;  // 85 (integer division)
double averageCorrect = (80 + 90 + 85) / 3.0;  // 85.0 (decimal)
```

**Philippine example:**
```cpp
// Splitting bill among friends
double totalBill = 1500.00;
int friends = 4;
double perPerson = totalBill / friends;  // 375.00
```

### Modulo (`%`)

**Purpose:** Get the remainder after division

```cpp
int a = 10;
int b = 3;
int remainder = a % b;  // 1 (because 10 ÷ 3 = 3 remainder 1)

int x = 20;
int y = 5;
int rem = x % y;  // 0 (20 is perfectly divisible by 5)
```

**Use cases:**

**Check if number is even or odd:**
```cpp
int number = 7;
if (number % 2 == 0) {
    cout << "Even";
} else {
    cout << "Odd";  // This runs (7 % 2 = 1)
}
```

**Cycle through values (like clock):**
```cpp
int hour = 25;
int validHour = hour % 24;  // 1 (wraps around after 24)
```

**Distribute items:**
```cpp
int candies = 17;
int children = 5;
int perChild = candies / children;  // 3
int leftover = candies % children;  // 2
cout << "Each child gets " << perChild << " candies." << endl;
cout << leftover << " candies left over." << endl;
```

## 2. Comparison Operators

**Purpose:** Compare two values, returns `true` or `false`

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `==` | Equal to | `5 == 5` | `true` |
| `!=` | Not equal to | `5 != 3` | `true` |
| `>` | Greater than | `10 > 5` | `true` |
| `<` | Less than | `3 < 8` | `true` |
| `>=` | Greater than or equal | `5 >= 5` | `true` |
| `<=` | Less than or equal | `4 <= 3` | `false` |

### Equal to (`==`)

**WARNING:** Don't confuse `==` (comparison) with `=` (assignment)!

```cpp
int x = 5;
int y = 5;

if (x == y) {
    cout << "Equal!";  // This runs
}

// Common mistake:
if (x = y) {  // WRONG! This assigns y to x, not comparison
    cout << "This is NOT a comparison!";
}
```

### Examples:

```cpp
int age = 18;
bool isAdult = (age >= 18);  // true

int score = 75;
const int PASSING = 75;
bool passed = (score >= PASSING);  // true

string password = "secret123";
bool correct = (password == "secret123");  // true
```

### Philippine Examples:

```cpp
// Jeepney fare check
double distance = 5.0;
const double BASE_DISTANCE = 4.0;
bool needsExtraFare = (distance > BASE_DISTANCE);  // true

// Voting age check
int age = 17;
const int VOTING_AGE = 18;
bool canVote = (age >= VOTING_AGE);  // false

// Grade check
double grade = 76.5;
const double PASSING_GRADE = 75.0;
bool isPassed = (grade >= PASSING_GRADE);  // true
```

## 3. Logical Operators

**Purpose:** Combine multiple conditions

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `&&` | AND | `true && true` | `true` |
| `\|\|` | OR | `true \|\| false` | `true` |
| `!` | NOT | `!true` | `false` |

### AND Operator (`&&`)

**Rule:** BOTH conditions must be true

**Truth table:**
```
A     B     A && B
true  true  true    ✓ (only this is true)
true  false false
false true  false
false false false
```

**Examples:**
```cpp
int age = 20;
bool hasID = true;

// Can enter club? (must be 18+ AND have ID)
bool canEnter = (age >= 18) && (hasID == true);  // true

int score = 85;
int attendance = 90;

// Gets award? (score >= 80 AND attendance >= 85)
bool getsAward = (score >= 80) && (attendance >= 85);  // true
```

**Philippine example:**
```cpp
// Can apply for scholarship?
int gpa = 90;
int familyIncome = 25000;

bool qualifies = (gpa >= 85) && (familyIncome <= 30000);  // true
cout << "Scholarship qualified: " << (qualifies ? "Yes" : "No") << endl;
```

### OR Operator (`||`)

**Rule:** AT LEAST ONE condition must be true

**Truth table:**
```
A     B     A || B
true  true  true
true  false true    ✓ (any true → true)
false true  true    ✓
false false false   (only all false → false)
```

**Examples:**
```cpp
bool hasWifi = false;
bool hasMobileData = true;

// Can access internet? (WiFi OR mobile data)
bool canConnect = hasWifi || hasMobileData;  // true

int mathGrade = 74;
int scienceGrade = 80;

// Pass any subject? (math >= 75 OR science >= 75)
bool passedAny = (mathGrade >= 75) || (scienceGrade >= 75);  // true
```

**Philippine example:**
```cpp
// Can pay tuition? (GCash OR Cash OR Bank transfer)
bool hasGCash = true;
bool hasCash = false;
bool hasBankAccount = false;

bool canPay = hasGCash || hasCash || hasBankAccount;  // true
```

### NOT Operator (`!`)

**Rule:** Reverses the boolean value

```cpp
bool isRaining = false;
bool isSunny = !isRaining;  // true

bool hasInternet = true;
bool offline = !hasInternet;  // false
```

**Examples:**
```cpp
bool isLoggedIn = false;
if (!isLoggedIn) {
    cout << "Please log in first.";  // This runs
}

bool hasSubmitted = true;
if (!hasSubmitted) {
    cout << "Submit your assignment!";
} else {
    cout << "Already submitted!";  // This runs
}
```

### Combining Logical Operators

**Complex conditions:**
```cpp
int age = 17;
bool hasParentConsent = true;
bool hasID = true;

// Can register? (18+ OR (under 18 AND has parent consent)) AND has ID
bool canRegister = ((age >= 18) || (age < 18 && hasParentConsent)) && hasID;
// true (because age < 18 AND hasParentConsent is true, AND hasID is true)
```

**Philippine example - PWD/Senior discount:**
```cpp
int age = 65;
bool isPWD = false;

// Qualifies for discount? (senior 60+ OR PWD)
bool getsDiscount = (age >= 60) || isPWD;  // true
double price = 500.00;
double discount = getsDiscount ? 0.20 : 0.00;  // 20% discount
double finalPrice = price * (1 - discount);  // 400.00
```

## 4. Assignment Operators

### Basic Assignment (`=`)

```cpp
int x = 10;  // Assign 10 to x
x = 20;      // Reassign x to 20
```

### Compound Assignment Operators

Shortcuts for common operations:

| Operator | Example | Equivalent to |
|----------|---------|---------------|
| `+=` | `x += 5` | `x = x + 5` |
| `-=` | `x -= 3` | `x = x - 3` |
| `*=` | `x *= 2` | `x = x * 2` |
| `/=` | `x /= 4` | `x = x / 4` |
| `%=` | `x %= 3` | `x = x % 3` |

**Examples:**
```cpp
int score = 100;
score += 10;  // score = 110
score -= 5;   // score = 105
score *= 2;   // score = 210
score /= 3;   // score = 70

double balance = 1000.00;
balance += 500.00;  // Deposit: 1500.00
balance -= 200.00;  // Withdrawal: 1300.00
```

**Philippine example:**
```cpp
double gcashBalance = 5000.00;
gcashBalance += 1000.00;  // Received payment: 6000.00
gcashBalance -= 250.00;   // Paid bill: 5750.00
cout << "GCash Balance: ₱" << gcashBalance << endl;
```

## 5. Increment and Decrement Operators

**Purpose:** Increase or decrease value by 1

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `++` | Increment | `x++` | `x = x + 1` |
| `--` | Decrement | `x--` | `x = x - 1` |

### Post-increment (`x++`)

**Use value first, THEN increment:**
```cpp
int x = 5;
int y = x++;  // y = 5, then x becomes 6
cout << "x: " << x << ", y: " << y << endl;
// Output: x: 6, y: 5
```

### Pre-increment (`++x`)

**Increment first, THEN use value:**
```cpp
int x = 5;
int y = ++x;  // x becomes 6, then y = 6
cout << "x: " << x << ", y: " << y << endl;
// Output: x: 6, y: 6
```

**When to use which?**
- **Standalone:** `x++;` or `++x;` (no difference)
- **In expression:** Matters! (rare for beginners)

**Common usage:**
```cpp
int count = 0;
count++;  // Increment counter (most common)

int lives = 3;
lives--;  // Decrease lives

// Loop counters (you'll learn this soon)
for (int i = 0; i < 10; i++) {  // i++ increments after each loop
    // ...
}
```

## Operator Precedence

**Order of operations** (like PEMDAS in math):

1. **Parentheses** `()`
2. **Increment/Decrement** `++`, `--`
3. **Multiplication, Division, Modulo** `*`, `/`, `%`
4. **Addition, Subtraction** `+`, `-`
5. **Comparison** `<`, `>`, `<=`, `>=`
6. **Equality** `==`, `!=`
7. **Logical AND** `&&`
8. **Logical OR** `||`
9. **Assignment** `=`, `+=`, `-=`, etc.

**Examples:**
```cpp
int result = 5 + 3 * 2;  // 11 (not 16, because * before +)
int result2 = (5 + 3) * 2;  // 16 (parentheses first)

bool check = 10 > 5 && 20 < 30;  // true (comparisons before &&)

int x = 10 + 5 * 2;  // 20 (not 30)
```

**Best practice:** Use parentheses to make it clear!
```cpp
int average = (score1 + score2 + score3) / 3;  // Clear!
```

## Practical Examples

### Example 1: Grade Calculator with Conditions

```cpp
#include <iostream>
using namespace std;

int main() {
    // Scores
    int quiz1 = 85;
    int quiz2 = 92;
    int exam = 88;
    
    // Calculate average
    double average = (quiz1 + quiz2 + exam) / 3.0;
    
    // Check if passed (>= 75)
    const double PASSING_GRADE = 75.0;
    bool passed = (average >= PASSING_GRADE);
    
    // Display results
    cout << "Average: " << average << endl;
    cout << "Status: " << (passed ? "PASSED" : "FAILED") << endl;
    
    return 0;
}
```

### Example 2: Discount Calculator

```cpp
#include <iostream>
using namespace std;

int main() {
    double price = 1500.00;
    int age = 65;
    bool isPWD = false;
    
    // Senior (60+) or PWD gets 20% discount
    bool getsDiscount = (age >= 60) || isPWD;
    double discountRate = getsDiscount ? 0.20 : 0.00;
    double discount = price * discountRate;
    double finalPrice = price - discount;
    
    cout << "Original Price: ₱" << price << endl;
    cout << "Discount: ₱" << discount << endl;
    cout << "Final Price: ₱" << finalPrice << endl;
    
    return 0;
}
```

### Example 3: GCash Balance Tracker

```cpp
#include <iostream>
using namespace std;

int main() {
    double balance = 5000.00;
    
    cout << "Initial Balance: ₱" << balance << endl;
    
    // Deposit
    balance += 1500.00;
    cout << "After deposit: ₱" << balance << endl;
    
    // Pay bills
    balance -= 800.00;
    cout << "After paying bills: ₱" << balance << endl;
    
    // Send money to friend
    balance -= 500.00;
    cout << "After sending money: ₱" << balance << endl;
    
    // Check if balance is sufficient
    double minimumBalance = 100.00;
    bool isSufficient = (balance >= minimumBalance);
    cout << "Balance OK: " << (isSufficient ? "Yes" : "Low balance!") << endl;
    
    return 0;
}
```

## Common Mistakes

### Mistake 1: Integer Division

**Wrong:**
```cpp
int average = (80 + 90 + 100) / 3;  // 90 (should be 90.0)
```

**Correct:**
```cpp
double average = (80 + 90 + 100) / 3.0;  // 90.0
```

### Mistake 2: Assignment vs Comparison

**Wrong:**
```cpp
if (x = 5) {  // WRONG! This assigns 5 to x
    cout << "x is 5";
}
```

**Correct:**
```cpp
if (x == 5) {  // Correct comparison
    cout << "x is 5";
}
```

### Mistake 3: Logical Operator Confusion

**Wrong:**
```cpp
if (age >= 18 && <= 65) {  // SYNTAX ERROR
```

**Correct:**
```cpp
if (age >= 18 && age <= 65) {  // Must specify variable twice
```

## Summary

**Key Takeaways:**

1. **Arithmetic operators:** `+`, `-`, `*`, `/`, `%`
   - Watch out for integer division!

2. **Comparison operators:** `==`, `!=`, `>`, `<`, `>=`, `<=`
   - Returns true or false

3. **Logical operators:** `&&` (AND), `||` (OR), `!` (NOT)
   - Combine multiple conditions

4. **Assignment operators:** `=`, `+=`, `-=`, `*=`, `/=`, `%=`
   - Shortcuts for common operations

5. **Increment/Decrement:** `++`, `--`
   - Change value by 1

6. **Operator precedence** matters - use parentheses for clarity!

---

## Closing Story

Tian practiced writing expressions for an hour, combining arithmetic, comparison, and logical operators. "Kuya, this is like building with Lego blocks! I can combine operators to create complex logic."

"That's the perfect analogy," Kuya Miguel said. "Simple operators combine to solve complex problems. You can now calculate grades, check eligibility for scholarships, and make smart decisions in your programs."

"But there's one thing missing," Tian frowned. "My programs still use hardcoded values. How do I make them interactive?"

Kuya Miguel smiled. "Perfect timing! Next, we'll learn about cin and cout - how to get input from users and display beautiful output. Your programs will finally be able to talk to people!"

Tian opened a new file, ready to make his programs come alive.

**Next Lesson Preview:**
In Lesson 4, you'll learn about **input and output** - how to interact with users using `cin` and `cout`, format output beautifully, and handle different types of input!

Ready to talk to your users? Let's continue!
