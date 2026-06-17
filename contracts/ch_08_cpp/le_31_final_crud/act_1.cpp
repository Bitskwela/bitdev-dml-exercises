#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <stdexcept>
#include <memory>
#include <cassert>

using namespace std;

// --- Base Class (Inheritance & Polymorphism) ---
class Person {
protected:
    string name;
    int age;
public:
    Person(string n = "", int a = 0) : name(n), age(a) {}
    virtual ~Person() {}

    virtual void display() const {
        cout << "Name: " << name << " | Age: " << age;
    }

    string getName() const { return name; }
    int getAge() const { return age; }
};

// TODO: Create a Resident class that inherits from Person with:
//       - private int id and string status (default "Active")
//       - constructor Resident(int i, string n, int a, string s = "Active")
//       - display() override printing "ID: <id> | Name: <name> | Age: <age> | Status: <status>"
//       - getId(), getStatus(), setStatus()

// --- Manager Class (STL, Exceptions, File I/O) ---
// TODO: Create a BarangayManager that holds vector<unique_ptr<Resident>> and:
//       - addResident(name, age): throws invalid_argument if name empty,
//         else adds and prints "Resident added successfully."
//       - findById(id): returns the Resident* or throws runtime_error("Resident not found!")
//       - updateStatus(id, newStatus): updates and prints "Status updated for <name>"
//       - deleteResident(id): erases the match (remove_if) and prints "Resident deleted."
//         or throws runtime_error if not found
//       - saveData(): writes each resident to "residents.txt" and prints
//         "Data saved to residents.txt"
//       - testLogic(): adds two residents, updates status of #1, deletes #2, saves

int main() {
    cout << "--- Barangay Resident Management System (Final Project) ---" << endl;
    // Your code here: construct a BarangayManager, run testLogic() inside a
    // try block, and on success print "Final Project logic validated successfully!"

    return 0;
}
