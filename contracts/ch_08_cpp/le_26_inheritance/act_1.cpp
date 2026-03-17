#include <iostream>
#include <string>
#include <cassert>

using namespace std;

class Vehicle {
protected:
    string brand;
public:
    Vehicle(string b) : brand(b) {}
    string getBrand() { return brand; }
};

// TODO: Create a Car class that inherits from Vehicle
// - Add a private member 'int doors'
// - Constructor takes brand and doors, chains to Vehicle
// - Add getDoors() method

int main() {
    // Your code here: create a Car and test inherited + own methods

    return 0;
}
