#include <iostream>
#include <vector>
#include <string>
#include <memory>
#include <cassert>
#include <stdexcept>

class Person {
public:
    virtual std::string type() { return "Person"; }
    virtual ~Person() {}
};

class Resident : public Person {
public:
    std::string type() override { return "Resident"; }
};

int main() {
    // Test OOP Integration
    std::unique_ptr<Person> p = std::make_unique<Resident>();
    assert(p->type() == "Resident");

    // Test STL Integration
    std::vector<int> ids = {1, 2, 3};
    assert(ids.size() == 3);

    // Test Exception Integration
    bool caught = false;
    try {
        throw std::runtime_error("Final Test");
    } catch (...) {
        caught = true;
    }
    assert(caught == true);

    std::cout << "Lesson 31 Final Integration Tests Passed!" << std::endl;
    return 0;
}
