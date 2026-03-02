# C++ Activity:

```cpp
#include <iostream>
using namespace std;

// Function that uses pass-by-reference to modify the original variable
void updateBalance(double& balance, double amount) {
    // Add amount to balance
}

// Function that calculates and returns a value
double calculateInterest(double balance, double rate) {
    // Return balance * (rate / 100.0)
    return 0;
}

int main() {
    double myBalance = 1000.0;

    // 1. Call updateBalance with myBalance and 500.0

    // 2. Call calculateInterest with myBalance and 5.0

    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: Pass by reference, return values, function parameters.

- Implement a balance tracker:
  - Define `updateBalance(double& balance, double amount)` that adds the `amount` to the `balance` using a reference.
  - Define `calculateInterest(double balance, double rate)` that returns the interest amount (balance \* rate / 100).
  - In `main()`, initialize a balance, update it using the function, and then calculate the interest.

```cpp
#include <iostream>
using namespace std;

void updateBalance(double& balance, double amount) {
    balance += amount;
}

double calculateInterest(double balance, double rate) {
    return balance * (rate / 100.0);
}

int main() {
    double myBalance = 1000.0;
    updateBalance(myBalance, 500.0);
    double interest = calculateInterest(myBalance, 5.0);

    cout << "New Balance: " << myBalance << endl;
    cout << "Interest: " << interest << endl;
    return 0;
}
```
