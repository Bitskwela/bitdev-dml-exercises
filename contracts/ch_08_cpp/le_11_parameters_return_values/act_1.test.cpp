#include <iostream>
#include <cassert>
#include <cmath>

using namespace std;

// Function prototypes
void updateBalance(double& balance, double amount);
double calculateInterest(double balance, double rate);

// Implementations for testing
void updateBalance(double& balance, double amount) {
    balance += amount;
}

double calculateInterest(double balance, double rate) {
    return balance * (rate / 100.0);
}

int main() {
    // Test updateBalance (Pass-by-reference)
    double balance = 1000.0;
    updateBalance(balance, 500.0);
    assert(balance == 1500.0 && "updateBalance failed to update original variable.");

    // Test calculateInterest (Return value)
    double interest = calculateInterest(1000.0, 5.0);
    assert(abs(interest - 50.0) < 0.0001 && "calculateInterest returned incorrect value.");

    cout << "All tests passed!" << endl;
    return 0;
}
