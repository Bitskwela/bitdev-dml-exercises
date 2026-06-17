# C++ Activity

Build a simplified ATM simulator for the Barangay Cooperative Bank.

```cpp
#include <iostream>
#include <iomanip>
#include <string>

using namespace std;

int main() {
    // Account data
    int correctPIN = 1234;
    double balance = 5000.00;
    string transactions[5];
    int transactionCount = 0;

    // Simulate Authentication
    int enteredPIN = 1234;
    bool authenticated = (enteredPIN == correctPIN);

    if (authenticated) {
        cout << "✓ Authentication successful!" << endl;

        // TODO: Simulate a deposit of 500.0
        // - Add depositAmount to balance
        // - Store "Deposit: P500" in transactions array
        // - Print the deposited amount

        // TODO: Simulate a withdrawal of 200.0
        // - Check if withdrawAmount <= balance
        // - If yes, subtract from balance and store in transactions
        // - If no, print "Insufficient funds!"

        // TODO: Print final balance with 2 decimal places
        // Hint: use fixed << setprecision(2)

        // TODO: Print transaction history using a for loop

    } else {
        cout << "Authentication failed." << endl;
    }

    return 0;
}
```

## Task for Learners

- Simulate a deposit of 500.0, record it in the transactions array, and print the deposited amount:

  ```cpp
  double depositAmount = 500.0;
  balance += depositAmount;
  transactions[transactionCount++] = "Deposit: P" + to_string((int)depositAmount);
  cout << "Deposited: P" << depositAmount << endl;
  ```

- Simulate a withdrawal of 200.0 with a balance check, and print the withdrawn amount (or an error if funds are short):

  ```cpp
  double withdrawAmount = 200.0;
  if (withdrawAmount <= balance) {
      balance -= withdrawAmount;
      transactions[transactionCount++] = "Withdraw: P" + to_string((int)withdrawAmount);
      cout << "Withdrawn: P" << withdrawAmount << endl;
  } else {
      cout << "Insufficient funds!" << endl;
  }
  ```

- Print the final balance with 2 decimal places, then loop through the transaction history:

  ```cpp
  cout << "\nFinal Balance: P" << fixed << setprecision(2) << balance << endl;
  cout << "--- Transaction History ---" << endl;
  for (int i = 0; i < transactionCount; i++) {
      cout << (i + 1) << ". " << transactions[i] << endl;
  }
  ```

### Breakdown of the Activity

- **`transactions[transactionCount++]`**: Stores a string at the current index and increments the counter.
- **`to_string()`**: Converts a number to a string for concatenation.
- **`fixed << setprecision(2)`**: Formats doubles to 2 decimal places.
- **`if (withdrawAmount <= balance)`**: Validates sufficient funds before withdrawing.
