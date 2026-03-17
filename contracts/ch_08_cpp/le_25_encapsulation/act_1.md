# C++ Activity

Protect your bank account data using private members and controlled public methods.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

class BankAccount {
private:
    double balance;
public:
    BankAccount(double b) : balance(b) {}

    // TODO: Implement getBalance() as a const method

    // TODO: Implement deposit() that only accepts positive amounts

};

class Student {
private:
    int grade;
public:
    Student(int g) : grade(g) {}

    // TODO: Implement getGrade() as a const method

    // TODO: Implement addPoints() that caps grade at 100

};

int main() {
    // Your code here: test BankAccount and Student

    return 0;
}
```

## Task for Learners

- Implement `getBalance()` as a const getter that returns the balance.

  ```cpp
  double getBalance() const { return balance; }
  ```

- Implement `deposit()` that only adds to balance if amount is positive.

  ```cpp
  void deposit(double a) { if (a > 0) balance += a; }
  ```

- Implement `getGrade()` and `addPoints()` for the Student class, capping grade at 100.

  ```cpp
  void addPoints(int p) { grade += p; if (grade > 100) grade = 100; }
  ```

### Breakdown of the Activity

- **`private`**: Hides `balance` and `grade` from direct access outside the class.
- **`const` getter**: Promises the method does not modify the object.
- **Validation in deposit**: Rejects negative amounts to protect data integrity.
- **Cap logic in addPoints**: Prevents grade from exceeding the maximum of 100.
