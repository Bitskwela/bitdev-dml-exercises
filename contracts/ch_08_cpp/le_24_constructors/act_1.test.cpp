#include <iostream>
#include <cassert>
#include <string>

class BankAccount {
public:
    std::string accountNumber;
    double balance;

    BankAccount() {
        accountNumber = "0000";
        balance = 0.0;
    }

    BankAccount(std::string acc, double bal) {
        accountNumber = acc;
        balance = bal;
    }
};

int main() {
    // Default Constructor Test
    BankAccount b1;
    assert(b1.accountNumber == "0000");
    assert(b1.balance == 0.0);

    // Parameterized Constructor Test
    BankAccount b2("TEST-001", 100.5);
    assert(b2.accountNumber == "TEST-001");
    assert(b2.balance == 100.5);

    std::cout << "Lesson 24 Tests Passed!" << std::endl;
    return 0;
}
