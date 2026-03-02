# C++ Activity:

```cpp
#include <iostream>
using namespace std;

// 1. Function to calculate the average of three grades
double calculateAverage(double math, double science, double english) {
    // Return average
    return 0;
}

// 2. Function to determine pass/fail status
bool isPassing(double average) {
    // Return true if average >= 75
    return false;
}

int main() {
    double m = 85.5, s = 90.0, e = 78.5;

    // 3. Call calculateAverage

    // 4. Call isPassing and print status

    return 0;
}
```

**Time Allotment: 25 minutes**

## Tasks for students

Topics Covered: Modular programming, functions with return values, logical flow.

- Implement a modular grade calculator:
  - Define `calculateAverage(double math, double science, double english)` that returns the average of the three grades.
  - Define `isPassing(double average)` that returns `true` if the average is 75 or above, and `false` otherwise.
  - In `main()`, use these functions to compute the average for a student and determine if they passed.

```cpp
#include <iostream>
using namespace std;

double calculateAverage(double math, double science, double english) {
    return (math + science + english) / 3.0;
}

bool isPassing(double average) {
    return average >= 75.0;
}

int main() {
    double m = 85.5, s = 90.0, e = 78.5;
    double avg = calculateAverage(m, s, e);

    cout << "Average: " << avg << endl;
    if (isPassing(avg)) {
        cout << "Status: PASSED" << endl;
    } else {
        cout << "Status: FAILED" << endl;
    }

    return 0;
}
```
