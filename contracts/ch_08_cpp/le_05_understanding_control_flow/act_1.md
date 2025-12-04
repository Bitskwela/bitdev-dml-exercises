# Lesson 5 Activities: Understanding Control Flow

## The Jeepney Driver Who Looks at the Road

Remember Tian's divide-by-zero crash? Her calculator crashed spectacularly when divisor was zero. Kuya Miguel gave her the perfect analogy: **"Right now, your program is like a jeepney driver who never looks at the road—keeps driving straight no matter what's ahead."**

**This lesson changes that.** You're teaching your programs to **make intelligent decisions**—to check conditions before acting, to choose different paths based on data, to validate input before processing it.

**What makes control flow powerful:**
- **`if/else`** statements let your code choose between paths
- **Comparison operators** (`==`, `!=`, `<`, `>`, `<=`, `>=`) test relationships
- **Logical operators** (`&&`, `||`, `!`) combine multiple conditions
- **Input validation** prevents crashes and bad data

Every real program makes decisions: ATMs checking PINs, games detecting collisions, websites verifying passwords. Today, your code gets smart!

---

## Task 1: Safe Division Calculator

**Context:**  
Tian's calculator crashed when dividing by zero. Build a smarter version that checks the divisor before performing division—just like a driver checks for obstacles before moving forward.

**Your Challenge:**  
Create a calculator that validates input and prevents division by zero crashes with clear error messages.

**What You'll Practice:**
- `if/else` statements for decision-making
- Comparison operators (`==`, `!=`)
- Input validation before operations
- User-friendly error messages

**Key Concepts:**
```cpp
if (divisor == 0) {
    // Handle error case
} else {
    // Safe to divide
}
```

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double num1, num2, result;
    
    cout << "=== SAFE DIVISION CALCULATOR ===" << endl;
    cout << endl;
    
    // Get two numbers from user
    // Check if divisor is zero
    // If zero, show error
    // If not zero, perform division and show result
    
    return 0;
}
```

**Expected Output (valid input):**
```
=== SAFE DIVISION CALCULATOR ===

Enter first number: 100
Enter second number: 5

100.00 ÷ 5.00 = 20.00
```

**Expected Output (division by zero):**
```
=== SAFE DIVISION CALCULATOR ===

Enter first number: 100
Enter second number: 0

ERROR: Cannot divide by zero!
Division by zero is mathematically undefined.
Please enter a non-zero divisor.
```

---

## Task 2: Jeepney Fare with Discount Checker

**Context:**  
Jeepney drivers give discounts to students (20%), senior citizens (20%), and PWDs (20%). Build a fare calculator that asks if the passenger qualifies for a discount before calculating the final fare.

**Your Challenge:**  
Create an interactive fare system that checks discount eligibility and applies it automatically.

**What You'll Practice:**
- `if/else if/else` chains for multiple conditions
- Character input (`y/n`)
- Discount calculations
- Clear conditional logic

**Formula:**
- Base fare: PHP 13.00 (first 4 km)
- Additional: PHP 2.00 per km after 4 km
- Discount: 20% if qualified

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance, fare, discount = 0, finalFare;
    char hasDiscount;
    
    cout << "=== JEEPNEY FARE CALCULATOR ===" << endl;
    cout << endl;
    
    // Get distance
    // Calculate base fare
    // Ask if qualified for discount (y/n)
    // Apply discount if applicable
    // Display breakdown
    
    return 0;
}
```

**Expected Output:**
```
=== JEEPNEY FARE CALCULATOR ===

Enter distance traveled (km): 7.5
Are you a student/senior citizen/PWD? (y/n): y

----- FARE RECEIPT -----
Distance: 7.5 km
Base Fare: PHP 20.00
Discount (20%): PHP 4.00
Final Fare: PHP 16.00
Thank you for riding!
```

---

## Task 3: Barangay Age Classification System

**Context:**  
Your barangay needs to classify residents for vaccination priority. Different age groups have different priorities: senior citizens (60+), adults (18-59), minors (13-17), and children (0-12).

