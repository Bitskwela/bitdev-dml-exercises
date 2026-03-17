# Modular Grade Calculator

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+13.0+-+COVER.png)

## Scene

Tian looked at his old grade calculator -- a 150-line mess with input handling, calculations, validation, and display all tangled in one giant block. "I need to add a feature to track highest and lowest grades, but I'm scared to touch anything. If I change one line, three other things might break."

Kuya Miguel pulled up a chair. "They use **modular design**. Look at your phone -- the screen, battery, and camera are separate modules. If the screen breaks, you replace just the screen. Right now, your calculator is like a jeepney welded together in one piece. Today we're rebuilding it the right way."

"We're not learning new syntax," Kuya Miguel said. "We're learning software architecture -- how to organize code like a professional. Separate functions for calculation, validation, and display. Let's go!"

## C++ Topics: Modular Programming

![13.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+13.1.png)

### Calculation Functions

> Break math logic into its own function with a clear return type. A `calculateAverage()` function takes grades as parameters and returns the result -- one job, done well.

### Validation Functions

> A `bool` function like `isPassing(double average)` returns `true` or `false`. This separates decision logic from display logic, making each piece independently testable.

### Putting It Together

> In `main()`, call your functions in sequence: calculate, validate, display. The main function becomes a clean, readable summary of what the program does.

#### Sample syntax

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
    bool passed = isPassing(avg);

    cout << "Average: " << avg << endl;
    cout << "Status: " << (passed ? "PASSED" : "FAILED") << endl;
    return 0;
}
```

Each function has one responsibility: `calculateAverage` computes the mean, `isPassing` checks the threshold, and `main` orchestrates the flow.
