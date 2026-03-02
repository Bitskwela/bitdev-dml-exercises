#include <iostream>
#include <string>

using namespace std;

/**
 * Task: String Manipulation
 * Concatenate names, check length, and modify characters using std::string.
 */

int main() {
    string firstName = "Juan";
    string lastName = "Dela Cruz";
    
    string fullName = firstName + " " + lastName;
    
    cout << "Full Name: " << fullName << endl;
    cout << "Length: " << fullName.length() << " characters" << endl;

    fullName[0] = 'R';
    cout << "Modified: " << fullName << endl;

    return 0;
}
