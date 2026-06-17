# C++ Activity

Write generic functions that work with any comparable type, then print a mixed-type pair.

```cpp
#include <iostream>
#include <string>
#include <cassert>

using namespace std;

// --- Task 1: Function Templates ---
// TODO: Create a function template getMinimum(T a, T b) that returns the smaller value

// TODO: Create a function template getMaximum(T a, T b) that returns the larger value

// --- Task 2: Multiple Template Parameters ---
// TODO: Create a function template printPair(T first, U second) that prints:
//       "Pair: <first> and <second>"

void run_demo() {
    // Your code here: test getMinimum / getMaximum with int, double, and string,
    // then print "Demonstrating multiple parameters:" followed by two printPair calls
}

int main() {
    cout << "--- Lesson 28: Templates ---" << endl;
    run_demo();
    cout << "\nTemplate logic validated!" << endl;
    return 0;
}
```

## Task for Learners

- Create a function template `getMinimum` using `template <typename T>`.

  ```cpp
  template <typename T>
  T getMinimum(T a, T b) {
      return (a < b) ? a : b;
  }
  ```

- Create a matching `getMaximum` template.

  ```cpp
  template <typename T>
  T getMaximum(T a, T b) {
      return (a > b) ? a : b;
  }
  ```

- Create a `printPair` template that takes two different type parameters.

  ```cpp
  template <typename T, typename U>
  void printPair(T first, U second) {
      cout << "Pair: " << first << " and " << second << endl;
  }
  ```

- In `run_demo()`, test the min/max templates with several types, then print the pair lines.

  ```cpp
  void run_demo() {
      assert(getMinimum(10, 20) == 10);
      assert(getMaximum(10, 20) == 20);

      assert(getMinimum(3.14, 2.71) == 2.71);
      assert(getMaximum(3.14, 2.71) == 3.14);

      string s1 = "Apple";
      string s2 = "Banana";
      assert(getMinimum(s1, s2) == "Apple");
      assert(getMaximum(s1, s2) == "Banana");

      cout << "Demonstrating multiple parameters:" << endl;
      printPair("Age", 25);
      printPair(3.14, "PI");
  }
  ```

### Breakdown of the Activity

- **`template <typename T>`**: Declares a generic type that the compiler fills in at each call site.
- **`(a < b) ? a : b`**: The ternary operator works for any type that supports `<`.
- **Multiple type parameters**: `printPair<T, U>` lets the two arguments be different types.
- **One definition, many types**: The same template handles int, double, and string.
