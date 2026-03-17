# C++ Activity

Ensure your objects start with valid data using default and parameterized constructors.

```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    // Your code here: Implement a default constructor (set accountNumber="0000", balance=0.0)

    // Your code here: Implement a parameterized constructor (string accNo, double initBalance)

    void display() {
        cout << "Account: " << accountNumber << " | Balance: P" << balance << endl;
    }

    double getBalance() const { return balance; }
};

int main() {
    // Your code here: Create a BankAccount using the default constructor

    // Your code here: Create a BankAccount using the parameterized constructor

    // Your code here: Call display on both accounts

    return 0;
}
```

## Task for Learners

- Implement the default constructor that sets safe initial values:

  ```cpp
  BankAccount() {
      accountNumber = "0000";
      balance = 0.0;
  }
  ```

- Implement the parameterized constructor that accepts an account number and initial balance.

- Create two accounts in `main` and call `display()` on both to verify initialization.

### Breakdown of the Activity

- **`BankAccount()`**: Default constructor -- same name as the class, no return type, no parameters.
- **`BankAccount(string, double)`**: Parameterized constructor -- C++ selects the right one based on arguments.
- **`~BankAccount()`**: Destructor runs automatically when the object leaves scope for cleanup.