**Your Challenge:**  
Build a classification system that uses nested `if/else` to categorize residents and assign vaccination priority levels.

**What You'll Practice:**
- Nested `if/else` for age ranges
- Multiple comparison operators
- Range checking (`>= && <=`)
- Complex conditional logic

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name;
    int age;
    
    cout << "=== BARANGAY AGE CLASSIFICATION ===" << endl;
    cout << endl;
    
    // Get name and age
    // Classify:
    //   - Senior Citizen (60+): Priority A
    //   - Adult (18-59): Priority B
    //   - Minor (13-17): Priority C
    //   - Child (0-12): Priority D
    //   - Invalid (negative): Error
    
    return 0;
}
```

**Expected Output:**
```
=== BARANGAY AGE CLASSIFICATION ===

Full name: Rosa Santos
Age: 65

----- CLASSIFICATION RESULT -----
Name: Rosa Santos
Age: 65
Category: Senior Citizen
Vaccination Priority: A (High Priority)
Special Assistance: Available
```

---

## Task 4: Grade Classification with Honors

**Context:**  
Teachers need a system that not only shows if a student passed but also awards honors based on performance. Create a comprehensive grading system with multiple classification levels.

**Your Challenge:**  
Build a grade classifier that determines pass/fail status AND awards honors (Summa Cum Laude, Magna Cum Laude, Cum Laude) based on final grade.

**What You'll Practice:**
- Multiple `if/else if` chains
- Range validation (0-100)
- Nested conditions
- Comprehensive classification logic

**Classification:**
- 98-100: Passed with Summa Cum Laude
- 95-97: Passed with Magna Cum Laude
- 90-94: Passed with Cum Laude
- 75-89: Passed
- 0-74: Failed
- Outside 0-100: Invalid

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string studentName;
    double grade;
    
    cout << "=== STUDENT GRADE CLASSIFICATION ===" << endl;
    cout << endl;
    
    // Get student name and grade
    // Validate grade (0-100)
    // Classify and display result
    
    return 0;
}
```

**Expected Output (with honors):**
```
=== STUDENT GRADE CLASSIFICATION ===

Student name: Maria Clara
Final grade: 96.5

----- GRADE REPORT -----
Student: Maria Clara
Grade: 96.50
Status: PASSED ✓
Honors: MAGNA CUM LAUDE
Remarks: Outstanding performance!
```

**Expected Output (failed):**
```
=== STUDENT GRADE CLASSIFICATION ===

Student name: Juan Reyes
Final grade: 68.0

----- GRADE REPORT -----
Student: Juan Reyes
Grade: 68.00
Status: FAILED ✗
Remarks: Need to retake this subject.
```

---

## Task 5: Electricity Bill with Penalty Checker

**Context:**  
Meralco charges penalties for late payments. Build a bill calculator that checks if payment is late and applies a 5% penalty automatically based on due date status.

**Your Challenge:**  
Create a billing system that uses conditional logic to add penalties, applies tiered pricing for electricity consumption, and generates a complete bill.

**What You'll Practice:**
- Nested `if/else` for tiered pricing
- Boolean conditions for late payment
- Multiple percentage calculations
- Complex real-world logic

**Pricing Tiers:**
- 0-100 kWh: PHP 10.50/kWh
- 101-200 kWh: PHP 11.00/kWh
- 201-300 kWh: PHP 12.00/kWh
- 301+ kWh: PHP 13.50/kWh
- Late penalty: 5% if late

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double kwh, baseCharge = 0, penalty = 0, totalBill;
    char isLate;
    
    cout << "=== MERALCO BILLING SYSTEM ===" << endl;
    cout << endl;
    
    // Get kWh consumed
    // Calculate tiered base charge
    // Ask if payment is late (y/n)
    // Add 5% penalty if late
    // Display complete bill
    
    return 0;
}
```

**Expected Output:**
```
=== MERALCO BILLING SYSTEM ===

