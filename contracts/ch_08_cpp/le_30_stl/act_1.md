# Lesson 30 Activities: Standard Template Library (STL)

## The Wheel-Reinventing Struggle

Tian spent **2 days** creating a dynamic array: resizing, memory management, bugs. Then discovered STL's `vector`—**battle-tested, optimized, ready to use.**

"You're reinventing the wheel! STL has all the data structures already—vector, map, string—all professional-grade!"

**STL is productivity boost!** Don't waste time on basic structures. Use optimized, tested implementations. Focus on solving problems, not building infrastructure!

**Three main STL components:**
1. **Containers:** vector, map, set, string
2. **Algorithms:** sort, find, count, reverse
3. **Iterators:** Connect containers and algorithms

---

## Task 1: Vector Basics

**Context:** Dynamic array that handles memory automatically.

**Starter Code:**
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
    
    cout << "Size: " << numbers.size() << endl;
    
    // Access elements
    cout << "First: " << numbers[0] << endl;
    cout << "Last: " << numbers.back() << endl;
    
    // Loop through
    for (int num : numbers) {
        cout << num << " ";
    }
    cout << endl;
    
    // Remove last
    numbers.pop_back();
    
    // Check empty
    if (!numbers.empty()) {
        cout << "Vector has " << numbers.size() << " elements" << endl;
    }
    
    return 0;
}
```

# Tasks for Learners

- Practice using vector methods: `push_back()`, `pop_back()`, `size()`, `empty()`, `back()`, and range-based loops to understand dynamic array operations.

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
      
      cout << "Size: " << numbers.size() << endl;
      
      // Access elements
      cout << "First: " << numbers[0] << endl;
      cout << "Last: " << numbers.back() << endl;
      
      // Loop through
      for (int num : numbers) {
          cout << num << " ";
      }
      cout << endl;
      
      // Remove last
      numbers.pop_back();
      
      // Check empty
      if (!numbers.empty()) {
          cout << "Vector has " << numbers.size() << " elements" << endl;
      }
      
      return 0;
  }
  ```

---

## Task 2: Vector with Structs

**Context:** Store custom types in vector.

**Starter Code:**
```cpp
#include <iostream>
#include <vector>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

int main() {
    vector<Resident> residents;
    
    // Add residents
    residents.push_back({"Juan Dela Cruz", 35, "Block 1"});
    residents.push_back({"Maria Santos", 28, "Block 2"});
    residents.push_back({"Pedro Garcia", 42, "Block 3"});
    
    // Display all
    cout << "=== Residents ===" << endl;
    for (const Resident& r : residents) {
        cout << r.name << " (" << r.age << ") - " << r.address << endl;
    }
    
    // Find by name
    string searchName = "Maria Santos";
    for (const Resident& r : residents) {
        if (r.name == searchName) {
            cout << "\nFound: " << r.name << ", Age: " << r.age << endl;
        }
    }
    
    return 0;
}
```

# Tasks for Learners

- Store custom struct types in a vector, iterate through them, and search for specific records by name.

  ```cpp
  #include <iostream>
  #include <vector>
  #include <string>
  using namespace std;

  struct Resident {
      string name;
      int age;
      string address;
  };

  int main() {
      vector<Resident> residents;
      
      // Add residents
      residents.push_back({"Juan Dela Cruz", 35, "Block 1"});
      residents.push_back({"Maria Santos", 28, "Block 2"});
      residents.push_back({"Pedro Garcia", 42, "Block 3"});
      
      // Display all
      cout << "=== Residents ===" << endl;
      for (const Resident& r : residents) {
          cout << r.name << " (" << r.age << ") - " << r.address << endl;
      }
      
      // Find by name
      string searchName = "Maria Santos";
      for (const Resident& r : residents) {
          if (r.name == searchName) {
              cout << "\nFound: " << r.name << ", Age: " << r.age << endl;
          }
      }
      
      return 0;
  }
  ```

---

## Task 3: String Class

