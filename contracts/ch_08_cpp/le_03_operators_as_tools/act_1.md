# Lesson 3 Activities: Operators as Tools

## From Static Variables to Dynamic Calculations

Remember Tian's frustration building the barangay dues calculator? Variables were declared but just sitting there—500 pesos stored but no way to actually calculate who owes what! Kuya Miguel's analogy was perfect: "You've got the ingredients but no cooking tools!"

**Operators are your mathematical and logical tools.** Think of them as the jeepney driver's skills—knowing when to add speed, when to subtract by braking, when to multiply distance by time. Every calculation you see in games (damage reduction, score multipliers, health regeneration), every financial system, every data analysis tool—all use operators.

**What You'll Master:**
- **Arithmetic operators** (+, -, *, /, %) for mathematical calculations
- **Comparison operators** (==, !=, <, >, <=, >=) for decision-making
- **Assignment operators** (=, +=, -=, *=, /=) for updating values
- **Increment/Decrement** (++, --) for counters and loops

This lesson transforms static data into dynamic, interactive programs!

---

## Task 1: Complete Calculator System

**Context:**  
You're building a calculator for a barangay office that needs to perform various calculations daily—from budget planning to resident fee calculations. Unlike a simple hardcoded calculation, this calculator demonstrates all arithmetic operations on any two numbers.

**Your Challenge:**  
Create a comprehensive calculator that performs ALL basic arithmetic operations and displays the results clearly.

**What You'll Practice:**
- Addition (+) for combining values
- Subtraction (-) for finding differences
- Multiplication (*) for scaling values
- Division (/) for distributing or averaging
- Modulo (%) for finding remainders

**Important Concepts:**
- Integer division vs decimal division
- Modulo for remainder calculations
- Order of operations (PEMDAS)
- Type casting when needed

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double num1 = 10;
    double num2 = 3;
    
    // Perform and display ALL arithmetic operations
    
    return 0;
}
```

**Expected Output:**
```
=== CALCULATOR SYSTEM ===
Number 1: 10
Number 2: 3

ARITHMETIC OPERATIONS:
Sum: 13
Difference: 7
Product: 30
Quotient: 3.33333
Remainder: 1
```

**Challenge:** Why do we cast to `int` for the modulo operation? What happens if you try modulo with doubles?

---

## Task 2: Jeepney Fare Calculator

**Context:**  
Manila jeepneys have a base fare of ₱13 for the first 4 kilometers, then ₱2 for each additional kilometer. You need to calculate fares using multiplication and addition operators.

**Your Challenge:**  
Build a fare calculator that computes the total fare based on distance traveled.

**Formula:**
- Distance ≤ 4 km: ₱13
- Distance > 4 km: ₱13 + (additional km × ₱2)

**What You'll Learn:**
- Combining operators in calculations
- Real-world application of arithmetic
- Working with money (double precision)

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance = 7.5;  // kilometers
    double baseFare = 13.00;
    double additionalRate = 2.00;
    double totalFare;
    
    // Calculate fare based on distance
    
    return 0;
}
```

**Expected Output:**
```
Distance: 7.5 km
Base Fare (first 4km): ₱13.00
Additional Distance: 3.5 km
Additional Charge: ₱7.00
Total Fare: ₱20.00
```

---

## Task 3: Modulo Magic - Even/Odd Detector

**Context:**  
The modulo operator (%) is incredibly useful! It returns the remainder after division. If `number % 2 == 0`, the number is even (no remainder). This is used everywhere—from determining alternating colors in UI to scheduling shifts.
    
    return 0;
}
```

**Expected Output:**
```
Number: 17
Type: Odd
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int number = 17;
    
    bool isEven = (number % 2 == 0);
    
    cout << "Number: " << number << endl;
    cout << "Type: " << (isEven ? "Even" : "Odd") << endl;
    
    return 0;
}
```

---

## Activity 3: Scholarship Eligibility Checker

**Objective:** Practice using logical operators (AND) to combine multiple conditions.

**Task:**  
Check if a student qualifies for a scholarship based on two criteria:
- GPA must be >= 85
- Family income must be <= ₱30,000

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double gpa = 90.0;
    double familyIncome = 25000.00;
    
    // Check eligibility using logical AND
    
    return 0;
}
```

**Expected Output:**
```
GPA: 90
Family Income: ₱25000
Scholarship Qualified: YES
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double gpa = 90.0;
    double familyIncome = 25000.00;
    
    bool qualifies = (gpa >= 85.0) && (familyIncome <= 30000.00);
    
    cout << "GPA: " << gpa << endl;
    cout << "Family Income: ₱" << familyIncome << endl;
    cout << "Scholarship Qualified: " << (qualifies ? "YES" : "NO") << endl;
    
    return 0;
}
```

