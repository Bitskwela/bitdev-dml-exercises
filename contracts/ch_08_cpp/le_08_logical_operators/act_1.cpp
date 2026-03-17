#include <iostream>
using namespace std;

int main() {
    int age;
    bool isRegistered;

    cout << "=== VOTER ELIGIBILITY CHECKER ===" << endl;
    cout << "Age: ";
    cin >> age;
    cout << "Registered? (1=Yes, 0=No): ";
    cin >> isRegistered;

    // Check if age >= 18 AND isRegistered using &&
    // If both true: print eligible message
    // Otherwise: print not eligible message

    return 0;
}
