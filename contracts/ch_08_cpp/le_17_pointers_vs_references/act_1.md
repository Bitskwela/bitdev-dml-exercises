# Lesson 17 Activities: Pointers vs References

## The Cleaner Alternative

Tian's code was full of asterisks and ampersands:
```cpp
void update(int* ptr) {
    *ptr += 10;
}
update(&value);
```

Kuya Miguel showed him **references**:
```cpp
void update(int& ref) {
    ref += 10;
}
update(value);
```

**"Same power, cleaner syntax!"** References are aliases—alternative names for existing variables. No dereferencing needed!

---

## Task 1: Reference Basics

**Context:** Create an alias for a variable.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int balance = 1000;
    
    // Reference: another name for balance
    int& balanceRef = balance;
    
    cout << "balance: " << balance << endl;
    cout << "balanceRef: " << balanceRef << endl;
    
    // Modifying reference modifies original
    balanceRef = 1500;
    
    cout << "After change:" << endl;
    cout << "balance: " << balance << endl;
    cout << "balanceRef: " << balanceRef << endl;
    
    return 0;
}
```

**Expected:** Both show 1500 (they're the same variable!)

---

## Task 2: Pointer vs Reference Syntax

**Context:** Compare how each works with functions.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

// Using pointer
void addTenPtr(int* ptr) {
    *ptr += 10;  // Need to dereference
}

// Using reference
void addTenRef(int& ref) {
    ref += 10;   // Direct access, no * needed
}

int main() {
    int value1 = 100;
    int value2 = 100;
    
    addTenPtr(&value1);  // Pass address
    addTenRef(value2);   // Pass variable directly
    
    cout << "value1 (pointer): " << value1 << endl;
    cout << "value2 (reference): " << value2 << endl;
    
    return 0;
}
```

**Expected:** Both become 110. **References are cleaner!**

---

## Task 3: When to Use Each

**Context:** Pointers and references solve different problems.

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

| Feature | Reference | Pointer |
|---------|-----------|---------|
| **Syntax** | `int&` | `int*` |
| **Initialization** | Must initialize | Can be null |
| **Reassignment** | Can't reassign | Can reassign |
| **Null possible?** | No | Yes (nullptr) |
| **Dereferencing** | Automatic | Manual (*) |
| **Array arithmetic** | No | Yes |
| **Use case** | Simple pass-by-reference | Optional params, dynamic memory, arrays |

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
