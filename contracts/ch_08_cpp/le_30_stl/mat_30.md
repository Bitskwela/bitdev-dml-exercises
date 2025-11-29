## Background Story

Tian spent two days implementing a dynamic array class—manual memory management, resize logic, bounds checking, copy constructors. It worked, but was full of subtle bugs. Then Tian discovered that C++ already had `vector` that did everything better.

"I wasted two days reinventing the wheel!" Tian exclaimed, frustrated. "Why didn't anyone tell me about the Standard Template Library?"

Kuya Miguel smiled. "Now you appreciate why STL exists. The vector you spent days on? STL's version is optimized, tested by millions of developers, handles edge cases you haven't thought of, and is maintained by language experts."

"The STL is a treasure trove," Kuya Miguel explained. "Need a dynamic array? Use `vector`. Need fast lookup by key? Use `map`. Need a queue? Use `queue`. Need sorted unique values? Use `set`. These data structures have been refined for decades. They're fast, reliable, and used in production systems worldwide."

"Professional developers don't write their own hash tables or sorting algorithms unless they have very specific needs," Kuya Miguel said. "They use STL—battle-tested, optimized implementations. Your job is to solve business problems, not reimplement basic data structures. Master the STL, and you'll be exponentially more productive!"

---

## Theory & Lecture Content

## What is STL?

**STL** = collection of powerful template classes and functions:
- **Containers**: vector, list, map, set, etc.
- **Algorithms**: sort, find, count, etc.
- **Iterators**: navigate through containers

---

## Vector - Dynamic Array

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> numbers;
    
    // Add elements
    numbers.push_back(10);
    numbers.push_back(20);
    numbers.push_back(30);
    
    // Access elements
    cout << numbers[0] << endl;  // 10
    cout << numbers.at(1) << endl;  // 20 (with bounds checking)
    
    // Size
    cout << "Size: " << numbers.size() << endl;
    
    // Iterate
    for (int num : numbers) {
        cout << num << " ";
    }
    cout << endl;
    
    // Remove last
    numbers.pop_back();
    
    // Insert at position
    numbers.insert(numbers.begin() + 1, 15);
    
    // Clear all
    // numbers.clear();
    
    return 0;
}
```

---

## String Class

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name = "Juan Dela Cruz";
    
    // Length
    cout << name.length() << endl;  // 14
    
    // Substring
    cout << name.substr(0, 4) << endl;  // "Juan"
    
    // Find
    size_t pos = name.find("Dela");
    if (pos != string::npos) {
        cout << "Found at position " << pos << endl;
    }
    
    // Replace
    name.replace(0, 4, "Maria");  // "Maria Dela Cruz"
    
    // Append
    name += " Santos";
    
    // Compare
    string other = "Maria";
    if (name.find(other) != string::npos) {
        cout << "Contains Maria\n";
    }
    
    return 0;
}
```

---

## Map - Key-Value Pairs

```cpp
#include <iostream>
#include <map>
#include <string>
using namespace std;

int main() {
    map<int, string> residents;
    
    // Add entries
    residents[1001] = "Juan Dela Cruz";
    residents[1002] = "Maria Santos";
    residents[1003] = "Pedro Reyes";
    
    // Access
    cout << residents[1001] << endl;  // "Juan Dela Cruz"
    
    // Check if key exists
    if (residents.find(1004) == residents.end()) {
        cout << "ID 1004 not found\n";
    }
    
    // Iterate
    for (auto& pair : residents) {
        cout << "ID: " << pair.first << ", Name: " << pair.second << endl;
    }
    
    // Remove
    residents.erase(1002);
    
    // Size
    cout << "Total residents: " << residents.size() << endl;
    
    return 0;
}
```

---

## Set - Unique Elements

```cpp
#include <iostream>
#include <set>
using namespace std;

int main() {
    set<int> ids;
    
    // Add elements (duplicates ignored)
    ids.insert(1001);
    ids.insert(1002);
    ids.insert(1001);  // Ignored
    ids.insert(1003);
    
    cout << "Size: " << ids.size() << endl;  // 3
    
    // Check if exists
    if (ids.find(1001) != ids.end()) {
        cout << "1001 exists\n";
    }
    
    // Iterate (automatically sorted)
    for (int id : ids) {
        cout << id << " ";
    }
    cout << endl;
    
    return 0;
}
```

---

## Algorithms

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    vector<int> numbers = {50, 20, 60, 10, 30, 40};
    
    // Sort
    sort(numbers.begin(), numbers.end());
    for (int n : numbers) cout << n << " ";  // 10 20 30 40 50 60
    cout << endl;
    
    // Reverse
    reverse(numbers.begin(), numbers.end());
    for (int n : numbers) cout << n << " ";  // 60 50 40 30 20 10
    cout << endl;
    
    // Find
    auto it = find(numbers.begin(), numbers.end(), 30);
    if (it != numbers.end()) {
        cout << "Found 30 at position " << (it - numbers.begin()) << endl;
    }
    
    // Count
    int count = count_if(numbers.begin(), numbers.end(), [](int n) {
        return n > 30;
    });
    cout << "Elements > 30: " << count << endl;
    
    // Min/Max
    cout << "Min: " << *min_element(numbers.begin(), numbers.end()) << endl;
    cout << "Max: " << *max_element(numbers.begin(), numbers.end()) << endl;
    
    return 0;
}
```

---

## Practical Example: Barangay Resident Management

```cpp
#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <algorithm>
using namespace std;

struct Resident {
    int id;
    string name;
    int age;
    double balance;
    
