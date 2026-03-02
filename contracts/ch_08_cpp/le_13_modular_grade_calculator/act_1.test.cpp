#include <iostream>
#include <cassert>
#include <cmath>

using namespace std;

// Function prototypes
double calculateAverage(double math, double science, double english);
bool isPassing(double average);

// Implementations for testing
double calculateAverage(double math, double science, double english) {
    return (math + science + english) / 3.0;
}

bool isPassing(double average) {
    return average >= 75.0;
}

int main() {
    // Test calculateAverage
    double avg = calculateAverage(80.0, 90.0, 100.0);
    assert(abs(avg - 90.0) < 0.0001 && "calculateAverage failed.");

    // Test isPassing
    assert(isPassing(75.0) == true && "isPassing failed at threshold.");
    assert(isPassing(74.9) == false && "isPassing failed below threshold.");
    assert(isPassing(80.0) == true && "isPassing failed above threshold.");

    cout << "All tests passed!" << endl;
    return 0;
}
