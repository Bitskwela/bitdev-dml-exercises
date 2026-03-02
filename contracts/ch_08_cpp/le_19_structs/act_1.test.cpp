#include <iostream>
#include <cassert>
#include <string>

using namespace std;

// Struct definition for testing
struct Resident {
    string name;
    int age;
    bool isVaccinated;
};

void testResidentStruct() {
    Resident r;
    r.name = "Juan Dela Cruz";
    r.age = 35;
    r.isVaccinated = true;
    
    assert(r.name == "Juan Dela Cruz" && "Task: Struct member 'name' incorrect.");
    assert(r.age == 35 && "Task: Struct member 'age' incorrect.");
    assert(r.isVaccinated == true && "Task: Struct member 'isVaccinated' incorrect.");
    
    cout << "Test Task (Resident Struct): PASS" << endl;
}

int main() {
    cout << "Running Lesson 19 Tests..." << endl;
    testResidentStruct();
    cout << "All Lesson 19 tests passed!" << endl;
    return 0;
}