    void display() const {
        cout << "ID: " << id << ", Name: " << name 
             << ", Age: " << age << ", Balance: P" << balance << endl;
    }
};

class ResidentManager {
private:
    vector<Resident> residents;
    map<int, int> idToIndex;  // Quick ID lookup
    
public:
    void addResident(const Resident& r) {
        residents.push_back(r);
        idToIndex[r.id] = residents.size() - 1;
        cout << "Added: " << r.name << endl;
    }
    
    Resident* findById(int id) {
        auto it = idToIndex.find(id);
        if (it != idToIndex.end()) {
            return &residents[it->second];
        }
        return nullptr;
    }
    
    void displayAll() {
        cout << "\n===== ALL RESIDENTS =====\n";
        for (const auto& r : residents) {
            r.display();
        }
        cout << "Total: " << residents.size() << endl;
    }
    
    void sortByName() {
        sort(residents.begin(), residents.end(), [](const Resident& a, const Resident& b) {
            return a.name < b.name;
        });
        
        // Rebuild index
        idToIndex.clear();
        for (size_t i = 0; i < residents.size(); i++) {
            idToIndex[residents[i].id] = i;
        }
        
        cout << "Sorted by name\n";
    }
    
    void sortByBalance() {
        sort(residents.begin(), residents.end(), [](const Resident& a, const Resident& b) {
            return a.balance > b.balance;  // Descending
        });
        
        idToIndex.clear();
        for (size_t i = 0; i < residents.size(); i++) {
            idToIndex[residents[i].id] = i;
        }
        
        cout << "Sorted by balance (highest first)\n";
    }
    
    vector<Resident> findByAge(int minAge, int maxAge) {
        vector<Resident> result;
        copy_if(residents.begin(), residents.end(), back_inserter(result),
                [minAge, maxAge](const Resident& r) {
                    return r.age >= minAge && r.age <= maxAge;
                });
        return result;
    }
    
    double getTotalBalance() {
        double total = 0;
        for (const auto& r : residents) {
            total += r.balance;
        }
        return total;
    }
};

int main() {
    ResidentManager manager;
    
    manager.addResident({1001, "Juan Dela Cruz", 30, 500.0});
    manager.addResident({1002, "Maria Santos", 25, 1200.0});
    manager.addResident({1003, "Pedro Reyes", 45, 800.0});
    manager.addResident({1004, "Ana Garcia", 28, 300.0});
    
    manager.displayAll();
    
    // Find by ID
    Resident* r = manager.findById(1002);
    if (r) {
        cout << "\nFound: ";
        r->display();
    }
    
    // Sort by name
    manager.sortByName();
    manager.displayAll();
    
    // Sort by balance
    manager.sortByBalance();
    manager.displayAll();
    
    // Find by age range
    cout << "\nResidents aged 25-35:\n";
    auto youngAdults = manager.findByAge(25, 35);
    for (const auto& r : youngAdults) {
        r.display();
    }
    
    // Total balance
    cout << "\nTotal balance: P" << manager.getTotalBalance() << endl;
    
    return 0;
}
```

---

## Iterators

```cpp
#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> numbers = {10, 20, 30, 40, 50};
    
    // Iterator
    vector<int>::iterator it;
    
    // Forward iteration
    for (it = numbers.begin(); it != numbers.end(); ++it) {
        cout << *it << " ";
    }
    cout << endl;
    
    // Reverse iteration
    for (auto rit = numbers.rbegin(); rit != numbers.rend(); ++rit) {
        cout << *rit << " ";
    }
    cout << endl;
    
    // Modify through iterator
    for (it = numbers.begin(); it != numbers.end(); ++it) {
        *it *= 2;
    }
    
    for (int n : numbers) {
        cout << n << " ";  // 20 40 60 80 100
    }
    cout << endl;
    
    return 0;
}
```

---

## Summary

"STL is so powerful!" Tian exclaimed.

"Absolutely!" Kuya Miguel said. "Remember:
- **vector** = dynamic array
- **map** = key-value pairs
- **set** = unique elements
- **Algorithms** = sort, find, count, etc.
- **Iterators** = navigate containers"

"Final lesson: **Complete CRUD System** — put it all together!"

---

**Key Takeaways:**
1. STL provides ready-to-use containers
2. vector for dynamic arrays
3. map for key-value storage
4. Algorithms for common operations
5. Iterators for traversal

---

## Closing Story

"I've been reinventing the wheel!" Tian laughed, replacing his custom array classes with vector, his lookup tables with map, his unique ID storage with set. The STL versions were more powerful, thoroughly tested, and incredibly efficient.

Kuya Miguel grinned. "That's why the STL exists. Decades of expert work, optimized and proven. Vector grows automatically, map provides fast lookups with balanced trees, algorithms like sort and find are highly optimized."

Tian practiced using vector for resident storage, map for quick ID-to-index lookup, set for unique collections, and algorithms for sorting, searching, and filtering. "And iterators let me traverse any container uniformly. Same pattern for vector, map, set, list."

"Exactly! Learn the STL patterns once, use them everywhere. And with C++11 range-based for loops and lambdas, the code becomes even cleaner. You saw how easy sorting by custom criteria became with lambda functions."

Tian's resident management system was now concise, powerful, and professional. Vector for dynamic storage, map for fast lookups, sort and find for queries. "This is production-quality code."

"It is. Now for the final challenge: build a complete CRUD system using everything you've learned."

**Next Lesson:** Final Challenge - Complete CRUD System
