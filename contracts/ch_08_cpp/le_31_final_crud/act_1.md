# C++ Activity

Integrate OOP, STL, and exception handling into a final capstone test.

```cpp
#include <iostream>
#include <vector>
#include <string>
#include <memory>
#include <cassert>
#include <stdexcept>

using namespace std;

class Person {
public:
    virtual string type() { return "Person"; }
    virtual ~Person() {}
};

// TODO: Create a Resident class that inherits from Person
// and overrides type() to return "Resident"

int main() {
    // TODO: Test OOP - create a Resident through a Person unique_ptr
    //       and verify polymorphism works

    // TODO: Test STL - create a vector of ints and verify size

    // TODO: Test Exceptions - throw and catch a runtime_error

    return 0;
}
```

## Task for Learners

- Create a `Resident` class that overrides `type()`.

  ```cpp
  class Resident : public Person {
  public:
      string type() override { return "Resident"; }
  };
  ```

- Test polymorphism with a smart pointer.

  ```cpp
  unique_ptr<Person> p = make_unique<Resident>();
  assert(p->type() == "Resident");
  ```

- Test STL vector basics.

  ```cpp
  vector<int> ids = {1, 2, 3};
  assert(ids.size() == 3);
  ```

- Test exception handling.

  ```cpp
  bool caught = false;
  try { throw runtime_error("Final Test"); }
  catch (...) { caught = true; }
  assert(caught == true);
  ```

### Breakdown of the Activity

- **`unique_ptr<Person>`**: Smart pointer that automatically frees memory; no manual `delete` needed.
- **`make_unique<Resident>()`**: Creates a Resident on the heap wrapped in a unique_ptr.
- **`p->type()`**: Polymorphic call -- returns "Resident" because the actual object is a Resident.
- **`catch (...)`**: Catch-all block that handles any exception type thrown.
- **Integration**: This activity verifies inheritance, polymorphism, STL, and exceptions all together.
