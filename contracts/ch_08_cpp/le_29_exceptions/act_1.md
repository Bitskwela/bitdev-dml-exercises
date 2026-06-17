# C++ Activity

Handle runtime errors gracefully using try-catch blocks with different exception types.

```cpp
#include <iostream>
#include <string>
#include <cassert>
#include <stdexcept>

using namespace std;

// --- Task 1: Basic Try-Catch (Division by Zero) ---
// TODO: Write safeDivide(double a, double b) that throws a
//       runtime_error("Division by zero error!") when b == 0,
//       otherwise returns a / b

// --- Task 2: Multiple Catch Blocks ---
// TODO: Write processResidentAge(int age) that:
//       - throws a string("Invalid age: Negative") when age < 0
//       - throws an int 120 when age > 120
//       - otherwise prints "Valid age: <age>"

void run_demo() {
    // Your code here: call safeDivide inside try-catch, then loop over
    // several ages calling processResidentAge with multiple catch blocks
}

int main() {
    cout << "--- Lesson 29: Exception Handling ---" << endl;
    run_demo();
    cout << "\nException handling demo completed!" << endl;
    return 0;
}
```

## Task for Learners

- Write `safeDivide()` that throws a `runtime_error` on divide-by-zero.

  ```cpp
  double safeDivide(double a, double b) {
      if (b == 0) {
          throw runtime_error("Division by zero error!");
      }
      return a / b;
  }
  ```

- Write `processResidentAge()` that throws different types depending on the input.

  ```cpp
  void processResidentAge(int age) {
      if (age < 0) throw string("Invalid age: Negative");
      if (age > 120) throw 120; // Throwing an int as an error code
      cout << "Valid age: " << age << endl;
  }
  ```

- In `run_demo()`, exercise both functions and catch each exception type.

  ```cpp
  void run_demo() {
      try {
          cout << "10 / 2 = " << safeDivide(10, 2) << endl;
          cout << "10 / 0 = ";
          safeDivide(10, 0); // This will throw
      } catch (const runtime_error& e) {
          cout << "Caught: " << e.what() << endl;
      }

      int testAges[] = {25, -1, 150};
      for (int a : testAges) {
          try {
              processResidentAge(a);
          } catch (const string& msg) {
              cout << "Caught String: " << msg << endl;
              assert(msg == "Invalid age: Negative");
          } catch (int errorCode) {
              cout << "Caught Int Code: " << errorCode << endl;
              assert(errorCode == 120);
          }
      }
  }
  ```

### Breakdown of the Activity

- **`throw runtime_error("...")`**: Creates and throws a standard exception object with a message.
- **`catch (const runtime_error& e)`**: Catches by const reference to avoid copying.
- **Multiple catch blocks**: Each block matches a specific thrown type (`string` vs `int`).
- **`e.what()`**: Returns the error description string from standard exceptions.
