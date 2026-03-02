# C++ Activity: Pointers

Master the use of pointers to store memory addresses and manipulate data directly.

```cpp
#include <iostream>
using namespace std;

void updateFund(int* fundPtr, int amount) {
    // Your code here: Update the value at the address provided by fundPtr
}

int main() {
    int barangayFund = 5000;

    // Your code here: Create a pointer to barangayFund

    // Your code here: Call updateFund using the pointer

    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: Pointers, Memory Addresses, Dereferencing, Pass-by-pointer.

1.  **Implement `updateFund`**: The function should take a pointer to an integer (`fundPtr`) and an amount. It should add the amount to the value stored at the memory address pointed to by `fundPtr`.
2.  **Create a Pointer**: In `main`, declare an integer pointer (e.g., `int* ptr`) and initialize it with the address of `barangayFund`.
3.  **Modify via Pointer**: Call the `updateFund` function passing the pointer and an amount (e.g., `2000`).
4.  **Verify Change**: Print the final value of `barangayFund` to confirm it has been updated to `7000`.
    cout << "*ptr: " << *ptr << endl;
        return 0;
    }

````

**Expected:** Both show 1500 (they reference the same memory location!)

---

## Task 4: Pointers and Functions

**Context:** Pass pointers to functions to modify original variables.

**Challenge:** Create `deductFee(int* balance, int fee)` that actually changes the balance.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

void deductFee(int* balance, int fee) {
  *balance -= fee;  // Dereference to modify original
}

int main() {
  int myBalance = 1000;

  cout << "Initial balance: " << myBalance << endl;

  deductFee(&myBalance, 200);  // Pass address

  cout << "After deduction: " << myBalance << endl;

  return 0;
}
````

# Tasks for Learners

- Create a function `deductFee(int* balance, int fee)` that uses pointers to modify the original balance variable.

  ```cpp
  #include <iostream>
  using namespace std;

  void deductFee(int* balance, int fee) {
      *balance -= fee;  // Dereference to modify original
  }

  int main() {
      int myBalance = 1000;

      cout << "Initial balance: " << myBalance << endl;

      deductFee(&myBalance, 200);  // Pass address

      cout << "After deduction: " << myBalance << endl;

      return 0;
  }
  ```

**Expected:** Balance becomes 800

---

## Task 5: Null Pointers

**Context:** Pointers that don't point anywhere (yet).

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

int main() {
    int* ptr = nullptr;  // Modern C++ null pointer

    cout << "Pointer value: " << ptr << endl;

    if (ptr == nullptr) {
        cout << "Pointer is null (not pointing to anything)" << endl;
    }

    // DANGER: Dereferencing null pointer crashes!
    // cout << *ptr << endl;  // DON'T DO THIS!

    // Safe usage: check before dereferencing
    int value = 100;
    ptr = &value;

    if (ptr != nullptr) {
        cout << "Safe to dereference: " << *ptr << endl;
    }

    return 0;
}
```

# Tasks for Learners

- Learn to safely handle null pointers by always checking if a pointer is `nullptr` before dereferencing it.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int* ptr = nullptr;  // Modern C++ null pointer

      cout << "Pointer value: " << ptr << endl;

      if (ptr == nullptr) {
          cout << "Pointer is null (not pointing to anything)" << endl;
      }

      // DANGER: Dereferencing null pointer crashes!
      // cout << *ptr << endl;  // DON'T DO THIS!

      // Safe usage: check before dereferencing
      int value = 100;
      ptr = &value;

      if (ptr != nullptr) {
          cout << "Safe to dereference: " << *ptr << endl;
      }

      return 0;
  }
  ```

**Always check pointers before dereferencing!**

---

## Task 6: Pointer Arithmetic

**Context:** Move through arrays using pointer arithmetic.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

int main() {
    int grades[5] = {85, 92, 78, 88, 95};

    // Array name is a pointer to first element
    int* ptr = grades;

    cout << "Using array index:" << endl;
    for (int i = 0; i < 5; i++) {
        cout << grades[i] << " ";
    }
    cout << endl;

    cout << "Using pointer arithmetic:" << endl;
    for (int i = 0; i < 5; i++) {
        cout << *(ptr + i) << " ";  // ptr+i moves to next element
    }
    cout << endl;

    return 0;
}
```

