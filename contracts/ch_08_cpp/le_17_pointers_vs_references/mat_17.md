# Lesson 17: Pointers vs References - When to Use Each

**Estimated Reading Time:** 11 minutes

---

## The Story

"Kuya," Tian asked, "you mentioned references before when we passed parameters. How are they different from pointers?"

Kuya Miguel drew two columns on the whiteboard. "Great question! Pointers and references are similar tools with different strengths. Let me show you when to use each."

---

## What is a Reference?

A **reference** is an **alias** (another name) for an existing variable.

```cpp
int age = 25;
int& ref = age;  // ref is now another name for age

cout << age;  // 25
cout << ref;  // 25

ref = 30;
cout << age;  // 30 (age changed too!)
```

**Key point:** `ref` and `age` refer to the **same memory location**.

---

## References vs Pointers

### Syntax Comparison

```cpp
int balance = 1000;

// Reference
int& refBalance = balance;
refBalance += 500;  // Direct modification
cout << balance;    // 1500

// Pointer
int* ptrBalance = &balance;
*ptrBalance += 500;  // Need dereference
cout << balance;     // 2000
```

---

## Key Differences

| Feature | Reference | Pointer |
|---------|-----------|---------|
| **Syntax** | `int& ref = var;` | `int* ptr = &var;` |
| **Access** | Direct: `ref` | Dereference: `*ptr` |
| **Null value** | Cannot be null | Can be `nullptr` |
| **Reassignment** | Cannot rebind | Can point to different addresses |
| **Initialization** | Must be initialized | Can be declared without initialization |
| **Arithmetic** | Not allowed | Allowed (`ptr++`) |
| **Usage** | Cleaner syntax | More flexible |

---

## References Must Be Initialized

```cpp
int& ref;  // ❌ ERROR! Reference must be initialized

int age = 25;
int& ref = age;  // ✓ OK
```

---

## References Cannot Be Null

```cpp
int& ref = nullptr;  // ❌ ERROR! References can't be null

int* ptr = nullptr;  // ✓ OK (pointers can be null)
```

---

## References Cannot Be Rebound

Once a reference is bound to a variable, it cannot be changed to refer to another variable:

```cpp
int x = 10;
int y = 20;

int& ref = x;  // ref refers to x
cout << ref;   // 10

ref = y;       // ❌ This does NOT rebind ref to y!
               // It assigns y's value to x!
cout << x;     // 20 (x changed)
cout << ref;   // 20 (still refers to x)
```

**With pointers (can reassign):**
```cpp
int x = 10;
int y = 20;

int* ptr = &x;  // ptr points to x
cout << *ptr;   // 10

ptr = &y;       // ✓ Now ptr points to y
cout << *ptr;   // 20
```

---

## Pass by Reference (Revisited)

```cpp
void deposit(int& balance, int amount) {
    balance += amount;  // Direct modification
}

int main() {
    int myBalance = 1000;
    deposit(myBalance, 500);  // Pass by reference
    cout << myBalance;        // 1500
    return 0;
}
```

**No need for:**
- `&` when calling (cleaner than pointers)
- `*` when using inside function (cleaner syntax)

---

## When to Use References

### 1. Function Parameters (Most Common)

```cpp
void updateBalance(int& balance, int amount) {
    balance += amount;
}

void displayResident(const string& name, const string& address) {
    cout << name << " lives at " << address << endl;
}
```

**Benefits:**
- Avoids copying large objects (efficient)
- Can modify original (if not `const`)
- Clean syntax

### 2. Range-Based For Loops

```cpp
int scores[5] = {85, 90, 78, 92, 88};

// Modify elements
for (int& score : scores) {
    score += 5;  // Add bonus to each score
}

// Read-only (const reference)
for (const int& score : scores) {
    cout << score << " ";
}
```

### 3. Operator Overloading (Advanced)

```cpp
class Counter {
    int value;
public:
    Counter& operator++() {  // Return reference for chaining
        value++;
        return *this;
    }
};
```

---

## When to Use Pointers

### 1. Dynamic Memory Allocation

```cpp
int* ptr = new int(10);  // Allocate memory
cout << *ptr;            // 10
delete ptr;              // Free memory
```

### 2. When Null is Meaningful

```cpp
int* findResident(int id) {
    // Search logic...
    if (found) {
        return &resident;
    } else {
        return nullptr;  // ✓ Pointers can represent "not found"
    }
}

int* result = findResident(101);
if (result != nullptr) {
    cout << "Found!";
} else {
    cout << "Not found";
}
```

### 3. Reassignment Needed

```cpp
int a = 10, b = 20, c = 30;
int* ptr = &a;

ptr = &b;  // Point to b
ptr = &c;  // Point to c
// Pointer can point to different variables
```

### 4. Data Structures (Linked Lists, Trees)

```cpp
struct Node {
    int data;
    Node* next;  // Pointer to next node
};
```

### 5. Arrays (Pointer Arithmetic)

```cpp
int numbers[5] = {10, 20, 30, 40, 50};
int* ptr = numbers;

for (int i = 0; i < 5; i++) {
    cout << *(ptr + i) << " ";  // Pointer arithmetic
}
```

