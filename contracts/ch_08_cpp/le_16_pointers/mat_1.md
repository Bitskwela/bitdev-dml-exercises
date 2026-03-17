# Pointers

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+16.0+-+COVER.png)

## Scene

"Why is my program crashing?" Tian stared at the error: `Segmentation fault (core dumped)`. After trying to optimize memory usage, everything broke.

Kuya Miguel examined the code. "You're accessing memory you don't own. Welcome to **pointers** -- the most powerful and most dangerous feature in C++. Pointers give you direct control over memory. Get it right, and you build incredibly efficient systems. Get it wrong, and you face crashes and data corruption."

"Think of memory like a massive storage facility," Kuya Miguel explained. "Normally you just ask for 'the box labeled age.' With pointers, you're saying 'I want the physical address of box 1034 and I'll access it directly.' This level of control is what makes C++ so fast. Every advanced concept builds on pointers. Ready?"

## C++ Topics: Pointers

![16.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+16.1.png)

### Declaring Pointers

> A pointer stores a **memory address**, not a value. Declare with `int* ptr;`. The `*` marks it as a pointer to an `int`.

### Address-Of Operator (`&`)

> The `&` operator gets the memory address of a variable: `int* ptr = &age;` makes `ptr` point to where `age` is stored in memory.

### Dereference Operator (`*`)

> The `*` operator accesses the value at a pointer's address: `*ptr` reads or writes the value that `ptr` points to.

### Null Pointers

> Always initialize pointers to `nullptr` if they don't point anywhere yet. Check `if (ptr != nullptr)` before dereferencing to avoid crashes.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

void updateFund(int* fundPtr, int amount) {
    if (fundPtr != nullptr) {
        *fundPtr += amount;  // Dereference to modify original
    }
}

int main() {
    int barangayFund = 5000;
    int* ptr = &barangayFund;    // ptr stores address of barangayFund

    updateFund(ptr, 2000);       // Pass pointer to function
    cout << "Final Fund value: " << barangayFund << endl;
    return 0;
}
```

`ptr` holds the address of `barangayFund`. Inside `updateFund`, `*fundPtr += amount` dereferences the pointer to modify the original variable. The `nullptr` check prevents crashes if the pointer is null.
