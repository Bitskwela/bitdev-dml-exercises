# C++ Activity

Tian creates a personal profile system to practice declaring different variable types.

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Declare your variables here
    // string fullName = ?
    // int age = ?
    // int gradeLevel = ?
    // string favoriteSubject = ?
    // double gpa = ?

    cout << "=== My Profile ===" << endl;
    // Display each variable with a label

    return 0;
}
```

## Task for Learners

- Declare a `string` variable `fullName` and assign it a name.

  ```cpp
  string fullName = "Tian Reyes";
  ```

- Declare `int` variables `age` and `gradeLevel`, and a `string` for `favoriteSubject`.

  ```cpp
  int age = 16;
  int gradeLevel = 10;
  string favoriteSubject = "Computer Science";
  ```

- Declare a `double` variable `gpa` for a decimal grade value.

  ```cpp
  double gpa = 91.5;
  ```

- Use `cout` to display each variable with the exact labels shown below.

  ```cpp
  cout << "Name: " << fullName << endl;
  cout << "Age: " << age << endl;
  cout << "Grade: " << gradeLevel << endl;
  cout << "Favorite Subject: " << favoriteSubject << endl;
  cout << "GPA: " << gpa << endl;
  ```

### Breakdown of the Activity

- **`string`**: Stores text in double quotes; requires `#include <string>`.
- **`int`**: Stores whole numbers without quotes.
- **`double`**: Stores decimal numbers for precision.
- **`cout << "Label: " << variable << endl;`**: Chains a label and variable value together for display.
