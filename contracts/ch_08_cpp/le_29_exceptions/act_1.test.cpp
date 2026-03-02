#include <iostream>
#include <cassert>
#include <string>
#include <stdexcept>

int main() {
    // Test basic catch
    bool caught = false;
    try {
        throw std::runtime_error("Test");
    } catch (const std::runtime_error& e) {
        caught = true;
    }
    assert(caught == true);

    // Test multiple types
    int typeCaught = 0; // 1 for string, 2 for int
    try {
        throw 404;
    } catch (const std::string& s) {
        typeCaught = 1;
    } catch (int i) {
        typeCaught = 2;
    }
    assert(typeCaught == 2);

    std::cout << "Lesson 29 Tests Passed!" << std::endl;
    return 0;
}
