#include <iostream>
#include <cassert>
#include <string>

class Vehicle {
protected:
    std::string brand;
public:
    Vehicle(std::string b) : brand(b) {}
    std::string getBrand() { return brand; }
};

class Car : public Vehicle {
public:
    Car(std::string b) : Vehicle(b) {}
};

int main() {
    Car c("Honda");
    // Test inheritance of method
    assert(c.getBrand() == "Honda");
    
    std::cout << "Lesson 26 Tests Passed!" << std::endl;
    return 0;
}
