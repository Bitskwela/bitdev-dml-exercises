#include <iostream>
#include <string>
#include <vector>
#include <cassert>

using namespace std;

/**
 * LESSON 27: Polymorphism
 * 
 * Polymorphism means "many forms". In C++, it allows the same function call 
 * to behave differently depending on the actual type of the object 
 * pointed to at RUNTIME. This is achieved using 'virtual' functions.
 * 
 * Kuya Miguel's Tip: Polymorphism allows you to treat a collection of different 
 * objects (e.g., Residents and Officials) as a uniform collection of their Base 
 * class (Persons), yet still have each object perform its specific behavior.
 */

// --- Task 1: Virtual Functions ---
class Person {
protected:
    string name;

public:
    Person(string n) : name(n) {}

    // 'virtual' tells the compiler to look for overrides in derived classes at runtime
    virtual string introduce() {
        return "I'm " + name + ", a person.";
    }

    // Always include a virtual destructor in a base class using polymorphism
    virtual ~Person() {}
};

class Resident : public Person {
public:
    Resident(string n) : Person(n) {}

    // 'override' keyword ensures we are actually overriding a base virtual function
    string introduce() override {
        return "I'm " + name + ", a resident.";
    }
};

class Official : public Person {
public:
    Official(string n) : Person(n) {}

    string introduce() override {
        return "I'm " + name + ", an official.";
    }
};

void run_demo() {
    // Array of base class pointers
    vector<Person*> barangayRegistry;
    
    barangayRegistry.push_back(new Resident("Juan"));
    barangayRegistry.push_back(new Official("Maria"));
    barangayRegistry.push_back(new Person("Stranger"));

    cout << "--- Polymorphism in Action ---" << endl;
    for (Person* p : barangayRegistry) {
        cout << p->introduce() << endl;
    }

    // Validation for student answer logic
    assert(barangayRegistry[0]->introduce() == "I'm Juan, a resident.");
    assert(barangayRegistry[1]->introduce() == "I'm Maria, an official.");
    assert(barangayRegistry[2]->introduce() == "I'm Stranger, a person.");

    // Clean up memory
    for (Person* p : barangayRegistry) {
        delete p;
    }
    barangayRegistry.clear();
}

int main() {
    cout << "--- Lesson 27: Polymorphism ---" << endl;
    run_demo();
    cout << "\nPolymorphism logic validated!" << endl;
    return 0;
}
