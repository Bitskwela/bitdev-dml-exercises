#include <iostream>

using namespace std;

/**
 * Task: Scope and Shadowing
 * Demonstrate global variables, local variables, and the scope resolution operator.
 */

int total = 0;

void addToTotal(int amount) {
    total += amount;
}

void shadowTest() {
    int total = 100;
    cout << "Local total: " << total << endl;
    cout << "Global total: " << ::total << endl;
}

int main() {
    addToTotal(50);
    shadowTest();
    
    cout << "Final Global Total: " << total << endl;

    return 0;
}
