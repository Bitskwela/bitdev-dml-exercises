# Lesson 4 Activities: Basic Input and Output

## From Hardcoded to Interactive Programs

Remember Tian's frustration? The barangay dues calculator worked perfectly—for exactly one resident named "Juan" who owed exactly 500 pesos. As Kuya Miguel pointed out: "Are you going to write 200 different programs?" The calculator was useless with only hardcoded values.

**This lesson changes everything.** You're transforming your programs from static demonstrations into interactive tools that respond to user input. Like Kuya Miguel said: "Right now, your program is like a vending machine with no buttons and no display."

**What makes input/output powerful:**
- **`cin`** reads user input (numbers, words, characters)
- **`getline()`** reads full lines with spaces
- **`cin.ignore()`** fixes the newline buffer problem
- **`<iomanip>`** formats output beautifully (decimal places, width, alignment)

Every real application—games asking for usernames, calculators waiting for numbers, ATMs requesting PINs—uses input and output. Today, you make your programs truly usable!

---

## Task 1: Personal Information Form

**Context:**  
You're building a barangay resident registration system that needs to collect information from users. Unlike hardcoded data, this system asks questions and stores the answers dynamically.

**Your Challenge:**  
Create an interactive form that collects and displays personal information with proper formatting.

**What You'll Practice:**
- `cin >>` for single-word input (age, numbers)
- `getline()` for full names with spaces
- `cin.ignore()` to handle the newline buffer issue
- `<iomanip>` for currency formatting
- Proper prompt display

**Key Concepts:**
- `cin >>` stops at whitespace (can't read "Juan Dela Cruz")
- `getline(cin, variable)` reads entire line including spaces
- After `cin >>`, leftover newline stays in buffer—use `cin.ignore()`
- `fixed` and `setprecision(2)` for currency display

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string fullName, city;
    int age;
    double income;
    
    cout << "=== RESIDENT REGISTRATION FORM ===" << endl;
    cout << endl;
    
    // Get full name (use getline for spaces!)
    // Get age (use cin)
    // Remember cin.ignore() after numeric input!
    // Get city
    // Get monthly income
    
    // Display formatted summary
    
    return 0;
}
```

**Expected Output:**
```
=== RESIDENT REGISTRATION FORM ===

Full name: Juan Dela Cruz
Age: 28
City: Manila
Monthly income: 35000

=== REGISTRATION SUMMARY ===
Name: Juan Dela Cruz
Age: 28 years old
City: Manila
Monthly Income: PHP 35,000.00
Registration: COMPLETE ✓
```

---

## Task 2: Sari-Sari Store Calculator

**Context:**  
Your neighbor Aling Rosa runs a sari-sari store and uses a notebook to calculate total costs. She wants a simple calculator that lets customers tell her what they're buying instead of her hardcoding prices each time.

**Your Challenge:**  
Create an interactive calculator where users input product name, quantity, and price. The program calculates the total and formats it properly with PHP currency.

**What You'll Practice:**
- Mixed input types (string, int, double)
- Buffer management with `cin.ignore()`
- Currency formatting with `setprecision()`
- Basic arithmetic with user values

**Key Concepts:**
```cpp
cin >> quantity;           // Reads integer
cin.ignore();             // Clears leftover newline
getline(cin, productName); // Now can read full product name
```

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string productName;
    int quantity;
    double pricePerUnit, totalCost;
    
    cout << "=== SARI-SARI STORE CALCULATOR ===" << endl;
    cout << endl;
    
    // Get product name, quantity, price per unit
    // Calculate total
    // Display receipt with formatting
    
    return 0;
}
```

**Expected Output:**
```
=== SARI-SARI STORE CALCULATOR ===

Product name: Lucky Me Pancit Canton
Quantity: 5
Price per unit: 15.50

----- RECEIPT -----
Product: Lucky Me Pancit Canton
Quantity: 5
Unit Price: PHP 15.50
Total Cost: PHP 77.50
Thank you for shopping!
```

---

## Task 3: Jeepney Fare Calculator

**Context:**  
Jeepney drivers need to calculate fares quickly based on distance. The base fare is PHP 13.00 for the first 4 kilometers, then PHP 2.00 for each additional kilometer. Create an interactive calculator!

**Your Challenge:**  
Ask the driver for passenger name and distance traveled, then calculate the total fare with proper currency formatting.

**What You'll Practice:**
- Reading user input for calculations
- Conditional arithmetic (base fare + additional)
- Professional output formatting
- Real-world pricing logic

