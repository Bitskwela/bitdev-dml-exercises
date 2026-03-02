#include <iostream>

using namespace std;

/**
 * Task: Parameters and Return Values
 * Implement updateBalance using pass-by-reference and calculateInterest with a return value.
 */

void updateBalance(double& balance, double amount) {
    balance += amount;
}

double calculateInterest(double balance, double rate) {
    return balance * (rate / 100.0);
}

int main() {
    double myBalance = 1000.0;
    
    updateBalance(myBalance, 500.0);
    double interest = calculateInterest(myBalance, 5.0);
    
    cout << "Final Balance: " << myBalance << endl;
    cout << "Interest: " << interest << endl;

    return 0;
}
