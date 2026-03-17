#include <iostream>
#include <vector>
#include <string>
#include <memory>
#include <cassert>
#include <stdexcept>

using namespace std;

class Person {
public:
    virtual string type() { return "Person"; }
    virtual ~Person() {}
};

// TODO: Create a Resident class that inherits from Person
// and overrides type() to return "Resident"

int main() {
    // TODO: Test OOP - create a Resident through a Person unique_ptr
    //       and verify polymorphism works

    // TODO: Test STL - create a vector of ints and verify size

    // TODO: Test Exceptions - throw and catch a runtime_error

    return 0;
}
