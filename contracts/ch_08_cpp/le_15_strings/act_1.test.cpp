#include <iostream>
#include <cassert>
#include <string>

using namespace std;

int main() {
    string firstName = "Juan";
    string lastName = "Dela Cruz";
    
    string fullName = firstName + " " + lastName;
    
    // Test concatenation
    assert(fullName == "Juan Dela Cruz" && "String concatenation failed.");
    
    // Test length
    assert(fullName.length() == 14 && "String length calculation failed.");
    
    // Test modification
    fullName[0] = 'R';
    assert(fullName == "Ruan Dela Cruz" && "String character modification failed.");

    cout << "All tests passed!" << endl;
    return 0;
}