**Formula:**
- If distance ≤ 4 km: fare = 13.00
- If distance > 4 km: fare = 13.00 + ((distance - 4) × 2.00)

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string passengerName;
    double distance, fare;
    
    cout << "=== JEEPNEY FARE CALCULATOR ===" << endl;
    cout << endl;
    
    // Get passenger name and distance
    // Calculate fare (base 13, +2 per km after 4km)
    // Display formatted receipt
    
    return 0;
}
```

**Expected Output:**
```
=== JEEPNEY FARE CALCULATOR ===

Passenger name: Maria Santos
Distance traveled (km): 7.5

----- FARE RECEIPT -----
Passenger: Maria Santos
Distance: 7.5 km
Fare: PHP 20.00
Safe travels!
```

---

## Task 4: Student Grade Input System

**Context:**  
Teachers spend hours calculating final grades. You're building a system that takes input for quiz, project, and exam scores, then calculates the weighted average.

**Your Challenge:**  
Create a program that asks for a student's name and three grades (Quiz 30%, Project 30%, Exam 40%), then displays the weighted final grade with 2 decimal places.

**What You'll Practice:**
- Multiple numeric inputs
- Weighted calculations
- Percentage formatting
- `setw()` for aligned output

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string studentName;
    double quiz, project, exam, finalGrade;
    
    cout << "=== STUDENT GRADE CALCULATOR ===" << endl;
    cout << endl;
    
    // Input: student name, quiz, project, exam
    // Calculate: finalGrade = (quiz*0.3) + (project*0.3) + (exam*0.4)
    // Display aligned output
    
    return 0;
}
```

**Expected Output:**
```
=== STUDENT GRADE CALCULATOR ===

Student name: Pedro Reyes
Quiz score (100): 85
Project score (100): 92
Exam score (100): 88

----- GRADE REPORT -----
Student: Pedro Reyes
Quiz:     85.00 (30%)
Project:  92.00 (30%)
Exam:     88.00 (40%)
-------------------
Final Grade: 88.10
```

---

## Task 5: Barangay Clearance Fee Calculator

**Context:**  
Your barangay charges different fees for clearance certificates based on purpose (business, employment, travel). Build a system that asks for applicant details and calculates the total fee including tax.

**Your Challenge:**  
Create a calculator that inputs applicant name, clearance purpose, base fee, and calculates total with 12% tax. Format all currency output properly.

**What You'll Practice:**
- Multiple string and numeric inputs
- Percentage calculations (tax)
- Professional formatting with `setprecision()`
- Real document processing simulation

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string applicantName, purpose;
    double baseFee, tax, totalFee;
    
    cout << "=== BARANGAY CLEARANCE FEE CALCULATOR ===" << endl;
    cout << endl;
    
    // Input: name, purpose, base fee
    // Calculate tax (12% of base fee)
    // Calculate total (base + tax)
    // Display formatted receipt
    
    return 0;
}
```

**Expected Output:**
```
=== BARANGAY CLEARANCE FEE CALCULATOR ===

Applicant name: Teresa Cruz
Purpose: Employment
Base fee: 150

----- OFFICIAL RECEIPT -----
Applicant: Teresa Cruz
Purpose: Employment
Base Fee: PHP 150.00
Tax (12%): PHP 18.00
Total Fee: PHP 168.00
Please proceed to payment window.
```

---

## Task 6: Philippine Peso Converter

**Context:**  
Overseas Filipino Workers (OFWs) need to quickly convert their earnings from foreign currency to Philippine pesos. Build a converter that takes user input for amount and exchange rate.

**Your Challenge:**  
Create a currency converter that asks for foreign amount, currency name, and exchange rate, then displays the peso equivalent beautifully formatted.

**What You'll Practice:**
- Multiple data types in sequence
- Decimal calculations
- `setw()` for column alignment
- Real-world financial formatting

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string currencyName;
    double foreignAmount, exchangeRate, pesoAmount;
    
    cout << "=== OFW CURRENCY CONVERTER ===" << endl;
    cout << endl;
    
    // Input: foreign amount, currency name, rate
    // Calculate peso amount
    // Display formatted conversion
    
    return 0;
}
```

**Expected Output:**
```
=== OFW CURRENCY CONVERTER ===

Foreign amount: 1000
Currency name: US Dollar
Exchange rate (to PHP): 56.50

----- CONVERSION SUMMARY -----
Foreign Amount: 1,000.00 USD
Exchange Rate: PHP 56.50
Peso Equivalent: PHP 56,500.00
Conversion complete!
```

---

## Task 7: Interactive Table Formatter

