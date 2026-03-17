# Lesson 18: Dynamic Memory Allocation

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+18.0+-+COVER.png)

## Scene

Tian's resident tracking system had a fatal flaw -- the array was hardcoded for 100 residents. When the barangay grew to 150, the program could not handle it. "Kuya, real apps don't ask users to recompile for more data. How do programs handle unknown amounts?"

Kuya Miguel grinned. "Welcome to **dynamic memory allocation**. Instead of deciding array sizes at compile time, you allocate memory at runtime based on actual needs."

"But there's a catch," he warned. "When the computer gives you memory, you must give it back when done -- or face memory leaks, where your program slowly consumes all available RAM."

## C++ Topics: Heap Allocation with new and delete

![18.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+18.1.png)

### Stack vs Heap

> Stack memory is automatic and fixed at compile time. Heap memory is allocated at runtime using `new` and must be manually freed with `delete`.

### Allocating Arrays

> Use `new dataType[size]` to create a dynamic array. The size can be a variable determined at runtime, unlike fixed stack arrays.

### Deallocating Memory

> Every `new` must have a matching `delete`. For arrays, use `delete[]`. Forgetting to free memory causes memory leaks.

### Dangling Pointers

> After deleting memory, set the pointer to `nullptr` to avoid accessing freed memory, which causes undefined behavior.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    int size = 5;
    int* ages = new int[size];  // Allocate on heap

    for (int i = 0; i < size; i++) {
        ages[i] = (i + 1) * 10;
    }

    cout << "Ages: ";
    for (int i = 0; i < size; i++) {
        cout << ages[i] << " ";
    }
    cout << endl;

    delete[] ages;     // Free memory
    ages = nullptr;    // Prevent dangling pointer
    return 0;
}
```

The `new int[size]` allocates an array on the heap whose size is determined at runtime. After use, `delete[]` frees the memory and setting the pointer to `nullptr` prevents accidental access to freed memory.
