#include <iostream>
#include <cassert>
#include <string>

template <typename T>
T getMin(T a, T b) { return (a < b) ? a : b; }

int main() {
    // Int check
    assert(getMin(5, 10) == 5);
    // Double check
    assert(getMin(1.5, 0.5) == 0.5);
    // String check
    assert(getMin(std::string("A"), std::string("B")) == "A");
    
    std::cout << "Lesson 28 Tests Passed!" << std::endl;
    return 0;
}
