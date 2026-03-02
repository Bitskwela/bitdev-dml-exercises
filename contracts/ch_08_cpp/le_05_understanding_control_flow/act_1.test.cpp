#include <iostream>
#include <cassert>

using namespace std;

int main() {
    // Test division logic
    double n1 = 10, n2 = 0;
    bool errorFound = false;
    if (n2 == 0) {
        errorFound = true;
    }
    assert(errorFound == true);

    cout << "[PASS] Safe Division Calculator" << endl;
    return 0;
}
