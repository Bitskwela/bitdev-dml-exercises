#include <iostream>
using namespace std;

void addTenPtr(int* ptr) {
    if (ptr != nullptr) {
        *ptr += 10;
    }
}

void addTenRef(int& ref) {
    ref += 10;
}

int main() {
    int value1 = 100;
    int value2 = 100;

    // Call addTenPtr with address
    addTenPtr(&value1);
    
    // Call addTenRef with reference
    addTenRef(value2);

    cout << "Value 1: " << value1 << endl;
    cout << "Value 2: " << value2 << endl;

    return 0;
}

