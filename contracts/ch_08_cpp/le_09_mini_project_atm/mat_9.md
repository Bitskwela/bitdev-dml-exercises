# Lesson 9: Mini Project - ATM Simulator Using Control Structures

## Background Story

"Tian, you've learned loops, conditions, and logical operators," Kuya Miguel said one afternoon. "Now it's time to combine everything into a real project!"

Tian's eyes lit up. "What are we building?"

"An ATM Simulator! It will have account balance, deposits, withdrawals, and security features. You'll use everything you've learned: loops for menus, conditions for validation, and logical operators for security checks."

## Project Overview

**ATM Simulator Features:**
1. PIN authentication (3 attempts max)
2. Check balance
3. Deposit money
4. Withdraw money (with balance check)
5. View transaction history
6. Exit system

**Skills Applied:**
- `while` loops for menu system
- `if/else` for validation
- Logical operators (`&&`, `||`)
- Arrays for transaction history
- `break` and `continue` statements

---

## Complete ATM Simulator Code

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Account data
    int correctPIN = 1234;
    double balance = 5000.00;
    
    // Transaction history (last 10 transactions)
    string transactions[10];
    int transactionCount = 0;
    
    // Authentication
    int enteredPIN;
    int attempts = 0;
    bool authenticated = false;
    
    cout << "========================================" << endl;
    cout << "   BARANGAY COOPERATIVE BANK ATM" << endl;
    cout << "========================================" << endl;
    
    // PIN Authentication Loop
    while (attempts < 3 && !authenticated) {
        cout << "\nEnter your PIN: ";
        cin >> enteredPIN;
        
        if (enteredPIN == correctPIN) {
            authenticated = true;
            cout << "✓ Authentication successful!" << endl;
        } else {
            attempts++;
            cout << "✗ Incorrect PIN. ";
            
            if (attempts < 3) {
                cout << "Attempts remaining: " << (3 - attempts) << endl;
            } else {
                cout << "Card blocked. Please contact your bank." << endl;
                return 0;  // Exit program
            }
        }
    }
    
    // Main Menu Loop
    int choice;
    bool exitATM = false;
    
    while (!exitATM) {
        cout << "\n========================================" << endl;
        cout << "             MAIN MENU" << endl;
        cout << "========================================" << endl;
        cout << "1. Check Balance" << endl;
        cout << "2. Deposit Money" << endl;
        cout << "3. Withdraw Money" << endl;
        cout << "4. View Transaction History" << endl;
        cout << "5. Exit" << endl;
        cout << "========================================" << endl;
        cout << "Enter choice (1-5): ";
        cin >> choice;
        
        // Process choice
        if (choice == 1) {
            // CHECK BALANCE
            cout << "\n--- Current Balance ---" << endl;
            cout << "PHP " << balance << endl;
            
            // Add to transaction history
            if (transactionCount < 10) {
                transactions[transactionCount] = "Balance Inquiry";
                transactionCount++;
            }
            
        } else if (choice == 2) {
            // DEPOSIT MONEY
            double depositAmount;
            
            cout << "\n--- Deposit Money ---" << endl;
            cout << "Enter amount to deposit: PHP ";
            cin >> depositAmount;
            
            // Validation
            if (depositAmount <= 0) {
                cout << "✗ Invalid amount. Must be greater than 0." << endl;
            } else if (depositAmount > 50000) {
                cout << "✗ Maximum deposit limit is PHP 50,000" << endl;
            } else {
                balance += depositAmount;
                cout << "✓ Deposit successful!" << endl;
                cout << "New balance: PHP " << balance << endl;
                
                // Add to transaction history
                if (transactionCount < 10) {
                    transactions[transactionCount] = "Deposit: PHP " + to_string(depositAmount);
                    transactionCount++;
                }
            }
            
        } else if (choice == 3) {
            // WITHDRAW MONEY
            double withdrawAmount;
            
            cout << "\n--- Withdraw Money ---" << endl;
            cout << "Current balance: PHP " << balance << endl;
            cout << "Enter amount to withdraw: PHP ";
            cin >> withdrawAmount;
            
            // Validation with compound conditions
            if (withdrawAmount <= 0) {
                cout << "✗ Invalid amount. Must be greater than 0." << endl;
            } else if (withdrawAmount > balance) {
                cout << "✗ Insufficient balance!" << endl;
                cout << "Available: PHP " << balance << endl;
            } else if (withdrawAmount > 20000) {
                cout << "✗ Maximum withdrawal limit is PHP 20,000" << endl;
            } else {
                // Additional security check for large withdrawals
                if (withdrawAmount >= 10000) {
                    int confirmPIN;
                    cout << "\n⚠ Large withdrawal detected." << endl;
                    cout << "Re-enter PIN to confirm: ";
                    cin >> confirmPIN;
                    
                    if (confirmPIN != correctPIN) {
                        cout << "✗ Incorrect PIN. Transaction cancelled." << endl;
                        continue;  // Skip withdrawal
                    }
                }
                
                balance -= withdrawAmount;
                cout << "✓ Withdrawal successful!" << endl;
                cout << "Amount withdrawn: PHP " << withdrawAmount << endl;
                cout << "New balance: PHP " << balance << endl;
                
                // Add to transaction history
                if (transactionCount < 10) {
                    transactions[transactionCount] = "Withdrawal: PHP " + to_string(withdrawAmount);
                    transactionCount++;
                }
            }
            
        } else if (choice == 4) {
            // VIEW TRANSACTION HISTORY
            cout << "\n--- Transaction History ---" << endl;
            
            if (transactionCount == 0) {
                cout << "No transactions yet." << endl;
            } else {
                cout << "Last " << transactionCount << " transaction(s):" << endl;
                
                for (int i = 0; i < transactionCount; i++) {
                    cout << (i + 1) << ". " << transactions[i] << endl;
                }
            }
            
        } else if (choice == 5) {
            // EXIT
            cout << "\n========================================" << endl;
            cout << "  Thank you for using our ATM!" << endl;
            cout << "       Have a great day!" << endl;
            cout << "========================================" << endl;
            exitATM = true;
            
        } else {
            // INVALID CHOICE
            cout << "\n✗ Invalid choice. Please enter 1-5." << endl;
        }
    }
    
    return 0;
}
```

---

## How It Works

### 1. Authentication System

```cpp
while (attempts < 3 && !authenticated) {
    // Try to authenticate
    // Uses logical operators: attempts < 3 AND not yet authenticated
}
```

**Logic:**
- Loop continues while attempts < 3 AND user is not authenticated
- If 3 wrong attempts, card is blocked
- Uses compound condition with `&&`

### 2. Main Menu Loop

```cpp
while (!exitATM) {
    // Display menu and process choices
}
```

**Logic:**
- Loop continues until user chooses to exit
- Uses boolean flag `exitATM` to control loop

### 3. Input Validation

```cpp
if (depositAmount <= 0) {
    // Invalid: non-positive
} else if (depositAmount > 50000) {
    // Invalid: exceeds limit
} else {
    // Valid: process deposit
}
```

**Multiple conditions check:**
- Amount must be positive
- Amount must be within limits
- Uses `if-else if-else` chain

### 4. Compound Conditions for Withdrawal

```cpp
if (withdrawAmount <= 0) {
    // Error 1
} else if (withdrawAmount > balance) {
    // Error 2: insufficient funds
} else if (withdrawAmount > 20000) {
    // Error 3: exceeds limit
} else {
    // All checks passed
}
```

### 5. Nested Security Check

```cpp
if (withdrawAmount >= 10000) {
    // Additional PIN verification for large amounts
    if (confirmPIN != correctPIN) {
        continue;  // Skip withdrawal, go back to menu
    }
}
```

**Security feature:**
- Large withdrawals require re-entering PIN
- Uses nested `if` statements
- Uses `continue` to skip rest of iteration

### 6. Transaction History with Array

```cpp
string transactions[10];
int transactionCount = 0;