Enter kWh consumed: 250
Is payment late? (y/n): y

----- ELECTRICITY BILL -----
kWh Consumed: 250.00
Base Charge: PHP 2,850.00
Late Penalty (5%): PHP 142.50
----------------------------
TOTAL AMOUNT DUE: PHP 2,992.50
Payment Status: OVERDUE ⚠
```

---

## Task 6: BMI Calculator with Health Recommendations

**Context:**  
Healthcare workers need a tool that calculates Body Mass Index (BMI) and provides specific health recommendations based on classification (underweight, normal, overweight, obese).

**Your Challenge:**  
Build a comprehensive BMI calculator that validates input, classifies results, and gives personalized health advice.

**What You'll Practice:**
- Input validation (positive values only)
- Formula calculations (BMI = weight / height²)
- Multi-level `if/else` classification
- Contextual recommendations

**BMI Classification:**
- Below 18.5: Underweight
- 18.5-24.9: Normal weight
- 25.0-29.9: Overweight
- 30.0+: Obese

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double weight, height, bmi;
    
    cout << "=== BMI HEALTH CALCULATOR ===" << endl;
    cout << endl;
    
    // Get weight (kg) and height (m)
    // Validate positive values
    // Calculate BMI = weight / (height * height)
    // Classify and give recommendations
    
    return 0;
}
```

**Expected Output:**
```
=== BMI HEALTH CALCULATOR ===

Enter weight (kg): 70
Enter height (m): 1.75

----- BMI ANALYSIS -----
Weight: 70.0 kg
Height: 1.75 m
BMI: 22.86
Classification: Normal Weight
Health Status: ✓ Healthy range
Recommendation: Maintain your current lifestyle with balanced diet and regular exercise.
```

---

## Task 7: Scholarship Eligibility Checker

**Context:**  
Universities offer different scholarships based on combined criteria: grade (must be ≥ 90) AND family income (must be < PHP 50,000/month). Both conditions must be true to qualify.

**Your Challenge:**  
Create a scholarship eligibility system that uses **logical AND operator (`&&`)** to check if BOTH conditions are met.

**What You'll Practice:**
- Logical AND operator (`&&`)
- Multiple condition checking
- Clear eligibility messages
- Real-world policy implementation

**Scholarship Types:**
- Full Scholarship: Grade ≥ 95 AND Income < 30,000
- Partial Scholarship: Grade ≥ 90 AND Income < 50,000
- Not Eligible: Otherwise

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    string studentName;
    double grade, monthlyIncome;
    
    cout << "=== SCHOLARSHIP ELIGIBILITY CHECKER ===" << endl;
    cout << endl;
    
    // Get student name, grade, monthly family income
    // Check eligibility using && operator
    // Display scholarship type or rejection
    
    return 0;
}
```

**Expected Output (full scholarship):**
```
=== SCHOLARSHIP ELIGIBILITY CHECKER ===

Student name: Ana Reyes
Final grade: 96.5
Monthly family income (PHP): 25000

----- ELIGIBILITY RESULT -----
Student: Ana Reyes
Grade: 96.50
Family Income: PHP 25,000.00

✓ ELIGIBLE FOR FULL SCHOLARSHIP
Coverage: 100% tuition + PHP 5,000 monthly stipend
Congratulations!
```

**Expected Output (not eligible):**
```
=== SCHOLARSHIP ELIGIBILITY CHECKER ===

Student name: Juan Cruz
Final grade: 88.0
Monthly family income (PHP): 60000

----- ELIGIBILITY RESULT -----
Student: Juan Cruz
Grade: 88.00
Family Income: PHP 60,000.00

