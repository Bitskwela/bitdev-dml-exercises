# Lesson 9 Activities: Mini Project - ATM System

## Your First Real Project

Kuya Miguel's challenge: **"Can you take everything you've learned and build something real?"** This is your test—build a working ATM simulator from scratch using all concepts from lessons 1-8.

**This is project-based learning.** No step-by-step tutorial. Just requirements, your knowledge, and problem-solving skills. Welcome to real development!

---

## Core Project: ATM Simulator

**Required Features:**
1. PIN authentication (3 attempts max)
2. Check balance
3. Deposit money
4. Withdraw money (validate sufficient balance)
5. View transaction history (last 5 transactions)
6. Exit system

**Skills You'll Apply:**
- `while` loops for menu
- `if/else` for validation
- Logical operators (`&&`, `||`)
- Arrays for transaction history
- Input/output formatting

**Starter Framework:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Account data
    int correctPIN = 1234;
    double balance = 5000.00;
    
    // Transaction history
    string transactions[5];
    int transactionCount = 0;
    
    // Authentication
    int enteredPIN, attempts = 0;
    bool authenticated = false;
    
    // TODO: PIN authentication loop (3 attempts)
    
    // TODO: Main menu loop
    
    return 0;
}
```

# Tasks for Learners

- Build complete ATM system: Implement PIN authentication, balance check, deposit, withdraw, and transaction history.

  ```cpp
  #include <iostream>
  #include <iomanip>
  #include <string>
  using namespace std;

  int main() {
      int correctPIN = 1234;
      double balance = 5000.00;
      string transactions[5];
      int transactionCount = 0;
      
      cout << "======================================" << endl;
      cout << "   BARANGAY COOPERATIVE BANK ATM" << endl;
      cout << "======================================" << endl;
      
      // PIN Authentication
      int enteredPIN, attempts = 0;
      bool authenticated = false;
      
      while (attempts < 3 && !authenticated) {
          cout << "\\nEnter PIN: ";
          cin >> enteredPIN;
          
          if (enteredPIN == correctPIN) {
              authenticated = true;
              cout << "✓ Authentication successful!" << endl;
          } else {
              attempts++;
              if (attempts < 3) {
                  cout << "✗ Incorrect. Attempts left: " << (3 - attempts) << endl;
              } else {
                  cout << "✗ Card blocked!" << endl;
                  return 0;
              }
          }
      }
      
      // Main Menu
      int choice;
      
      do {
          cout << "\\n======================================" << endl;
          cout << "           MAIN MENU" << endl;
          cout << "======================================" << endl;
          cout << "1. Check Balance" << endl;
          cout << "2. Deposit" << endl;
          cout << "3. Withdraw" << endl;
          cout << "4. Transaction History" << endl;
          cout << "5. Exit" << endl;
          cout << "======================================" << endl;
          cout << "Choice: ";
          cin >> choice;
          
          if (choice == 1) {
              cout << "\\n--- Balance ---" << endl;
              cout << "PHP " << fixed << setprecision(2) << balance << endl;
              
              if (transactionCount < 5) {
                  transactions[transactionCount++] = "Balance Inquiry";
              }
          }
          else if (choice == 2) {
              double amount;
              cout << "\\n--- Deposit ---" << endl;
              cout << "Amount: PHP ";
              cin >> amount;
              
              if (amount > 0 && amount <= 50000) {
                  balance += amount;
                  cout << "✓ Deposit successful!" << endl;
                  cout << "New balance: PHP " << balance << endl;
                  
                  if (transactionCount < 5) {
                      transactions[transactionCount++] = "Deposit: PHP " + to_string(amount);
                  }
              } else {
                  cout << "✗ Invalid amount!" << endl;
              }
          }
          else if (choice == 3) {
              double amount;
              cout << "\\n--- Withdraw ---" << endl;
              cout << "Balance: PHP " << balance << endl;
              cout << "Amount: PHP ";
              cin >> amount;
              
              if (amount > 0 && amount <= balance && amount <= 20000) {
                  balance -= amount;
                  cout << "✓ Withdrawal successful!" << endl;
                  cout << "New balance: PHP " << balance << endl;
                  
                  if (transactionCount < 5) {
                      transactions[transactionCount++] = "Withdraw: PHP " + to_string(amount);
                  }
              } else {
                  cout << "✗ Transaction failed!" << endl;
              }
          }
          else if (choice == 4) {
              cout << "\\n--- Transaction History ---" << endl;
              if (transactionCount == 0) {
                  cout << "No transactions yet." << endl;
              } else {
                  for (int i = 0; i < transactionCount; i++) {
                      cout << (i + 1) << ". " << transactions[i] << endl;
                  }
              }
          }
          else if (choice == 5) {
              cout << "\\nThank you for banking with us!" << endl;
          }
          else {
              cout << "\\n✗ Invalid choice!" << endl;
          }
          
      } while (choice != 5);
      
      return 0;
  }
  ```

---

## Enhancement Challenges

### Challenge 1: Daily Withdrawal Limit
Add PHP 20,000 daily limit. Track today's withdrawals.

### Challenge 2: Transfer Money
Allow transfers between accounts (requires multiple account system).

### Challenge 3: Interest Calculator
Show projected interest earnings at 5% annual rate.

### Challenge 4: PIN Change
Let users change their PIN after verifying old one.

### Challenge 5: Multiple Accounts
Support 3+ accounts with array-based storage.

---

**This is your milestone project!** It combines everything: loops, conditions, logical operators, arrays, input/output. Build it, test it, break it, fix it. This is how you become a developer!
