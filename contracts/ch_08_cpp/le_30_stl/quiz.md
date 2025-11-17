# Quiz: Lesson 30 - STL Basics

**Instructions:** Choose the best answer for each question. Each question tests your understanding of the C++ Standard Template Library and its practical applications.

---


# Quiz 1

## Section 1: Basic Concepts (Questions 1-10)

### Question 1
What is the STL?

A) A design pattern for C++ programs  
B) Standard Template Library - a collection of template classes and functions  
C) A debugging tool for memory leaks  
D) A C++ compiler extension

**Answer: B) Standard Template Library - a collection of template classes and functions**

**Explanation:**
The STL provides ready-to-use containers (vector, map, set), algorithms (sort, find, count), and iterators. It's a core part of the C++ standard library that enables efficient and reusable code.

---

### Question 2
Which operation adds an element to the end of a vector?

A) `vector.add()`  
B) `vector.append()`  
C) `vector.push_back()`  
D) `vector.insert_end()`

**Answer: C) `vector.push_back()`**

**Explanation:**
```cpp
vector<int> numbers;
numbers.push_back(10);  // Adds 10 to the end
numbers.push_back(20);  // Now vector has [10, 20]
```
`push_back()` is the standard method to add elements to the end of a vector. It automatically handles memory reallocation when needed.

---

### Question 3
What's the difference between `vector[index]` and `vector.at(index)`?

A) No difference, they work identically  
B) `at()` provides bounds checking and throws exception if index is invalid  
C) `[]` is faster but at() is deprecated  
D) `at()` only works with integers

**Answer: B) `at()` provides bounds checking and throws exception if index is invalid**

**Explanation:**
```cpp
vector<int> nums = {10, 20, 30};
cout << nums[5];      // Undefined behavior - no error checking
cout << nums.at(5);   // Throws out_of_range exception
```
Use `at()` when you want safer code with automatic error detection. Use `[]` when you're certain the index is valid and need maximum performance.

---

### Question 4
In a `map<int, string>`, what does the first type represent?

A) The value type  
B) The key type used for lookups  
C) The size of the map  
D) The iterator type

**Answer: B) The key type used for lookups**

**Explanation:**
```cpp
map<int, string> residents;
residents[1001] = "Juan";  // 1001 is the key (int)
residents[1002] = "Maria"; // "Maria" is the value (string)

cout << residents[1001];    // Lookup by key, outputs "Juan"
```
Maps store key-value pairs. The first template parameter is the key type, the second is the value type.

---

### Question 5
What is the key characteristic of a `set` container?

A) It stores elements in the order they were inserted  
B) It automatically stores unique elements only (no duplicates)  
C) It's faster than vectors for all operations  
D) It can only store integers

**Answer: B) It automatically stores unique elements only (no duplicates)**

**Explanation:**
```cpp
set<int> ids;
ids.insert(1001);
ids.insert(1002);
ids.insert(1001);  // Ignored - duplicate!

cout << ids.size();  // Outputs: 2 (not 3)
```
Sets automatically reject duplicates and keep elements sorted. This makes them perfect for tracking unique items.

---


# Quiz 2

### Question 6
Which string method extracts a portion of a string?

A) `str.extract()`  
B) `str.slice()`  
C) `str.substr()`  
D) `str.portion()`

**Answer: C) `str.substr()`**

**Explanation:**
```cpp
string name = "Juan Dela Cruz";
string firstName = name.substr(0, 4);  // "Juan"
// substr(starting_position, length)

string lastName = name.substr(10);     // "Cruz" (from pos 10 to end)
```
`substr()` creates a new string from a portion of the original. First parameter is the starting position, second (optional) is the length.

---




### Question 7
What does the `find()` algorithm return when the element is NOT found?

A) `-1`  
B) `NULL`  
C) `end()` iterator  
D) `false`

**Answer: C) `end()` iterator**

**Explanation:**
```cpp
vector<int> numbers = {10, 20, 30, 40};
auto it = find(numbers.begin(), numbers.end(), 25);

if (it == numbers.end()) {
    cout << "Not found!";  // This will execute
} else {
    cout << "Found at position: " << (it - numbers.begin());
}
```
In C++, `find()` returns an iterator. If the element isn't found, it returns `end()`, which points "past the last element."

---

