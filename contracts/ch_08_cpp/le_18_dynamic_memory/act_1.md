# C++ Activity

Allocate and deallocate memory on the heap at runtime for the barangay resident system.

```cpp
#include <iostream>
using namespace std;

int main() {
    int size;
    cout << "Enter the number of residents: ";
    if (!(cin >> size) || size <= 0) return 0;

    // Your code here: Allocate an integer array of 'size' on the heap

    // Your code here: Fill the array with values (e.g., (i + 1) * 10)

    // Your code here: Print the values

    // Your code here: Deallocate the memory and set pointer to nullptr

    return 0;
}
```

## Task for Learners

- Allocate a dynamic array using `new`:

  ```cpp
  int* ages = new int[size];
  ```

- Fill the array with a loop assigning `(i + 1) * 10` to each element.

- Print the values and then free the memory using `delete[]`.

### Breakdown of the Activity

- **`new int[size]`**: Allocates a contiguous block of memory on the heap for `size` integers.
- **`delete[] ages`**: Frees the entire array; using `delete` without `[]` on an array causes undefined behavior.
- **`ages = nullptr`**: Best practice to prevent dangling pointer access after deallocation.
