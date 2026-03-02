#include <iostream>
using namespace std;

void updateFund(int* fundPtr, int amount) {
    if (fundPtr != nullptr) {
        *fundPtr += amount;
    }
}

int main() {
    int barangayFund = 5000;
    
    // Create a pointer to barangayFund
    int* ptr = &barangayFund;
    
    // Update the fund via pointer
    updateFund(ptr, 2000);
    
    cout << "Final Fund value: " << barangayFund << endl;
    
    return 0;
}