✗ NOT ELIGIBLE
Reason: Grade below 90 OR income exceeds threshold
Consider applying next semester after improvement.
```

---

## Reflection Questions

After completing these tasks, think deeply about decision-making in code:

1. **The Crash Prevention Mindset**: Before lesson 5, Tian's calculator crashed on zero. Now it checks first. What other real-world programs MUST validate input before acting? (ATMs, airplanes, medical devices?)

2. **Comparison vs Assignment**: What's the difference between `if (x = 5)` and `if (x == 5)`? Why is the first one dangerous? Test it—what happens?

3. **Logical Operators in Daily Life**: The scholarship checker uses `&&` (both conditions must be true). Think of 3 real situations where you need `&&` (AND) vs `||` (OR) logic. Example: "You can withdraw money if you have correct PIN AND sufficient balance."

4. **Range Checking Patterns**: Look at Task 3 (age classification). How do you check if a number is between 18 and 59? Why use `age >= 18 && age <= 59` instead of two separate if statements?

5. **Nested vs Flat Conditionals**: Task 5 has nested `if/else` for electricity tiers. Could you rewrite it with flat `if/else if` chains? Which is clearer? When does nesting make sense?

6. **Error Messages Matter**: Compare "ERROR" vs "ERROR: Cannot divide by zero! Division by zero is mathematically undefined." Which helps users more? Why do professional programs invest in good error messages?

7. **The Jeepney Driver Analogy**: Kuya Miguel said your program was "a driver who never looks at the road." Now with `if/else`, your code checks conditions before acting. Think of 3 more analogies for decision-making in code (chef tasting food before serving? doctor checking symptoms before diagnosis?).

8. **Boolean Logic Complexity**: In Task 7, scholarship needs grade ≥ 90 AND income < 50,000. What if the rule was "grade ≥ 90 OR income < 50,000 (but not both)"? How would you code that with `&&`, `||`, and `!` operators?

---

## What You've Learned

You've given your programs **intelligence**. They're no longer linear scripts—they can **analyze, decide, and adapt** based on data.

**Core Skills Unlocked:**
- **`if/else` statements** – Choose between code paths
- **Comparison operators** – `==`, `!=`, `<`, `>`, `<=`, `>=`
- **Logical operators** – `&&` (AND), `||` (OR), `!` (NOT)
- **Input validation** – Check before processing
- **Nested conditions** – Handle complex multi-level decisions
- **Range checking** – Validate data within boundaries

**Real-World Applications:**
- **Banking**: ATMs checking PINs, verifying balances before withdrawal
- **E-commerce**: Discount eligibility, free shipping thresholds
- **Healthcare**: BMI classification, disease risk assessment
- **Education**: Grading systems, scholarship eligibility
- **Government**: Barangay systems, age-based classifications, bill calculations

**The Transformation:**
```cpp
// Before (Lesson 4): Blind execution
double result = num1 / num2;  // CRASH if num2 is 0!

// After (Lesson 5): Smart checking
if (num2 == 0) {
    cout << "ERROR: Cannot divide by zero!" << endl;
} else {
    double result = num1 / num2;
    cout << "Result: " << result << endl;
}
```

As Kuya Miguel said: **"Now your program is like a smart jeepney driver—it checks the road, avoids obstacles, and makes decisions."** Your code is no longer reckless—it's **careful, intelligent, and crash-proof**.

Next lesson: **Loops**—because typing 200 lines of the same code is absurd. You'll learn to automate repetition with `for`, `while`, and `do-while` loops!

---

<details>
<summary><strong>📝 Answer Key for All Tasks</strong></summary>

### Task 1: Safe Division Calculator

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double num1, num2, result;
    
    cout << "=== SAFE DIVISION CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Enter first number: ";
    cin >> num1;
    
    cout << "Enter second number: ";
    cin >> num2;
    
    cout << endl;
    
    // Check if divisor is zero
    if (num2 == 0) {
        cout << "ERROR: Cannot divide by zero!" << endl;
        cout << "Division by zero is mathematically undefined." << endl;
        cout << "Please enter a non-zero divisor." << endl;
    } else {
        result = num1 / num2;
        cout << fixed << setprecision(2);
        cout << num1 << " ÷ " << num2 << " = " << result << endl;
    }
    
    return 0;
}
```

