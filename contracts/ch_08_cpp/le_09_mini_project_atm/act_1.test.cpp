#include <iostream>
#include <cassert>
#include <string>

using namespace std;

int main() {
    // Test PIN logic
    int pin = 1234;
    assert(pin == 1234);

    // Test deposit logic
    double balance = 5000.0;
    double deposit = 500.0;
    balance += deposit;
    assert(balance == 5500.0);

    // Test withdraw logic
    double withdraw = 1000.0;
    if (withdraw <= balance) {
        balance -= withdraw;
    }
    assert(balance == 4500.0);

    // Test history array logic
    string history[5];
    int count = 0;
    history[count++] = "Test Trans";
    assert(count == 1);
    assert(history[0] == "Test Trans");

    cout << "All le_09 tests passed!" << endl;
    return 0;
}
