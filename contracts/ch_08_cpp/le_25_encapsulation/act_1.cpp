#include <iostream>
#include <string>
#include <cassert>

using namespace std;

class BankAccount {
private:
    double balance;
public:
    BankAccount(double b) : balance(b) {}

    // TODO: Implement getBalance() as a const method

    // TODO: Implement deposit() that only accepts positive amounts

};

class Student {
private:
    int grade;
public:
    Student(int g) : grade(g) {}

    // TODO: Implement getGrade() as a const method

    // TODO: Implement addPoints() that caps grade at 100

};

int main() {
    // Your code here: test BankAccount and Student

    return 0;
}
