# C++ Activity

Tian builds a barangay resident registration form that collects and displays personal information.

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string fullName, city;
    int age;
    double income;

    cout << "=== RESIDENT REGISTRATION FORM ===" << endl;

    // Get full name using getline
    // Get age using cin
    // Use cin.ignore() to clear buffer
    // Get city using getline
    // Get monthly income using cin

    cout << endl;
    cout << "=== REGISTRATION SUMMARY ===" << endl;
    // Display all information with labels
    // Use fixed and setprecision(2) for income

    return 0;
}
```

## Task for Learners

- Use `getline(cin, fullName)` to read the full name (supports spaces).

  ```cpp
  cout << "Full name: ";
  getline(cin, fullName);
  ```

- Use `cin >> age` then `cin.ignore()` before the next `getline`.

- Use `getline(cin, city)` for the city and `cin >> income` for monthly income.

- Display the summary using `fixed << setprecision(2)` for the income value.

### Breakdown of the Activity

- **`getline(cin, var)`**: Reads a full line including spaces.
- **`cin >> var`**: Reads a single value (stops at whitespace).
- **`cin.ignore()`**: Clears the newline left in the buffer after `cin >>`.
- **`fixed << setprecision(2)`**: Formats decimals to exactly 2 places.
