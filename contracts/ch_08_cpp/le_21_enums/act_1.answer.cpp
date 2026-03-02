#include <iostream>
#include <string>
using namespace std;

enum BarangayPosition {
    CAPTAIN,
    KAGAWAD,
    SECRETARY,
    TREASURER
};

int main() {
    BarangayPosition currentPosition = SECRETARY;
    
    // Switch statement using the enum
    switch (currentPosition) {
        case CAPTAIN:
            cout << "The Captain leads the barangay." << endl;
            break;
        case KAGAWAD:
            cout << "The Kagawad helps pass ordinances." << endl;
            break;
        case SECRETARY:
            cout << "The Secretary handles all records and documentation." << endl;
            break;
        case TREASURER:
            cout << "The Treasurer manages the barangay funds." << endl;
            break;
        default:
            cout << "Unknown position." << endl;
    }
    
    return 0;
}

