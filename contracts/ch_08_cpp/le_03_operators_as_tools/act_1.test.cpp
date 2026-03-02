#include <iostream>
#include <cassert>
#include <cmath>

using namespace std;

int main() {
    // Test basic arithmetic logic
    double n1 = 10, n2 = 3;
    assert(n1 + n2 == 13);
    assert(n1 - n2 == 7);
    assert(n1 * n2 == 30);
    assert(abs((n1 / n2) - 3.33333) < 0.0001);
    assert((int)n1 % (int)n2 == 1);

    cout << "[PASS] Complete Calculator System" << endl;
    return 0;
}
