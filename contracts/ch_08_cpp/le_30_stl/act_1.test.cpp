#include <iostream>
#include <vector>
#include <algorithm>
#include <map>
#include <cassert>

int main() {
    // Vector Test
    std::vector<int> v = {1, 2, 3};
    assert(v.size() == 3);
    v.push_back(4);
    assert(v.back() == 4);

    // Algorithm Test
    std::sort(v.rbegin(), v.rend()); // Sort descending
    assert(v[0] == 4);

    // Map Test
    std::map<int, std::string> m;
    m[1] = "One";
    assert(m[1] == "One");

    std::cout << "Lesson 30 Tests Passed!" << std::endl;
    return 0;
}
