#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    // Your code here: Implement a default constructor (set accountNumber="0000", balance=0.0)

    // Your code here: Implement a parameterized constructor (string accNo, double initBalance)

    void display() {
        cout << "Account: " << accountNumber << " | Balance: P" << balance << endl;
    }

    double getBalance() const { return balance; }
};

int main() {
    // Your code here: Create a BankAccount using the default constructor

    // Your code here: Create a BankAccount using the parameterized constructor

    // Your code here: Call display on both accounts

    return 0;
}
