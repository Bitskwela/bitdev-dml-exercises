#include <iostream>
using namespace std;

int main() {
    int size;
    cout << "Enter the number of residents: ";
    cin >> size;

    // Allocate an integer array on the heap
    int* ages = new int[size];
    
    // Fill the array
    for (int i = 0; i < size; i++) {
        ages[i] = (i + 1) * 10;
    }
    
    // Print the values
    cout << "Ages stored on heap: ";
    for (int i = 0; i < size; i++) {
        cout << ages[i] << " ";
    }
    cout << endl;
    
    // Deallocate memory - CRITICAL
    delete[] ages;
    ages = nullptr;

    return 0;
}

