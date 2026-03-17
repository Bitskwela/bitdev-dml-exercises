# C++ Activity

Use STL containers and algorithms to store, sort, and look up barangay data.

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <map>
#include <cassert>

using namespace std;

int main() {
    // TODO: Create a vector, add elements, verify size and back()

    // TODO: Sort a vector in descending order and verify

    // TODO: Create a map, add a key-value pair, verify lookup

    return 0;
}
```

## Task for Learners

- Create a vector, push_back elements, and verify size.

  ```cpp
  vector<int> v = {1, 2, 3};
  v.push_back(4);
  assert(v.size() == 4);
  assert(v.back() == 4);
  ```

- Sort in descending order using reverse iterators.

  ```cpp
  sort(v.rbegin(), v.rend());
  assert(v[0] == 4);
  ```

- Create a map with a key-value pair and verify lookup.

  ```cpp
  map<int, string> m;
  m[1] = "One";
  assert(m[1] == "One");
  ```

### Breakdown of the Activity

- **`push_back()`**: Adds an element to the end of the vector, automatically resizing if needed.
- **`sort(v.rbegin(), v.rend())`**: Sorts using reverse iterators, producing descending order.
- **`map[key] = value`**: Inserts or updates a key-value pair in the map.
- **`assert()`**: Validates correctness at runtime; program aborts if the condition is false.
