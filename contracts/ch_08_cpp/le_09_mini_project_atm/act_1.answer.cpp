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
        
        // Simulate Menu Choice 2: Deposit
        double depositAmount = 500.0;
        balance += depositAmount;
        if (transactionCount < 5) {
            transactions[transactionCount++] = "Deposit: P" + to_string((int)depositAmount);
        }
        cout << "Deposited: P" << depositAmount << endl;
        
        // Simulate Menu Choice 3: Withdraw
        double withdrawAmount = 200.0;
        if (withdrawAmount <= balance) {
            balance -= withdrawAmount;
            if (transactionCount < 5) {
                transactions[transactionCount++] = "Withdraw: P" + to_string((int)withdrawAmount);
            }
            cout << "Withdrawn: P" << withdrawAmount << endl;
        } else {
            cout << "Insufficient funds!" << endl;
        }
        
        // Show Summary
        cout << "\nFinal Balance: P" << fixed << setprecision(2) << balance << endl;
        cout << "--- Transaction History ---" << endl;
        for (int i = 0; i < transactionCount; i++) {
            cout << (i + 1) << ". " << transactions[i] << endl;
        }
    } else {
        cout << "Authentication failed." << endl;
    }

    return 0;
}
