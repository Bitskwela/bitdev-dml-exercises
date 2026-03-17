# Arrays

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+14.0+-+COVER.png)

## Scene

The barangay secretary dropped a bombshell: "We need to track monthly dues for 500 residents." Tian stared at his code in horror -- the current system used individual variables like `int resident1_dues`, `int resident2_dues`. Creating 500 variables manually was insane.

"Kuya, there has to be a better way," Tian pleaded. "How do real systems handle thousands of records? Facebook doesn't create a separate variable for each user."

Kuya Miguel grinned. "Welcome to **arrays** -- the solution to managing collections of data. Instead of 500 variables, you create one array that holds 500 values. Instead of 500 lines of processing code, you write one loop. Arrays are everywhere: player inventory in games, student records in schools, product lists in sari-sari stores. Let's unlock this power!"

## C++ Topics: Arrays

![14.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+14.1.png)

### Declaration and Initialization

> An array holds multiple values of the **same type** in contiguous memory. Declare with `type name[size]` and optionally initialize with `= {val1, val2, ...}`.

### Indexing

> Access elements using zero-based indexing: `arr[0]` is the first element, `arr[4]` is the fifth. Going out of bounds causes undefined behavior.

### Looping Through Arrays

> Use a `for` loop with the array size to process every element. This is the core pattern for summing, searching, or transforming array data.

### Arrays and Functions

> Arrays are always passed by reference to functions. Pass the array and its size as separate parameters so the function knows how many elements to process.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    int expenses[5] = {1000, 2000, 1500, 3000, 2500};
    int total = 0;
    int size = 5;

    for (int i = 0; i < size; i++) {
        total += expenses[i];
    }

    double average = (double)total / size;

    cout << "Total Expenses: " << total << endl;
    cout << "Average Expense: " << average << endl;
    return 0;
}
```

The array `expenses` stores 5 values. A `for` loop iterates through each index, accumulating the total. Casting to `double` before division ensures a decimal average.
