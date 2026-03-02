#include <iostream>
#include <cassert>

using namespace std;

// Prototype for lesson 16 functions
void updateFund(int* fundPtr, int amount);

// Function definitions for testing
void updateFund(int* fundPtr, int amount) {
    if (fundPtr != nullptr) {
        *fundPtr += amount;
    }
}

void testUpdateFund() {
    int barangayFund = 5000;
    updateFund(&barangayFund, 2000);
    assert(barangayFund == 7000 && "Task: Failed to modify original via pass-by-pointer.");
    
    // Testing nullptr safety
    updateFund(nullptr, 500); // Should not crash
    cout << "Test Task (Update Fund via Pointers): PASS" << endl;
}

int main() {
    cout << "Running Lesson 16 Tests..." << endl;
    testUpdateFund();
    cout << "All Lesson 16 tests passed!" << endl;
    return 0;
}