---

## Practical Example: Barangay System

```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    double balance;
};

// Use reference: clean syntax, always valid
void deposit(Resident& r, double amount) {
    r.balance += amount;
    cout << "Deposited P" << amount << " to " << r.name << endl;
}

// Use const reference: read-only, efficient
void display(const Resident& r) {
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Balance: P" << r.balance << endl;
}

// Use pointer: can return nullptr for "not found"
Resident* findResident(Resident residents[], int size, string name) {
    for (int i = 0; i < size; i++) {
        if (residents[i].name == name) {
            return &residents[i];
        }
    }
    return nullptr;  // Not found
}

int main() {
    Resident residents[3] = {
        {"Juan Dela Cruz", 30, 1000.0},
        {"Maria Santos", 25, 1500.0},
        {"Pedro Reyes", 35, 2000.0}
    };
    
    // Search for resident
    string searchName = "Maria Santos";
    Resident* found = findResident(residents, 3, searchName);
    
    if (found != nullptr) {
        cout << "Found resident:\n";
        display(*found);  // Dereference pointer to pass as reference
        
        deposit(*found, 500);
        
        cout << "\nAfter deposit:\n";
        display(*found);
    } else {
        cout << searchName << " not found!" << endl;
    }
    
    return 0;
}
```

**Output:**
```
Found resident:
Name: Maria Santos
Age: 25
Balance: P1500

Deposited P500 to Maria Santos

After deposit:
Name: Maria Santos
Age: 25
Balance: P2000
```

---

## Common Patterns

### Pattern 1: Function Taking Large Object (Use const reference)

```cpp
// ❌ BAD: Copies entire string (slow)
void display(string name) {
    cout << name;
}

// ✓ GOOD: No copy, efficient
void display(const string& name) {
    cout << name;
}
```

### Pattern 2: Function Modifying Object (Use reference)

```cpp
void addBonus(int& score, int bonus) {
    score += bonus;
}
```

### Pattern 3: Function Returning Optional Result (Use pointer)

```cpp
int* findMax(int arr[], int size) {
    if (size == 0) return nullptr;  // Empty array
    
    int* maxPtr = &arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] > *maxPtr) {
            maxPtr = &arr[i];
        }
    }
    return maxPtr;
}
```

### Pattern 4: Swapping Two Variables

**Using references:**
```cpp
void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

int x = 10, y = 20;
swap(x, y);  // Clean call
```

**Using pointers:**
```cpp
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int x = 10, y = 20;
swap(&x, &y);  // Need &
```

**References are cleaner for this use case!**

---

## Quick Decision Guide

**Use References when:**
- ✓ Parameter must always be valid (non-null)
- ✓ You want clean syntax
- ✓ No need to reassign to different object
- ✓ Modifying or reading large objects

**Use Pointers when:**
- ✓ Need to represent "no value" (nullptr)
- ✓ Need to reassign to different addresses
- ✓ Dynamic memory allocation
- ✓ Pointer arithmetic needed
- ✓ Data structures (linked lists, trees)

---

## Common Mistakes

### Mistake 1: Trying to Rebind References

```cpp
int x = 10, y = 20;
int& ref = x;

ref = y;  // ❌ Does NOT rebind! Assigns y's value to x
```

### Mistake 2: Uninitialized References

```cpp
int& ref;  // ❌ ERROR! Must initialize
```

### Mistake 3: Dangling References

```cpp
int& getReference() {
    int temp = 10;
    return temp;  // ❌ DANGER! Returns reference to local variable
}  // temp is destroyed here!
```

### Mistake 4: Mixing Syntax

```cpp
int age = 25;
int& ref = &age;  // ❌ WRONG! & is for pointers, not references

int& ref = age;   // ✓ CORRECT
```

---

## Best Practices

1. **Prefer references for function parameters**
```cpp
void process(const string& name) {  // ✓ Clean and safe
    // ...
}
```

2. **Use pointers when null is meaningful**
```cpp
int* findElement(int arr[], int size, int target) {
    // Can return nullptr if not found
}
```

3. **Use const references for read-only access**
```cpp
void display(const Resident& r) {  // ✓ Efficient, safe
    cout << r.name;
}
```

4. **Initialize pointers to nullptr**
```cpp
int* ptr = nullptr;  // ✓ Safe
```

---

## Summary

Tian reviewed the comparison table. "So references are like pointers, but simpler and safer!"

"Exactly!" Kuya Miguel nodded. "Remember:
- **References** — cleaner syntax, always valid, can't be null
- **Pointers** — more flexible, can be null, can be reassigned
- **Use references** for parameters and read-only access
- **Use pointers** when you need null or dynamic memory"

"Next," Kuya Miguel said, "we'll explore **dynamic memory** — creating variables that live on the heap!"

---

**Key Takeaways:**
1. References are aliases, pointers store addresses
2. References cannot be null or rebound
3. Use references for clean function parameters
4. Use pointers when null is meaningful or reassignment needed
5. Both avoid copying large objects

**Next Lesson:** Dynamic Memory Allocation with `new` and `delete`
