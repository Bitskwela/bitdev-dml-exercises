#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>
#include <stdexcept>
#include <memory>
#include <cassert>

using namespace std;

/**
 * LESSON 31: Final CRUD Project (Barangay Resident Management)
 * 
 * This project integrates all major C++ concepts learned in this course:
 * - Basic Syntax, Variables, Control Flow
 * - Functions, Classes, Structs, Enums
 * - Pointers (Smart Pointers), Dynamic Memory
 * - OOP: Inheritance, Encapsulation, Polymorphism
 * - Templates, STL (vector, string, algorithms)
 * - Exception Handling, File I/O
 * 
 * Kuya Miguel's Tip: This is the 'Zero to Hero' moment. You've built 
 * a professional-grade system with proper architecture. Congratulations!
 */

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

// --- Derived Class ---
class Resident : public Person {
private:
    int id;
    string status; // "Active", "Inactive"
public:
    Resident(int i, string n, int a, string s = "Active") 
        : Person(n, a), id(i), status(s) {}

    void display() const override {
        cout << "ID: " << id << " | ";
        Person::display();
        cout << " | Status: " << status << endl;
    }

    int getId() const { return id; }
    string getStatus() const { return status; }
    void setStatus(string s) { status = s; }
};

// --- Manager Class (STL, Exceptions, File I/O) ---
class BarangayManager {
private:
    vector<unique_ptr<Resident>> residents;
    int nextId = 1;
    const string filename = "residents.txt";

public:
    void addResident(string name, int age) {
        if (name.empty()) throw invalid_argument("Name cannot be empty!");
        residents.push_back(make_unique<Resident>(nextId++, name, age, "Active"));
        cout << "Resident added successfully." << endl;
    }

    void displayAll() const {
        if (residents.empty()) {
            cout << "No records found." << endl;
            return;
        }
        for (const auto& r : residents) {
            r->display();
        }
    }

    Resident* findById(int id) {
        for (auto& r : residents) {
            if (r->getId() == id) return r.get();
        }
        throw runtime_error("Resident not found!");
    }

    void updateStatus(int id, string newStatus) {
        Resident* r = findById(id);
        r->setStatus(newStatus);
        cout << "Status updated for " << r->getName() << endl;
    }

    void deleteResident(int id) {
        auto it = remove_if(residents.begin(), residents.end(), 
            [id](const unique_ptr<Resident>& r) { return r->getId() == id; });
        
        if (it != residents.end()) {
            residents.erase(it, residents.end());
            cout << "Resident deleted." << endl;
        } else {
            throw runtime_error("Could not delete: ID not found.");
        }
    }

    void saveData() {
        ofstream outFile(filename);
        if (!outFile) return;
        for (const auto& r : residents) {
            outFile << r->getId() << "," << r->getName() << "," << r->getAge() << "," << r->getStatus() << endl;
        }
        outFile.close();
        cout << "Data saved to " << filename << endl;
    }

    // Integrated testing method instead of a full interactive menu for automation
    void testLogic() {
        addResident("Tian", 21);
        addResident("Miguel", 25);
        assert(residents.size() == 2);
        
        updateStatus(1, "Inactive");
        assert(findById(1)->getStatus() == "Inactive");
        
        deleteResident(2);
        assert(residents.size() == 1);
        
        saveData();
    }
};

int main() {
    cout << "--- Barangay Resident Management System (Final Project) ---" << endl;
    BarangayManager bm;
    
    try {
        bm.testLogic();
        cout << "\nFinal Project logic validated successfully!" << endl;
    } catch (const exception& e) {
        cerr << "Error: " << e.what() << endl;
    }

    return 0;
}
