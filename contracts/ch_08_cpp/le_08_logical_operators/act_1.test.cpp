#include <iostream>
#include <cassert>

using namespace std;

int main() {
    // Test AND operator
    int age = 18;
    bool registered = true;
    assert((age >= 18 && registered) == true);
    assert((age < 18 && registered) == false);

    // Test OR operator
    int residentAge = 65;
    bool pwd = false;
    assert((residentAge >= 60 || pwd) == true);
    assert((50 >= 60 || false) == false);

    // Test NOT operator
    bool paid = false;
    assert(!paid == true);

    cout << "All le_08 tests passed!" << endl;
    return 0;
}
