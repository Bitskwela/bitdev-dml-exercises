#include <iostream>

using namespace std;

/**
 * Task: Array Processing
 * Declare an array, calculate the sum and average using a loop.
 */

int main() {
    int expenses[5] = {1000, 2000, 1500, 3000, 2500};
    int total = 0;
    int size = 5;

    for (int i = 0; i < size; i++) {
        total += expenses[i];
    }

    double average = (double)total / size;

    cout << "Total Expenses: " << total << endl;
    cout << "Average Expense: " << average << endl;

    return 0;
}
