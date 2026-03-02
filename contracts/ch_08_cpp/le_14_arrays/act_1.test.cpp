#include <iostream>
#include <cassert>
#include <cmath>

using namespace std;

int main() {
    int expenses[5] = {1000, 2000, 1500, 3000, 2500};
    int total = 0;
    int size = 5;

    for (int i = 0; i < size; i++) {
        total += expenses[i];
    }

    double average = (double)total / size;

    // Test total calculation
    assert(total == 10000 && "Total calculation failed.");

    // Test average calculation
    assert(abs(average - 2000.0) < 0.0001 && "Average calculation failed.");

    cout << "All tests passed!" << endl;
    return 0;
}
