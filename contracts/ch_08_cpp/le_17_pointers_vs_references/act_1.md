# C++ Activity: Pointers vs. References

Compare the syntax and behavior of pointers and references when modifying variables.

```cpp
#include <iostream>
using namespace std;

void addTenPtr(int* ptr) {
    // Your code here: Add 10 using pointer dereferencing
}

void addTenRef(int& ref) {
    // Your code here: Add 10 using a reference
}

int main() {
    int value1 = 100;
    int value2 = 100;

    // Call addTenPtr
    // Call addTenRef

    cout << "Value 1: " << value1 << endl;
    cout << "Value 2: " << value2 << endl;

    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: Pointers, References, Memory Aliases, Function Parameters.

1. **Implement `addTenPtr`**: Use the pointer `ptr` to add 10 to the original variable. Remember to dereference the pointer using `*`.
2. **Implement `addTenRef`**: Use the reference `ref` to add 10 to the original variable. Notice that no special syntax is needed inside the function.
3. **Call functions in `main`**:
   - Call `addTenPtr` by passing the address of `value1` (use `&`).
   - Call `addTenRef` by passing `value2` directly.
4. **Verify Output**: Both `value1` and `value2` should result in `110`.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

// Use reference: simple pass-by-reference
void updateBalance(double& balance, double amount) {
    balance += amount;
}

// Use pointer: might be null (optional parameter)
void displayName(string* name) {
    if (name != nullptr) {
        cout << "Name: " << *name << endl;
    } else {
        cout << "No name provided" << endl;
    }
}

// Use pointer: need to reassign
void reassignValue(int* ptr, int newValue) {
    ptr = &newValue;  // Can change what pointer points to
}

int main() {
    double myBalance = 1000.0;
    updateBalance(myBalance, 500.0);
    cout << "Balance: " << myBalance << endl;

    string myName = "Juan";
    displayName(&myName);  // Pass address
    displayName(nullptr);   // Pass null (optional)

    return 0;
}
```

# Tasks for Learners

- Demonstrate when to use references versus pointers by implementing functions for different use cases: simple pass-by-reference, optional parameters, and pointer reassignment.

  ```cpp
  #include <iostream>
  using namespace std;

  // Use reference: simple pass-by-reference
  void updateBalance(double& balance, double amount) {
      balance += amount;
  }

  // Use pointer: might be null (optional parameter)
  void displayName(string* name) {
      if (name != nullptr) {
          cout << "Name: " << *name << endl;
      } else {
          cout << "No name provided" << endl;
      }
  }

  // Use pointer: need to reassign
  void reassignValue(int* ptr, int newValue) {
      ptr = &newValue;  // Can change what pointer points to
  }

  int main() {
      double myBalance = 1000.0;
      updateBalance(myBalance, 500.0);
      cout << "Balance: " << myBalance << endl;

      string myName = "Juan";
      displayName(&myName);  // Pass address
      displayName(nullptr);   // Pass null (optional)

      return 0;
  }
  ```

---

## Task 4: Const References for Efficiency

**Context:** Pass large objects without copying, but prevent modification.

**Challenge:** Pass strings efficiently to display function.

**Starter Code:**

```cpp
#include <iostream>
#include <string>
using namespace std;

// Const reference: read-only, no copy
void displayResident(const string& name, const string& address) {
    cout << "Resident: " << name << endl;
    cout << "Address: " << address << endl;

    // name = "Changed";  // ERROR: can't modify const reference
}

int main() {
    string residentName = "Maria Santos";
    string residentAddress = "123 Main St, Iloilo City";

    displayResident(residentName, residentAddress);

    return 0;
}
```

# Tasks for Learners

- Pass strings efficiently to a display function using const references to avoid copying while preventing modification.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  // Const reference: read-only, no copy
  void displayResident(const string& name, const string& address) {
      cout << "Resident: " << name << endl;
      cout << "Address: " << address << endl;

      // name = "Changed";  // ERROR: can't modify const reference
  }

  int main() {
      string residentName = "Maria Santos";
      string residentAddress = "123 Main St, Iloilo City";

      displayResident(residentName, residentAddress);

      return 0;
  }
  ```

**Why?** Passing by value copies the string (expensive!). Const reference avoids the copy but prevents modification.

---

## Task 5: Swap Function Comparison

**Context:** Implement swap using both pointers and references.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

// Using pointers
void swapPtr(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Using references
void swapRef(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

int main() {
    int x1 = 10, y1 = 20;
    int x2 = 10, y2 = 20;

    cout << "Before swap:" << endl;
    cout << "x1=" << x1 << " y1=" << y1 << endl;
    cout << "x2=" << x2 << " y2=" << y2 << endl;

    swapPtr(&x1, &y1);  // Pass addresses
    swapRef(x2, y2);    // Pass variables

    cout << "\nAfter swap:" << endl;
    cout << "x1=" << x1 << " y1=" << y1 << endl;
    cout << "x2=" << x2 << " y2=" << y2 << endl;

    return 0;
}
```

# Tasks for Learners

- Implement swap functions using both pointers and references to compare the syntax and demonstrate that both approaches work.

  ```cpp
  #include <iostream>
  using namespace std;

  // Using pointers
  void swapPtr(int* a, int* b) {
      int temp = *a;
      *a = *b;
      *b = temp;
  }

  // Using references
  void swapRef(int& a, int& b) {
      int temp = a;
      a = b;
      b = temp;
  }

  int main() {
      int x1 = 10, y1 = 20;
      int x2 = 10, y2 = 20;

      cout << "Before swap:" << endl;
      cout << "x1=" << x1 << " y1=" << y1 << endl;
      cout << "x2=" << x2 << " y2=" << y2 << endl;

      swapPtr(&x1, &y1);  // Pass addresses
      swapRef(x2, y2);    // Pass variables

      cout << "\nAfter swap:" << endl;
      cout << "x1=" << x1 << " y1=" << y1 << endl;
      cout << "x2=" << x2 << " y2=" << y2 << endl;

      return 0;
  }
  ```

