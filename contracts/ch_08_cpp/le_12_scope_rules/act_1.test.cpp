#include <iostream>
#include <cassert>

using namespace std;

// External declarations for symbols defined in the student's code (simulated here)
int total = 0;

void addToTotal(int amount) {
    total += amount;
}

int getShadowedValue() {
    int total = 100;
    return total;
}

int getGlobalValue() {
    return ::total;
}

int main() {
    // Reset global for test
    total = 0;

    // Test global update
    addToTotal(50);
    assert(total == 50 && "addToTotal failed to update global variable.");

    // Test shadowing logic
    assert(getShadowedValue() == 100 && "Local variable should shadow global.");
    assert(getGlobalValue() == 50 && "Scope resolution operator :: should access global variable.");

    cout << "All tests passed!" << endl;
    return 0;
}