**Context:** Powerful string manipulation.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string name = "Juan Dela Cruz";
    
    // Length
    cout << "Length: " << name.length() << endl;
    
    // Concatenation
    string greeting = "Hello, " + name + "!";
    cout << greeting << endl;
    
    // Substring
    string firstName = name.substr(0, 4);  // "Juan"
    cout << "First name: " << firstName << endl;
    
    // Find
    int pos = name.find("Dela");
    if (pos != string::npos) {
        cout << "'Dela' found at position " << pos << endl;
    }
    
    // Replace
    string modified = name;
    modified.replace(0, 4, "Pedro");
    cout << "Modified: " << modified << endl;
    
    // Compare
    if (name == "Juan Dela Cruz") {
        cout << "Names match!" << endl;
    }
    
    // Convert to uppercase
    for (char& c : name) {
        c = toupper(c);
    }
    cout << "Uppercase: " << name << endl;
    
    return 0;
}
```

# Tasks for Learners

- Use string class methods like `length()`, `substr()`, `find()`, `replace()`, concatenation, comparison, and character manipulation.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  int main() {
      string name = "Juan Dela Cruz";
      
      // Length
      cout << "Length: " << name.length() << endl;
      
      // Concatenation
      string greeting = "Hello, " + name + "!";
      cout << greeting << endl;
      
      // Substring
      string firstName = name.substr(0, 4);  // "Juan"
      cout << "First name: " << firstName << endl;
      
      // Find
      int pos = name.find("Dela");
      if (pos != string::npos) {
          cout << "'Dela' found at position " << pos << endl;
      }
      
      // Replace
      string modified = name;
      modified.replace(0, 4, "Pedro");
      cout << "Modified: " << modified << endl;
      
      // Compare
      if (name == "Juan Dela Cruz") {
          cout << "Names match!" << endl;
      }
      
      // Convert to uppercase
      for (char& c : name) {
          c = toupper(c);
      }
      cout << "Uppercase: " << name << endl;
      
      return 0;
  }
  ```

---

## Task 4: Map (Key-Value Pairs)

**Context:** Store data with keys (like dictionary).

**Starter Code:**
```cpp
#include <iostream>
#include <map>
#include <string>
using namespace std;

int main() {
    // Map: Resident ID -> Name
    map<int, string> residents;
    
    // Add residents
    residents[1001] = "Juan Dela Cruz";
    residents[1002] = "Maria Santos";
    residents[1003] = "Pedro Garcia";
    
    // Access by key
    cout << "Resident 1002: " << residents[1002] << endl;
    
    // Check if key exists
    if (residents.find(1005) == residents.end()) {
        cout << "Resident 1005 not found" << endl;
    }
    
    // Loop through
    cout << "\n=== All Residents ===" << endl;
    for (auto& pair : residents) {
        cout << "ID " << pair.first << ": " << pair.second << endl;
    }
    
    // Remove
    residents.erase(1002);
    
    // Size
    cout << "\nTotal residents: " << residents.size() << endl;
    
    return 0;
}
```

# Tasks for Learners

- Use map container to store key-value pairs, access elements by key, check for key existence, iterate through pairs, and remove entries.

  ```cpp
  #include <iostream>
  #include <map>
  #include <string>
  using namespace std;

  int main() {
      // Map: Resident ID -> Name
      map<int, string> residents;
      
      // Add residents
      residents[1001] = "Juan Dela Cruz";
      residents[1002] = "Maria Santos";
      residents[1003] = "Pedro Garcia";
      
      // Access by key
      cout << "Resident 1002: " << residents[1002] << endl;
      
      // Check if key exists
      if (residents.find(1005) == residents.end()) {
          cout << "Resident 1005 not found" << endl;
      }
      
      // Loop through
      cout << "\n=== All Residents ===" << endl;
      for (auto& pair : residents) {
          cout << "ID " << pair.first << ": " << pair.second << endl;
      }
      
      // Remove
      residents.erase(1002);
      
      // Size
      cout << "\nTotal residents: " << residents.size() << endl;
      
      return 0;
  }
  ```

---

## Task 5: Set (Unique Values)

**Context:** Store unique elements, automatically sorted.

**Starter Code:**
```cpp
#include <iostream>
#include <set>
#include <string>
using namespace std;

int main() {
    set<string> barangays;
    
    // Add elements
    barangays.insert("Barangay 1");
    barangays.insert("Barangay 3");
    barangays.insert("Barangay 2");
    barangays.insert("Barangay 1");  // Duplicate ignored
    
    // Size
    cout << "Total unique barangays: " << barangays.size() << endl;
    
    // Display (automatically sorted)
    cout << "\n=== Barangays ===" << endl;
    for (const string& b : barangays) {
        cout << b << endl;
    }
    
    // Check membership
    if (barangays.find("Barangay 2") != barangays.end()) {
        cout << "\nBarangay 2 exists" << endl;
    }
    
    // Remove
    barangays.erase("Barangay 3");
    
    // Check empty
    if (!barangays.empty()) {
        cout << barangays.size() << " barangays remaining" << endl;
    }
    
    return 0;
}
```

# Tasks for Learners

