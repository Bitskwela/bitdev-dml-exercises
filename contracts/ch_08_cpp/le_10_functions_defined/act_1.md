# C++ Activity

Create reusable functions for the Barangay Portal system.

```cpp
#include <iostream>
#include <string>

using namespace std;

// Task 1: Define a void function that prints a welcome message
void displayWelcome() {
    // Your code here
}

// Task 2: Define a function that takes a string parameter
void greetResident(string name) {
    // Your code here
}

int main() {
    cout << "=== TASK 1: DIRECT FUNCTION CALL ===" << endl;
    displayWelcome();
    cout << endl;

    cout << "=== TASK 2: PARAMETERIZED FUNCTION CALL ===" << endl;
    greetResident("Juan");
    greetResident("Maria");

    return 0;
}
```

## Task for Learners

- Complete `displayWelcome()` to print a greeting:

  ```cpp
  cout << "Welcome to Barangay Portal!" << endl;
  ```

- Complete `greetResident(string name)` to print a personalized greeting:

  ```cpp
  cout << "Welcome, " << name << "!" << endl;
  ```

- Observe how `main()` calls both functions -- one without arguments, one with.

### Breakdown of the Activity

- **`void`**: Means the function does not return a value.
- **`string name`**: A parameter that receives input when the function is called.
- **`displayWelcome()`**: A function call with no arguments.
- **`greetResident("Juan")`**: Passes the string `"Juan"` as an argument to the parameter `name`.
