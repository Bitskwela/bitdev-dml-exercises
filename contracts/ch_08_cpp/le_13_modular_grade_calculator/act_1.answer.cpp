#include <iostream>

using namespace std;

/**
 * Task: Modular Grade Calculator
 * Implement calculation and logic in separate functions.
 */

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
