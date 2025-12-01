# Lesson 5 Activities: Understanding Control Flow

---

## Activity 1: Number Classifier

**Objective:** Practice if-else statements to classify numbers based on multiple criteria.

**Task:**  
Write a program that asks the user for a number and classifies it as:
- Positive, Negative, or Zero
- Even or Odd (if not zero)
- Divisible by 5 or not

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int number;
    
    cout << "Enter a number: ";
    cin >> number;
    
    // Classify the number
    
    return 0;
}
```

**Expected Output:**
```
Enter a number: 10
10 is Positive
10 is Even
10 is divisible by 5
```

**Solution:**
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

---

## Activity 2: BMI Calculator with Classification

**Objective:** Practice if-else chains for multi-level classification.

**Task:**  
Create a BMI (Body Mass Index) calculator that:
- Gets weight in kg and height in meters
- Calculates BMI = weight / (height * height)
- Classifies the result:
  - Underweight: BMI < 18.5
  - Normal: 18.5 <= BMI < 25
  - Overweight: 25 <= BMI < 30
  - Obese: BMI >= 30
- Provides health recommendations based on classification

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double weight, height, bmi;
    
    cout << "=== BMI Calculator ===" << endl;
    // Get input and calculate
    
    return 0;
}
```

**Expected Output:**
```
=== BMI Calculator ===
Enter weight (in kg): 70
Enter height (in meters): 1.75

Your BMI: 22.86
Classification: Normal
Recommendation: Maintain your healthy lifestyle!
```

**Solution:**
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

---

## Activity 3: Simple Calculator with Menu

**Objective:** Practice switch statements for menu-driven programs.

**Task:**  
Create a calculator program with a menu:
```
1. Addition
2. Subtraction
3. Multiplication
4. Division
5. Exit
```
Use a switch statement and handle division by zero.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    double num1, num2, result;
    
    cout << "=== Simple Calculator ===" << endl;
    // Display menu and get choice
    
    return 0;
}
```

**Expected Output:**
```
=== Simple Calculator ===
1. Addition
2. Subtraction
3. Multiplication
4. Division
5. Exit
Enter your choice: 1
Enter first number: 10
Enter second number: 5
10 + 5 = 15
```

**Solution:**
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

---

## Activity 4: Electricity Bill Calculator

**Objective:** Practice nested if-else statements for tiered pricing calculations.

**Task:**  
Create a program that calculates electricity bills based on Meralco's structure:
- 0-100 kWh: 10.50 per kWh
- 101-200 kWh: 11.00 per kWh
- 201-300 kWh: 12.00 per kWh
- Above 300 kWh: 13.50 per kWh

Also add:
- 5% system loss charge
- 12% VAT on total

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double kwh, charge = 0;
    
    cout << "=== Meralco Bill Calculator ===" << endl;
    cout << "Enter kWh consumed: ";
    cin >> kwh;
    
    // Calculate tiered charges
    
    return 0;
}
```

**Expected Output:**
```
=== Meralco Bill Calculator ===
Enter kWh consumed: 350

=== BILLING SUMMARY ===
kWh Consumed: 350.00
Generation Charge: 4275.00 pesos
System Loss Charge (5%): 213.75 pesos
VAT (12%): 538.65 pesos
--------------------------------
TOTAL AMOUNT DUE: 5027.40 pesos
```

**Solution:**
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

---

## Activity 5: Zodiac Sign Finder

**Objective:** Practice complex nested if-else logic with date ranges.

**Task:**  
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

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int month, day;
    string zodiacSign;
    
    cout << "=== Zodiac Sign Finder ===" << endl;
    cout << "Enter birth month (1-12): ";
    cin >> month;
    cout << "Enter birth day: ";
    cin >> day;
    
    // Determine zodiac sign
    
    return 0;
}
```

**Expected Output:**
```
=== Zodiac Sign Finder ===
Enter birth month (1-12): 7
Enter birth day: 25

