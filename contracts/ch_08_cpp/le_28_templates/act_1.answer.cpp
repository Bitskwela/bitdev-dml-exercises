#include <iostream>
#include <string>
#include <cassert>

using namespace std;

/**
 * LESSON 28: Templates
 * 
 * Templates allow us to write "Generic Code". Instead of writing 
 * separate functions for int, double, and string, we write ONE 
 * template that works for any data type that supports the operations 
 * used within the function (like comparison or addition).
 * 
 * Kuya Miguel's Tip: Use templates to follow the DRY (Don't Repeat Yourself) 
 * principle for algorithms that work the same way regardless of data type.
 */

// --- Task 1: Function Template ---
// A generic function to find the minimum of two values.
template <typename T>
T getMinimum(T a, T b) {
    return (a < b) ? a : b;
}

// A generic function to find the maximum of two values.
template <typename T>
T getMaximum(T a, T b) {
    return (a > b) ? a : b;
}

// --- Task 2: Multiple Template Parameters ---
template <typename T, typename U>
void printPair(T first, U second) {
    cout << "Pair: " << first << " and " << second << endl;
}

void run_demo() {
    // Testing with integers
    assert(getMinimum(10, 20) == 10);
    assert(getMaximum(10, 20) == 20);

    // Testing with doubles
    assert(getMinimum(3.14, 2.71) == 2.71);
    assert(getMaximum(3.14, 2.71) == 3.14);

    // Testing with strings
    string s1 = "Apple";
    string s2 = "Banana";
    assert(getMinimum(s1, s2) == "Apple");
    assert(getMaximum(s1, s2) == "Banana");

    cout << "Demonstrating multiple parameters:" << endl;
    printPair("Age", 25);
    printPair(3.14, "PI");
}

int main() {
    cout << "--- Lesson 28: Templates ---" << endl;
    run_demo();
    cout << "\nTemplate logic validated!" << endl;
    return 0;
}
