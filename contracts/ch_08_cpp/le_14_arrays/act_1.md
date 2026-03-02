# C++ Activity:

```cpp
#include <iostream>
using namespace std;

int main() {
    // 1. Declare an array of 5 integers (monthly expenses)
    int expenses[5] = {1000, 2000, 1500, 3000, 2500};

    // 2. Calculate the total expense using a loop
    int total = 0;

    // 3. Find the average expense
    double average = 0;

    // 4. Print the total and average

    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: Array declaration, initialization, looping through arrays, basic statistics.

- Manage a list of expenses:
  - Declare an array of 5 integers representing monthly expenses.
  - Use a `for` loop to iterate through the array and calculate the total sum of expenses.
  - Calculate the average expense (total divided by number of elements).
  - Print the total and the average to the console.

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

    double average = static_cast<double>(total) / size;

    cout << "Total Expenses: " << total << endl;
    cout << "Average Expense: " << average << endl;

    return 0;
}
```
