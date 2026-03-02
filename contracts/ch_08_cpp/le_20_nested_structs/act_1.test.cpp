#include <iostream>
#include <cassert>
#include <string>

using namespace std;

struct Date {
    int day;
    int month;
    int year;
};

struct Resident {
    string name;
    Date birthDate;
};

void testNestedStruct() {
    Resident person;
    person.name = "Crisostomo Ibarra";
    person.birthDate.day = 30;
    person.birthDate.month = 12;
    person.birthDate.year = 1861;
    
    assert(person.name == "Crisostomo Ibarra" && "Task: Parent struct member incorrect.");
    assert(person.birthDate.day == 30 && "Task: Nested member 'day' incorrect.");
    assert(person.birthDate.month == 12 && "Task: Nested member 'month' incorrect.");
    assert(person.birthDate.year == 1861 && "Task: Nested member 'year' incorrect.");
    
    cout << "Test Task (Nested Structs): PASS" << endl;
}

int main() {
    cout << "Running Lesson 20 Tests..." << endl;
    testNestedStruct();
    cout << "All Lesson 20 tests passed!" << endl;
    return 0;
}