---

## Activity 4: Temperature Converter

**Objective:** Apply arithmetic operators in a real-world formula.

**Task:**  
Convert temperature from Celsius to Fahrenheit using the formula:  
**F = (C × 9/5) + 32**

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double celsius = 30.0;
    
    // Convert to Fahrenheit
    
    return 0;
}
```

**Expected Output:**
```
30°C = 86°F
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double celsius = 30.0;
    double fahrenheit = (celsius * 9.0 / 5.0) + 32.0;
    
    cout << celsius << "°C = " << fahrenheit << "°F" << endl;
    
    return 0;
}
```

---

## Challenge Activity: Jeepney Fare Calculator

**Objective:** Combine multiple operators to solve a real Philippine scenario.

**Task:**  
Calculate jeepney fare based on distance:
- Base fare: ₱13.00 (first 4 km)
- Additional: ₱2.00 per kilometer after 4 km
- Senior citizen discount: 20% off total fare

**Test cases:**
- Distance: 3 km, Senior: No → ₱13.00
- Distance: 7 km, Senior: No → ₱19.00
- Distance: 10 km, Senior: Yes → ₱20.80

**Hint:** Use comparison operators and arithmetic operators together

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

int main() {
    double distance = 10.0;
    bool isSenior = true;
    
    double fare;
    if (distance <= 4) {
        fare = 13.00;
    } else {
        fare = 13.00 + ((distance - 4) * 2.00);
    }
    
    // Apply senior discount
    if (isSenior) {
        fare = fare * 0.80;  // 20% off
    }
    
    cout << "Distance: " << distance << " km" << endl;
    cout << "Senior Citizen: " << (isSenior ? "Yes" : "No") << endl;
    cout << "Fare: ₱" << fare << endl;
    
    return 0;
}
```

</details>

---

## Debugging Exercise: Operator Mistakes

**Objective:** Identify and fix common operator errors.

**Task:**  
The following program has 5 operator-related errors. Find and fix them.

**Buggy Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int score1 = 85;
    int score2 = 90;
    int score3 = 78;
    
    double average = (score1 + score2 + score3) / 3;
    
    bool passed = average = 75;
    bool highHonors = (average >= 90 && <= 100);
    
    int count = 0;
    count =+ 5;
    
    cout << "Average: " << average << endl;
    cout << "Passed: " << passed << endl;
    cout << "High Honors: " << highHonors << endl;
    cout << "Count: " << count << endl;
    
    return 0;
}
```

**Errors to find:**
1. Integer division (should use 3.0)
2. Assignment instead of comparison (= vs ==)
3. Incomplete logical expression
4. Wrong compound operator (=+ vs +=)

<details>
<summary>Click to view corrected code</summary>

```cpp
#include <iostream>
using namespace std;

int main() {
    int score1 = 85;
    int score2 = 90;
    int score3 = 78;
    
    double average = (score1 + score2 + score3) / 3.0;  // Fixed: 3.0 instead of 3
    
    bool passed = average >= 75;  // Fixed: >= instead of =
    bool highHonors = (average >= 90 && average <= 100);  // Fixed: added 'average' before <=
    
    int count = 0;
    count += 5;  // Fixed: += instead of =+
    
    cout << "Average: " << average << endl;
    cout << "Passed: " << passed << endl;
    cout << "High Honors: " << highHonors << endl;
    cout << "Count: " << count << endl;
    
    return 0;
}
```

</details>

---

## Reflection Questions

After completing these activities:

1. **What's the difference between `/` and `%` operators?**
   - `/` performs division, `%` gives the remainder

2. **Why does `5 / 2` give `2` instead of `2.5`?**
   - Integer division truncates the decimal part

3. **When would you use `&&` vs `||`?**
   - `&&` (AND) when ALL conditions must be true
   - `||` (OR) when AT LEAST ONE condition must be true

4. **What's the difference between `==` and `=`?**
   - `==` compares values (returns true/false)
   - `=` assigns a value to a variable

---

## Next Steps

Great work! You now understand:
- ✅ Arithmetic operators (+, -, *, /, %)
- ✅ Comparison operators (==, !=, <, >, <=, >=)
- ✅ Logical operators (&&, ||, !)
- ✅ Assignment operators (=, +=, -=, *=, /=)
- ✅ Operator precedence and using parentheses

**Ready for Lesson 4?**  
Next, you'll learn about **input and output** - how to make your programs interactive by getting user input and displaying formatted output!
