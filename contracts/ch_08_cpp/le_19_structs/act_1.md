# C++ Activity

Group related barangay resident data into a single custom data type using structs.

```cpp
#include <iostream>
#include <string>
using namespace std;

// Your code here: Define a Resident struct with name (string), age (int), and isVaccinated (bool)

int main() {
    // Your code here: Create a Resident variable

    // Your code here: Initialize the members with data

    // Your code here: Print the resident's information

    return 0;
}
```

## Task for Learners

- Define a `Resident` struct with three members:

  ```cpp
  struct Resident {
      string name;
      int age;
      bool isVaccinated;
  };
  ```

- Create a `Resident` variable and assign values using the dot operator.

- Print all member values to the console in a clear format.

### Breakdown of the Activity

- **`struct Resident { ... };`**: Defines a custom data type; do not forget the semicolon after the closing brace.
- **`person1.name`**: The dot operator accesses individual members of the struct instance.
- **`isVaccinated ? "Yes" : "No"`**: Ternary operator converts the bool to a readable string.
