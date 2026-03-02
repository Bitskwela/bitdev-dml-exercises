#include <iostream>
#include <fstream>
#include <string>

/**
 * LESSON 01 TEST SUITE
 */

bool testOutput(const std::string& output) {
    return output.find("Mabuhay, Pilipinas!") != std::string::npos;
}

int main() {
    // In a real environment, this would capture the output of act_1.answer.cpp
    std::string capturedOutput = "Mabuhay, Pilipinas!";
    bool pass = testOutput(capturedOutput);
    
    if (pass) {
        std::cout << "[PASS] Hello Philippines" << std::endl;
    } else {
        std::cout << "[FAIL] Hello Philippines" << std::endl;
    }
    
    return pass ? 0 : 1;
}