**Context:**  
You're building a menu display system for a restaurant. Instead of hardcoded menus, staff should input dish names and prices, then see a beautifully formatted menu table.

**Your Challenge:**  
Create a program that inputs 3 dishes with prices, then displays them in a formatted table using `setw()` for alignment.

**What You'll Practice:**
- Loops with user input (or 3 separate inputs)
- `setw()` for column width
- `left` and `right` alignment
- Professional table formatting

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string dish1, dish2, dish3;
    double price1, price2, price3;
    
    cout << "=== RESTAURANT MENU MAKER ===" << endl;
    cout << endl;
    
    // Input 3 dishes and prices
    // Display formatted table with setw()
    
    return 0;
}
```

**Expected Output:**
```
=== RESTAURANT MENU MAKER ===

Dish 1 name: Chicken Adobo
Dish 1 price: 120

Dish 2 name: Sinigang na Baboy
Dish 2 price: 150

Dish 3 name: Lumpia Shanghai
Dish 3 price: 80

========== MENU ==========
Chicken Adobo        PHP 120.00
Sinigang na Baboy    PHP 150.00
Lumpia Shanghai      PHP  80.00
==========================
```

---

## Reflection Questions

After completing these tasks, think deeply about input/output in real programs:

1. **The Buffer Problem**: What happens if you use `cin >>` for a number, then immediately use `getline()` for a name? Why does `cin.ignore()` solve this? Draw what's happening in the input buffer.

2. **User Experience Design**: Compare a program with clear prompts vs. one with no prompts. How does good input/output design affect user trust in your software?

3. **Error-Prone Input**: What happens if a user types "twenty" when your program expects `cin >> age` (an integer)? How might you make input more robust in the future?

4. **Real-World Validation**: In Task 2 (Sari-Sari Store), what if quantity is negative? Should your program accept it? How do professional applications validate input?

5. **Formatting Impact**: Calculate 35000 / 3. Display it as raw output vs. using `fixed << setprecision(2)`. Which looks more professional for a banking application?

6. **The cin vs getline Rule**: Create a mental model: When should you use `cin >>` vs. `getline()`? When do you MUST use `cin.ignore()`?

7. **From Static to Dynamic**: Look back at your Lesson 1-3 programs with hardcoded values. Which ones would be 10x more useful with user input? Pick one and rewrite it with `cin`.

8. **Philippine Context**: Why are proper peso formatting and receipt-like outputs important for programs used in sari-sari stores or barangay systems where trust and clarity matter?

---

## What You've Learned

You've crossed a critical threshold in programming. Your programs are no longer demonstrations—they're **interactive tools** that respond to real users.

**Core Skills Unlocked:**
- **`cin >>`** – Read single-word or numeric input
- **`getline(cin, variable)`** – Read full lines with spaces
- **`cin.ignore()`** – Clear buffer after numeric input to prevent getline() issues
- **`<iomanip>`** – Format output with precision, width, alignment
- **User-Centered Design** – Write clear prompts and professional displays

**Real-World Applications:**
- **Banking Systems**: ATMs asking for PIN and amount
- **E-commerce**: Shopping carts calculating totals from user input
- **Healthcare**: Patient records collecting symptoms and vitals
- **Education**: Grading systems processing scores
- **Government**: Barangay systems, tax calculators, clearance applications

**The Transformation:**
```cpp
// Before (Lesson 1-3): Static toy
int dues = 500;
cout << "You owe: " << dues;

// After (Lesson 4): Interactive tool
double dues;
cout << "Enter dues amount: ";
cin >> dues;
cout << "You owe: PHP " << fixed << setprecision(2) << dues;
```

As Kuya Miguel said: **"This is the difference between a toy program and a real tool."** You've made that leap.

Next lesson, you'll add intelligence—teaching your programs to **make decisions** with `if/else` statements!

---

<details>
<summary><strong>📝 Answer Key for All Tasks</strong></summary>

### Task 1: Personal Information Form

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string fullName, city;
    int age;
    double income;
    
    cout << "=== RESIDENT REGISTRATION FORM ===" << endl;
    cout << endl;
    
    cout << "Full name: ";
    getline(cin, fullName);  // Use getline for names with spaces
    
    cout << "Age: ";
    cin >> age;
    cin.ignore();  // CRITICAL: Clear buffer after numeric input
    
    cout << "City: ";
    getline(cin, city);
    
    cout << "Monthly income: ";
    cin >> income;
    
    cout << endl;
    cout << "=== REGISTRATION SUMMARY ===" << endl;
    cout << "Name: " << fullName << endl;
    cout << "Age: " << age << " years old" << endl;
    cout << "City: " << city << endl;
    cout << "Monthly Income: PHP " << fixed << setprecision(2) << income << endl;
    cout << "Registration: COMPLETE ✓" << endl;
    
    return 0;
}
```

