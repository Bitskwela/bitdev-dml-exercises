#include <iostream>
#include <string>
#include <cassert>

using namespace std;

// --- Task 1: Basic Inheritance (Person -> Resident) ---
class Person {
protected:
    string name;
    int age;

public:
    Person(string n, int a) : name(n), age(a) {}

    void display() {
        cout << "[Person] Name: " << name << ", Age: " << age << endl;
    }
};

// TODO: Create a Resident class that inherits from Person
// - Add a private member 'string barangay'
// - Constructor takes name, age, barangay and chains to Person
// - Add showBarangay() that prints: "[Resident] <name> lives in <barangay>"

// --- Task 2: Vehicle & Car ---
class Vehicle {
protected:
    string brand;
    int year;

public:
    Vehicle(string b, int y) : brand(b), year(y) {}

    void display() {
        cout << "[Vehicle] Brand: " << brand << ", Year: " << year << endl;
    }

    string getBrand() { return brand; }
};

// TODO: Create a Car class that inherits from Vehicle
// - Add a private member 'int doors'
// - Constructor takes brand, year, doors and chains to Vehicle
// - Add showDoors() that prints: "[Car] This <brand> has <doors> doors."
// - Add getDoors() method

void run_demo() {
    // Your code here: create a Resident and a Car, then call
    // inherited + specialized methods to produce the expected output
}

int main() {
    cout << "--- Lesson 26: Inheritance ---" << endl;
    run_demo();
    cout << "\nInheritance demo completed successfully!" << endl;
    return 0;
}
