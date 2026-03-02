# C++ Activity:

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== MULTIPLICATION TABLE ===" << endl;
    cout << endl;

    // Outer loop: rows (1-10)
    // Inner loop: columns (1-10)
    // Print product with tab spacing

    return 0;
}
```

**Time Allotment: 25 minutes**

## Tasks for students

Topics Covered: Nested `for` loops, multi-dimensional iteration, tab formatting (`\t`)

- Generate a multiplication table from 1x1 to 10x10 using nested loops:
  - Create an outer `for` loop to control the rows (from 1 to 10).
  - Inside the outer loop, create an inner `for` loop to control the columns (from 1 to 10).
  - In the inner loop, calculate the product of the row index and column index.
  - Print the product followed by a tab character (`\t`) to align the numbers.
  - After the inner loop finishes each row, use `cout << endl;` to move to the next line.
