# C++ Activity

Explore how global and local variables interact through scope and shadowing.

```cpp
#include <iostream>

using namespace std;

// 1. Declare a global variable 'total'
int total = 0;

void addToTotal(int amount) {
    // 2. Add amount to the global 'total'
    // Your code here
}

void shadowTest() {
    // 3. Declare a local variable named 'total' and initialize it to 100
    // 4. Print the local 'total' and the global 'total' (using ::)
    // Your code here
}

int main() {
    addToTotal(50);
    shadowTest();

    cout << "Final Global Total: " << total << endl;

    return 0;
}
```

## Task for Learners

- Complete `addToTotal` to modify the global variable:

  ```cpp
  total += amount;
  ```

- Complete `shadowTest` with a local variable that shadows the global:

  ```cpp
  int total = 100;
  cout << "Local total: " << total << endl;
  cout << "Global total: " << ::total << endl;
  ```

- Observe that `::total` accesses the global even when a local variable has the same name.

### Breakdown of the Activity

- **`int total = 0;`** (outside functions): A global variable accessible everywhere.
- **`int total = 100;`** (inside function): A local variable that shadows the global.
- **`::total`**: The scope resolution operator accesses the global variable despite shadowing.
- **`addToTotal(50)`**: Modifies the global `total` directly since no local version exists in that function.
