#include <iostream>
#include <cassert>
#include <string>

class Base {
public:
    virtual std::string msg() { return "Base"; }
    virtual ~Base() {}
};

class Derived : public Base {
public:
    std::string msg() override { return "Derived"; }
};

int main() {
    Base* b = new Derived();
    // Test that the override is called, not the base method
    assert(b->msg() == "Derived");
    
    delete b;
    std::cout << "Lesson 27 Tests Passed!" << std::endl;
    return 0;
}
