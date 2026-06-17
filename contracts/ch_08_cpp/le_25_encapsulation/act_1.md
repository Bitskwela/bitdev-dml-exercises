# C++ Activity

Protect your bank account data using private members and controlled public methods.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

// --- Task 1: Private Data Members & Public Interface ---
class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    BankAccount(string accNo, double initBalance) : accountNumber(accNo), balance(initBalance) {
        if (balance < 0) balance = 0;
    }

    // TODO: Implement getBalance() as a const getter

    // TODO: Implement deposit() that only accepts positive amounts
    //       and prints: "Deposited P<amount>. New balance: P<balance>"

    // TODO: Implement withdraw() that rejects invalid amounts
    //       and prints the success / failure message
};

// --- Task 2: Student Class with Encapsulation ---
class Student {
private:
    string name;
    int grade;

public:
    Student(string n, int g) : name(n), grade(g) {
        if (grade < 0) grade = 0;
        if (grade > 100) grade = 100;
    }

    // TODO: Implement getGrade() and getName() as const getters

    // TODO: Implement addPoints() that caps grade at 100
};

void run_demo() {
    // Your code here: exercise BankAccount and Student
}

int main() {
    cout << "--- Lesson 25: Encapsulation ---" << endl;
    run_demo();
    cout << "\nAll encapsulation logic validated!" << endl;
    return 0;
}
```

## Task for Learners

- Implement `getBalance()` as a const getter that returns the balance.

  ```cpp
  double getBalance() const {
      return balance;
  }
  ```

- Implement `deposit()` that only adds to balance if the amount is positive, and prints the result.

  ```cpp
  void deposit(double amount) {
      if (amount > 0) {
          balance += amount;
          cout << "Deposited P" << amount << ". New balance: P" << balance << endl;
      } else {
          cout << "Invalid deposit amount!" << endl;
      }
  }
  ```

- Implement `withdraw()` that only succeeds for a positive amount that does not exceed the balance.

  ```cpp
  bool withdraw(double amount) {
      if (amount > 0 && amount <= balance) {
          balance -= amount;
          cout << "Withdrew P" << amount << ". Remaining: P" << balance << endl;
          return true;
      }
      cout << "Withdrawal failed: Invalid amount or Insufficient funds!" << endl;
      return false;
  }
  ```

- Implement `getGrade()`, `getName()`, and `addPoints()` for the `Student` class, capping grade at 100.

  ```cpp
  int getGrade() const { return grade; }
  string getName() const { return name; }

  void addPoints(int points) {
      if (points > 0) {
          grade += points;
          if (grade > 100) grade = 100;
      }
  }
  ```

- In `run_demo()`, exercise both classes so the program prints the expected lines.

  ```cpp
  void run_demo() {
      BankAccount myAcc("ACC-987", 1000.0);

      myAcc.deposit(500);
      assert(myAcc.getBalance() == 1500.0);

      bool result = myAcc.withdraw(2000);
      assert(result == false);
      assert(myAcc.getBalance() == 1500.0);

      Student s("Maria", 85);
      s.addPoints(10);
      assert(s.getGrade() == 95);
      s.addPoints(10);
      assert(s.getGrade() == 100); // Verify cap logic
  }
  ```

### Breakdown of the Activity

- **`private`**: Hides `balance` and `grade` from direct access outside the class.
- **`const` getter**: Promises the method does not modify the object.
- **Validation in deposit**: Rejects negative amounts to protect data integrity.
- **Cap logic in addPoints**: Prevents grade from exceeding the maximum of 100.
