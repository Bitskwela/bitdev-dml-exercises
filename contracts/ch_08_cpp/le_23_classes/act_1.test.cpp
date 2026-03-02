#include <iostream>
#include <cassert>
#include <string>

// Redefining for testing
class Resident {
public:
    std::string name;
    int age;
    void haveBirthday() { age++; }
};

class Student {
public:
    std::string name;
    int grade;
    void study() { grade += 5; if(grade > 100) grade = 100; }
};

int main() {
    // Resident Test
    Resident r;
    r.age = 20;
    r.haveBirthday();
    assert(r.age == 21);

    // Student Test
    Student s;
    s.grade = 98;
    s.study();
    assert(s.grade == 100);

    std::cout << "Lesson 23 Tests Passed!" << std::endl;
    return 0;
}
