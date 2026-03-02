#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <map>
#include <cassert>

using namespace std;

/**
 * LESSON 30: Standard Template Library (STL)
 * 
 * The STL is a collection of battle-tested, highly optimized template classes 
 * and functions. It's the "toolbox" of every professional C++ developer.
 * 
 * Kuya Miguel's Tip: Don't reinvent the wheel! If you need a list, 
 * use 'vector'. If you need a dictionary, use 'map'. If you need 
 * to sort, use 'sort()'. Focus on your app's logic, not data structures.
 */

// --- Task 1: Vector Basics ---
void vectorDemo() {
    vector<string> names;
    names.push_back("Juan");
    names.push_back("Maria");
    names.push_back("Pedro");

    assert(names.size() == 3);
    assert(names.front() == "Juan");
    assert(names.back() == "Pedro");

    names.pop_back(); // Remove Pedro
    assert(names.size() == 2);

    cout << "Vector Names: ";
    for (const string& n : names) cout << n << " ";
    cout << endl;
}

// --- Task 2: Algorithms ---
void algorithmDemo() {
    vector<int> scores = {85, 92, 78, 95, 88};

    // Sort in ascending order
    sort(scores.begin(), scores.end());
    assert(scores[0] == 78);
    assert(scores.back() == 95);

    // Reverse the order
    reverse(scores.begin(), scores.end());
    assert(scores[0] == 95);

    cout << "Sorted & Reversed Scores: ";
    for (int s : scores) cout << s << " ";
    cout << endl;
}

// --- Task 3: Maps (Key-Value Pairs) ---
void mapDemo() {
    map<string, int> residentAges;
    residentAges["Juan"] = 30;
    residentAges["Maria"] = 25;

    assert(residentAges["Juan"] == 30);
    assert(residentAges.count("Maria") == 1);
    assert(residentAges.count("Pedro") == 0);

    cout << "Map Entry: Maria is " << residentAges["Maria"] << " years old." << endl;
}

int main() {
    cout << "--- Lesson 30: Standard Template Library ---" << endl;
    
    vectorDemo();
    algorithmDemo();
    mapDemo();

    cout << "\nSTL demonstration completed successfully!" << endl;
    return 0;
}
