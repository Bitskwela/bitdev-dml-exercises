#include <iostream>
using namespace std;

/**
 * LESSON 03: OPERATORS AS TOOLS
 * Task: Complete Calculator System
 */

int main() {
    double num1 = 10;
    double num2 = 3;
    
    // Perform all arithmetic operations
    double sum = num1 + num2;
    double difference = num1 - num2;
    double product = num1 * num2;
    double quotient = num1 / num2;
    int remainder = (int)num1 % (int)num2;  // Modulo works with integers
    
    // Display results
    cout << "=== CALCULATOR SYSTEM ===" << endl;
    cout << "Number 1: " << num1 << endl;
    cout << "Number 2: " << num2 << endl;
    cout << endl;
    cout << "ARITHMETIC OPERATIONS:" << endl;
    cout << "Sum: " << sum << endl;
    cout << "Difference: " << difference << endl;
    cout << "Product: " << product << endl;
    cout << "Quotient: " << quotient << endl;
    cout << "Remainder: " << remainder << endl;
    
    return 0;
}