**Key Points:**
- `getline()` reads full names with spaces
- `cin.ignore()` after `cin >> age` prevents getline() from reading leftover newline
- `fixed << setprecision(2)` formats currency to 2 decimal places

---

### Task 2: Sari-Sari Store Calculator

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string productName;
    int quantity;
    double pricePerUnit, totalCost;
    
    cout << "=== SARI-SARI STORE CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Product name: ";
    getline(cin, productName);
    
    cout << "Quantity: ";
    cin >> quantity;
    
    cout << "Price per unit: ";
    cin >> pricePerUnit;
    
    totalCost = quantity * pricePerUnit;
    
    cout << endl;
    cout << "----- RECEIPT -----" << endl;
    cout << "Product: " << productName << endl;
    cout << "Quantity: " << quantity << endl;
    cout << "Unit Price: PHP " << fixed << setprecision(2) << pricePerUnit << endl;
    cout << "Total Cost: PHP " << totalCost << endl;
    cout << "Thank you for shopping!" << endl;
    
    return 0;
}
```

**Key Points:**
- Mixed data types: string, int, double
- Arithmetic with user input: `quantity * pricePerUnit`
- Professional receipt formatting

---

### Task 3: Jeepney Fare Calculator

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string passengerName;
    double distance, fare;
    
    cout << "=== JEEPNEY FARE CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Passenger name: ";
    getline(cin, passengerName);
    
    cout << "Distance traveled (km): ";
    cin >> distance;
    
    // Calculate fare: base 13 for first 4km, +2 per additional km
    if (distance <= 4) {
        fare = 13.00;
    } else {
        fare = 13.00 + ((distance - 4) * 2.00);
    }
    
    cout << endl;
    cout << "----- FARE RECEIPT -----" << endl;
    cout << "Passenger: " << passengerName << endl;
    cout << "Distance: " << fixed << setprecision(1) << distance << " km" << endl;
    cout << "Fare: PHP " << setprecision(2) << fare << endl;
    cout << "Safe travels!" << endl;
    
    return 0;
}
```

**Key Points:**
- Conditional calculation (base + additional)
- Different `setprecision()` for distance (1) vs. fare (2)
- Real-world Philippine transportation pricing

---

### Task 4: Student Grade Input System

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string studentName;
    double quiz, project, exam, finalGrade;
    
    cout << "=== STUDENT GRADE CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Student name: ";
    getline(cin, studentName);
    
    cout << "Quiz score (100): ";
    cin >> quiz;
    
    cout << "Project score (100): ";
    cin >> project;
    
    cout << "Exam score (100): ";
    cin >> exam;
    
    // Weighted average: 30% quiz, 30% project, 40% exam
    finalGrade = (quiz * 0.3) + (project * 0.3) + (exam * 0.4);
    
    cout << endl;
    cout << "----- GRADE REPORT -----" << endl;
    cout << "Student: " << studentName << endl;
    cout << fixed << setprecision(2);
    cout << "Quiz:     " << quiz << " (30%)" << endl;
    cout << "Project:  " << project << " (30%)" << endl;
    cout << "Exam:     " << exam << " (40%)" << endl;
    cout << "-------------------" << endl;
    cout << "Final Grade: " << finalGrade << endl;
    
    return 0;
}
```

**Key Points:**
- Weighted percentage calculations
- `setprecision(2)` applied once for all subsequent output
- Clear breakdown of grade components

---

### Task 5: Barangay Clearance Fee Calculator

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string applicantName, purpose;
    double baseFee, tax, totalFee;
    
    cout << "=== BARANGAY CLEARANCE FEE CALCULATOR ===" << endl;
    cout << endl;
    
    cout << "Applicant name: ";
    getline(cin, applicantName);
    
    cout << "Purpose: ";
    getline(cin, purpose);
    
    cout << "Base fee: ";
    cin >> baseFee;
    
    tax = baseFee * 0.12;  // 12% tax
    totalFee = baseFee + tax;
    
    cout << endl;
    cout << "----- OFFICIAL RECEIPT -----" << endl;
    cout << "Applicant: " << applicantName << endl;
    cout << "Purpose: " << purpose << endl;
    cout << fixed << setprecision(2);
    cout << "Base Fee: PHP " << baseFee << endl;
    cout << "Tax (12%): PHP " << tax << endl;
    cout << "Total Fee: PHP " << totalFee << endl;
    cout << "Please proceed to payment window." << endl;
    
    return 0;
}
```