**Key Points:**
- `if (num2 == 0)` checks for zero BEFORE dividing
- Clear error message explains WHY it's an error
- `else` block only runs when division is safe
- This prevents the crash Tian experienced!

---

### Task 2: Jeepney Fare with Discount Checker

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance, fare, discount = 0, finalFare;
    char hasDiscount;
    
    cout << "=== JEEPNEY FARE CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Enter distance traveled (km): ";
    cin >> distance;
    
    // Calculate base fare
    if (distance <= 4) {
        fare = 13.00;
    } else {
        fare = 13.00 + ((distance - 4) * 2.00);
    }
    
    // Check discount eligibility
    cout << "Are you a student/senior citizen/PWD? (y/n): ";
    cin >> hasDiscount;
    
    if (hasDiscount == 'y' || hasDiscount == 'Y') {
        discount = fare * 0.20;  // 20% discount
        finalFare = fare - discount;
    } else {
        finalFare = fare;
    }
    
    cout << endl;
    cout << "----- FARE RECEIPT -----" << endl;
    cout << fixed << setprecision(2);
    cout << "Distance: " << distance << " km" << endl;
    cout << "Base Fare: PHP " << fare << endl;
    
    if (discount > 0) {
        cout << "Discount (20%): PHP " << discount << endl;
    }
    
    cout << "Final Fare: PHP " << finalFare << endl;
    cout << "Thank you for riding!" << endl;
    
    return 0;
}
```

**Key Points:**
- First `if/else` calculates base fare with distance check
- Second `if` applies discount only if qualified
- Uses `||` (OR) to accept both 'y' and 'Y'
- Discount only displays if actually applied

---

### Task 3: Barangay Age Classification System

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name;
    int age;
    
    cout << "=== BARANGAY AGE CLASSIFICATION ===" << endl;
    cout << endl;
    
    cout << "Full name: ";
    getline(cin, name);
    
    cout << "Age: ";
    cin >> age;
    
    cout << endl;
    cout << "----- CLASSIFICATION RESULT -----" << endl;
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    
    if (age < 0) {
        cout << "ERROR: Invalid age! Age cannot be negative." << endl;
    } else if (age >= 0 && age <= 12) {
        cout << "Category: Child" << endl;
        cout << "Vaccination Priority: D" << endl;
        cout << "Special Assistance: Pediatric care available" << endl;
    } else if (age >= 13 && age <= 17) {
        cout << "Category: Minor" << endl;
        cout << "Vaccination Priority: C" << endl;
        cout << "Special Assistance: Parental consent required" << endl;
    } else if (age >= 18 && age <= 59) {
        cout << "Category: Adult" << endl;
        cout << "Vaccination Priority: B" << endl;
        cout << "Special Assistance: Standard process" << endl;
    } else {  // age >= 60
        cout << "Category: Senior Citizen" << endl;
        cout << "Vaccination Priority: A (High Priority)" << endl;
        cout << "Special Assistance: Available" << endl;
    }
    
    return 0;
}
```

**Key Points:**
- Uses `if/else if/else` chain for multiple age ranges
- Range checking with `age >= X && age <= Y`
- Validates negative ages as error
- Each category gets specific information

---

