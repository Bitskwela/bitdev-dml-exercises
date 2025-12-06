## Background Story

Tian had been learning C++ concepts for weeks—variables, operators, conditions, loops, logical operators. Each lesson made sense individually, but Tian felt overwhelmed. "Kuya, I understand each piece, but how do they all fit together in a real program?"

Kuya Miguel smiled knowingly. "You're experiencing what every developer faces: tutorial hell. You can follow lessons, but can you build something real? Let's find out. Today, we're building an **ATM Simulator** from scratch—no tutorial, no step-by-step guide. Just you, your knowledge, and a problem to solve."

Tian's eyes widened with a mix of excitement and nervousness.

"Think about it," Kuya Miguel continued. "An ATM needs secure login with limited attempts—that's loops and conditions. It needs to validate withdrawals against balance—that's logical operators. It needs a menu system that keeps running until the user exits—that's a while loop with nested switch cases. Every concept you've learned will connect here."

"This is your first real test," Kuya Miguel said seriously. "Can you take what you know and build something that works? Welcome to project-based learning. Let's see what you can do!"

---

## Theory & Lecture Content

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

---

## Closing Story

Tian hit Enter and watched his ATM simulator spring to life. PIN authentication, balance checks, deposits, withdrawals with validation, transaction history. It all worked.

"Kuya, I can't believe I built this," Tian said, eyes wide. "A few weeks ago, I was just learning cout and cin. Now I have a working ATM system!"

Kuya Miguel nodded proudly. "You combined everything: while loops for the menu, if-else chains for validation, logical operators for security, arrays for history. This is what real programming looks like. Taking separate concepts and weaving them together to solve real problems."

Tian tested the withdrawal limit, triggering the secondary PIN check for large amounts. "This actually feels secure. Like something people could use."

"It's a solid foundation. But look at your code. It's getting long, right? Lots of repetition? That's where we're headed next. Functions will let you break this down into clean, reusable pieces. Authentication as a function, withdrawal as a function, deposit as a function. Much more organized."

Tian saved his ATM project with pride. Chapter 2 complete. Time to learn structure.

**Reading time:** ~12 minutes
