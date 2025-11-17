# Lesson 18: Dynamic Memory Allocation with `new` and `delete`

**Estimated Reading Time:** 13 minutes

---

## The Story

"Kuya, what if I don't know how many residents I'll have? Arrays have fixed sizes!"

Kuya Miguel smiled. "That's where **dynamic memory** comes in. Instead of declaring fixed-size arrays at compile time, you can allocate memory **at runtime** — exactly as much as you need."

---

## Stack vs Heap Memory

### Stack Memory (Automatic)
- Variables declared normally
- Fixed size, determined at compile time
- Automatically managed (created/destroyed)
- Fast but limited size

```cpp
int age = 25;           // Stack
int scores[100];        // Stack (fixed size)
```

### Heap Memory (Dynamic)
- Allocated using `new`
- Size can be determined at runtime
- **Manually managed** (you must `delete`)
- Slower but much larger

```cpp
int* ptr = new int(25);      // Heap
int* scores = new int[n];    // Heap (size determined at runtime)
```

---

## Allocating Single Variables

### Syntax
```cpp
dataType* pointer = new dataType;
dataType* pointer = new dataType(initialValue);
```

### Examples
```cpp
int* age = new int;        // Uninitialized
*age = 25;

int* balance = new int(1000);  // Initialized to 1000
cout << *balance;              // 1000

double* price = new double(49.99);
string* name = new string("Juan Dela Cruz");
```

---

## Deallocating Memory

**You MUST free memory** allocated with `new` using `delete`:

```cpp
int* ptr = new int(10);
cout << *ptr;
delete ptr;  // Free memory
```

**Failure to `delete` causes memory leaks!**

---

## Allocating Arrays

### Syntax
```cpp
dataType* pointer = new dataType[size];
```

### Examples
```cpp
int size = 5;
int* scores = new int[size];  // Dynamic array

// Use like normal array
scores[0] = 85;
scores[1] = 90;
scores[2] = 78;

// Must delete array
delete[] scores;  // Note the []
```

---

## `delete` vs `delete[]`

| Allocation | Deallocation |
|------------|--------------|
| `new` | `delete` |
| `new[]` | `delete[]` |

```cpp
int* single = new int(10);
delete single;  // No brackets

int* array = new int[5];
delete[] array;  // With brackets []
```

**Using wrong one causes undefined behavior!**

---

## Practical Example: Dynamic Resident Array

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    int numResidents;
    cout << "How many residents? ";
    cin >> numResidents;
    
    // Allocate dynamic arrays
    string* names = new string[numResidents];
    int* ages = new int[numResidents];
    
    // Input
    cin.ignore();
    for (int i = 0; i < numResidents; i++) {
        cout << "\nResident " << (i + 1) << ":\n";
        cout << "Name: ";
        getline(cin, names[i]);
        cout << "Age: ";
        cin >> ages[i];
        cin.ignore();
    }
    
    // Display
    cout << "\n===== RESIDENT LIST =====\n";
    for (int i = 0; i < numResidents; i++) {
        cout << names[i] << " (Age " << ages[i] << ")\n";
    }
    
    // Clean up
    delete[] names;
    delete[] ages;
    
    cout << "Memory freed!" << endl;
    return 0;
}
```

---

## Memory Leaks

**Memory leak:** Allocated memory that is never freed.

```cpp
void leak() {
    int* ptr = new int(10);
    // ❌ Forgot to delete!
}  // ptr goes out of scope, but memory still allocated

int main() {
    for (int i = 0; i < 1000; i++) {
        leak();  // Leaks memory 1000 times!
    }
    return 0;
}
```

**Fix:**
```cpp
void noLeak() {
    int* ptr = new int(10);
    delete ptr;  // ✓ Memory freed
}
```

---

## Dangling Pointers

**Dangling pointer:** Pointer to memory that has been freed.

```cpp
int* ptr = new int(10);
delete ptr;  // Memory freed

cout << *ptr;  // ❌ DANGER! Accessing freed memory (undefined behavior)
```

**Best practice:** Set to `nullptr` after deleting:
```cpp
int* ptr = new int(10);
delete ptr;
ptr = nullptr;  // ✓ Safe

if (ptr != nullptr) {
    cout << *ptr;  // Won't execute
}
```

---

## Double Delete

**Never delete the same memory twice:**

```cpp
int* ptr = new int(10);
delete ptr;
delete ptr;  // ❌ CRASH! Double delete

// ✓ SAFE
int* ptr = new int(10);
delete ptr;
ptr = nullptr;
delete ptr;  // Safe (deleting nullptr does nothing)
```

---

## Checking Allocation Success

`new` can fail if memory is exhausted:

```cpp
int* ptr = new(nothrow) int[1000000000];  // Very large allocation

if (ptr == nullptr) {
    cout << "Allocation failed!" << endl;
} else {
    // Use ptr
    delete[] ptr;
}
```

**Without `nothrow`:** `new` throws exception on failure (more common in modern C++).

---

## Dynamic 2D Arrays

### Method 1: Array of Pointers

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
delete[] matrix;  // Delete array of pointers
```

### Method 2: Single Contiguous Block (More Efficient)

```cpp
int rows = 3, cols = 4;
int* matrix = new int[rows * cols];

// Access as 2D: matrix[row * cols + col]
matrix[1 * cols + 2] = 5;  // Row 1, Col 2

delete[] matrix;
```

---

## Resizing Arrays (Manual)

C++ arrays **cannot be resized**. You must allocate new memory and copy:

