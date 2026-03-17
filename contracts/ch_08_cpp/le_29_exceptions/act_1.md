# C++ Activity

Handle runtime errors gracefully using try-catch blocks with different exception types.

```cpp
#include <iostream>
#include <cassert>
#include <string>
#include <stdexcept>

using namespace std;

// TODO: Write code that throws a runtime_error and catches it
// TODO: Write code that throws an int and catches it with the correct catch block

int main() {
    // Your code here

    return 0;
}
```

## Task for Learners

- Throw a `runtime_error` inside a try block and verify it is caught.

  ```cpp
  bool caught = false;
  try {
      throw runtime_error("Test");
  } catch (const runtime_error& e) {
      caught = true;
  }
  assert(caught == true);
  ```

- Throw an `int` and verify the correct catch block handles it.

  ```cpp
  int typeCaught = 0;
  try {
      throw 404;
  } catch (const string& s) {
      typeCaught = 1;
  } catch (int i) {
      typeCaught = 2;
  }
  assert(typeCaught == 2);
  ```

### Breakdown of the Activity

- **`throw runtime_error("Test")`**: Creates and throws a standard exception object with a message.
- **`catch (const runtime_error& e)`**: Catches by const reference to avoid copying.
- **Multiple catch blocks**: Checked in order; `int` matches before `string` for an int throw.
- **`e.what()`**: Returns the error description string from standard exceptions.
