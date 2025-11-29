# Quiz: Lesson 18 - Dynamic Memory Allocation

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Basic Dynamic Memory

### Question 1
What keyword allocates dynamic memory?

A) `malloc`  
B) `new`  
C) `create`  
D) `alloc`

**Answer: B) `new`**

**Explanation:**
```cpp
int* ptr = new int(10);  // Allocate on heap
delete ptr;              // Free memory
```

---

### Question 2
What's the difference?

```cpp
int x = 10;         // Statement A
int* ptr = new int(10);  // Statement B
```

A) No difference  
B) A is stack, B is heap  
C) A is heap, B is stack  
D) Both are stack

**Answer: B) A is stack, B is heap**

**Explanation:**
- **Stack:** Automatic, fast, limited size, auto-managed
- **Heap:** Dynamic, large, manual management (`new`/`delete`)

```cpp
int x = 10;              // Stack (automatic)
int* ptr = new int(10);  // Heap (manual)
delete ptr;              // Must free manually
```

---

### Question 3
What happens if you forget `delete`?

```cpp
int* ptr = new int(10);
// Forgot delete ptr;
```

A) Compilation error  
B) Memory leak  
C) Automatic cleanup  
D) Nothing wrong

**Answer: B) Memory leak**

**Explanation:**
Memory allocated with `new` is NOT automatically freed. Forgetting `delete` causes a **memory leak** — wasted memory that can't be reclaimed.

```cpp
void leak() {
    int* ptr = new int(10);
    // ❌ Memory leaked!
}

for (int i = 0; i < 1000; i++) {
    leak();  // Leaks 1000 times!
}
```

---

### Question 4
What's the correct way to delete an array?

```cpp
int* arr = new int[5];
// How to delete?
```

A) `delete arr;`  
B) `delete[] arr;`  
C) `free(arr);`  
D) `delete arr[];`

**Answer: B) `delete[] arr;`**

**Explanation:**
| Allocation | Deallocation |
|------------|--------------|
| `new` | `delete` |
| `new[]` | `delete[]` |

```cpp
int* single = new int(10);
delete single;  // No brackets

int* array = new int[5];
delete[] array;  // With brackets
```

---

### Question 5
What's wrong with this code?

```cpp
int* ptr = new int(10);
delete ptr;
cout << *ptr;
```

A) Nothing wrong  
B) Dangling pointer (accessing freed memory)  
C) Memory leak  
D) Wrong delete syntax

**Answer: B) Dangling pointer (accessing freed memory)**

**Explanation:**
After `delete ptr`, the memory is freed. Accessing `*ptr` is **undefined behavior** (crash, garbage, or worse).

**Fix:**
```cpp
int* ptr = new int(10);
delete ptr;
ptr = nullptr;  // ✓ Set to null

if (ptr != nullptr) {
    cout << *ptr;  // Won't execute
}
```

---

## Section 2: Arrays and Memory Management

### Question 6
What's the output?

```cpp
int size = 3;
int* arr = new int[size];

arr[0] = 10;
arr[1] = 20;
arr[2] = 30;

cout << arr[1];
delete[] arr;
```

A) `10`  
B) `20`  
C) `30`  
D) Compilation error

**Answer: B) `20`**

**Explanation:**
Dynamic arrays work like regular arrays with `[]` indexing.

```cpp
arr[0] = 10;
arr[1] = 20;  // Second element
arr[2] = 30;

cout << arr[1];  // 20
```

---


# Quiz 2

### Question 7
Can array size be determined at runtime?

```cpp
int n;
cin >> n;
int* arr = new int[n];  // Valid?
```

A) Yes, with dynamic memory  
B) No, size must be constant  
C) Only for small sizes  
D) Syntax error

**Answer: A) Yes, with dynamic memory**

**Explanation:**
**Dynamic arrays** can have runtime-determined sizes:

