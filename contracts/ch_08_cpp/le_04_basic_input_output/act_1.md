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

- Use `getline(cin, fullName)` to read the full name (supports spaces). Print the prompt `Full name: ` first.

  ```cpp
  cout << "Full name: ";
  getline(cin, fullName);
  ```

- Print the prompt `Age: `, read with `cin >> age`, then call `cin.ignore()` before the next `getline`.

  ```cpp
  cout << "Age: ";
  cin >> age;
  cin.ignore();
  ```

- Print the prompt `City: ` and use `getline(cin, city)`; then print `Monthly income: ` and use `cin >> income`.

  ```cpp
  cout << "City: ";
  getline(cin, city);
  cout << "Monthly income: ";
  cin >> income;
  ```

- Display the summary with the exact labels below. Use `fixed << setprecision(2)` so the income shows two decimals, and prefix it with `P` for pesos.

  ```cpp
  cout << "Name: " << fullName << endl;
  cout << "Age: " << age << endl;
  cout << "City: " << city << endl;
  cout << fixed << setprecision(2);
  cout << "Monthly Income: P" << income << endl;
  ```

### Breakdown of the Activity

- **`getline(cin, var)`**: Reads a full line including spaces.
- **`cin >> var`**: Reads a single value (stops at whitespace).
- **`cin.ignore()`**: Clears the newline left in the buffer after `cin >>`.
- **`fixed << setprecision(2)`**: Formats decimals to exactly 2 places.
