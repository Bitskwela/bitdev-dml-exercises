# Lesson 3 Activities: Operators as Tools

---

## Activity 1: Simple Calculator

**Objective:** Practice using arithmetic operators on two numbers.

**Task:**  
Create a program that performs all basic arithmetic operations (addition, subtraction, multiplication, division, and modulo) on two numbers.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double num1 = 10;
    double num2 = 3;
    
    // Calculate and display results
    
    return 0;
}
```

**Expected Output:**
```
Number 1: 10
Number 2: 3
Sum: 13
Difference: 7
Product: 30
Quotient: 3.33333
Remainder: 1
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double num1 = 10;
    double num2 = 3;
    
    cout << "Number 1: " << num1 << endl;
    cout << "Number 2: " << num2 << endl;
    cout << "Sum: " << (num1 + num2) << endl;
    cout << "Difference: " << (num1 - num2) << endl;
    cout << "Product: " << (num1 * num2) << endl;
    cout << "Quotient: " << (num1 / num2) << endl;
    cout << "Remainder: " << ((int)num1 % (int)num2) << endl;
    
    return 0;
}
```

---

## Activity 2: Even or Odd Checker

**Objective:** Use the modulo operator to determine if a number is even or odd.

**Task:**  
Write a program that checks whether a given number is even or odd.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int number = 17;
    
    // Check if even using modulo operator
    
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
