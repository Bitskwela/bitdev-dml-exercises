# Lesson 4 Activities: Basic Input and Output

---

## Activity 1: Personal Information Form

**Objective:** Practice using `cin`, `getline()`, and output formatting to create a personal information form.

**Task:**  
Write a program that asks for and displays:
- Full name
- Age
- City
- Monthly income (with 2 decimal places)

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
    
    cout << "=== Personal Information ===" << endl;
    cout << endl;
    
    // Get user input here
    
    // Display summary here
    
    return 0;
}
```

**Expected Output:**
```
=== Personal Information ===

Full name: Juan Dela Cruz
Age: 28
City: Manila
Monthly income: 35000

=== Summary ===
Name: Juan Dela Cruz
Age: 28
City: Manila
Income: PHP 35000.00
```

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