**Key Points:**
- Tax calculation as percentage
- Multiple string inputs with getline()
- Government document formatting

---

### Task 6: Philippine Peso Converter

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string currencyName;
    double foreignAmount, exchangeRate, pesoAmount;
    
    cout << "=== OFW CURRENCY CONVERTER ===" << endl;
    cout << endl;
    
    cout << "Foreign amount: ";
    cin >> foreignAmount;
    cin.ignore();  // Clear buffer before getline
    
    cout << "Currency name: ";
    getline(cin, currencyName);
    
    cout << "Exchange rate (to PHP): ";
    cin >> exchangeRate;
    
    pesoAmount = foreignAmount * exchangeRate;
    
    cout << endl;
    cout << "----- CONVERSION SUMMARY -----" << endl;
    cout << fixed << setprecision(2);
    cout << "Foreign Amount: " << foreignAmount << " " << currencyName << endl;
    cout << "Exchange Rate: PHP " << exchangeRate << endl;
    cout << "Peso Equivalent: PHP " << pesoAmount << endl;
    cout << "Conversion complete!" << endl;
    
    return 0;
}
```

**Key Points:**
- Multiplication for currency conversion
- `cin.ignore()` between numeric input and getline()
- Real-world financial calculations for OFWs

---

### Task 7: Interactive Table Formatter

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string dish1, dish2, dish3;
    double price1, price2, price3;
    
    cout << "=== RESTAURANT MENU MAKER ===" << endl;
    cout << endl;
    
    cout << "Dish 1 name: ";
    getline(cin, dish1);
    cout << "Dish 1 price: ";
    cin >> price1;
    cin.ignore();
    
    cout << endl;
    cout << "Dish 2 name: ";
    getline(cin, dish2);
    cout << "Dish 2 price: ";
    cin >> price2;
    cin.ignore();
    
    cout << endl;
    cout << "Dish 3 name: ";
    getline(cin, dish3);
    cout << "Dish 3 price: ";
    cin >> price3;
    
    cout << endl;
    cout << "========== MENU ==========" << endl;
    cout << fixed << setprecision(2);
    cout << left << setw(20) << dish1 << " PHP " << right << setw(6) << price1 << endl;
    cout << left << setw(20) << dish2 << " PHP " << right << setw(6) << price2 << endl;
    cout << left << setw(20) << dish3 << " PHP " << right << setw(6) << price3 << endl;
    cout << "==========================" << endl;
    
    return 0;
}
```

**Key Points:**
- `setw()` controls column width
- `left` aligns dish names left, `right` aligns prices right
- Professional table formatting with alignment
- `cin.ignore()` after each numeric input before getline()

---

</details>

---

**Next Steps:**  
Test each program with different inputs. Try breaking them (negative numbers, very long names). Notice how proper formatting makes output professional. Get ready for Lesson 5—where your programs learn to **make intelligent decisions** with `if/else`!

---

## Answer Key

**Solution:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string fullName, city;
    int age;
    double income;
    
    cout << "=== Personal Information ===" << endl;
    cout << endl;
    
    cout << "Full name: ";
    getline(cin, fullName);
    
    cout << "Age: ";
    cin >> age;
    cin.ignore();
    
    cout << "City: ";
    getline(cin, city);
    
    cout << "Monthly income: ";
    cin >> income;
    
    cout << endl;
    cout << "=== Summary ===" << endl;
    cout << "Name: " << fullName << endl;
    cout << "Age: " << age << endl;
    cout << "City: " << city << endl;
    cout << fixed << setprecision(2);
    cout << "Income: PHP " << income << endl;
    
    return 0;
}
```

---

## Activity 2: Restaurant Bill Calculator

**Objective:** Practice arithmetic operations with formatted output.

**Task:**  
Create a program that:
1. Asks for the bill amount
2. Asks for tip percentage (e.g., 10 for 10%)
3. Calculates and displays:
   - Bill amount
   - Tip amount
   - Total amount to pay

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double billAmount, tipPercentage;
    
    cout << "=== Restaurant Bill ===" << endl;
    cout << endl;
    
    // Get input and calculate
    
    return 0;
}
```

**Expected Output:**
```
=== Restaurant Bill ===

Enter bill amount: 850.50
Enter tip percentage: 10

=== Summary ===
Bill Amount:  PHP  850.50
Tip (10%):    PHP   85.05
----------------------------
Total:        PHP  935.55
```

