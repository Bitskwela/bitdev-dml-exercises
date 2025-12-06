# Quiz: Lesson 17 - Pointers vs References

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What is a reference?

A) A pointer to a pointer  
B) An alias (another name) for a variable  
C) A copy of a variable  
D) A deleted variable

**Answer: B) An alias (another name) for a variable**

**Explanation:**
```cpp
int age = 25;
int& ref = age;  // ref is another name for age

ref = 30;
cout << age;  // 30 (both refer to same memory)
```

---

### Question 2
Which statement is TRUE?

A) References can be null  
B) Pointers can be null  
C) Both can be null  
D) Neither can be null

**Answer: B) Pointers can be null**

**Explanation:**
```cpp
int* ptr = nullptr;  // ✓ OK (pointers can be null)

int& ref = nullptr;  // ❌ ERROR! References cannot be null
```

---

### Question 3
Can references be rebound to another variable?

```cpp
int x = 10, y = 20;
int& ref = x;
ref = y;  // What happens?
```

A) ref now refers to y  
B) ref still refers to x, but x's value becomes 20  
C) Compilation error  
D) Both x and y become 10

**Answer: B) ref still refers to x, but x's value becomes 20**

**Explanation:**
References **cannot be rebound**. `ref = y` assigns y's value to x.

```cpp
int x = 10, y = 20;
int& ref = x;  // ref is bound to x forever

ref = y;       // Assigns y's value (20) to x
cout << x;     // 20
cout << ref;   // 20 (still refers to x)
```

---

### Question 4
What's the output?
```cpp
void modify(int& x) {
    x = 100;
}

int main() {
    int num = 50;
    modify(num);
    cout << num;
    return 0;
}
```

A) `50`  
B) `100`  
C) Compilation error  
D) `0`

**Answer: B) `100`**

**Explanation:**
Pass by reference modifies the original variable.

```cpp
modify(num);  // Pass by reference
// num is modified to 100
```

---

### Question 5
When should you use pointers instead of references?

A) Always  
B) Never  
C) When you need to represent "no value" (null) or reassign  
D) When you want simpler syntax

**Answer: C) When you need to represent "no value" (null) or reassign**

**Explanation:**

**Use pointers when:**
- Need to check for null (e.g., "not found")
- Need to reassign to different addresses
- Dynamic memory allocation

```cpp
int* findResident(int id) {
    if (found) return &resident;
    else return nullptr;  // ✓ Pointer can be null
}
```

**Use references when:**
- Parameter must always be valid
- Want clean syntax
- No need to reassign

---


# Quiz 2

### Question 6
Which syntax is correct for a reference?

A) `int& ref = &variable;`  
B) `int& ref = variable;`  
C) `int* ref = variable;`  
D) `int ref& = variable;`

**Answer: B) `int& ref = variable;`**

**Explanation:**
```cpp
int age = 25;

int& ref = age;   // ✓ CORRECT (reference)
int& ref = &age;  // ❌ WRONG (& is for pointers)
int* ptr = &age;  // ✓ CORRECT (pointer)
```

---




### Question 7
What's wrong with this code?
```cpp
int& getReference() {
    int temp = 10;
    return temp;
}
```

A) Nothing wrong  
B) Returns reference to local variable (dangling reference)  
C) Wrong return type  
D) Missing semicolon

**Answer: B) Returns reference to local variable (dangling reference)**

**Explanation:**
`temp` is destroyed when the function ends. Returning a reference to it creates a **dangling reference** — pointing to deleted memory!

**Fix:**
```cpp
// Option 1: Return by value
int getValue() {
    int temp = 10;
    return temp;  // ✓ OK (copies value)
}

// Option 2: Return reference to persistent variable
int global = 10;
int& getReference() {
    return global;  // ✓ OK (global persists)
}
```

---

### Question 8
Which is more efficient for large objects?

```cpp
struct Resident {
    string name;
    string address;
    int age;
    double balance;
};

// Option A
void display(Resident r) {
    cout << r.name;
}

// Option B
void display(const Resident& r) {
    cout << r.name;
}
```

A) Option A  
B) Option B  
C) Both same  
D) Depends

**Answer: B) Option B**

**Explanation:**
- **Option A:** Copies entire struct (slow for large objects)
- **Option B:** Passes reference (no copy, fast)

```cpp
void display(const Resident& r) {  // ✓ Efficient
    cout << r.name;  // Can read
    // r.age = 30;   // ❌ ERROR: const prevents modification
}
```

`const` ensures you don't accidentally modify the object.

---

### Question 9
What's the output?
```cpp
int x = 10, y = 20;
int* ptr = &x;

cout << *ptr << " ";
ptr = &y;
cout << *ptr;
```

A) `10 10`  
B) `10 20`  
C) `20 20`  
D) Compilation error

**Answer: B) `10 20`**

**Explanation:**
Pointers **can be reassigned** to point to different variables.

```cpp
int* ptr = &x;  // Points to x
cout << *ptr;   // 10

ptr = &y;       // Now points to y
cout << *ptr;   // 20
```

---


# Quiz 1

### Question 10
A barangay function searches for a resident. If not found, it should indicate "no result". Which design is best?

