#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

/**
 * LESSON 04: BASIC INPUT AND OUTPUT
 * Task: Personal Information Form
 */

int main() {
    string fullName, city;
    int age;
    double income;
    
    // In a testing environment, cin might be simulated
    cout << "=== RESIDENT REGISTRATION FORM ===" << endl;
    
    cout << "Full name: ";
    getline(cin, fullName);
    
    cout << "Age: ";
    cin >> age;
    cin.ignore();  // Clear buffer
    
    cout << "City: ";
    getline(cin, city);
    
    cout << "Monthly income: ";
    cin >> income;
    
    cout << endl;
    cout << "=== REGISTRATION SUMMARY ===" << endl;
    cout << "Name: " << fullName << endl;
    cout << "Age: " << age << endl;
    cout << "City: " << city << endl;
    cout << fixed << setprecision(2);
    cout << "Monthly Income: P" << income << endl;
    
    return 0;
}
