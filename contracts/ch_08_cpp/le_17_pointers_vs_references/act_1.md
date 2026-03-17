# C++ Activity

Compare the syntax and behavior of pointers and references when modifying variables.

```cpp
#include <iostream>
using namespace std;

void addTenPtr(int* ptr) {
    // Your code here: Add 10 using pointer dereferencing
}

void addTenRef(int& ref) {
    // Your code here: Add 10 using a reference
}

int main() {
    int value1 = 100;
    int value2 = 100;

    // Your code here: Call addTenPtr with the address of value1
    // Your code here: Call addTenRef with value2

    cout << "Value 1: " << value1 << endl;
    cout << "Value 2: " << value2 << endl;

    return 0;
}
```

## Task for Learners

- Implement `addTenPtr` using pointer dereferencing to add 10:

  ```cpp
  *ptr += 10;
  ```

- Implement `addTenRef` using the reference directly to add 10:

  ```cpp
  ref += 10;
  ```

- Call both functions in `main` -- pass `&value1` to the pointer version and `value2` to the reference version.

### Breakdown of the Activity

- **`int* ptr`**: A pointer parameter that stores an address; use `*ptr` to access the value.
- **`int& ref`**: A reference parameter that acts as an alias; use it directly like a normal variable.
- **`&value1`**: The address-of operator passes the memory address to the pointer function.