### Task 4: Grade Classification with Honors

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string studentName;
    double grade;
    
    cout << "=== STUDENT GRADE CLASSIFICATION ===" << endl;
    cout << endl;
    
    cout << "Student name: ";
    getline(cin, studentName);
    
    cout << "Final grade: ";
    cin >> grade;
    
    cout << endl;
    cout << "----- GRADE REPORT -----" << endl;
    cout << "Student: " << studentName << endl;
    cout << fixed << setprecision(2);
    cout << "Grade: " << grade << endl;
    
    // Validate grade range
    if (grade < 0 || grade > 100) {
        cout << "ERROR: Invalid grade! Must be between 0 and 100." << endl;
        return 1;
    }
    
    // Classify grade
    if (grade >= 98) {
        cout << "Status: PASSED ✓" << endl;
        cout << "Honors: SUMMA CUM LAUDE" << endl;
        cout << "Remarks: Exceptional academic excellence!" << endl;
    } else if (grade >= 95) {
        cout << "Status: PASSED ✓" << endl;
        cout << "Honors: MAGNA CUM LAUDE" << endl;
        cout << "Remarks: Outstanding performance!" << endl;
    } else if (grade >= 90) {
        cout << "Status: PASSED ✓" << endl;
        cout << "Honors: CUM LAUDE" << endl;
        cout << "Remarks: Excellent work!" << endl;
    } else if (grade >= 75) {
        cout << "Status: PASSED ✓" << endl;
        cout << "Remarks: Good job! Keep improving." << endl;
    } else {
        cout << "Status: FAILED ✗" << endl;
        cout << "Remarks: Need to retake this subject." << endl;
    }
    
    return 0;
}
```

**Key Points:**
- Input validation first: `if (grade < 0 || grade > 100)`
- Uses `||` (OR) because grade outside EITHER bound is invalid
- `if/else if` chain for honors levels
- Different messages for each classification
- `return 1;` exits program early if invalid input

---

### Task 5: Electricity Bill with Penalty Checker

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double kwh, baseCharge = 0, penalty = 0, totalBill;
    char isLate;
    
    cout << "=== MERALCO BILLING SYSTEM ===" << endl;
    cout << endl;
    
    cout << "Enter kWh consumed: ";
    cin >> kwh;
    
    // Calculate tiered base charge
    if (kwh <= 100) {
        baseCharge = kwh * 10.50;
    } else if (kwh <= 200) {
        baseCharge = (100 * 10.50) + ((kwh - 100) * 11.00);
    } else if (kwh <= 300) {
        baseCharge = (100 * 10.50) + (100 * 11.00) + ((kwh - 200) * 12.00);
    } else {  // kwh > 300
        baseCharge = (100 * 10.50) + (100 * 11.00) + (100 * 12.00) + ((kwh - 300) * 13.50);
    }
    
    // Check if late payment
    cout << "Is payment late? (y/n): ";
    cin >> isLate;
    
    if (isLate == 'y' || isLate == 'Y') {
        penalty = baseCharge * 0.05;  // 5% late penalty
    }
    
    totalBill = baseCharge + penalty;
    
    cout << endl;
    cout << "----- ELECTRICITY BILL -----" << endl;
    cout << fixed << setprecision(2);
    cout << "kWh Consumed: " << kwh << endl;
    cout << "Base Charge: PHP " << baseCharge << endl;
    
    if (penalty > 0) {
        cout << "Late Penalty (5%): PHP " << penalty << endl;
    }
    
    cout << "----------------------------" << endl;
    cout << "TOTAL AMOUNT DUE: PHP " << totalBill << endl;
    
    if (penalty > 0) {
        cout << "Payment Status: OVERDUE ⚠" << endl;
    } else {
        cout << "Payment Status: On Time ✓" << endl;
    }
    
    return 0;
}
```

**Key Points:**
- Nested `if/else if` for tiered pricing (each tier has different rate)
- Calculates cumulative charge: first 100 at 10.50, next 100 at 11.00, etc.
- Penalty only applies if late (`isLate == 'y'`)
- Conditional display: penalty only shows if it exists

---