**Solution:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double billAmount, tipPercentage;
    
    cout << "=== Restaurant Bill ===" << endl;
    cout << endl;
    
    cout << "Enter bill amount: ";
    cin >> billAmount;
    
    cout << "Enter tip percentage: ";
    cin >> tipPercentage;
    
    double tipAmount = billAmount * (tipPercentage / 100.0);
    double totalAmount = billAmount + tipAmount;
    
    cout << endl;
    cout << "=== Summary ===" << endl;
    cout << fixed << setprecision(2);
    cout << "Bill Amount:  PHP " << setw(8) << billAmount << endl;
    cout << "Tip (" << tipPercentage << "%):    PHP " 
         << setw(8) << tipAmount << endl;
    cout << "----------------------------" << endl;
    cout << "Total:        PHP " << setw(8) << totalAmount << endl;
    
    return 0;
}
```

---

## Activity 3: Jeepney Fare Calculator

**Objective:** Combine input/output with conditional logic and calculations.

**Task:**  
Create a program that calculates jeepney fare:
- Base fare: 13 pesos (first 4 km)
- Additional: 1.50 pesos per km after 4 km
- 20% discount for students

Ask for:
- Distance in kilometers
- Student status (1 for yes, 0 for no)

Display the calculated fare with breakdown.

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance;
    bool isStudent;
    
    cout << "=== Jeepney Fare Calculator ===" << endl;
    cout << endl;
    
    // Get input and calculate fare
    
    return 0;
}
```

**Expected Output:**
```
=== Jeepney Fare Calculator ===

Distance (km): 8.5
Are you a student? (1=yes, 0=no): 1

Base fare (4 km):       PHP  13.00
Additional (4.5 km):    PHP   6.75
Subtotal:               PHP  19.75
Student discount (20%): PHP  -3.95
-----------------------------------
Total fare:             PHP  15.80
```

**Solution:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double distance;
    bool isStudent;
    
    cout << "=== Jeepney Fare Calculator ===" << endl;
    cout << endl;
    
    cout << "Distance (km): ";
    cin >> distance;
    
    cout << "Are you a student? (1=yes, 0=no): ";
    cin >> isStudent;
    
    double baseFare = 13.0;
    double additionalFare = 0.0;
    
    if (distance > 4.0) {
        additionalFare = (distance - 4.0) * 1.50;
    }
    
    double subtotal = baseFare + additionalFare;
    double discount = isStudent ? subtotal * 0.20 : 0.0;
    double totalFare = subtotal - discount;
    
    cout << endl;
    cout << fixed << setprecision(2);
    cout << "Base fare (4 km):       PHP " << setw(7) << baseFare << endl;
    
    if (distance > 4.0) {
        cout << "Additional (" << (distance - 4.0) << " km):    PHP " 
             << setw(7) << additionalFare << endl;
    }
    
    cout << "Subtotal:               PHP " << setw(7) << subtotal << endl;
    
    if (isStudent) {
        cout << "Student discount (20%): PHP " << setw(7) 
             << -discount << endl;
    }
    
    cout << "-----------------------------------" << endl;
    cout << "Total fare:             PHP " << setw(7) << totalFare << endl;
    
    return 0;
}
```

---

## Activity 4: BMI Calculator

**Objective:** Practice using `getline()`, calculations, and conditional output formatting.

**Task:**  
Create a Body Mass Index calculator that:
1. Asks for name
2. Asks for weight in kg
3. Asks for height in meters
4. Calculates BMI = weight / (height * height)
5. Displays category:
   - Below 18.5: Underweight
   - 18.5 to 24.9: Normal weight
   - 25 to 29.9: Overweight
   - 30 and above: Obese

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string name;
    double weight, height;
    
    cout << "=== BMI Calculator ===" << endl;
    cout << endl;
    
    // Get input and calculate BMI
    
    return 0;
}
```

**Expected Output:**
```
=== BMI Calculator ===

Name: Maria Santos
Weight (kg): 65
Height (m): 1.65

=== Results ===
Name: Maria Santos
Weight: 65.00 kg
Height: 1.65 m
BMI: 23.88
Category: Normal weight
```