# Tasks for Learners

- Use pointer arithmetic to traverse an array, demonstrating that `*(ptr + i)` accesses the same element as `grades[i]`.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int grades[5] = {85, 92, 78, 88, 95};

      // Array name is a pointer to first element
      int* ptr = grades;

      cout << "Using array index:" << endl;
      for (int i = 0; i < 5; i++) {
          cout << grades[i] << " ";
      }
      cout << endl;

      cout << "Using pointer arithmetic:" << endl;
      for (int i = 0; i < 5; i++) {
          cout << *(ptr + i) << " ";  // ptr+i moves to next element
      }
      cout << endl;

      return 0;
  }
  ```

**Expected:** Both methods print: 85 92 78 88 95

---

## Task 7: Common Pointer Dangers

**Context:** Learn what NOT to do with pointers.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

int main() {
    // DANGER 1: Dangling pointer
    int* ptr1;
    {
        int temp = 100;
        ptr1 = &temp;  // temp dies when block ends!
    }
    // cout << *ptr1;  // CRASH: temp doesn't exist anymore

    // DANGER 2: Wild pointer (uninitialized)
    // int* ptr2;  // Points to random memory!
    // cout << *ptr2;  // CRASH: random memory

    // SAFE: Always initialize
    int* ptr3 = nullptr;

    // DANGER 3: Dereferencing null
    // cout << *ptr3;  // CRASH: null has no value

    // SAFE: Check before use
    if (ptr3 != nullptr) {
        cout << *ptr3 << endl;
    } else {
        cout << "Pointer is null, can't dereference" << endl;
    }

    return 0;
}
```

# Tasks for Learners

- Learn to identify and avoid common pointer dangers: dangling pointers, wild pointers, and null pointer dereferencing.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      // DANGER 1: Dangling pointer
      int* ptr1;
      {
          int temp = 100;
          ptr1 = &temp;  // temp dies when block ends!
      }
      // cout << *ptr1;  // CRASH: temp doesn't exist anymore

      // DANGER 2: Wild pointer (uninitialized)
      // int* ptr2;  // Points to random memory!
      // cout << *ptr2;  // CRASH: random memory

      // SAFE: Always initialize
      int* ptr3 = nullptr;

      // DANGER 3: Dereferencing null
      // cout << *ptr3;  // CRASH: null has no value

      // SAFE: Check before use
      if (ptr3 != nullptr) {
          cout << *ptr3 << endl;
      } else {
          cout << "Pointer is null, can't dereference" << endl;
      }

      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Pointer Essentials</strong></summary>

**Syntax:**

```cpp
int x = 10;
int* ptr = &x;  // ptr stores address of x
cout << *ptr;   // Dereference: access value at address
```

**Operators:**

- `&` - Address-of operator: `&variable` gives address
- `*` - Dereference operator: `*pointer` accesses value
- `*` - Pointer declaration: `int* ptr`

**Key Concepts:**

- **Pointer:** Variable that stores a memory address
- **Dereferencing:** Accessing value at the address
- **nullptr:** Pointer pointing to nothing (safe null)

**Common Patterns:**

```cpp
// Swap using pointers
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Check before use
if (ptr != nullptr) {
    cout << *ptr;
}
```

**The Dangers:**

1. **Null pointer dereference:** `*ptr` when `ptr == nullptr` → CRASH
2. **Dangling pointer:** Pointing to deleted/freed memory → CRASH
3. **Wild pointer:** Uninitialized pointer → CRASH
4. **Memory leaks:** Forgetting to free allocated memory

**Golden Rules:**

- Always initialize pointers (`= nullptr` if not pointing yet)
- Always check `!= nullptr` before dereferencing
- Never dereference after deleting
- One `new` = one `delete` (we'll learn this in dynamic memory)

</details>

---

**Master pointers carefully:** They're powerful, but one mistake crashes your entire program. Always be defensive!
