#include <iostream>
#include <cassert>

using namespace std;

// Function prototypes
void addTenPtr(int* ptr);
void addTenRef(int& ref);

// Function definitions for testing
void addTenPtr(int* ptr) {
    if (ptr != nullptr) {
        *ptr += 10;
    }
}

void addTenRef(int& ref) {
    ref += 10;
}

void testPtrAndRef() {
    int v1 = 100;
    int v2 = 100;
    
    addTenPtr(&v1);
    addTenRef(v2);
    
    assert(v1 == 110 && "Task: Pointer function failed.");
    assert(v2 == 110 && "Task: Reference function failed.");
    
    cout << "Test Task (Ptr vs Ref Comparison): PASS" << endl;
}

int main() {
    cout << "Running Lesson 17 Tests..." << endl;
    testPtrAndRef();
    cout << "All Lesson 17 tests passed!" << endl;
    return 0;
}

