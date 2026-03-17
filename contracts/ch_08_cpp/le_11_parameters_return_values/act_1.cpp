#include <iostream>

using namespace std;

// Task 1: Implement pass-by-reference to modify the original balance
void updateBalance(double& balance, double amount) {
    // Your code here: add amount to balance
}

// Task 2: Implement a function that calculates and returns interest
double calculateInterest(double balance, double rate) {
    // Your code here: return balance * (rate / 100.0)
    return 0;
}

int main() {
    double myBalance = 1000.0;

    // Call updateBalance with myBalance and 500.0
    updateBalance(myBalance, 500.0);
    double interest = calculateInterest(myBalance, 5.0);

    cout << "Final Balance: " << myBalance << endl;
    cout << "Interest: " << interest << endl;

    return 0;
}