### Question 8
Which algorithm would you use to arrange vector elements in ascending order?

A) `arrange()`  
B) `sort()`  
C) `order()`  
D) `organize()`

**Answer: B) `sort()`**

**Explanation:**
```cpp
vector<int> numbers = {50, 20, 60, 10, 30};
sort(numbers.begin(), numbers.end());
// Now: [10, 20, 30, 50, 60]

// For descending order:
sort(numbers.begin(), numbers.end(), greater<int>());
// Now: [60, 50, 30, 20, 10]
```
`sort()` requires iterators to the beginning and end of the range to sort. It uses an optimized algorithm (usually IntroSort).

---

### Question 9
What's the main advantage of using `vector` over traditional arrays?

A) Vectors are always faster  
B) Vectors have dynamic size and built-in memory management  
C) Vectors use less memory  
D) Arrays are deprecated in modern C++

**Answer: B) Vectors have dynamic size and built-in memory management**

**Explanation:**
```cpp
// Traditional array - fixed size
int arr[5];  // Must know size at compile time
// arr[5] = 10;  // Error! Can't grow

// Vector - dynamic size
vector<int> vec;
vec.push_back(10);
vec.push_back(20);  // Grows automatically!
vec.push_back(30);  // No memory management needed
```
Vectors automatically handle memory allocation/deallocation and can grow or shrink as needed. They also provide bounds checking with `at()` and many useful methods.

---


# Quiz 1

### Question 10
When would you choose `map` over `vector` for storing data?

A) When you need fast access by numeric index  
B) When you need to look up values by specific keys (like ID numbers)  
C) When order of insertion matters most  
D) When you want to use less memory

**Answer: B) When you need to look up values by specific keys (like ID numbers)**

**Explanation:**
```cpp
// Map - Fast lookup by ID (O(log n))
map<int, string> residents;
residents[1001] = "Juan";
residents[1050] = "Maria";
cout << residents[1050];  // Direct access by ID!

// Vector - Would need to search through all elements
vector<pair<int, string>> residentList;
// Need loop to find ID 1050 - slower O(n)
```
Maps excel at key-value associations with fast lookups. Vectors are better for sequential access and when using numeric indices.

---

## Section 2: Advanced Scenarios (Questions 11-15)

### Question 11
You're managing barangay residents. Which STL container combination is best?

```cpp
struct Resident {
    int id;
    string name;
    int age;
    double balance;
};
```

A) Array of Residents  
B) `vector<Resident>` for storage + `map<int, int>` for ID lookup  
C) Only `map<int, Resident>`  
D) `set<Resident>`

**Answer: B) `vector<Resident>` for storage + `map<int, int>` for ID lookup**

**Explanation:**
```cpp
class ResidentManager {
private:
    vector<Resident> residents;      // Stores actual data
    map<int, int> idToIndex;        // Maps ID to vector index
    
public:
    void addResident(const Resident& r) {
        residents.push_back(r);
        idToIndex[r.id] = residents.size() - 1;  // Quick lookup!
    }
    
    Resident* findById(int id) {
        auto it = idToIndex.find(id);
        if (it != idToIndex.end()) {
            return &residents[it->second];  // O(log n) lookup!
        }
        return nullptr;
    }
};
```
This combination provides both fast iteration (vector) and fast ID-based lookups (map). Best of both worlds!

---


# Quiz 1

### Question 12
How would you sort residents by name alphabetically?

A) Use `sort()` with default comparison  
B) Use `sort()` with a custom lambda function  
C) Manually write bubble sort  
D) Use `order_by_name()` function

**Answer: B) Use `sort()` with a custom lambda function**

**Explanation:**
```cpp
vector<Resident> residents = {
    {1001, "Zenaida", 30, 500},
    {1002, "Ana", 25, 1200},
    {1003, "Maria", 45, 800}
};

// Sort by name using lambda
sort(residents.begin(), residents.end(), 
     [](const Resident& a, const Resident& b) {
         return a.name < b.name;  // Ascending alphabetical
     });

// Now order: Ana, Maria, Zenaida
for (const auto& r : residents) {
    cout << r.name << " ";
}
```
Lambdas provide flexible custom sorting. You can sort by any field: name, age, balance, etc.

---


# Quiz 1

### Question 13
You need to find all residents aged 25-35. Which approach is best?

