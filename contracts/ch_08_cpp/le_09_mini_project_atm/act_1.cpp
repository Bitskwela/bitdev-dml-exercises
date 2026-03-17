#include <iostream>
#include <iomanip>
#include <string>

using namespace std;

int main() {
    // Account data
    int correctPIN = 1234;
    double balance = 5000.00;
    string transactions[5];
    int transactionCount = 0;

    // Simulate Authentication
    int enteredPIN = 1234;
    bool authenticated = (enteredPIN == correctPIN);

    if (authenticated) {
        cout << "✓ Authentication successful!" << endl;

        // TODO: Simulate a deposit of 500.0
        // - Add depositAmount to balance
        // - Store "Deposit: P500" in transactions array
        // - Print the deposited amount

        // TODO: Simulate a withdrawal of 200.0
        // - Check if withdrawAmount <= balance
        // - If yes, subtract from balance and store in transactions
        // - If no, print "Insufficient funds!"

        // TODO: Print final balance with 2 decimal places
        // Hint: use fixed << setprecision(2)

        // TODO: Print transaction history using a for loop

    } else {
        cout << "Authentication failed." << endl;
    }

    return 0;
}