```cpp
int numResidents;
cout << "How many residents? ";
cin >> numResidents;

string* names = new string[numResidents];  // ✓ Size from user
// Use array...
delete[] names;
```

**Static arrays** need compile-time constants:
```cpp
const int SIZE = 10;
int arr[SIZE];  // ✓ Constant size

int n = 10;
int arr[n];  // ❌ Not standard C++ (some compilers allow)
```

---

### Question 8
What happens here?

```cpp
int* ptr = new int(10);
delete ptr;
delete ptr;  // Delete again
```

A) Memory freed twice (safe)  
B) Undefined behavior (crash likely)  
C) Compilation error  
D) No effect

**Answer: B) Undefined behavior (crash likely)**

**Explanation:**
**Double delete** is a serious bug! Second `delete` tries to free already-freed memory.

**Fix:**
```cpp
int* ptr = new int(10);
delete ptr;
ptr = nullptr;  // ✓ Safe

delete ptr;  // Safe (deleting nullptr does nothing)
```

---

### Question 9
How do you check if allocation succeeded?

```cpp
int* ptr = new(nothrow) int[1000000000];
// What next?
```

A) Always succeeds  
B) Check if `ptr == nullptr`  
C) Check if `ptr == 0`  
D) Cannot check

**Answer: B) Check if `ptr == nullptr`**

**Explanation:**
```cpp
int* ptr = new(nothrow) int[1000000000];  // Large allocation

if (ptr == nullptr) {
    cout << "Allocation failed!" << endl;
} else {
    // Use ptr
    delete[] ptr;
}
```

**Without `nothrow`:** `new` throws `std::bad_alloc` exception on failure.

---


# Quiz 1

### Question 10
A barangay system needs to store resident names. The number is unknown until runtime. Which is best?

```cpp
// Option A: Fixed-size array
string residents[100];

// Option B: Dynamic array
int n;
cin >> n;
string* residents = new string[n];
// ... use ...
delete[] residents;

// Option C: Vector (STL)
#include <vector>
vector<string> residents(n);
```

A) Option A  
B) Option B  
C) Option C  
D) B and C are both good

**Answer: D) B and C are both good (C is better)**

**Explanation:**
- **Option A:** ❌ Wastes memory if fewer residents; fails if more than 100
- **Option B:** ✓ Allocates exact amount needed; must manage memory manually
- **Option C:** ✓ Best! Automatic memory management, can resize, safer

**Option B usage:**
```cpp
int n;
cin >> n;
string* residents = new string[n];

for (int i = 0; i < n; i++) {
    getline(cin, residents[i]);
}

delete[] residents;  // Must remember to delete
```

**Option C usage (best):**
```cpp
#include <vector>

int n;
cin >> n;
vector<string> residents(n);

for (int i = 0; i < n; i++) {
    getline(cin, residents[i]);
}
// No delete needed! Automatic cleanup
```

---

## Section 3: Advanced Memory Concepts

### Question 11
What's wrong?

```cpp
int x = 10;
int* ptr = &x;
delete ptr;
```

A) Nothing wrong  
B) Cannot delete stack memory  
C) Missing brackets  
D) Wrong pointer type

**Answer: B) Cannot delete stack memory**

**Explanation:**
`x` is on the **stack** (automatic storage). Only heap memory (allocated with `new`) can be deleted.

```cpp
// ❌ WRONG
int x = 10;
delete &x;  // CRASH! x is on stack

// ✓ CORRECT
int* ptr = new int(10);  // Heap
delete ptr;  // OK
```

---


# Quiz 1

### Question 12
Which is a memory leak?

```cpp
// Option A
void funcA() {
    int* ptr = new int(10);
    delete ptr;
}

// Option B
void funcB() {
    int* ptr = new int(10);
    // No delete
}

// Option C
void funcC() {
    int x = 10;
}
```

A) Option A  
B) Option B  
C) Option C  
D) All of them

**Answer: B) Option B**

