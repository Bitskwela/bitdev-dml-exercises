#include <iostream>
#include <string>

using namespace std;

// Task 1: Simple Greeting Function
void displayWelcome() {
    cout << "Welcome to Barangay Portal!" << endl;
}

// Task 2: Function with Parameter
void greetResident(string name) {
    cout << "Welcome, " << name << "!" << endl;
}

int main() {
    cout << "=== TASK 1: DIRECT FUNCTION CALL ===" << endl;
    displayWelcome();
    cout << endl;

    cout << "=== TASK 2: PARAMETERIZED FUNCTION CALL ===" << endl;
    greetResident("Juan");
    greetResident("Maria");

    return 0;
}
