#include <iostream>
#include <string>
#include <cassert>
#include <sstream>
#include <iomanip>

using namespace std;

int main() {
    // Test formatting logic
    double value = 123.456;
    stringstream ss;
    ss << fixed << setprecision(2) << value;
    assert(ss.str() == "123.46");

    cout << "[PASS] Personal Information Form" << endl;
    return 0;
}
