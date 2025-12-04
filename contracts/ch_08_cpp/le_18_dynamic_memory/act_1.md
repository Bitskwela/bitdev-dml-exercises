# Lesson 18 Activities: Dynamic Memory

## The 100-Resident Problem

Tian hardcoded an array:
```cpp
string residents[100];
```

But the barangay had **120 residents**. He changed it to 200. Next year? 250. **The array kept growing!**

**Dynamic memory solves this.** Instead of fixed sizes at compile time, allocate memory at **runtime** based on actual needs. Use the **heap** (grows dynamically) instead of the **stack** (fixed size).

---

## Task 1: Stack vs Heap

**Context:** Understand the two memory regions.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // STACK: Fixed size, automatic cleanup
    int stackArray[5] = {1, 2, 3, 4, 5};
    
    cout << "Stack array:" << endl;
    for (int i = 0; i < 5; i++) {
        cout << stackArray[i] << " ";
    }
    cout << endl;
    
    // HEAP: Dynamic size, manual cleanup
    int size;
    cout << "How many elements? ";
    cin >> size;
    
    int* heapArray = new int[size];  // Allocate on heap
    
    cout << "Enter " << size << " values:" << endl;
    for (int i = 0; i < size; i++) {
        cin >> heapArray[i];
    }
    
    cout << "Heap array:" << endl;
    for (int i = 0; i < size; i++) {
        cout << heapArray[i] << " ";
    }
    cout << endl;
    
    delete[] heapArray;  // MUST free memory!
    
    return 0;
}
```

**Key:** Stack is automatic. Heap requires `new` and `delete`.

---

## Task 2: Dynamic Single Value

**Context:** Allocate individual variables dynamically.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Allocate single int on heap
    int* ptr = new int;
    
    *ptr = 100;
    cout << "Value: " << *ptr << endl;
    cout << "Address: " << ptr << endl;
    
    delete ptr;  // Free memory
    ptr = nullptr;  // Good practice: prevent dangling pointer
    
    return 0;
}
```

**Task:** Create a dynamic double. Assign a value. Print it. Delete it.

---

## Task 3: Dynamic Arrays

**Context:** Create arrays of any size at runtime.

**Challenge:** Let user decide array size.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int numStudents;
    cout << "How many students? ";
    cin >> numStudents;
    
    // Dynamic array
    int* grades = new int[numStudents];
    
    // Input grades
    for (int i = 0; i < numStudents; i++) {
        cout << "Student " << (i+1) << " grade: ";
        cin >> grades[i];
    }
    
    // Calculate average
    double sum = 0;
    for (int i = 0; i < numStudents; i++) {
        sum += grades[i];
    }
    double average = sum / numStudents;
    
    cout << "Average: " << average << endl;
    
    delete[] grades;  // Free array (use delete[] for arrays!)
    
    return 0;
}
```

**Critical:** `delete[]` for arrays, `delete` for single values!

---

## Task 4: Memory Leaks

**Context:** Forgetting to delete causes memory leaks.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

void badFunction() {
    int* leak = new int[1000];
    // OOPS! Forgot delete[]
    // Memory is lost forever (until program ends)
}

void goodFunction() {
    int* data = new int[1000];
    // ... use data ...
    delete[] data;  // Properly freed
}

int main() {
    cout << "Calling badFunction 100 times (memory leak!)..." << endl;
    for (int i = 0; i < 100; i++) {
        badFunction();  // Leaks 1000 ints each time!
    }
    
    cout << "Calling goodFunction 100 times (no leak)..." << endl;
    for (int i = 0; i < 100; i++) {
        goodFunction();  // Properly managed
    }
    
    cout << "Done. Check Task Manager for memory usage!" << endl;
    
    return 0;
}
```

**Rule:** Every `new` must have exactly one `delete`. No more, no less!

---

## Task 5: Resizing Array

**Context:** Simulate dynamic resizing (like vector does internally).

