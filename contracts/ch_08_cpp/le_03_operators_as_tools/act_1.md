# C++ Activity

Tian builds a complete calculator to practice all five arithmetic operators.

```cpp
#include <iostream>
using namespace std;

int main() {
    double num1 = 10;
    double num2 = 3;

    // Perform all arithmetic operations and store in variables
    // double sum = ?
    // double difference = ?
    // double product = ?
    // double quotient = ?
    // int remainder = ?

    cout << "=== CALCULATOR SYSTEM ===" << endl;
    cout << "Number 1: " << num1 << endl;
    cout << "Number 2: " << num2 << endl;
    cout << endl;
    cout << "ARITHMETIC OPERATIONS:" << endl;
    // Display each result with a label

    return 0;
}
```

## Task for Learners

- Calculate the sum, difference, product, and quotient of `num1` and `num2`.

  ```cpp
  double sum = num1 + num2;
  ```

- Calculate the remainder using modulo. Cast to `int` since `%` requires integers.

  ```cpp
  int remainder = (int)num1 % (int)num2;
  ```

- Display all results with descriptive labels using `cout`.

### Breakdown of the Activity

- **`+`, `-`, `*`, `/`**: Basic arithmetic operators that work with `double` values.
- **`%` (modulo)**: Returns the remainder; requires integer operands.
- **`(int)value`**: Casts a `double` to `int` so modulo can be used.
