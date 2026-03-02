#include <iostream>
#include <cassert>
#include <string>

class BankAccount {
private:
    double balance;
public:
    BankAccount(double b) : balance(b) {}
    double getBalance() const { return balance; }
    void deposit(double a) { if(a > 0) balance += a; }
};

class Student {
private:
    int grade;
public:
    Student(int g) : grade(g) {}
    int getGrade() const { return grade; }
    void addPoints(int p) { grade += p; if(grade > 100) grade = 100; }
};

int main() {
    // BankAccount Encapsulation Test
    BankAccount b(100);
    b.deposit(50);
    assert(b.getBalance() == 150);
    b.deposit(-50);
    assert(b.getBalance() == 150);

    // Student Encapsulation Test
    Student s(90);
    s.addPoints(5);
    assert(s.getGrade() == 95);
    s.addPoints(10);
    assert(s.getGrade() == 100);

    std::cout << "Lesson 25 Tests Passed!" << std::endl;
    return 0;
}