### Task 6: BMI Calculator with Health Recommendations

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double weight, height, bmi;
    
    cout << "=== BMI HEALTH CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Enter weight (kg): ";
    cin >> weight;
    
    cout << "Enter height (m): ";
    cin >> height;
    
    // Validate positive values
    if (weight <= 0 || height <= 0) {
        cout << "\nERROR: Weight and height must be positive values!" << endl;
        return 1;
    }
    
    // Calculate BMI
    bmi = weight / (height * height);
    
    cout << endl;
    cout << "----- BMI ANALYSIS -----" << endl;
    cout << fixed << setprecision(2);
    cout << "Weight: " << weight << " kg" << endl;
    cout << "Height: " << height << " m" << endl;
    cout << "BMI: " << setprecision(2) << bmi << endl;
    
    // Classify BMI
    cout << "Classification: ";
    if (bmi < 18.5) {
        cout << "Underweight" << endl;
        cout << "Health Status: ⚠ Below healthy range" << endl;
        cout << "Recommendation: Increase calorie intake with nutrient-rich foods. Consult a nutritionist." << endl;
    } else if (bmi < 25.0) {
        cout << "Normal Weight" << endl;
        cout << "Health Status: ✓ Healthy range" << endl;
        cout << "Recommendation: Maintain your current lifestyle with balanced diet and regular exercise." << endl;
    } else if (bmi < 30.0) {
        cout << "Overweight" << endl;
        cout << "Health Status: ⚠ Above healthy range" << endl;
        cout << "Recommendation: Increase physical activity and monitor calorie intake. Consider consulting a doctor." << endl;
    } else {
        cout << "Obese" << endl;
        cout << "Health Status: ⚠ High risk" << endl;
        cout << "Recommendation: Consult a doctor immediately. Start a supervised weight loss program." << endl;
    }
    
    return 0;
}
```

**Key Points:**
- Input validation: checks if weight or height is ≤ 0
- BMI formula: `weight / (height * height)`
- `if/else if` classifies BMI into 4 categories
- Each category gets health status and specific recommendations
- Uses comparison operators to check ranges

---

### Task 7: Scholarship Eligibility Checker

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    string studentName;
    double grade, monthlyIncome;
    
    cout << "=== SCHOLARSHIP ELIGIBILITY CHECKER ===" << endl;
    cout << endl;
    
    cout << "Student name: ";
    getline(cin, studentName);
    
    cout << "Final grade: ";
    cin >> grade;
    
    cout << "Monthly family income (PHP): ";
    cin >> monthlyIncome;
    
    cout << endl;
    cout << "----- ELIGIBILITY RESULT -----" << endl;
    cout << "Student: " << studentName << endl;
    cout << fixed << setprecision(2);
    cout << "Grade: " << grade << endl;
    cout << "Family Income: PHP " << monthlyIncome << endl;
    cout << endl;
    
    // Check scholarship eligibility using && operator
    if (grade >= 95 && monthlyIncome < 30000) {
        cout << "✓ ELIGIBLE FOR FULL SCHOLARSHIP" << endl;
        cout << "Coverage: 100% tuition + PHP 5,000 monthly stipend" << endl;
        cout << "Congratulations!" << endl;
    } else if (grade >= 90 && monthlyIncome < 50000) {
        cout << "✓ ELIGIBLE FOR PARTIAL SCHOLARSHIP" << endl;
        cout << "Coverage: 50% tuition" << endl;
        cout << "Congratulations!" << endl;
    } else {
        cout << "✗ NOT ELIGIBLE" << endl;
        
        // Provide specific feedback
        if (grade < 90 && monthlyIncome >= 50000) {
            cout << "Reason: Grade below 90 AND income exceeds threshold" << endl;
        } else if (grade < 90) {
            cout << "Reason: Grade below 90" << endl;
        } else if (monthlyIncome >= 50000) {
            cout << "Reason: Income exceeds threshold" << endl;
        }
        
        cout << "Consider applying next semester after improvement." << endl;
    }
    
    return 0;
}
```

**Key Points:**
- **Logical AND (`&&`)**: BOTH conditions must be true
- `grade >= 95 && monthlyIncome < 30000` - full scholarship
- `grade >= 90 && monthlyIncome < 50000` - partial scholarship
- Nested `if` in else block provides specific rejection reasons
- Demonstrates real-world multi-criteria eligibility checking

---

</details>

---

**Next Steps:**  
Test each program with edge cases: zero values, negative numbers, boundary values (exactly 75, exactly 90). See how `if/else` prevents crashes and guides users. Get ready for Lesson 6—**loops** will teach you to automate repetition instead of typing the same code 200 times!
