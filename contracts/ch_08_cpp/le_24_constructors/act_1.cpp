#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    // TODO: Default constructor BankAccount()
    //   - set accountNumber = "0000", balance = 0.0
    //   - print: "[Default Constructor] Account created with default values."

    // TODO: Parameterized constructor BankAccount(string accNo, double initBalance)
    //   - set accountNumber = accNo, balance = initBalance
    //   - print: "[Parameterized Constructor] Account <accountNumber> created with balance P<balance>"

    // TODO: Destructor ~BankAccount()
    //   - print: "[Destructor] Account <accountNumber> is being destroyed. Cleaning up..."

    void display() {
        cout << "Account: " << accountNumber << " | Balance: P" << balance << endl;
    }

    double getBalance() const { return balance; }
};

// TODO: task1_demo(): create a BankAccount with the DEFAULT constructor,
//       then call display() on it.
void task1_demo() {
    // TODO: build the default account and display it here
}

// TODO: task2_demo(): create a BankAccount "ACC-123" with balance 5000.0
//       using the PARAMETERIZED constructor, then call display() on it.
void task2_demo() {
    // TODO: build the parameterized account and display it here
}

int main() {
    cout << "--- Lesson 24: Constructors & Destructors ---" << endl;

    // TODO: Task 1 scope block.
    //   Print "\nStarting Task 1 scope...", run task1_demo(),
    //   then print "Task 1 scope ending..." INSIDE a { } block so the
    //   destructor fires before the block closes.
    {
        // TODO: Task 1 scope body
    }

    // TODO: Task 2 scope block (same pattern, "Task 2").
    {
        // TODO: Task 2 scope body
    }

    cout << "\nAll activities completed successfully!" << endl;

    return 0;
}
