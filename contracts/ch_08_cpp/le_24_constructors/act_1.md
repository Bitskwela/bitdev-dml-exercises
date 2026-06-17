# C++ Activity

Ensure your `BankAccount` objects start with valid data using a **default** and a **parameterized** constructor, and watch a **destructor** clean up automatically when each object leaves scope. To make construction and destruction visible, each constructor and the destructor print a message, and `main` runs each demo inside its own `{ }` scope block.

```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    // TODO: Default constructor BankAccount()
    //   - set accountNumber = "0000", balance = 0.0
    //   - print: "[Default Constructor] Account created with default values."

    // TODO: Parameterized constructor BankAccount(string accNo, double initBalance)
    //   - set accountNumber = accNo, balance = initBalance
    //   - print: "[Parameterized Constructor] Account <accountNumber> created with balance P<balance>"

    // TODO: Destructor ~BankAccount()
    //   - print: "[Destructor] Account <accountNumber> is being destroyed. Cleaning up..."

    void display() {
        cout << "Account: " << accountNumber << " | Balance: P" << balance << endl;
    }

    double getBalance() const { return balance; }
};

// TODO: task1_demo(): create a BankAccount with the DEFAULT constructor,
//       then call display() on it.
void task1_demo() {
    // TODO: build the default account and display it here
}

// TODO: task2_demo(): create a BankAccount "ACC-123" with balance 5000.0
//       using the PARAMETERIZED constructor, then call display() on it.
void task2_demo() {
    // TODO: build the parameterized account and display it here
}

int main() {
    cout << "--- Lesson 24: Constructors & Destructors ---" << endl;

    // TODO: Task 1 scope block.
    //   Print "\nStarting Task 1 scope...", run task1_demo(),
    //   then print "Task 1 scope ending..." INSIDE a { } block so the
    //   destructor fires before the block closes.
    {
        // TODO: Task 1 scope body
    }

    // TODO: Task 2 scope block (same pattern, "Task 2").
    {
        // TODO: Task 2 scope body
    }

    cout << "\nAll activities completed successfully!" << endl;

    return 0;
}
```

## Task for Learners

- Implement the **default constructor** that sets safe initial values and announces itself:

  ```cpp
  BankAccount() {
      accountNumber = "0000";
      balance = 0.0;
      cout << "[Default Constructor] Account created with default values." << endl;
  }
  ```

- Implement the **parameterized constructor** that initializes from arguments and announces itself:

  ```cpp
  BankAccount(string accNo, double initBalance) {
      accountNumber = accNo;
      balance = initBalance;
      cout << "[Parameterized Constructor] Account " << accountNumber << " created with balance P" << balance << endl;
  }
  ```

- Implement the **destructor**, which runs automatically when the object is destroyed:

  ```cpp
  ~BankAccount() {
      cout << "[Destructor] Account " << accountNumber << " is being destroyed. Cleaning up..." << endl;
  }
  ```

- Fill in `task1_demo()` so it builds an account with the default constructor and displays it:

  ```cpp
  void task1_demo() {
      BankAccount defaultAcc;
      defaultAcc.display();
  }
  ```

- Fill in `task2_demo()` so it builds an account with the parameterized constructor and displays it:

  ```cpp
  void task2_demo() {
      BankAccount myAcc("ACC-123", 5000.0);
      myAcc.display();
  }
  ```

- In `main`, run each demo inside its own scope block. The closing `}` is what triggers the destructor, so the cleanup line prints *before* the "scope ending" line:

  ```cpp
  {
      cout << "\nStarting Task 1 scope..." << endl;
      task1_demo();
      cout << "Task 1 scope ending..." << endl;
  } // Constructor and Destructor will be visible in output here

  {
      cout << "\nStarting Task 2 scope..." << endl;
      task2_demo();
      cout << "Task 2 scope ending..." << endl;
  }
  ```

### Expected Output

```
--- Lesson 24: Constructors & Destructors ---

Starting Task 1 scope...
[Default Constructor] Account created with default values.
Account: 0000 | Balance: P0
[Destructor] Account 0000 is being destroyed. Cleaning up...
Task 1 scope ending...

Starting Task 2 scope...
[Parameterized Constructor] Account ACC-123 created with balance P5000
Account: ACC-123 | Balance: P5000
[Destructor] Account ACC-123 is being destroyed. Cleaning up...
Task 2 scope ending...

All activities completed successfully!
```

> Note the ordering inside each block: the object is created inside `task1_demo()`/`task2_demo()`, so its destructor fires when that function returns -- *before* the "scope ending..." line prints. That is why every `[Destructor] ...` line appears just above its `Task N scope ending...` line.

### Breakdown of the Activity

- **`BankAccount()`**: Default constructor -- same name as the class, no return type, no parameters. Guarantees every account starts with a known balance instead of garbage.
- **`BankAccount(string, double)`**: Parameterized constructor -- C++ selects the right constructor based on the arguments you pass (constructor overloading).
- **`~BankAccount()`**: Destructor -- runs automatically when the object leaves scope. Here it just prints, but in real code it would release resources (RAII).
- **Scope blocks `{ ... }`**: A local object (the one built inside each demo function) is destroyed the moment its function returns, which is why the destructor message appears before the "scope ending" message.