- Use set container to store unique elements that are automatically sorted, insert duplicates (which are ignored), check membership, and remove elements.

  ```cpp
  #include <iostream>
  #include <set>
  #include <string>
  using namespace std;

  int main() {
      set<string> barangays;
      
      // Add elements
      barangays.insert("Barangay 1");
      barangays.insert("Barangay 3");
      barangays.insert("Barangay 2");
      barangays.insert("Barangay 1");  // Duplicate ignored
      
      // Size
      cout << "Total unique barangays: " << barangays.size() << endl;
      
      // Display (automatically sorted)
      cout << "\n=== Barangays ===" << endl;
      for (const string& b : barangays) {
          cout << b << endl;
      }
      
      // Check membership
      if (barangays.find("Barangay 2") != barangays.end()) {
          cout << "\nBarangay 2 exists" << endl;
      }
      
      // Remove
      barangays.erase("Barangay 3");
      
      // Check empty
      if (!barangays.empty()) {
          cout << barangays.size() << " barangays remaining" << endl;
      }
      
      return 0;
  }
  ```

---

## Task 6: STL Algorithms

**Context:** Powerful algorithms for common operations.

**Starter Code:**
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
using namespace std;

int main() {
    vector<int> ages = {35, 28, 42, 19, 55, 31};
    
    // Sort
    sort(ages.begin(), ages.end());
    cout << "Sorted: ";
    for (int age : ages) cout << age << " ";
    cout << endl;
    
    // Find
    auto it = find(ages.begin(), ages.end(), 42);
    if (it != ages.end()) {
        cout << "Found 42 at position " << (it - ages.begin()) << endl;
    }
    
    // Count
    vector<int> numbers = {1, 2, 3, 2, 4, 2, 5};
    int count2 = count(numbers.begin(), numbers.end(), 2);
    cout << "Number 2 appears " << count2 << " times" << endl;
    
    // Min/Max
    int minAge = *min_element(ages.begin(), ages.end());
    int maxAge = *max_element(ages.begin(), ages.end());
    cout << "Min age: " << minAge << ", Max age: " << maxAge << endl;
    
    // Sum
    int totalAge = accumulate(ages.begin(), ages.end(), 0);
    cout << "Total age: " << totalAge << endl;
    cout << "Average age: " << totalAge / ages.size() << endl;
    
    // Reverse
    reverse(ages.begin(), ages.end());
    cout << "Reversed: ";
    for (int age : ages) cout << age << " ";
    cout << endl;
    
    return 0;
}
```

# Tasks for Learners

- Apply STL algorithms like `sort()`, `find()`, `count()`, `min_element()`, `max_element()`, `accumulate()`, and `reverse()` on vectors.

  ```cpp
  #include <iostream>
  #include <vector>
  #include <algorithm>
  #include <numeric>
  using namespace std;

  int main() {
      vector<int> ages = {35, 28, 42, 19, 55, 31};
      
      // Sort
      sort(ages.begin(), ages.end());
      cout << "Sorted: ";
      for (int age : ages) cout << age << " ";
      cout << endl;
      
      // Find
      auto it = find(ages.begin(), ages.end(), 42);
      if (it != ages.end()) {
          cout << "Found 42 at position " << (it - ages.begin()) << endl;
      }
      
      // Count
      vector<int> numbers = {1, 2, 3, 2, 4, 2, 5};
      int count2 = count(numbers.begin(), numbers.end(), 2);
      cout << "Number 2 appears " << count2 << " times" << endl;
      
      // Min/Max
      int minAge = *min_element(ages.begin(), ages.end());
      int maxAge = *max_element(ages.begin(), ages.end());
      cout << "Min age: " << minAge << ", Max age: " << maxAge << endl;
      
      // Sum
      int totalAge = accumulate(ages.begin(), ages.end(), 0);
      cout << "Total age: " << totalAge << endl;
      cout << "Average age: " << totalAge / ages.size() << endl;
      
      // Reverse
      reverse(ages.begin(), ages.end());
      cout << "Reversed: ";
      for (int age : ages) cout << age << " ";
      cout << endl;
      
      return 0;
  }
  ```

---

## Task 7: Complete Example - Resident Database

**Context:** Combine multiple STL containers.

**Starter Code:**
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
    string barangay;
};

int main() {
    vector<Resident> residents = {
        {1001, "Juan Dela Cruz", 35, "Barangay 1"},
        {1002, "Maria Santos", 28, "Barangay 2"},
        {1003, "Pedro Garcia", 42, "Barangay 1"},
        {1004, "Ana Reyes", 31, "Barangay 3"},
        {1005, "Jose Ramos", 55, "Barangay 2"}
    };
    
    // 1. Sort by age
    sort(residents.begin(), residents.end(), 
         [](const Resident& a, const Resident& b) {
             return a.age < b.age;
         });
    
    cout << "=== Sorted by Age ===" << endl;
    for (const Resident& r : residents) {
        cout << r.name << " (" << r.age << ")" << endl;
    }
    
    // 2. Map: Barangay -> Count
    map<string, int> barangayCount;
    for (const Resident& r : residents) {
        barangayCount[r.barangay]++;
    }
    
    cout << "\n=== Residents per Barangay ===" << endl;
    for (const auto& pair : barangayCount) {
        cout << pair.first << ": " << pair.second << " residents" << endl;
    }
    
    // 3. Find senior citizens (60+)
    cout << "\n=== Senior Citizens ===" << endl;
    int seniorCount = count_if(residents.begin(), residents.end(),
                               [](const Resident& r) { return r.age >= 60; });
    cout << "Total senior citizens: " << seniorCount << endl;
    
    // 4. Average age
    int totalAge = 0;
    for (const Resident& r : residents) {
        totalAge += r.age;
    }
    cout << "Average age: " << totalAge / residents.size() << endl;
    
    return 0;
}
```

