#include <iostream>
#include <string>
using namespace std;

// TODO: Define the Resident class (public members).
//   - Data: string name; int age;
//   - Method introduce(): prints "Hi, I'm <name>, <age> years old."
//   - Method haveBirthday(): increments age, then prints "<name> is now <age> years old!"
class Resident {
public:
    string name;
    int age;

    // TODO: void introduce() { ... }

    // TODO: void haveBirthday() { ... }
};

// TODO: Define the Student class (public members).
//   - Data: string name; int grade;
//   - Method introduce(): prints "Student: <name>, Grade: <grade>"
//   - Method study(): adds 5 to grade (cap at 100), then prints
//     "<name> studied hard! Grade is now <grade>"
class Student {
public:
    string name;
    int grade;

    // TODO: void introduce() { ... }

    // TODO: void study() { ... }
};

// TODO: task1_demo(): create a Resident "Juan Dela Cruz" age 30,
//       call introduce() then haveBirthday().
void task1_demo() {
    // TODO: build the Resident object and call its methods here
}

// TODO: task2_demo(): create a Student "Pedro Garcia" grade 80,
//       then call study().
void task2_demo() {
    // TODO: build the Student object and call study() here
}

int main() {
    cout << "--- Lesson 23: Classes (OOP Basics) ---" << endl;

    // TODO: run task1_demo() and task2_demo()

    cout << "\nAll activities completed successfully!" << endl;

    return 0;
}
