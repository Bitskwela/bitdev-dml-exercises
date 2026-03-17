# Mini Project: ATM Simulator

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+9.0+-+COVER.png)

## Scene

Tian had been learning C++ concepts for weeks -- variables, operators, conditions, loops. Each lesson made sense individually, but he felt overwhelmed. "Kuya, I understand each piece, but how do they all fit together in a real program?"

Kuya Miguel smiled. "You're experiencing what every developer faces: tutorial hell. Today, we're building an **ATM Simulator** from scratch. An ATM needs secure login with limited attempts, balance validation for withdrawals, and a menu system that keeps running until the user exits. Every concept you've learned will connect here."

"This is your first real test," Kuya Miguel said. "Can you take what you know and build something that works? Welcome to project-based learning!"

## C++ Topics: Combining Control Structures

![9.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+9.1.png)

### PIN Authentication with Loops

> Use a `while` loop with a compound condition (`attempts < 3 && !authenticated`) to give users limited login attempts before blocking the card.

### Menu System with Boolean Flags

> A `while (!exitATM)` loop keeps the ATM running until the user chooses to exit. Combined with `if-else` chains, each menu option triggers a different action.

### Input Validation

> Use `if-else if-else` chains to check that deposit and withdrawal amounts are positive, within limits, and backed by sufficient balance.

### Transaction History with Arrays

> Store transaction descriptions in a `string` array and use a counter to track how many entries exist. A `for` loop displays the history on demand.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    int correctPIN = 1234;
    double balance = 5000.00;
    string transactions[5];
    int transactionCount = 0;

    // PIN authentication (3 attempts max)
    int enteredPIN, attempts = 0;
    bool authenticated = false;

    while (attempts < 3 && !authenticated) {
        cout << "Enter PIN: ";
        cin >> enteredPIN;
        if (enteredPIN == correctPIN) authenticated = true;
        else { attempts++; cout << "Wrong PIN.\n"; }
    }

    // Menu loop with boolean flag
    bool exitATM = false;
    int choice;
    while (!exitATM) {
        cout << "1.Balance 2.Deposit 3.Withdraw 4.History 5.Exit\n";
        cin >> choice;
        if (choice == 5) exitATM = true;
    }
    return 0;
}
```

This skeleton shows how a `while` loop with `&&` handles authentication, a boolean flag controls the menu loop, and `if-else` chains route each menu choice to the right action.
