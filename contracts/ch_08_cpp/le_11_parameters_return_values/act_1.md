# C++ Activity

Build a balance tracker using pass-by-reference and return values.

```cpp
#include <iostream>

using namespace std;

// Task 1: Implement pass-by-reference to modify the original balance
void updateBalance(double& balance, double amount) {
    // Your code here: add amount to balance
}

// Task 2: Implement a function that calculates and returns interest
double calculateInterest(double balance, double rate) {
    // Your code here: return balance * (rate / 100.0)
    return 0;
}

int main() {
    double myBalance = 1000.0;

    // Call updateBalance with myBalance and 500.0
    updateBalance(myBalance, 500.0);
    double interest = calculateInterest(myBalance, 5.0);

    cout << "Final Balance: " << myBalance << endl;
    cout << "Interest: " << interest << endl;

    return 0;
}
```

## Task for Learners

- Complete `updateBalance` to add the amount to the balance using the reference:

  ```cpp
  balance += amount;
  ```

- Complete `calculateInterest` to return the interest calculation:

  ```cpp
  return balance * (rate / 100.0);
  ```

- Observe that `myBalance` in `main()` changes after calling `updateBalance` because of `&`.

### Breakdown of the Activity

- **`double& balance`**: The `&` makes this a reference parameter, so changes affect the original variable.
- **`double balance`** (no `&`): Pass by value -- the function gets a copy and the original stays unchanged.
- **`return`**: Sends a computed value back to the caller.
