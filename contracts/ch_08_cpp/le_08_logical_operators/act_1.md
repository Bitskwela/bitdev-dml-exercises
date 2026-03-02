# C++ Activity:

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

    // Check if age >= 18 AND isRegistered

    return 0;
}
```

**Time Allotment: 20 minutes**

## Tasks for students

Topics Covered: Logical operators (`&&`, `||`), compound conditions

- Implement a voter eligibility checker using the AND (`&&`) operator:

  - Prompt the user to enter their age.
  - Prompt the user to indicate if they are registered (using 1 for Yes, 0 for No).
  - Use an `if` statement with the `&&` operator to check if the age is 18 or older AND the user is registered.
  - If both conditions are true, display "✓ Eligible to vote!".
  - Otherwise, display "✗ Not eligible.".

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

      // Both must be true
      if (age >= 18 && isRegistered) {
          cout << "✓ Eligible to vote!" << endl;
      } else {
          cout << "✗ Not eligible." << endl;
      }

      return 0;
  }
  ```
