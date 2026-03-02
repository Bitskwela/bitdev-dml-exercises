#include <iostream>
#include <string>
#include <cassert>

using namespace std;

/**
 * LESSON 25: Encapsulation
 * 
 * Encapsulation is the practice of bundling data and methods inside a class 
 * and RESTRICTING direct access to the data. We use access specifiers 
 * like 'private' to protect fields and 'public' for the interface.
 * 
 * Kuya Miguel's Tip: Think of your class as a black box. The user doesn't 
 * need to know HOW it works inside, only WHAT they can do with it through 
 * public methods. This prevents accidental data corruption.
 */

// --- Task 1: Private Data Members & Public Interface ---
class BankAccount {
private:
    string accountNumber;
    double balance; // Private: Cannot be accessed as account.balance = 1000000;

public:
    BankAccount(string accNo, double initBalance) : accountNumber(accNo), balance(initBalance) {
        if (balance < 0) balance = 0; // Basic validation in constructor
    }

    // Public "Getter" (Accessor)
    double getBalance() const {
        return balance;
    }

    // Public "Setter" with Validation (Mutator)
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "Deposited P" << amount << ". New balance: P" << balance << endl;
        } else {
            cout << "Invalid deposit amount!" << endl;
        }
    }

    bool withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Withdrew P" << amount << ". Remaining: P" << balance << endl;
            return true;
        }
        cout << "Withdrawal failed: Invalid amount or Insufficient funds!" << endl;
        return false;
    }
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

    int getGrade() const { return grade; }
    string getName() const { return name; }

    void addPoints(int points) {
        if (points > 0) {
            grade += points;
            if (grade > 100) grade = 100;
        }
    }
};

void run_demo() {
    BankAccount myAcc("ACC-987", 1000.0);
    
    // Test Encapsulation
    myAcc.deposit(500);
    assert(myAcc.getBalance() == 1500.0);
    
    bool result = myAcc.withdraw(2000);
    assert(result == false);
    assert(myAcc.getBalance() == 1500.0);

    Student s("Maria", 85);
    s.addPoints(10);
    assert(s.getGrade() == 95);
    s.addPoints(10);
    assert(s.getGrade() == 100); // Verify cap logic
}

int main() {
    cout << "--- Lesson 25: Encapsulation ---" << endl;
    run_demo();
    cout << "\nAll encapsulation logic validated!" << endl;
    return 0;
}
