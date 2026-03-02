#include <iostream>
#include <string>
#include <cassert>

using namespace std;

/**
 * LESSON 26: Inheritance
 * 
 * Inheritance allows a class (Derived Class) to inherit attributes and methods 
 * from another class (Base Class). This promotes code reuse and models 
 * "is-a" relationships (e.g., a Car IS-A Vehicle).
 * 
 * Kuya Miguel's Tip: Use inheritance to avoid repeating yourself (DRY). 
 * Put common logic in the Base class and specialized logic in the Derived classes.
 */

// --- Task 1: Basic Inheritance ---
// Base class for all people in the barangay
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

// Derived class: Resident IS-A Person
class Resident : public Person {
private:
    string barangay;

public:
    Resident(string n, int a, string brgy) : Person(n, a), barangay(brgy) {}

    void showBarangay() {
        cout << "[Resident] " << name << " lives in " << barangay << endl;
    }
};

// --- Task 2: Vehicle & Car Activity ---
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

class Car : public Vehicle {
private:
    int doors;

public:
    Car(string b, int y, int d) : Vehicle(b, y), doors(d) {}

    void showDoors() {
        cout << "[Car] This " << brand << " has " << doors << " doors." << endl;
    }

    int getDoors() { return doors; }
};

void run_demo() {
    Resident r("Juan", 30, "San Antonio");
    r.display();      // Shared method
    r.showBarangay(); // Specialized method

    Car myCar("Toyota", 2022, 4);
    myCar.display();   // Shared method
    myCar.showDoors(); // Specialized method
    
    assert(myCar.getBrand() == "Toyota");
    assert(myCar.getDoors() == 4);
}

int main() {
    cout << "--- Lesson 26: Inheritance ---" << endl;
    run_demo();
    cout << "\nInheritance demo completed successfully!" << endl;
    return 0;
}