**Solution:**
```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string name;
    double weight, height;
    
    cout << "=== BMI Calculator ===" << endl;
    cout << endl;
    
    cout << "Name: ";
    getline(cin, name);
    
    cout << "Weight (kg): ";
    cin >> weight;
    
    cout << "Height (m): ";
    cin >> height;
    
    double bmi = weight / (height * height);
    
    string category;
    if (bmi < 18.5) {
        category = "Underweight";
    } else if (bmi < 25.0) {
        category = "Normal weight";
    } else if (bmi < 30.0) {
        category = "Overweight";
    } else {
        category = "Obese";
    }
    
    cout << endl;
    cout << "=== Results ===" << endl;
    cout << "Name: " << name << endl;
    cout << fixed << setprecision(2);
    cout << "Weight: " << weight << " kg" << endl;
    cout << "Height: " << height << " m" << endl;
    cout << "BMI: " << bmi << endl;
    cout << "Category: " << category << endl;
    
    return 0;
}
```

---

## Activity 5: Load Balance Tracker

**Objective:** Practice user interaction with conditional logic and state tracking.

**Task:**  
Create a program that simulates checking and adding load balance:
1. Display current balance (start with 50.00)
2. Ask if user wants to add load (y/n)
3. If yes, ask for amount to add
4. Display new balance with proper formatting

**Starter Code:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double balance = 50.00;
    char choice;
    
    cout << "=== Load Balance ===" << endl;
    cout << endl;
    
    // Display balance and ask for action
    
    return 0;
}
```

**Expected Output:**
```
=== Load Balance ===

Current balance: PHP 50.00

Add load? (y/n): y
Enter amount: 100

Transaction successful!
New balance: PHP 150.00
```

**Solution:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double balance = 50.00;
    char choice;
    double amount;
    
    cout << "=== Load Balance ===" << endl;
    cout << endl;
    cout << fixed << setprecision(2);
    cout << "Current balance: PHP " << balance << endl;
    cout << endl;
    
    cout << "Add load? (y/n): ";
    cin >> choice;
    
    if (choice == 'y' || choice == 'Y') {
        cout << "Enter amount: ";
        cin >> amount;
        
        balance += amount;
        
        cout << endl;
        cout << "Transaction successful!" << endl;
        cout << "New balance: PHP " << balance << endl;
    } else {
        cout << endl;
        cout << "No transaction made." << endl;
        cout << "Balance: PHP " << balance << endl;
    }
    
    return 0;
}
```

---

## Challenge Activity: Enhanced GCash Simulator

**Objective:** Create a more complex interactive program combining all I/O concepts.

**Task:**  
Build a GCash simulator that:
1. Asks for user's name
2. Shows current balance (start with ₱1,000.00)
3. Offers menu:
   - 1. Send Money
   - 2. Add Money
   - 3. Pay Bills
   - 4. Check Balance
   - 5. Exit
4. Handles each transaction with proper formatting
5. Updates and displays balance after each transaction

