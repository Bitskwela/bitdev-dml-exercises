# C++ Activity:

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string fullName, city;
    int age;
    double income;

    // Get full name (use getline for spaces!)
    // Get age (use cin)
    // Remember cin.ignore() after numeric input!
    // Get city
    // Get monthly income

    // Display formatted summary

    return 0;
}
```

**Time Allotment: 30 minutes**

## Tasks for students

Topics Covered: `cin`, `getline()`, `cin.ignore()`, `<iomanip>` (fixed, setprecision)

- Create an interactive registration form that collects and displays resident information:
  - Use `getline(cin, fullName)` to read the full name including spaces.
  - Use `cin >> age` to read the age.
  - Call `cin.ignore()` after reading the age to clear the newline character from the buffer before using `getline()` again.
  - Use `getline(cin, city)` to read the city.
  - Use `cin >> income` to read the monthly income.
  - Use `fixed` and `setprecision(2)` from the `<iomanip>` library to display the income with two decimal places.
  - Display all collected information in a clear summary.