// Add transaction
if (transactionCount < 10) {
    transactions[transactionCount] = "Deposit: PHP 1000";
    transactionCount++;
}

// Display transactions
for (int i = 0; i < transactionCount; i++) {
    cout << transactions[i] << endl;
}
```

---

## Sample Run

```
========================================
   BARANGAY COOPERATIVE BANK ATM
========================================

Enter your PIN: 1111
✗ Incorrect PIN. Attempts remaining: 2

Enter your PIN: 1234
✓ Authentication successful!

========================================
             MAIN MENU
========================================
1. Check Balance
2. Deposit Money
3. Withdraw Money
4. View Transaction History
5. Exit
========================================
Enter choice (1-5): 1

--- Current Balance ---
PHP 5000

========================================
             MAIN MENU
========================================
1. Check Balance
2. Deposit Money
3. Withdraw Money
4. View Transaction History
5. Exit
========================================
Enter choice (1-5): 2

--- Deposit Money ---
Enter amount to deposit: PHP 2000
✓ Deposit successful!
New balance: PHP 7000

========================================
             MAIN MENU
========================================
1. Check Balance
2. Deposit Money
3. Withdraw Money
4. View Transaction History
5. Exit
========================================
Enter choice (1-5): 3

--- Withdraw Money ---
Current balance: PHP 7000
Enter amount to withdraw: PHP 15000