```cpp
int oldSize = 3;
int* oldArray = new int[oldSize]{10, 20, 30};

int newSize = 5;
int* newArray = new int[newSize];

// Copy old data
for (int i = 0; i < oldSize; i++) {
    newArray[i] = oldArray[i];
}

// Initialize new elements
newArray[3] = 40;
newArray[4] = 50;

// Free old memory
delete[] oldArray;

// Use newArray
for (int i = 0; i < newSize; i++) {
    cout << newArray[i] << " ";
}

delete[] newArray;
```

**Better:** Use `std::vector` (automatic resizing).

---

## Smart Pointers (Preview)

Modern C++ has **smart pointers** that automatically manage memory:

```cpp
#include <memory>

// unique_ptr: sole owner
std::unique_ptr<int> ptr = std::make_unique<int>(10);
// No need to delete! Automatically freed

// shared_ptr: shared ownership
std::shared_ptr<int> ptr1 = std::make_shared<int>(20);
std::shared_ptr<int> ptr2 = ptr1;  // Both own it
// Freed when last owner goes out of scope
```

**Smart pointers prevent memory leaks!** (Covered in advanced C++.)

---

## Practical Example: Dynamic Barangay Fund Tracker

```cpp
#include <iostream>
using namespace std;

int main() {
    int numTransactions;
    cout << "How many transactions? ";
    cin >> numTransactions;
    
    // Dynamic arrays
    double* amounts = new double[numTransactions];
    char* types = new char[numTransactions];  // 'D' = deposit, 'W' = withdrawal
    
    double balance = 5000.0;
    cout << "Initial balance: P" << balance << "\n\n";
    
    // Input transactions
    for (int i = 0; i < numTransactions; i++) {
        cout << "Transaction " << (i + 1) << ":\n";
        cout << "Type (D/W): ";
        cin >> types[i];
        cout << "Amount: P";
        cin >> amounts[i];
        
        if (types[i] == 'D' || types[i] == 'd') {
            balance += amounts[i];
        } else {
            balance -= amounts[i];
        }
    }
    
    // Display report
    cout << "\n===== TRANSACTION REPORT =====\n";
    for (int i = 0; i < numTransactions; i++) {
        cout << "Transaction " << (i + 1) << ": ";
        if (types[i] == 'D' || types[i] == 'd') {
            cout << "Deposit P" << amounts[i] << endl;
        } else {
            cout << "Withdrawal P" << amounts[i] << endl;
        }
    }
    cout << "==============================\n";
    cout << "Final balance: P" << balance << endl;
    
    // Clean up
    delete[] amounts;
    delete[] types;
    
    return 0;
}
```

---

## Best Practices

### 1. Always Pair `new` with `delete`
```cpp
int* ptr = new int(10);
// ... use ptr ...
delete ptr;
```

### 2. Set to `nullptr` After Deleting
```cpp
delete ptr;
ptr = nullptr;
```

### 3. Check for `nullptr` Before Using
```cpp
if (ptr != nullptr) {
    cout << *ptr;
}
```

### 4. Use `delete[]` for Arrays
```cpp
int* arr = new int[5];
delete[] arr;  // Not delete arr
```

### 5. Consider Smart Pointers (Modern C++)
```cpp
std::unique_ptr<int> ptr = std::make_unique<int>(10);
// Automatic cleanup!
```

---

## Common Mistakes

### Mistake 1: Forgetting to Delete
```cpp
void process() {
    int* data = new int[1000];
    // ... use data ...
    // ❌ Forgot delete[] data;
}  // Memory leaked!
```

### Mistake 2: Wrong Delete Operator
```cpp
int* arr = new int[5];
delete arr;  // ❌ Should be delete[]
```

### Mistake 3: Using After Delete
```cpp
int* ptr = new int(10);
delete ptr;
cout << *ptr;  // ❌ Dangling pointer!
```

### Mistake 4: Deleting Stack Memory
```cpp
int x = 10;
int* ptr = &x;
delete ptr;  // ❌ CRASH! x is on stack, not heap
```

### Mistake 5: Memory Leak in Loop
```cpp
for (int i = 0; i < 100; i++) {
    int* temp = new int(i);
    // ❌ Never deleted!
}
```

---

## When to Use Dynamic Memory

**Use dynamic memory when:**
- ✓ Size unknown at compile time
- ✓ Need large amounts of memory (heap is bigger than stack)
- ✓ Creating data structures (linked lists, trees)
- ✓ Need lifetime beyond function scope

**Avoid when:**
- ❌ Size is known and small (use stack/arrays)
- ❌ Can use `std::vector` instead (safer!)
- ❌ Adds unnecessary complexity

---

## Summary

Tian practiced with dynamic arrays. "So I can create arrays of any size at runtime!"

"Exactly!" Kuya Miguel said. "But remember:
- **Stack** — automatic, fast, limited
- **Heap** — dynamic, large, manual management
- **`new`** allocates, **`delete`** frees
- **`new[]`** requires **`delete[]`**
- Always free memory or you get **memory leaks**
- Set pointers to `nullptr` after deleting"

"Next," Kuya Miguel announced, "we enter Chapter 2: **Structuring the Battlefield** — combining data with **structs**!"

---

**Key Takeaways:**
1. Use `new` to allocate heap memory
2. Use `delete` (or `delete[]`) to free memory
3. Always pair allocation with deallocation
4. Set pointers to `nullptr` after deleting
5. Memory leaks = allocated memory never freed

**Next Lesson:** Structs - Grouping Related Data
