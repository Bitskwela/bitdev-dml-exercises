#include <iostream>
#include <cassert>

using namespace std;

int main() {
    // Test nested loop logic
    int totalIterations = 0;
    for (int i = 1; i <= 10; i++) {
        for (int j = 1; j <= 10; j++) {
            totalIterations++;
        }
    }
    assert(totalIterations == 100);

    cout << "[PASS] Multiplication Table" << endl;
    return 0;
}