**Expected:** Both methods swap successfully. **References are cleaner!**

---

## Task 6: Reference Limitations

**Context:** Understand what references CAN'T do.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

int main() {
    int value1 = 100;
    int value2 = 200;

    // Reference must be initialized
    // int& ref;  // ERROR: must initialize immediately
    int& ref = value1;

    // Reference can't be reassigned
    ref = value2;  // This changes value1 to 200, doesn't rebind ref!
    cout << "value1: " << value1 << endl;  // 200
    cout << "value2: " << value2 << endl;  // 200

    // Pointer CAN be reassigned
    int* ptr = &value1;
    cout << "Pointer to value1: " << *ptr << endl;
    ptr = &value2;  // Now points to value2
    cout << "Pointer to value2: " << *ptr << endl;

    return 0;
}
```

# Tasks for Learners

- Understand reference limitations by demonstrating that references must be initialized immediately and cannot be reassigned, while pointers can be reassigned to point to different variables.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int value1 = 100;
      int value2 = 200;

      // Reference must be initialized
      // int& ref;  // ERROR: must initialize immediately
      int& ref = value1;

      // Reference can't be reassigned
      ref = value2;  // This changes value1 to 200, doesn't rebind ref!
      cout << "value1: " << value1 << endl;  // 200
      cout << "value2: " << value2 << endl;  // 200

      // Pointer CAN be reassigned
      int* ptr = &value1;
      cout << "Pointer to value1: " << *ptr << endl;
      ptr = &value2;  // Now points to value2
      cout << "Pointer to value2: " << *ptr << endl;

      return 0;
  }
  ```

---

## Task 7: Decision Guide

**Context:** Practical decision-making chart.

**Starter Code:**

```cpp
#include <iostream>
#include <string>
using namespace std;

// ✅ Use reference: modify original
void updateScore(int& score, int points) {
    score += points;
}

// ✅ Use const reference: read large object efficiently
void printReport(const string& longReport) {
    cout << longReport << endl;
}

// ✅ Use pointer: optional parameter (can be null)
void displayOptionalAddress(string* address) {
    if (address != nullptr) {
        cout << "Address: " << *address << endl;
    } else {
        cout << "No address provided" << endl;
    }
}

// ✅ Use pointer: need to change what you point to
void switchTarget(int* ptr, int& target1, int& target2, bool useFirst) {
    ptr = useFirst ? &target1 : &target2;
}

int main() {
    int score = 80;
    updateScore(score, 15);
    cout << "Score: " << score << endl;

    string report = "This is a very long report...";
    printReport(report);

    string addr = "123 Main St";
    displayOptionalAddress(&addr);
    displayOptionalAddress(nullptr);

    return 0;
}
```

# Tasks for Learners

- Apply the decision guide by implementing functions that demonstrate the appropriate use of references and pointers for different scenarios: modifying originals, reading large objects efficiently, handling optional parameters, and changing pointer targets.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  // ✅ Use reference: modify original
  void updateScore(int& score, int points) {
      score += points;
  }

  // ✅ Use const reference: read large object efficiently
  void printReport(const string& longReport) {
      cout << longReport << endl;
  }

  // ✅ Use pointer: optional parameter (can be null)
  void displayOptionalAddress(string* address) {
      if (address != nullptr) {
          cout << "Address: " << *address << endl;
      } else {
          cout << "No address provided" << endl;
      }
  }

  // ✅ Use pointer: need to change what you point to
  void switchTarget(int* ptr, int& target1, int& target2, bool useFirst) {
      ptr = useFirst ? &target1 : &target2;
  }

  int main() {
      int score = 80;
      updateScore(score, 15);
      cout << "Score: " << score << endl;

      string report = "This is a very long report...";
      printReport(report);

      string addr = "123 Main St";
      displayOptionalAddress(&addr);
      displayOptionalAddress(nullptr);

      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Pointers vs References Cheat Sheet</strong></summary>

**References:**

```cpp
int& ref = value;  // Alias for value
ref = 100;         // Modifies value directly
```

**Pointers:**

```cpp
int* ptr = &value;  // Stores address
*ptr = 100;         // Dereference to modify
```

**Comparison Table:**

| Feature              | Reference                | Pointer                                 |
| -------------------- | ------------------------ | --------------------------------------- |
| **Syntax**           | `int&`                   | `int*`                                  |
| **Initialization**   | Must initialize          | Can be null                             |
| **Reassignment**     | Can't reassign           | Can reassign                            |
| **Null possible?**   | No                       | Yes (nullptr)                           |
| **Dereferencing**    | Automatic                | Manual (\*)                             |
| **Array arithmetic** | No                       | Yes                                     |
| **Use case**         | Simple pass-by-reference | Optional params, dynamic memory, arrays |

**Decision Guide:**

**Use REFERENCE when:**

- ✅ You need to modify original variable
- ✅ Parameter must always exist (not optional)
- ✅ Passing large objects efficiently (const reference)
- ✅ You want cleaner syntax

**Use POINTER when:**

- ✅ Parameter might be null (optional)
- ✅ You need to change what you're pointing to
- ✅ Working with arrays
- ✅ Dynamic memory allocation (next lesson!)
- ✅ C-style APIs require it

**Modern C++ Preference:**

- Use references by default
- Use pointers only when necessary
- Use smart pointers for dynamic memory (advanced)

</details>

---

**Pro tip:** Prefer references for cleaner code. Use pointers when you need their special powers (null, reassignment, arrays)!
