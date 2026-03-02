#include <iostream>
#include <cassert>
#include <string>

using namespace std;

enum BarangayPosition {
    CAPTAIN,
    KAGAWAD,
    SECRETARY,
    TREASURER
};

void testEnum() {
    BarangayPosition pos = SECRETARY;
    
    assert(pos == SECRETARY && "Task: Enum assignment failed.");
    assert(CAPTAIN == 0 && "Task: Enum default value for CAPTAIN should be 0.");
    assert(TREASURER == 3 && "Task: Enum default value for TREASURER should be 3.");
    
    cout << "Test Task (Enums Implementation): PASS" << endl;
}

int main() {
    cout << "Running Lesson 21 Tests..." << endl;
    testEnum();
    cout << "All Lesson 21 tests passed!" << endl;
    return 0;
}

