#include <iostream>
#include <iomanip>

using namespace std;

int main() {
    int age;
    bool isRegistered;
    
    cout << "=== VOTER ELIGIBILITY CHECKER ===" << endl;
    
    cout << "Age: ";
    cin >> age;
    
    cout << "Registered? (1=Yes, 0=No): ";
    cin >> isRegistered;
    
    // Both must be true
    if (age >= 18 && isRegistered) {
        cout << "✓ Eligible to vote!" << endl;
    } else {
        cout << "✗ Not eligible." << endl;
    }
    
    return 0;
}
