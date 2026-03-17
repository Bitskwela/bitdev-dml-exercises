# C++ Activity

Build a modular grade calculator with separate functions for computation and validation.

```cpp
#include <iostream>

using namespace std;

// Task 1: Calculate the average of three grades
double calculateAverage(double math, double science, double english) {
    // Your code here: return the average
    return 0;
}

// Task 2: Determine if the average is passing (>= 75)
bool isPassing(double average) {
    // Your code here: return true if average >= 75.0
    return false;
}

int main() {
    double m = 85.5, s = 90.0, e = 78.5;

    // Task 3: Call calculateAverage and store the result
    // Your code here

    // Task 4: Call isPassing and print the status
    // Your code here

    return 0;
}
```

## Task for Learners

- Complete `calculateAverage` to return the mean of three grades:

  ```cpp
  return (math + science + english) / 3.0;
  ```

- Complete `isPassing` to return whether the average meets the threshold:

  ```cpp
  return average >= 75.0;
  ```

- In `main()`, call both functions and print the results:

  ```cpp
  double avg = calculateAverage(m, s, e);
  cout << "Average: " << avg << endl;
  cout << "Status: " << (isPassing(avg) ? "PASSED" : "FAILED") << endl;
  ```

### Breakdown of the Activity

- **`double calculateAverage(...)`**: Takes three `double` parameters and returns their average.
- **`bool isPassing(double)`**: Returns `true` or `false` based on a threshold check.
- **`(condition ? "A" : "B")`**: The ternary operator prints one of two strings based on the condition.
