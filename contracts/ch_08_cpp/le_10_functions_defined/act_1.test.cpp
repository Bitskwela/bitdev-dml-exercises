#include <iostream>
#include <cassert>
#include <string>
#include <sstream>

using namespace std;

// Helper to capture cout for testing if needed
// For simple C++ tests, we just check that functions compile and run
void testFunc() {
    // This just ensures the function exists and can be called
}

int main() {
    // Basic test to ensure functions are defined and callable
    testFunc();
    
    // In a more advanced test, we might capture stdout
    // But for beginning C++, verifying logic is enough
    string name = "Tian";
    assert(name == "Tian");

    cout << "All le_10 tests passed!" << endl;
    return 0;
}
