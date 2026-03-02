# C++ Activity:

```cpp
#include <iostream>
using namespace std;

// 1. Declare a global variable 'total'
int total = 0;

void addToTotal(int amount) {
    // 2. Add amount to the global 'total'
}

void shadowTest() {
    // 3. Declare a local variable named 'total' and initialize it to 100
    // 4. Print the local 'total' and the global 'total' (using ::)
}

int main() {
    addToTotal(50);
    shadowTest();
    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: Global variables, local variables, shadowing, scope resolution operator `::`.

- Explore variable scope and shadowing:
  - Declare a global variable `total` initialized to 0.
  - Create a function `addToTotal(int amount)` that updates the global `total`.
  - Create a function `shadowTest()` that declares a local variable also named `total`.
  - Inside `shadowTest()`, print both the local `total` and the global `total` using the scope resolution operator `::`.

```cpp
#include <iostream>
using namespace std;

int total = 0;

void addToTotal(int amount) {
    total += amount;
}

void shadowTest() {
    int total = 100;
    cout << "Local total: " << total << endl;
    cout << "Global total: " << ::total << endl;
}

int main() {
    addToTotal(50);
    shadowTest();
    return 0;
}
```