```cpp
// Option A: Return by reference
Resident& findResident(Resident arr[], int size, string name) {
    for (int i = 0; i < size; i++) {
        if (arr[i].name == name) return arr[i];
    }
    // What if not found? References can't be null!
}

// Option B: Return by pointer
Resident* findResident(Resident arr[], int size, string name) {
    for (int i = 0; i < size; i++) {
        if (arr[i].name == name) return &arr[i];
    }
    return nullptr;  // Can return null for "not found"
}
```

A) Option A (reference)  
B) Option B (pointer)  
C) Both are equally good  
D) Neither works

**Answer: B) Option B (pointer)**

**Explanation:**
**Option A:** ❌ Problematic! What to return if not found? References can't be null.

**Option B:** ✓ Perfect! Can return `nullptr` to represent "not found".

```cpp
Resident* found = findResident(residents, size, "Juan");

if (found != nullptr) {
    cout << "Found: " << found->name << endl;
    // or: cout << (*found).name << endl;
} else {
    cout << "Resident not found!" << endl;
}
```

**Rule:** Use pointers when the result can be "nothing" (null).

---

## Quiz Section 2: Advanced Scenarios

### Question 11
What's the best parameter type for this function?

```cpp
void displayName(_____ name) {
    cout << "Name: " << name << endl;
}
```

A) `string name` (pass by value)  
B) `string& name` (reference)  
C) `const string& name` (const reference)  
D) `string* name` (pointer)

**Answer: C) `const string& name` (const reference)**

**Explanation:**
- `string name` — ❌ Copies string (inefficient)
- `string& name` — ⚠️ Allows modification (not needed here)
- `const string& name` — ✓ No copy (efficient) + read-only (safe)
- `string* name` — ⚠️ Overkill, need nullptr checks

```cpp
void displayName(const string& name) {  // ✓ Best
    cout << "Name: " << name << endl;
}
```

---


# Quiz 1

### Question 12
Can you have a reference to a pointer?

A) No, impossible  
B) Yes, `int&* ref;`  
C) Yes, `int*& ref;`  
D) Only with const

**Answer: C) Yes, `int*& ref;`**

**Explanation:**
```cpp
int x = 10;
int* ptr = &x;

int*& refToPtr = ptr;  // Reference to pointer

*refToPtr = 20;  // Modifies x
cout << x;       // 20
```

Read right-to-left: `int*&` = reference to a pointer to int.

---


# Quiz 1

### Question 13
What's the output?
```cpp
void swap(int* a, int* b) {
    int* temp = a;
    a = b;
    b = temp;
}

int main() {
    int x = 10, y = 20;
    int* p1 = &x;
    int* p2 = &y;
    
    swap(p1, p2);
    cout << *p1 << " " << *p2;
    return 0;
}
```

A) `20 10` (swapped)  
B) `10 20` (not swapped)  
C) Compilation error  
D) `0 0`

**Answer: B) `10 20` (not swapped)**

**Explanation:**
The function swaps **local copies** of the pointers, not the originals.

**Fix (pass pointers by reference):**
```cpp
void swap(int*& a, int*& b) {  // Reference to pointer
    int* temp = a;
    a = b;
    b = temp;
}
```

Or better, swap values:
```cpp
void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}
swap(x, y);  // Cleaner
```

---


# Quiz 1

### Question 14
Which is valid?

```cpp
int x = 10;

// Option A
int& ref;
ref = x;

// Option B
int& ref = x;

// Option C
int& ref = &x;

// Option D
int& ref(x);
```

A) Option A  
B) Option B  
C) Option C  
D) Option D

**Answer: B) Option B**

**Explanation:**
- **Option A:** ❌ References must be initialized when declared
- **Option B:** ✓ Correct syntax
- **Option C:** ❌ Don't use & on the right side for references
- **Option D:** ⚠️ Valid but unusual syntax

```cpp
int& ref = x;  // ✓ Most common and clear
```

---


# Quiz 1

### Question 15
What's the difference?

```cpp
void func1(int* ptr);
void func2(int& ref);

int main() {
    int x = 10;
    
    func1(&x);  // How to call func1?
    func2(x);   // How to call func2?
}
```

A) No difference  
B) func1 needs & when calling, func2 doesn't  
C) func2 needs & when calling, func1 doesn't  
D) Both need &

**Answer: B) func1 needs & when calling, func2 doesn't**

**Explanation:**
```cpp
void func1(int* ptr) { *ptr = 20; }
void func2(int& ref) { ref = 30; }

int x = 10;

func1(&x);  // ✓ Pass address (pointer)
func2(x);   // ✓ Pass variable (reference)
```

References have **cleaner calling syntax** — no need for `&` at call site.

---

**Score yourself:**
- 15/15: References & Pointers Master! 🎯
- 12-14: Excellent understanding!
- 9-11: Good, review rebinding and use cases
- Below 9: Re-read pointers vs references

**Key Concepts:**
1. References = aliases, Pointers = addresses
2. References can't be null or rebound
3. Use const references for efficient read-only parameters
4. Use pointers when null is meaningful
5. References have cleaner syntax for function calls
