# C++ Activity

Tian builds a safe division calculator that validates input before performing calculations.

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double num1, num2;

    cout << "=== SAFE DIVISION CALCULATOR ===" << endl;

    cout << "Enter first number: ";
    cin >> num1;
    cout << "Enter second number: ";
    cin >> num2;

    // Check if num2 is zero
    // If zero: print error message
    // If not zero: divide and display result with 2 decimal places

    return 0;
}
```

## Task for Learners

- Use an `if` statement to check if `num2` equals zero.

  ```cpp
  if (num2 == 0) {
      cout << "ERROR: Cannot divide by zero!" << endl;
  }
  ```

- Use `else` to perform the division when `num2` is not zero.

- Format the result to 2 decimal places using `fixed` and `setprecision(2)`.

### Breakdown of the Activity

- **`if (condition)`**: Executes the block only when the condition is true.
- **`else`**: Runs when the `if` condition is false.
- **`==`**: Comparison operator; do not confuse with `=` (assignment).
- **`fixed << setprecision(2)`**: Formats output to 2 decimal places.
