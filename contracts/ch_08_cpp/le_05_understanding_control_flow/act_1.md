# C++ Activity:

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double num1, num2, result;

    cout << "=== SAFE DIVISION CALCULATOR ===" << endl;
    cout << endl;

    // Get two numbers from user
    // Check if divisor is zero
    // If zero, show error
    // If not zero, perform division and show result

    return 0;
}
```

**Time Allotment: 20 minutes**

## Tasks for students

Topics Covered: `if/else`, comparison operators (`==`), input validation, output formatting

- Implement a calculator that validates input to prevent division by zero:
  - Prompt the user to enter two numbers (`num1` and `num2`).
  - Use an `if` statement to check if the divisor (`num2`) is equal to zero.
  - If the divisor is zero, display a clear error message: "ERROR: Cannot divide by zero!".
  - If the divisor is not zero (using `else`), perform the division.
  - Display the calculated result formatted to 2 decimal places using `fixed` and `setprecision(2)`.
