#include <iostream>
#include <string>
#include <cassert>

using namespace std;

/**
 * LESSON 23: Classes (OOP Basics)
 * 
 * A Class is a "blueprint" for creating objects. Unlike Structs which 
 * primarily group data, Classes group both DATA (attributes) and 
 * BEHAVIOR (methods) together as a single unit.
 * 
 * Kuya Miguel's Tip: Use Classes when you want your data to have 
 * "actions" associated with it. This is the heart of Object-Oriented Programming (OOP).
 */

// --- Task 1: First Class ---
// Creating a Resident class to represent a person in the barangay.
class Resident {
public:
    // Data (Attributes)
    string name;
    int age;

    // Behavior (Methods)
    void introduce() {
        cout << "Hi, I'm " << name << ", " << age << " years old." << endl;
    }

    void haveBirthday() {
        age++;
        cout << name << " is now " << age << " years old!" << endl;
    }
};

// --- Task 2: Student Class Activity ---
// Learners practice creating their own class with specific behaviors.
class Student {
public:
    string name;
    int grade;

    void introduce() {
        cout << "Student: " << name << ", Grade: " << grade << endl;
    }

    void study() {
        grade += 5;
        if (grade > 100) grade = 100; // Cap at 100
        cout << name << " studied hard! Grade is now " << grade << endl;
    }
};

void task1_demo() {
    Resident res;
    res.name = "Juan Dela Cruz";
    res.age = 30;
    res.introduce();
    res.haveBirthday();
    assert(res.age == 31);
}

void task2_demo() {
    Student s;
    s.name = "Pedro Garcia";
    s.grade = 80;
    s.study();
    assert(s.grade == 85);
}

int main() {
    cout << "--- Lesson 23: Classes (OOP Basics) ---" << endl;
    
    task1_demo();
    task2_demo();

    cout << "\nAll activities completed successfully!" << endl;
    
    return 0;
}