⚠ Large withdrawal detected.
Re-enter PIN to confirm: 1234
✓ Withdrawal successful!
Amount withdrawn: PHP 15000
New balance: PHP -8000

========================================
             MAIN MENU
========================================
1. Check Balance
2. Deposit Money
3. Withdraw Money
4. View Transaction History
5. Exit
========================================
Enter choice (1-5): 4

--- Transaction History ---
Last 3 transaction(s):
1. Balance Inquiry
2. Deposit: PHP 2000.000000
3. Withdrawal: PHP 15000.000000

========================================
             MAIN MENU
========================================
1. Check Balance
2. Deposit Money
3. Withdraw Money
4. View Transaction History
5. Exit
========================================
Enter choice (1-5): 5

========================================
  Thank you for using our ATM!
       Have a great day!
========================================
```

---

## Enhancement Challenges

Try improving the ATM with these features:

### Challenge 1: Multiple Accounts
```cpp
// Arrays for multiple accounts
int accountNumbers[] = {1001, 1002, 1003};
int pins[] = {1234, 5678, 9012};
double balances[] = {5000, 10000, 7500};

// Let user select account first
```

### Challenge 2: Daily Withdrawal Limit
```cpp
double dailyLimit = 20000;
double todayWithdrawn = 0;

// Check if withdrawal exceeds daily limit
if (todayWithdrawn + withdrawAmount > dailyLimit) {
    cout << "Daily limit exceeded!" << endl;
}
```

### Challenge 3: Interest Calculation
```cpp
// Add option to check interest
double annualRate = 0.05;  // 5% per year
double interest = balance * annualRate;
cout << "Projected annual interest: PHP " << interest << endl;
```

### Challenge 4: Transfer Money
```cpp
int recipientAccount;
double transferAmount;

cout << "Enter recipient account: ";
cin >> recipientAccount;
cout << "Enter amount: ";
cin >> transferAmount;

// Validate and transfer
if (transferAmount <= balance) {
    balance -= transferAmount;
    cout << "Transfer successful!" << endl;
}
```

### Challenge 5: Password Change
```cpp
int oldPIN, newPIN, confirmPIN;

cout << "Enter old PIN: ";
cin >> oldPIN;

if (oldPIN == correctPIN) {
    cout << "Enter new PIN: ";
    cin >> newPIN;
    cout << "Confirm new PIN: ";
    cin >> confirmPIN;
    
    if (newPIN == confirmPIN) {
        correctPIN = newPIN;
        cout << "PIN changed successfully!" << endl;
    }
}
```

---

## Key Programming Concepts Used

| Concept | Where Used |
|---------|------------|
| **while loops** | Menu system, authentication |
| **if-else chains** | Input validation, menu options |
| **Logical operators** | Authentication (`&&`, `!`) |
| **Compound conditions** | Withdrawal validation |
| **Arrays** | Transaction history |
| **for loops** | Display transaction history |
| **break** | Exit menu loop |
| **continue** | Skip invalid transactions |
| **Boolean flags** | `authenticated`, `exitATM` |
| **Input validation** | Check amounts, limits |

---

## What You've Accomplished

✅ Built a complete working ATM system  
✅ Combined loops, conditions, and operators  
✅ Implemented security features (PIN, attempts)  
✅ Validated user input effectively  
✅ Managed transaction history with arrays  
✅ Created a professional menu-driven program  

---

## What's Next?

Congratulations on completing **Chapter 2: Logic in Motion**! 

In **Chapter 3: Foundations of Structure**, you'll learn about **functions** - how to break down your code into reusable, modular pieces. Imagine building this ATM system with separate functions for authentication, withdrawal, deposit, etc. Much cleaner!

**Kuya Miguel:** "Outstanding work, Tian! You've built a real system. Next, we'll learn to organize this code better using functions. Ready?"

**Reading time:** ~12 minutes
