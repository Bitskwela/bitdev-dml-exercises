#include <iostream>
#include <string>
#include <cassert>

using namespace std;

/**
 * LESSON 24: Constructors and Destructors
 * 
 * A Constructor is a special member function that is automatically called 
 * when an object is created. It's used to initialize the object's data members.
 * 
 * A Destructor is called when an object is destroyed. It's used for cleanup.
 * 
 * Kuya Miguel's Tip: Always use constructors to ensure your objects 
 * start in a "valid state". Never let an object have uninitialized garbage data.
 */

// --- Task 1: Default Constructor ---
// A constructor with no parameters that sets default values.
class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    // Default Constructor
    BankAccount() {
        accountNumber = "0000";
        balance = 0.0;
        cout << "[Default Constructor] Account created with default values." << endl;
    }

    // Parameterized Constructor (Task 2 style)
    BankAccount(string accNo, double initBalance) {
        accountNumber = accNo;
        balance = initBalance;
        cout << "[Parameterized Constructor] Account " << accountNumber << " created with balance P" << balance << endl;
    }

    // Destructor
    ~BankAccount() {
        cout << "[Destructor] Account " << accountNumber << " is being destroyed. Cleaning up..." << endl;
    }

    void display() {
        cout << "Account: " << accountNumber << " | Balance: P" << balance << endl;
    }

    double getBalance() const { return balance; }
};

void task1_demo() {
    BankAccount defaultAcc;
    defaultAcc.display();
    assert(defaultAcc.getBalance() == 0.0);
}

void task2_demo() {
    BankAccount myAcc("ACC-123", 5000.0);
    myAcc.display();
    assert(myAcc.getBalance() == 5000.0);
}

int main() {
    cout << "--- Lesson 24: Constructors & Destructors ---" << endl;
    
    {
        cout << "\nStarting Task 1 scope..." << endl;
        task1_demo();
        cout << "Task 1 scope ending..." << endl;
    } // Constructor and Destructor will be visible in output here

    {
        cout << "\nStarting Task 2 scope..." << endl;
        task2_demo();
        cout << "Task 2 scope ending..." << endl;
    }

    cout << "\nAll activities completed successfully!" << endl;
    
    return 0;
}
