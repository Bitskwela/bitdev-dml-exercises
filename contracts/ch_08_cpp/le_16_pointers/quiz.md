# Quiz: Lesson 16 - Pointers

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What does a pointer store?

A) The value of a variable  
B) The memory address of a variable  
C) The name of a variable  
D) The type of a variable

**Answer: B) The memory address of a variable**

**Explanation:**
```cpp
int age = 25;
int* ptr = &age;

cout << ptr;   // Memory address (e.g., 0x7fff5fbff6fc)
cout << *ptr;  // Value at that address (25)
```

---

### Question 2
What does `&` operator do?

A) Dereference a pointer  
B) Get the address of a variable  
C) Multiply values  
D) Declare a reference

**Answer: B) Get the address of a variable**

**Explanation:**
```cpp
int balance = 1000;
int* ptr = &balance;  // & gets address of balance

cout << &balance;  // Memory address
```

---

### Question 3
What's the output?
```cpp
int x = 10;
int* ptr = &x;

cout << *ptr;
```

A) The address of x  
B) `10`  
C) The address of ptr  
D) Compilation error

**Answer: B) `10`**

**Explanation:**
`*ptr` dereferences the pointer — gets the value at the address ptr holds.

```cpp
int x = 10;
int* ptr = &x;

cout << ptr;   // Address
cout << *ptr;  // 10 (dereference)
```

---

### Question 4
What happens here?
```cpp
int age = 25;
int* ptr = &age;

*ptr = 30;
cout << age;
```

A) `25`  
B) `30`  
C) Compilation error  
D) Address of age

**Answer: B) `30`**

**Explanation:**
Modifying `*ptr` changes the value at the address ptr points to (which is `age`).

```cpp
*ptr = 30;  // Changes age to 30
cout << age;  // 30
```

---

### Question 5
What's wrong with this code?
```cpp
int* ptr;
*ptr = 100;
```

A) Nothing wrong  
B) Pointer is uninitialized  
C) Wrong syntax  
D) Cannot assign to pointer

**Answer: B) Pointer is uninitialized**

**Explanation:**
`ptr` contains a random address. Writing to `*ptr` writes to unknown memory → crash!

**Fix:**
```cpp
int x;
int* ptr = &x;  // Initialize to valid address
*ptr = 100;     // Now safe

// Or:
int* ptr = nullptr;
if (ptr != nullptr) {
    *ptr = 100;  // Safe check
}
```

---


# Quiz 2

### Question 6
What does `nullptr` represent?

A) A pointer to zero  
B) A null (invalid) pointer  
C) A pointer to the last element  
D) A deleted pointer

**Answer: B) A null (invalid) pointer**

**Explanation:**
```cpp
int* ptr = nullptr;  // Points to nothing (null)

if (ptr == nullptr) {
    cout << "Pointer is null";
}

// ❌ CRASH if dereferenced
// cout << *ptr;  // Segmentation fault!
```

Always check for null before dereferencing!

---




### Question 7
What's the relationship between arrays and pointers?

```cpp
int numbers[5] = {10, 20, 30, 40, 50};
```

A) No relationship  
B) Array name is a pointer to the first element  
C) Arrays cannot use pointers  
D) Pointers cannot point to arrays

**Answer: B) Array name is a pointer to the first element**

**Explanation:**
```cpp
int numbers[5] = {10, 20, 30, 40, 50};

cout << numbers;     // Address of first element
cout << &numbers[0]; // Same address

cout << *numbers;    // 10 (first element)
cout << numbers[0];  // 10 (same)

cout << *(numbers+1); // 20 (second element)
cout << numbers[1];   // 20 (same)
```

---

### Question 8
What's the output?
```cpp
void increment(int* x) {
    (*x)++;
}

int main() {
    int num = 5;
    increment(&num);
    cout << num;
    return 0;
}
```

A) `5`  
B) `6`  
C) Compilation error  
D) Address of num

**Answer: B) `6`**

**Explanation:**
The function receives the address of `num` and increments the value at that address.

```cpp
(*x)++  // Increment value at address x
// num becomes 6
```

---

### Question 9
What does `->` do?

```cpp
struct Person {
    string name;
    int age;
};

Person p = {"Juan", 25};
Person* ptr = &p;

cout << ptr->age;  // What does -> do?
```

A) Multiplies pointer  
B) Access member via pointer (shorthand for `(*ptr).age`)  
C) Compares pointer  
D) Deletes pointer

**Answer: B) Access member via pointer (shorthand for `(*ptr).age`)**

**Explanation:**
```cpp
Person* ptr = &p;

// These are equivalent:
cout << ptr->age;     // 25 (shorthand)
cout << (*ptr).age;   // 25 (full syntax)
```

`->` is just cleaner syntax for accessing struct/class members through a pointer.

---


# Quiz 1

### Question 10
A barangay function needs to update a resident's balance. Which is best?

```cpp
// Option A: Pass by value
void deposit(int balance, int amount) {
    balance += amount;
}

// Option B: Pass by pointer
void deposit(int* balance, int amount) {
    *balance += amount;
}

// Option C: Pass by reference
void deposit(int& balance, int amount) {
    balance += amount;
}
```

A) Option A  
B) Option B (pointer)  
C) Option C (reference)  
D) B and C are both good

**Answer: D) B and C are both good**

**Explanation:**
- **Option A:** ❌ Pass by value doesn't modify the original
- **Option B:** ✓ Pointer works, but requires `&` when calling
- **Option C:** ✓ Reference is cleaner and safer

**Option B usage (pointer):**
```cpp
int balance = 1000;
deposit(&balance, 500);  // Must pass address
```

**Option C usage (reference):**
```cpp
int balance = 1000;
deposit(balance, 500);  // Cleaner syntax
```

**When to use pointers vs references:**
- **Pointers:** When you need to reassign (`ptr = &other`), or check for null
- **References:** When you always have a valid object, cleaner syntax

**For this case,** Option C (reference) is slightly better: cleaner, can't be null.

---

**Score yourself:**
- 10/10: Pointer Master! 🎯
- 8-9: Excellent!
- 6-7: Good, review dereference and addresses
- Below 6: Re-read pointer basics

**Key Concepts:**
1. Pointers store addresses
2. `&` = address-of operator
3. `*` = dereference operator (get value)
4. Always initialize pointers
5. Check for `nullptr` before dereferencing
6. Arrays and pointers are related
7. Use `->` to access members via pointer
