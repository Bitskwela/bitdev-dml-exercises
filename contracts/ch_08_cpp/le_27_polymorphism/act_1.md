# C++ Activity

Use virtual functions to make the correct method execute at runtime.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

class Base {
public:
    // TODO: Declare a virtual method msg() that returns "Base"

    // TODO: Add a virtual destructor
};

// TODO: Create a Derived class that overrides msg() to return "Derived"

int main() {
    // Your code here: create a Derived through a Base pointer
    // and test that the override is called

    return 0;
}
```

## Task for Learners

- Add a `virtual` method `msg()` to Base that returns the string `"Base"`.

  ```cpp
  virtual string msg() { return "Base"; }
  ```

- Create a `Derived` class that overrides `msg()` to return `"Derived"`.

  ```cpp
  string msg() override { return "Derived"; }
  ```

- In `main`, create a `Derived` object through a `Base*` pointer and verify the override is called.

  ```cpp
  Base* b = new Derived();
  assert(b->msg() == "Derived");
  delete b;
  ```

### Breakdown of the Activity

- **`virtual`**: Enables dynamic dispatch so the runtime object type determines which method runs.
- **`override`**: Ensures the derived method actually overrides a base virtual function.
- **`virtual ~Base()`**: Virtual destructor ensures proper cleanup when deleting through a base pointer.
- **`Base* b = new Derived()`**: A base pointer holding a derived object -- the core of polymorphism.
