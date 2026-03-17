# C++ Activity

Track and analyze monthly barangay expenses using an array.

```cpp
#include <iostream>

using namespace std;

int main() {
    // 1. Array of 5 monthly expenses is declared for you
    int expenses[5] = {1000, 2000, 1500, 3000, 2500};
    int total = 0;
    int size = 5;

    // 2. TODO: Use a for loop to calculate the total of all expenses
    // Your code here

    // 3. TODO: Calculate the average expense
    double average = 0;
    // Your code here

    // 4. TODO: Print the total and average
    // Your code here

    return 0;
}
```

## Task for Learners

- Use a `for` loop to sum all elements in the array:

  ```cpp
  for (int i = 0; i < size; i++) {
      total += expenses[i];
  }
  ```

- Calculate the average by casting to `double`:

  ```cpp
  average = (double)total / size;
  ```

- Print the total and average:

  ```cpp
  cout << "Total Expenses: " << total << endl;
  cout << "Average Expense: " << average << endl;
  ```

### Breakdown of the Activity

- **`int expenses[5]`**: Declares an array of 5 integers.
- **`expenses[i]`**: Accesses the element at index `i` (zero-based).
- **`(double)total`**: Casts the integer to a double so division produces a decimal result.
- **`total += expenses[i]`**: Accumulates each element into the running total.
