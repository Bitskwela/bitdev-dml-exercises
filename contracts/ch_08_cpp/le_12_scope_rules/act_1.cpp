#include <iostream>

using namespace std;

// 1. Declare a global variable 'total'
int total = 0;

void addToTotal(int amount) {
    // 2. Add amount to the global 'total'
    // Your code here
}

void shadowTest() {
    // 3. Declare a local variable named 'total' and initialize it to 100
    // 4. Print the local 'total' and the global 'total' (using ::)
    // Your code here
}

int main() {
    addToTotal(50);
    shadowTest();

    cout << "Final Global Total: " << total << endl;

    return 0;
}
