# C++ Activity:

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

**Time Allotment: 45 minutes**

## Tasks for students

Topics Covered: `while` loops, `if/else`, logical operators, arrays, I/O formatting.

- Build a complete ATM system:

  - Implement PIN authentication (3 attempts max).
  - Provide a menu for: Check Balance, Deposit, Withdraw, and Transaction History.
  - Withdrawal must validate sufficient balance.
  - Maintain a simple transaction history using an array.

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
          cout << "\nEnter PIN: ";
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
          cout << "\n======================================" << endl;
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
              cout << "\n--- Balance ---" << endl;
              cout << "PHP " << fixed << setprecision(2) << balance << endl;

              if (transactionCount < 5) {
                  transactions[transactionCount++] = "Balance Inquiry";
              }
          }
          else if (choice == 2) {
              double amount;
              cout << "\n--- Deposit ---" << endl;
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
              cout << "\n--- Withdraw ---" << endl;
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
              cout << "\n--- Transaction History ---" << endl;
              if (transactionCount == 0) {
                  cout << "No transactions yet." << endl;
              } else {
                  for (int i = 0; i < transactionCount; i++) {
                      cout << (i + 1) << ". " << transactions[i] << endl;
                  }
              }
          }
          else if (choice == 5) {
              cout << "\nThank you for banking with us!" << endl;
          }
          else {
              cout << "\n✗ Invalid choice!" << endl;
          }

      } while (choice != 5);

      return 0;
  }
  ```
