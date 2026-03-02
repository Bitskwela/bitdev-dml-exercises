#include <iostream>
using namespace std;

/**
 * LESSON 07: NESTED CONTROL STRUCTURES
 * Task: Multiplication Table
 */

int main() {
    cout << "=== MULTIPLICATION TABLE ===" << endl;
    
    for (int i = 1; i <= 10; i++) {  // Outer loop: Rows
        for (int j = 1; j <= 10; j++) {  // Inner loop: Columns
            cout << (i * j) << "\t";
        }
        cout << endl;  // Move to next line after row
    }
    
    return 0;
}
