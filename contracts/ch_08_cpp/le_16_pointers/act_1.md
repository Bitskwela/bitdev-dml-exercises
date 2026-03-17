# C++ Activity

Use pointers to update the barangay fund by passing a memory address to a function.

```cpp
#include <iostream>
using namespace std;

void updateFund(int* fundPtr, int amount) {
    // TODO: Check if fundPtr is not nullptr, then add amount to the value it points to
    // Your code here
}

int main() {
    int barangayFund = 5000;

    // TODO: Create a pointer to barangayFund
    // Your code here

    // TODO: Call updateFund using the pointer and amount 2000
    // Your code here

    cout << "Final Fund value: " << barangayFund << endl;

    return 0;
}
```

## Task for Learners

- Complete `updateFund` to safely dereference and modify the value:

  ```cpp
  if (fundPtr != nullptr) {
      *fundPtr += amount;
  }
  ```

- Create a pointer to `barangayFund`:

  ```cpp
  int* ptr = &barangayFund;
  ```

- Call the function with the pointer:

  ```cpp
  updateFund(ptr, 2000);
  ```

### Breakdown of the Activity

- **`int* ptr = &barangayFund`**: Creates a pointer that stores the address of `barangayFund`.
- **`*fundPtr += amount`**: Dereferences the pointer to access and modify the original variable.
- **`if (fundPtr != nullptr)`**: Safety check that prevents crashing if the pointer is null.
- **`updateFund(ptr, 2000)`**: Passes the pointer (address) to the function, allowing it to modify `barangayFund` indirectly.