# Tasks for Learners

- Combine multiple STL containers (vector, map) and algorithms (sort with lambda, count_if) to build a resident database that sorts by age, counts residents per barangay, finds senior citizens, and calculates average age.

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
      string barangay;
  };

  int main() {
      vector<Resident> residents = {
          {1001, "Juan Dela Cruz", 35, "Barangay 1"},
          {1002, "Maria Santos", 28, "Barangay 2"},
          {1003, "Pedro Garcia", 42, "Barangay 1"},
          {1004, "Ana Reyes", 31, "Barangay 3"},
          {1005, "Jose Ramos", 55, "Barangay 2"}
      };
      
      // 1. Sort by age
      sort(residents.begin(), residents.end(), 
           [](const Resident& a, const Resident& b) {
               return a.age < b.age;
           });
      
      cout << "=== Sorted by Age ===" << endl;
      for (const Resident& r : residents) {
          cout << r.name << " (" << r.age << ")" << endl;
      }
      
      // 2. Map: Barangay -> Count
      map<string, int> barangayCount;
      for (const Resident& r : residents) {
          barangayCount[r.barangay]++;
      }
      
      cout << "\n=== Residents per Barangay ===" << endl;
      for (const auto& pair : barangayCount) {
          cout << pair.first << ": " << pair.second << " residents" << endl;
      }
      
      // 3. Find senior citizens (60+)
      cout << "\n=== Senior Citizens ===" << endl;
      int seniorCount = count_if(residents.begin(), residents.end(),
                                 [](const Resident& r) { return r.age >= 60; });
      cout << "Total senior citizens: " << seniorCount << endl;
      
      // 4. Average age
      int totalAge = 0;
      for (const Resident& r : residents) {
          totalAge += r.age;
      }
      cout << "Average age: " << totalAge / residents.size() << endl;
      
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 STL Quick Reference</strong></summary>

**Vector:**
```cpp
vector<int> v;
v.push_back(10);     // Add to end
v.pop_back();        // Remove from end
v.size();            // Number of elements
v.empty();           // Check if empty
v[i];                // Access by index
v.clear();           // Remove all
```

**String:**
```cpp
string s = "Hello";
s.length();          // Length
s + " World";        // Concatenate
s.substr(0, 3);      // Substring
s.find("ell");       // Find position
s.replace(0, 1, "h"); // Replace
```

**Map:**
```cpp
map<int, string> m;
m[1] = "One";        // Insert/update
m.find(1);           // Find key
m.erase(1);          // Remove key
m.size();            // Number of pairs
```

**Set:**
```cpp
set<int> s;
s.insert(10);        // Add element
s.erase(10);         // Remove element
s.find(10);          // Find element
s.size();            // Number of elements
```

**Algorithms:**
```cpp
sort(v.begin(), v.end());
find(v.begin(), v.end(), value);
count(v.begin(), v.end(), value);
min_element(v.begin(), v.end());
max_element(v.begin(), v.end());
reverse(v.begin(), v.end());
```

**Benefits:**
- No manual memory management
- Optimized and tested
- Consistent interfaces
- Generic (works with any type)
- Productivity boost!

</details>

---

**STL = professional C++ development. Don't reinvent the wheel—use the library!**
