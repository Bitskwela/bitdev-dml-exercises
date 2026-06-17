#include <iostream>
#include <string>
#include <cassert>
#include <stdexcept>

using namespace std;

// --- Task 1: Basic Try-Catch (Division by Zero) ---
// TODO: Write safeDivide(double a, double b) that throws a
//       runtime_error("Division by zero error!") when b == 0,
//       otherwise returns a / b

// --- Task 2: Multiple Catch Blocks ---
// TODO: Write processResidentAge(int age) that:
//       - throws a string("Invalid age: Negative") when age < 0
//       - throws an int 120 when age > 120
//       - otherwise prints "Valid age: <age>"

void run_demo() {
    // Your code here: call safeDivide inside try-catch, then loop over
    // several ages calling processResidentAge with multiple catch blocks
}

int main() {
    cout << "--- Lesson 29: Exception Handling ---" << endl;
    run_demo();
    cout << "\nException handling demo completed!" << endl;
    return 0;
}
