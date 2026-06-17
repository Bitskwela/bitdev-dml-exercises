# C++ Activity

Use STL containers and algorithms to store, sort, and look up barangay data.

```cpp
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <map>
#include <cassert>

using namespace std;

// --- Task 1: Vector Basics ---
// TODO: vectorDemo() - push_back three names, check size/front/back,
//       pop_back the last one, then print: "Vector Names: <name> <name> "

// --- Task 2: Algorithms ---
// TODO: algorithmDemo() - sort a vector of scores ascending, reverse it,
//       then print: "Sorted & Reversed Scores: <s> <s> ... "

// --- Task 3: Maps (Key-Value Pairs) ---
// TODO: mapDemo() - insert key-value pairs, verify with count(),
//       then print: "Map Entry: Maria is <age> years old."

int main() {
    cout << "--- Lesson 30: Standard Template Library ---" << endl;

    // Your code here: call vectorDemo(), algorithmDemo(), mapDemo()

    cout << "\nSTL demonstration completed successfully!" << endl;
    return 0;
}
```

## Task for Learners

- Write `vectorDemo()` using `push_back`, `pop_back`, `size`, `front`, and `back`.

  ```cpp
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
  ```

- Write `algorithmDemo()` using `sort` and `reverse`.

  ```cpp
  void algorithmDemo() {
      vector<int> scores = {85, 92, 78, 95, 88};

      sort(scores.begin(), scores.end());
      assert(scores[0] == 78);
      assert(scores.back() == 95);

      reverse(scores.begin(), scores.end());
      assert(scores[0] == 95);

      cout << "Sorted & Reversed Scores: ";
      for (int s : scores) cout << s << " ";
      cout << endl;
  }
  ```

- Write `mapDemo()` using `operator[]` and `count`.

  ```cpp
  void mapDemo() {
      map<string, int> residentAges;
      residentAges["Juan"] = 30;
      residentAges["Maria"] = 25;

      assert(residentAges["Juan"] == 30);
      assert(residentAges.count("Maria") == 1);
      assert(residentAges.count("Pedro") == 0);

      cout << "Map Entry: Maria is " << residentAges["Maria"] << " years old." << endl;
  }
  ```

- Call all three demos from `main()` so the program prints the expected lines.

  ```cpp
  vectorDemo();
  algorithmDemo();
  mapDemo();
  ```

### Breakdown of the Activity

- **`push_back()` / `pop_back()`**: Add or remove an element at the end of the vector.
- **`sort()` then `reverse()`**: Sort ascending, then flip to descending order.
- **`map[key] = value`**: Inserts or updates a key-value pair in the map.
- **`count(key)`**: Returns 1 if the key exists, 0 otherwise -- a safe membership check.
