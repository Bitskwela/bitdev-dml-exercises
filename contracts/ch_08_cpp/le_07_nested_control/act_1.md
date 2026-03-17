# C++ Activity

Tian generates a multiplication table for the barangay's math tutoring program using nested loops.

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "=== MULTIPLICATION TABLE ===" << endl;

    // Outer loop: rows (1 to 10)
        // Inner loop: columns (1 to 10)
            // Print product with tab spacing
        // Print endl after each row

    return 0;
}
```

## Task for Learners

- Create an outer `for` loop for rows, from 1 to 10.

  ```cpp
  for (int i = 1; i <= 10; i++) {
  ```

- Inside it, create an inner `for` loop for columns, from 1 to 10.

  ```cpp
  for (int j = 1; j <= 10; j++) {
      cout << (i * j) << "\t";
  }
  ```

- After the inner loop, print `endl` to move to the next row.

### Breakdown of the Activity

- **Outer loop (`i`)**: Controls the row number; runs 10 times.
- **Inner loop (`j`)**: Controls the column; runs 10 times per row (100 total iterations).
- **`(i * j)`**: Calculates the product for each cell in the table.
- **`"\t"`**: Tab character that aligns numbers into neat columns.