**Features to implement:**
- Input validation (can't send more than balance)
- Proper money formatting (2 decimal places)
- Transaction receipts with details
- Use of `setw()` for aligned output

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string name;
    double balance = 1000.00;
    int choice;
    double amount;
    string recipient, biller;
    
    cout << "=== GCash Simulator ===" << endl;
    cout << "Enter your name: ";
    getline(cin, name);
    
    cout << "\nWelcome, " << name << "!" << endl;
    
    do {
        cout << "\n=== MAIN MENU ===" << endl;
        cout << "Current Balance: PHP " << fixed << setprecision(2) << balance << endl;
        cout << "\n1. Send Money" << endl;
        cout << "2. Add Money (Cash In)" << endl;
        cout << "3. Pay Bills" << endl;
        cout << "4. Check Balance" << endl;
        cout << "5. Exit" << endl;
        cout << "\nEnter choice: ";
        cin >> choice;
        cin.ignore();
        
        switch(choice) {
            case 1:  // Send Money
                cout << "\n=== SEND MONEY ===" << endl;
                cout << "Recipient name: ";
                getline(cin, recipient);
                cout << "Amount to send: PHP ";
                cin >> amount;
                cin.ignore();
                
                if (amount > balance) {
                    cout << "\nInsufficient balance!" << endl;
                } else if (amount <= 0) {
                    cout << "\nInvalid amount!" << endl;
                } else {
                    balance -= amount;
                    cout << "\n=== TRANSACTION SUCCESSFUL ===" << endl;
                    cout << "Sent PHP " << fixed << setprecision(2) << amount 
                         << " to " << recipient << endl;
                    cout << "New Balance: PHP " << balance << endl;
                }
                break;
                
            case 2:  // Add Money
                cout << "\n=== CASH IN ===" << endl;
                cout << "Amount to add: PHP ";
                cin >> amount;
                cin.ignore();
                
                if (amount <= 0) {
                    cout << "\nInvalid amount!" << endl;
                } else {
                    balance += amount;
                    cout << "\n=== TRANSACTION SUCCESSFUL ===" << endl;
                    cout << "Added PHP " << fixed << setprecision(2) << amount << endl;
                    cout << "New Balance: PHP " << balance << endl;
                }
                break;
                
            case 3:  // Pay Bills
                cout << "\n=== PAY BILLS ===" << endl;
                cout << "Biller name (e.g., Meralco, Water): ";
                getline(cin, biller);
                cout << "Amount to pay: PHP ";
                cin >> amount;
                cin.ignore();
                
                if (amount > balance) {
                    cout << "\nInsufficient balance!" << endl;
                } else if (amount <= 0) {
                    cout << "\nInvalid amount!" << endl;
                } else {
                    balance -= amount;
                    cout << "\n=== PAYMENT SUCCESSFUL ===" << endl;
                    cout << "Paid PHP " << fixed << setprecision(2) << amount 
                         << " to " << biller << endl;
                    cout << "New Balance: PHP " << balance << endl;
                }
                break;
                
            case 4:  // Check Balance
                cout << "\n=== BALANCE INQUIRY ===" << endl;
                cout << "Account: " << name << endl;
                cout << "Balance: PHP " << fixed << setprecision(2) << balance << endl;
                break;
                
            case 5:  // Exit
                cout << "\nThank you for using GCash, " << name << "!" << endl;
                cout << "Final Balance: PHP " << fixed << setprecision(2) << balance << endl;
                break;
                
            default:
                cout << "\nInvalid choice! Please select 1-5." << endl;
        }
        
    } while (choice != 5);
    
    return 0;
}
```

</details>

---

## Debugging Exercise: Input/Output Errors

**Objective:** Identify and fix common I/O mistakes.

**Task:**  
The following program has 6 errors. Find and fix them all.

**Buggy Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    string fullName;
    int age;
    double salary;
    
    cout << "Enter your full name: ";
    cin >> fullName;  // Error 1: Won't work for full names with spaces
    
    cout << "Enter age: ";
    cout >> age;  // Error 2: Wrong operator for input
    
    cout << "Enter salary: ";
    cin >> salary;
    
    cout << fixed << setprecision(2);  // Error 3: Missing <iomanip>
    cout << "Name: " << fullName << end;  // Error 4: Wrong line ending
    cout << "Age: " age << endl;  // Error 5: Missing <<
    cout << "Salary: PHP" << salary << endl;  // Works but no space
    
    return 0;
}  // Error 6: Missing <string> header
```

<details>
<summary>Click to view corrected code</summary>

```cpp
#include <iostream>
#include <iomanip>   // Fix 3: Add iomanip header
#include <string>    // Fix 6: Add string header
using namespace std;

int main() {
    string fullName;
    int age;
    double salary;
    
    cout << "Enter your full name: ";
    getline(cin, fullName);  // Fix 1: Use getline for full names
    
    cout << "Enter age: ";
    cin >> age;  // Fix 2: Use cin >> for input
    
    cout << "Enter salary: ";
    cin >> salary;
    
    cout << fixed << setprecision(2);
    cout << "Name: " << fullName << endl;  // Fix 4: Use endl not end
    cout << "Age: " << age << endl;  // Fix 5: Add <<
    cout << "Salary: PHP " << salary << endl;  // Better with space
    
    return 0;
}
```

</details>

---

## Reflection Questions

After completing these activities:

1. **When should you use `getline()` instead of `cin >>`?**
   - Use `getline()` for strings with spaces (full names, addresses)
   - Use `cin >>` for single words or numeric types

2. **Why do we need `cin.ignore()` after `cin >>`?**
   - To clear the newline character left in the input buffer
   - Prevents `getline()` from reading an empty line

3. **What's the purpose of `fixed` and `setprecision()`?**
   - `fixed`: Forces fixed-point notation (not scientific)
   - `setprecision(n)`: Sets decimal places for floating-point numbers

4. **How do `<<` and `>>` operators work?**
   - `<<`: Insertion operator (puts data into stream/output)
   - `>>`: Extraction operator (gets data from stream/input)

---

## Next Steps

Excellent work! You now know how to:
- ✅ Get user input with `cin` and `getline()`
- ✅ Format output with manipulators
- ✅ Handle different data types
- ✅ Create interactive programs
- ✅ Use proper input/output techniques

**Ready for Lesson 5?**  
Next, you'll learn about **control flow** - making decisions with if/else statements and switch cases to create more intelligent programs!
