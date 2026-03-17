# STL Basics

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+30.0+-+COVER.png)

## Scene

Tian spent two days building a dynamic array class with manual memory management and resize logic. Then he discovered C++ already had `vector` that did everything better. "I wasted two days reinventing the wheel!" he exclaimed.

Kuya Miguel smiled. "Now you appreciate why the STL exists. The Standard Template Library gives you battle-tested, optimized containers and algorithms. Need a dynamic array? Use `vector`. Need fast key lookup? Use `map`. Need to sort? Use `sort()`."

"Professional developers solve business problems, not reimplement data structures," Kuya Miguel said. "Master the STL and you'll be exponentially more productive."

## C++ Topics: Standard Template Library

![30.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+30.1.png)

### Vector

> `vector<T>` is a dynamic array that grows automatically. Use `push_back()` to add, `pop_back()` to remove, `size()` to check count, and `[]` or `.at()` to access elements.

### Map

> `map<K, V>` stores key-value pairs sorted by key. Access with `m[key]`, check existence with `find()`, remove with `erase()`. Provides fast O(log n) lookups.

### Algorithms

> The `<algorithm>` header provides `sort()`, `find()`, `count()`, `reverse()`, `min_element()`, and `max_element()`. They work on any container via iterators.

### Range-based For Loops

> `for (auto& item : container)` iterates through every element cleanly. Use `const auto&` when you only need to read, not modify.

#### Sample syntax

```cpp
#include <vector>
#include <algorithm>
#include <map>

vector<int> v = {3, 1, 2};
sort(v.begin(), v.end());  // v is now {1, 2, 3}

map<int, string> m;
m[1] = "One";
// m.find(1) != m.end() -> true
```

`vector` handles dynamic sizing and memory automatically. `sort()` takes iterator begin/end and sorts in-place. `map` provides key-value storage with automatic sorting by key. These replace manual arrays, custom sort functions, and hand-built lookup tables.
