# C++ Activity

Write a generic minimum function that works with any comparable type.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

// TODO: Create a function template getMin(T a, T b) that returns the smaller value

int main() {
    // Your code here: test getMin with int, double, and string types

    return 0;
}
```

## Task for Learners

- Create a function template `getMin` using `template <typename T>`.

  ```cpp
  template <typename T>
  T getMin(T a, T b) {
      return (a < b) ? a : b;
  }
  ```

- Test with integers: `assert(getMin(5, 10) == 5);`

- Test with doubles: `assert(getMin(1.5, 0.5) == 0.5);`

- Test with strings: `assert(getMin(string("A"), string("B")) == "A");`

### Breakdown of the Activity

- **`template <typename T>`**: Declares a generic type that the compiler fills in at each call site.
- **`(a < b) ? a : b`**: The ternary operator works for any type that supports `<`.
- **Type inference**: The compiler deduces `T` from the arguments automatically.
- **One definition, many types**: The same function handles int, double, and string.
