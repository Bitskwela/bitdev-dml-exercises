#include <iostream>
#include <iomanip>
using namespace std;

/**
 * LESSON 05: UNDERSTANDING CONTROL FLOW
 * Task: Safe Division Calculator
 */

int main() {
    double num1, num2, result;
    
    cout << "=== SAFE DIVISION CALCULATOR ===" << endl;
    
    // In a testing environment, cin might be simulated
    cout << "Enter first number: ";
    if (!(cin >> num1)) return 0;
    
    cout << "Enter second number: ";
    if (!(cin >> num2)) return 0;
    
    if (num2 == 0) {
        cout << "ERROR: Cannot divide by zero!" << endl;
    } else {
        result = num1 / num2;
        cout << fixed << setprecision(2);
        cout << num1 << " / " << num2 << " = " << result << endl;
    }
    
    return 0;
}