**Challenge:** Double array size when full.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int capacity = 2;
    int size = 0;
    int* arr = new int[capacity];
    
    cout << "Enter numbers (0 to stop):" << endl;
    
    while (true) {
        int value;
        cin >> value;
        
        if (value == 0) break;
        
        // Check if full
        if (size == capacity) {
            cout << "Array full! Resizing from " << capacity << " to " << (capacity * 2) << endl;
            
            // Create bigger array
            capacity *= 2;
            int* newArr = new int[capacity];
            
            // Copy old data
            for (int i = 0; i < size; i++) {
                newArr[i] = arr[i];
            }
            
            // Free old array
            delete[] arr;
            
            // Point to new array
            arr = newArr;
        }
        
        arr[size] = value;
        size++;
    }
    
    cout << "\nStored values:" << endl;
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
    
    delete[] arr;
    
    return 0;
}
```

**This is how `vector` works behind the scenes!**

---

## Task 6: Dynamic 2D Array

**Context:** Create dynamic multidimensional arrays.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int rows, cols;
    
    cout << "Enter rows: ";
    cin >> rows;
    cout << "Enter columns: ";
    cin >> cols;
    
    // Allocate 2D array
    int** matrix = new int*[rows];  // Array of pointers
    for (int i = 0; i < rows; i++) {
        matrix[i] = new int[cols];  // Each row is an array
    }
    
    // Fill matrix
    cout << "Enter values:" << endl;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cout << "matrix[" << i << "][" << j << "]: ";
            cin >> matrix[i][j];
        }
    }
    
    // Display matrix
    cout << "\nMatrix:" << endl;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }
    
    // Free memory (must delete each row, then array of rows)
    for (int i = 0; i < rows; i++) {
        delete[] matrix[i];
    }
    delete[] matrix;
    
    return 0;
}
```

---

## Task 7: Barangay Resident System

**Context:** Real-world dynamic memory—resize as residents register.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    int capacity = 5;
    int count = 0;
    string* residents = new string[capacity];
    
    cout << "=== BARANGAY RESIDENT SYSTEM ===" << endl;
    cout << "Enter resident names (empty to stop):" << endl;
    
    while (true) {
        string name;
        cout << "Resident " << (count + 1) << ": ";
        getline(cin, name);
        
        if (name.empty()) break;
        
        // Resize if needed
        if (count == capacity) {
            cout << "[System: Expanding capacity to " << (capacity * 2) << "]" << endl;
            
            int newCapacity = capacity * 2;
            string* newArray = new string[newCapacity];
            
            for (int i = 0; i < count; i++) {
                newArray[i] = residents[i];
            }
            
            delete[] residents;
            residents = newArray;
            capacity = newCapacity;
        }
        
        residents[count] = name;
        count++;
    }
    
    cout << "\n=== REGISTERED RESIDENTS ===" << endl;
    for (int i = 0; i < count; i++) {
        cout << (i + 1) << ". " << residents[i] << endl;
    }
    
    cout << "Total: " << count << " residents" << endl;
    
    delete[] residents;
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Dynamic Memory Reference</strong></summary>

**Allocation:**
```cpp
int* ptr = new int;           // Single value
int* arr = new int[size];     // Array
```

**Deallocation:**
```cpp
delete ptr;      // Single value
delete[] arr;    // Array (note the [])
```

**Stack vs Heap:**

| Stack | Heap |
|-------|------|
| Fixed size at compile time | Dynamic size at runtime |
| Fast allocation | Slower allocation |
| Automatic cleanup | Manual cleanup (new/delete) |
| Limited size (~1-8MB) | Large size (GBs available) |
| Local variables | Dynamic allocation |

**Memory Leak Prevention:**
1. Every `new` needs one `delete`
2. Use `delete[]` for arrays, `delete` for single values
3. Set pointer to `nullptr` after delete
4. Use smart pointers in modern C++ (advanced)

**Common Mistakes:**
```cpp
// ❌ Memory leak
int* ptr = new int;
// Forgot delete!

// ❌ Double delete
delete ptr;
delete ptr;  // CRASH!

// ❌ Wrong delete type
int* arr = new int[10];
delete arr;  // Should be delete[]

// ✅ Correct
int* ptr = new int;
delete ptr;
ptr = nullptr;
```

**When to Use Dynamic Memory:**
- Size unknown at compile time
- Large data structures
- Lifetime beyond function scope
- Implementing data structures (linked lists, trees)

</details>

---

**Remember:** With great power (dynamic memory) comes great responsibility (manual cleanup)! Every `new` = one `delete`!
