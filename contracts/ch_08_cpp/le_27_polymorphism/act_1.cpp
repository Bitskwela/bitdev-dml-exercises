#include <iostream>
#include <string>
#include <vector>
#include <cassert>

using namespace std;

// --- Task 1: Virtual Functions ---
class Person {
protected:
    string name;

public:
    Person(string n) : name(n) {}

    // TODO: Declare a virtual method introduce() that returns
    //       "I'm <name>, a person."

    // TODO: Add a virtual destructor
};

// TODO: Create a Resident class that overrides introduce()
//       to return "I'm <name>, a resident."

// TODO: Create an Official class that overrides introduce()
//       to return "I'm <name>, an official."

void run_demo() {
    // Your code here: store Resident, Official, and Person objects in a
    // vector<Person*>, print each introduce() under a
    // "--- Polymorphism in Action ---" header, then clean up the memory
}

int main() {
    cout << "--- Lesson 27: Polymorphism ---" << endl;
    run_demo();
    cout << "\nPolymorphism logic validated!" << endl;
    return 0;
}