**Explanation:**
- **Option A:** ✓ No leak (memory freed)
- **Option B:** ❌ Memory leak! Allocated but never freed
- **Option C:** ✓ No leak (stack memory, auto-managed)

```cpp
void funcB() {
    int* ptr = new int(10);
    // When function ends, ptr goes out of scope
    // But the heap memory is still allocated!
    // Memory leaked ❌
}
```

---


# Quiz 1

### Question 13
How do you allocate a 2D array dynamically?

```cpp
int rows = 3, cols = 4;
// Allocate 3x4 matrix
```

A) `int** matrix = new int[rows][cols];`  
B) `int** matrix = new int*[rows];` then allocate each row  
C) Cannot allocate 2D arrays dynamically  
D) `int* matrix = new int[rows, cols];`

**Answer: B) `int** matrix = new int*[rows];` then allocate each row**

**Explanation:**
```cpp
int rows = 3, cols = 4;

// Allocate array of pointers
int** matrix = new int*[rows];

// Allocate each row
for (int i = 0; i < rows; i++) {
    matrix[i] = new int[cols];
}

// Use matrix
matrix[0][0] = 1;
matrix[1][2] = 5;

// Deallocate
for (int i = 0; i < rows; i++) {
    delete[] matrix[i];  // Delete each row
}
delete[] matrix;  // Delete pointer array
```

---


# Quiz 1

### Question 14
What's the output?

```cpp
int* ptr1 = new int(10);
int* ptr2 = ptr1;

delete ptr1;
ptr1 = nullptr;

cout << *ptr2;  // What happens?
```

A) `10`  
B) `0`  
C) Undefined behavior  
D) Compilation error

**Answer: C) Undefined behavior**

**Explanation:**
Both `ptr1` and `ptr2` point to the same memory. After `delete ptr1`, the memory is freed. `ptr2` becomes a **dangling pointer**.

```cpp
int* ptr1 = new int(10);
int* ptr2 = ptr1;  // Both point to same memory

delete ptr1;       // Memory freed
ptr1 = nullptr;    // ptr1 is safe now

// But ptr2 still points to freed memory!
cout << *ptr2;  // ❌ Undefined behavior
```

**Fix:**
```cpp
delete ptr1;
ptr1 = nullptr;
ptr2 = nullptr;  // ✓ Both safe
```

---


# Quiz 1

### Question 15
Why prefer smart pointers over raw pointers?

```cpp
// Raw pointer
int* ptr = new int(10);
// Must remember to delete
delete ptr;

// Smart pointer
std::unique_ptr<int> ptr = std::make_unique<int>(10);
// Automatic cleanup!
```

A) Smart pointers are faster  
B) Smart pointers automatically manage memory  
C) Smart pointers use less memory  
D) No difference

**Answer: B) Smart pointers automatically manage memory**

**Explanation:**
**Raw pointers:**
- Manual memory management
- Risk of memory leaks
- Risk of dangling pointers
- Error-prone

**Smart pointers:**
- ✓ Automatic cleanup (RAII)
- ✓ No memory leaks
- ✓ Exception-safe
- ✓ Modern C++ best practice

```cpp
#include <memory>

void process() {
    std::unique_ptr<int> ptr = std::make_unique<int>(10);
    
    // Use ptr...
    
    // No delete needed! Automatically freed when
    // ptr goes out of scope
}
```

---

**Score yourself:**
- 15/15: Memory Management Master! 🎯
- 12-14: Excellent!
- 9-11: Good, review delete[] and memory leaks
- Below 9: Re-read dynamic memory concepts

**Key Concepts:**
1. `new` allocates heap memory, `delete` frees it
2. `new[]` requires `delete[]`
3. Always pair allocation with deallocation
4. Forgetting delete = memory leak
5. Using after delete = dangling pointer
6. Set pointers to `nullptr` after deleting
7. Prefer smart pointers in modern C++
