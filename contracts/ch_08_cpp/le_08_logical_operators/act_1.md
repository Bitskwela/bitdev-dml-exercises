# C++ Activity

Tian builds a voter eligibility checker for the barangay using logical operators to combine conditions.

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    bool isRegistered;

    cout << "=== VOTER ELIGIBILITY CHECKER ===" << endl;
    cout << "Age: ";
    cin >> age;
    cout << "Registered? (1=Yes, 0=No): ";
    cin >> isRegistered;

    // Check if age >= 18 AND isRegistered using &&
    // If both true: print eligible message
    // Otherwise: print not eligible message

    return 0;
}
```

## Task for Learners

- Use an `if` statement with the `&&` operator to check both conditions.

  ```cpp
  if (age >= 18 && isRegistered) {
  ```

- Print a success message when both conditions are true.

- Use `else` to print a "not eligible" message when either condition fails.

### Breakdown of the Activity

- **`&&` (AND)**: Both sides must be `true` for the whole expression to be `true`.
- **`age >= 18`**: Comparison that checks if the voter is old enough.
- **`isRegistered`**: A `bool` that is already `true` or `false`; no comparison needed.
- **`cin >> isRegistered`**: Reads `1` as `true` and `0` as `false`.