Your Zodiac Sign: Leo
```

**Solution:**
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

---

## Challenge Activity: Grade Management System

**Objective:** Combine switch, if-else, and complex logic for a complete system.

**Task:**  
Create a student grade management system that:
1. Shows a menu:
   - 1. Add student grade
   - 2. Check passing status
   - 3. Get letter grade
   - 4. Exit
2. For "Add student grade": store a grade (0-100)
3. For "Check passing status": 
   - Passed if >= 75
   - Failed if < 75
4. For "Get letter grade":
   - A: 90-100
   - B: 85-89
   - C: 80-84
   - D: 75-79
   - F: Below 75

**Features:**
- Input validation (grades must be 0-100)
- Use switch for menu
- Use if-else for grade classification
- Loop until user exits

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
using namespace std;

int main() {
    int choice;
    double grade = -1;  // -1 indicates no grade entered yet
    
    do {
        cout << "\n=== Grade Management System ===" << endl;
        cout << "1. Add student grade" << endl;
        cout << "2. Check passing status" << endl;
        cout << "3. Get letter grade" << endl;
        cout << "4. Exit" << endl;
        cout << "Enter choice: ";
        cin >> choice;
        
        switch(choice) {
            case 1:  // Add grade
                cout << "\nEnter student grade (0-100): ";
                cin >> grade;
                
                if (grade < 0 || grade > 100) {
                    cout << "Invalid grade! Must be between 0 and 100." << endl;
                    grade = -1;
                } else {
                    cout << "Grade " << grade << " recorded successfully!" << endl;
                }
                break;
                
            case 2:  // Check passing
                if (grade == -1) {
                    cout << "\nNo grade entered yet! Please add a grade first." << endl;
                } else {
                    cout << "\nGrade: " << grade << endl;
                    if (grade >= 75) {
                        cout << "Status: PASSED ✓" << endl;
                        cout << "Congratulations!" << endl;
                    } else {
                        cout << "Status: FAILED ✗" << endl;
                        cout << "Need to retake this subject." << endl;
                    }
                }
                break;
                
            case 3:  // Get letter grade
                if (grade == -1) {
                    cout << "\nNo grade entered yet! Please add a grade first." << endl;
                } else {
                    cout << "\nNumeric Grade: " << grade << endl;
                    cout << "Letter Grade: ";
                    
                    if (grade >= 90) {
                        cout << "A (Excellent)" << endl;
                    } else if (grade >= 85) {
                        cout << "B (Very Good)" << endl;
                    } else if (grade >= 80) {
                        cout << "C (Good)" << endl;
                    } else if (grade >= 75) {
                        cout << "D (Passed)" << endl;
                    } else {
                        cout << "F (Failed)" << endl;
                    }
                }
                break;
                
            case 4:  // Exit
                cout << "\nThank you for using the Grade Management System!" << endl;
                break;
                
            default:
                cout << "\nInvalid choice! Please select 1-4." << endl;
        }
        
    } while (choice != 4);
    
    return 0;
}
```

</details>

---

## Debugging Exercise: Control Flow Mistakes

**Objective:** Identify and fix common control flow errors.

**Task:**  
The following program has 7 logic errors. Find and fix them.

**Buggy Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int score;
    char grade;
    
    cout << "Enter your score: ";
    cin >> score;
    
    // Error 1: Using = instead of ==
    if (score = 100) {
        cout << "Perfect score!" << endl;
    }
    
    // Error 2: Wrong logic for range
    if (score >= 90 && score <= 100) {
        grade = 'A';
    } else if (score >= 80) {  // Error 3: Missing upper bound
        grade = 'B';
    } else if (score >= 70 && <= 79) {  // Error 4: Incomplete condition
        grade = 'C';
    }
    
    // Error 5: Semicolon after if
    if (score < 60);
    {
        cout << "Failed!" << endl;
    }
    
    // Error 6: Missing break statements
    switch(grade) {
        case 'A':
            cout << "Excellent!" << endl;
        case 'B':
            cout << "Good!" << endl;
        case 'C':
            cout << "Fair!" << endl;
        default:
            cout << "Unknown grade" << endl;
    }
    
    // Error 7: Wrong logical operator
    if (score < 0 && score > 100) {
        cout << "Invalid score!" << endl;
    }
    
    return 0;
}
```

<details>
<summary>Click to view corrected code</summary>

```cpp
#include <iostream>
using namespace std;

int main() {
    int score;
    char grade = 'F';  // Initialize to prevent undefined behavior
    
    cout << "Enter your score: ";
    cin >> score;
    
    // Fix 7: Check for invalid input first (use OR, not AND)
    if (score < 0 || score > 100) {
        cout << "Invalid score! Must be 0-100" << endl;
        return 1;
    }
    
    // Fix 1: Use == for comparison
    if (score == 100) {
        cout << "Perfect score!" << endl;
    }
    
    // Fix 2 & 3: Add proper range checks
    if (score >= 90 && score <= 100) {
        grade = 'A';
    } else if (score >= 80 && score < 90) {  // Fix 3: Add upper bound
        grade = 'B';
    } else if (score >= 70 && score < 80) {  // Fix 4: Complete condition
        grade = 'C';
    } else if (score >= 60 && score < 70) {
        grade = 'D';
    }
    
    // Fix 5: Remove semicolon
    if (score < 60) {
        cout << "Failed!" << endl;
    }
    
    // Fix 6: Add break statements
    switch(grade) {
        case 'A':
            cout << "Excellent!" << endl;
            break;
        case 'B':
            cout << "Good!" << endl;
            break;
        case 'C':
            cout << "Fair!" << endl;
            break;
        case 'D':
            cout << "Needs improvement!" << endl;
            break;
        default:
            cout << "Keep trying!" << endl;
    }
    
    return 0;
}
```

</details>

---

## Reflection Questions

After completing these activities:

1. **When should you use if-else vs switch?**
   - if-else: For ranges, complex conditions, boolean expressions
   - switch: For exact value matching (integers, chars)

2. **What's the difference between `&&` and `||`?**
   - `&&` (AND): Both conditions must be true
   - `||` (OR): At least one condition must be true

3. **Why is input validation important?**
   - Prevents crashes from invalid data
   - Ensures program logic works correctly
   - Provides better user experience

4. **What happens if you forget `break` in a switch?**
   - Fall-through: Next cases also execute
   - Can be intentional, but usually a bug

---

## Next Steps

Fantastic progress! You now understand:
- ✅ if-else statements for decision making
- ✅ switch statements for menu-driven programs
- ✅ Nested conditions for complex logic
- ✅ Input validation techniques
- ✅ Logical operators for combining conditions

**Ready for Lesson 6?**  
Next, you'll learn about **loops** - repeating actions with for, while, and do-while loops to process data efficiently!
