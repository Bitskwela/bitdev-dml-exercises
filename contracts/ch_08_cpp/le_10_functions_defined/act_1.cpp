#include <iostream>
#include <string>

using namespace std;

// Task 1: Define a void function that prints a welcome message
void displayWelcome() {
    // Your code here
}

// Task 2: Define a function that takes a string parameter
void greetResident(string name) {
    // Your code here
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
