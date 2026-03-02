#include <iostream>
#include <cassert>

using namespace std;

void testDynamicAllocation() {
    int size = 5;
    int* ages = new int[size];
    
    assert(ages != nullptr && "Task: Dynamic allocation failed.");
    
    for (int i = 0; i < size; i++) {
        ages[i] = (i + 1) * 10;
    }
    
    assert(ages[0] == 10 && "Task: Value assignment failed at index 0.");
    assert(ages[4] == 50 && "Task: Value assignment failed at index 4.");
    
    delete[] ages;
    cout << "Test Task (Dynamic Memory Allocation): PASS" << endl;
}

int main() {
    cout << "Running Lesson 18 Tests..." << endl;
    testDynamicAllocation();
    cout << "All Lesson 18 tests passed!" << endl;
    return 0;
}

