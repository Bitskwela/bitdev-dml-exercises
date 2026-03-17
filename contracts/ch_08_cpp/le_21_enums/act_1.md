# C++ Activity

Replace magic numbers with meaningful enum names for barangay positions.

```cpp
#include <iostream>
using namespace std;

// Your code here: Create an enum 'BarangayPosition' with CAPTAIN, KAGAWAD, SECRETARY, TREASURER

int main() {
    // Your code here: Create a variable of type BarangayPosition and assign SECRETARY

    // Your code here: Use a switch statement to print a description based on the position

    return 0;
}
```

## Task for Learners

- Define the `BarangayPosition` enum with four values:

  ```cpp
  enum BarangayPosition {
      CAPTAIN, KAGAWAD, SECRETARY, TREASURER
  };
  ```

- Declare a variable of type `BarangayPosition` and assign it a value like `SECRETARY`.

- Write a `switch` statement that prints a unique description for each position.

### Breakdown of the Activity

- **`enum BarangayPosition`**: Defines a type with named constants; values default to 0, 1, 2, 3.
- **`case SECRETARY:`**: Switch cases use the enum name instead of a raw number for readability.
- **`CAPTAIN == 0`**: Enum values are integers under the hood, starting at 0 by default.
