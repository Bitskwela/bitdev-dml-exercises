#include <iostream>
#include <string>
#include <cassert>

using namespace std;

// --- Task 1: Private Data Members & Public Interface ---
class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    BankAccount(string accNo, double initBalance) : accountNumber(accNo), balance(initBalance) {
        if (balance < 0) balance = 0;
    }

    // TODO: Implement getBalance() as a const getter

    // TODO: Implement deposit() that only accepts positive amounts
    //       and prints: "Deposited P<amount>. New balance: P<balance>"

    // TODO: Implement withdraw() that rejects invalid amounts
    //       and prints the success / failure message
};

// --- Task 2: Student Class with Encapsulation ---
class Student {
private:
    string name;
    int grade;

public:
    Student(string n, int g) : name(n), grade(g) {
        if (grade < 0) grade = 0;
        if (grade > 100) grade = 100;
    }

    // TODO: Implement getGrade() and getName() as const getters

    // TODO: Implement addPoints() that caps grade at 100
};

void run_demo() {
    // Your code here: exercise BankAccount and Student
}

int main() {
    cout << "--- Lesson 25: Encapsulation ---" << endl;
    run_demo();
    cout << "\nAll encapsulation logic validated!" << endl;
    return 0;
}
