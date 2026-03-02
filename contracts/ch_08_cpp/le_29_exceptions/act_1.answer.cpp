#include <iostream>
#include <string>
#include <cassert>
#include <stdexcept>

using namespace std;

/**
 * LESSON 29: Exception Handling
 * 
 * Exceptions are runtime errors that disrupt normal program flow. Instead of 
 * letting the program crash, we use 'try', 'throw', and 'catch' to handle 
 * these situations gracefully.
 * 
 * Kuya Miguel's Tip: Use exceptions for "exceptional" circumstances that 
 * you can't prevent with simple 'if' checks alone, or when you want the 
 * caller of a function to decide how to handle an error.
 */

// --- Task 1: Basic Try-Catch (Division by Zero) ---
double safeDivide(double a, double b) {
    if (b == 0) {
        throw runtime_error("Division by zero error!");
    }
    return a / b;
}

// --- Task 2: Multiple Catch Blocks ---
void processResidentAge(int age) {
    if (age < 0) throw string("Invalid age: Negative");
    if (age > 120) throw 120; // Throwing an int as an error code
    cout << "Valid age: " << age << endl;
}

void run_demo() {
    // Demo Task 1
    try {
        cout << "10 / 2 = " << safeDivide(10, 2) << endl;
        cout << "10 / 0 = ";
        safeDivide(10, 0); // This will throw
    } catch (const runtime_error& e) {
        cout << "Caught: " << e.what() << endl;
    }

    // Demo Task 2
    int testAges[] = {25, -1, 150};
    for (int a : testAges) {
        try {
            processResidentAge(a);
        } catch (const string& msg) {
            cout << "Caught String: " << msg << endl;
            assert(msg == "Invalid age: Negative");
        } catch (int errorCode) {
            cout << "Caught Int Code: " << errorCode << endl;
            assert(errorCode == 120);
        }
    }
}

int main() {
    cout << "--- Lesson 29: Exception Handling ---" << endl;
    run_demo();
    cout << "\nException handling demo completed!" << endl;
    return 0;
}