A) Manual loop checking each resident  
B) Use `count_if()` to count them  
C) Use `copy_if()` with lambda to filter  
D) Sort by age first, then extract range

**Answer: C) Use `copy_if()` with lambda to filter**

**Explanation:**
```cpp
vector<Resident> residents = /* ... */;
vector<Resident> youngAdults;

copy_if(residents.begin(), residents.end(), 
        back_inserter(youngAdults),
        [](const Resident& r) {
            return r.age >= 25 && r.age <= 35;
        });

// youngAdults now contains only residents in age range
cout << "Found " << youngAdults.size() << " young adults\n";
for (const auto& r : youngAdults) {
    r.display();
}
```
`copy_if()` is the idiomatic STL way to filter elements. It's clear, efficient, and leverages the power of algorithms.

---


# Quiz 1

### Question 14
What's wrong with this code?

```cpp
vector<Resident> residents;
// ... add residents ...
for (int i = 0; i <= residents.size(); i++) {
    residents[i].display();
}
```

A) Nothing, it's correct  
B) Loop goes one past the end (off-by-one error)  
C) Should use `residents.at(i)`  
D) Should use iterator instead

**Answer: B) Loop goes one past the end (off-by-one error)**

**Explanation:**
```cpp
// WRONG - crashes!
for (int i = 0; i <= residents.size(); i++) {
    // If size is 3, this tries to access indices 0,1,2,3
    // But valid indices are only 0,1,2!
}

// CORRECT version 1 - traditional loop
for (int i = 0; i < residents.size(); i++) {
    residents[i].display();
}

// CORRECT version 2 - range-based (preferred)
for (const auto& r : residents) {
    r.display();
}

// CORRECT version 3 - iterator
for (auto it = residents.begin(); it != residents.end(); ++it) {
    it->display();
}
```
Always use `<` not `<=` when looping with indices. Or better yet, use range-based for loops to avoid index errors entirely!

---


# Quiz 1

### Question 15
You need to calculate total outstanding balance for all residents. Which is the most modern C++ approach?

A) Traditional for loop with accumulator  
B) While loop with iterator  
C) Range-based for loop with lambda  
D) Recursive function

**Answer: C) Range-based for loop with lambda**

**Explanation:**
```cpp
vector<Resident> residents = {
    {1001, "Juan", 30, 500.0},
    {1002, "Maria", 25, 1200.0},
    {1003, "Pedro", 45, 800.0}
};

// Modern approach - clean and readable
double total = 0;
for (const auto& r : residents) {
    total += r.balance;
}
cout << "Total balance: P" << total << endl;  // P2500

// Alternative with accumulate algorithm
#include <numeric>
double total2 = accumulate(residents.begin(), residents.end(), 0.0,
                           [](double sum, const Resident& r) {
                               return sum + r.balance;
                           });

// Or even simpler if you have a getter
double total3 = 0;
for (const auto& r : residents) {
    if (r.isActive()) {  // Only count active residents
        total3 += r.getBalance();
    }
}
```
Range-based for loops are the modern C++ way - clean, safe, and efficient. They work with all STL containers and prevent index errors.

---

## Scoring Guide

**15/15: STL Master! 🏆**
Perfect score! You have excellent understanding of STL containers, algorithms, and practical applications. You're ready to build efficient C++ systems.

**12-14: Excellent! ⭐**
Strong knowledge of STL. Review the questions you missed to fill in small gaps.

**9-11: Good Foundation 👍**
You understand the basics well. Spend more time with map, algorithms, and practical scenarios. Review lessons 28-30.

**6-8: Needs Practice 📚**
The concepts are there, but you need more hands-on practice. Try implementing the resident management system yourself.

**Below 6: Review Required 🔄**
Go back and re-read Lesson 30. Focus on understanding each container type and when to use them. Practice with small examples before tackling complex scenarios.

---

**Key Takeaways:**
1. **Vector** = dynamic array with automatic memory management
2. **Map** = key-value pairs for fast lookups
3. **Set** = unique elements, automatically sorted
4. **Algorithms** = sort, find, count_if, copy_if for common operations
5. **Iterators** = universal way to traverse containers
6. **Lambdas** = inline functions for custom sorting and filtering

**Next:** Lesson 31 - Put everything together in a complete CRUD system!
