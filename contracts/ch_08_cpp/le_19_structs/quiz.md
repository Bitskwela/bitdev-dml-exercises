# Quiz: Lesson 19 - Structs

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Struct Basics

### Question 1
What is a struct?

A) A type of array  
B) A user-defined data type that groups related variables  
C) A pointer  
D) A loop structure

**Answer: B) A user-defined data type that groups related variables**

**Explanation:**
```cpp
struct Resident {
    string name;   // Different types
    int age;       // grouped together
    double balance;
};
```

Structs let you create custom types by bundling related data.

---

### Question 2
What's wrong with this struct declaration?

```cpp
struct Person {
    string name;
    int age;
}
```

A) Nothing wrong  
B) Missing semicolon after closing brace  
C) Wrong keyword  
D) Missing data types

**Answer: B) Missing semicolon after closing brace**

**Explanation:**
```cpp
struct Person {
    string name;
    int age;
};  // ✓ Semicolon required!
```

---

### Question 3
How do you access struct members?

```cpp
struct Point {
    int x;
    int y;
};

Point p;
p.x = 10;  // What operator is this?
```

A) Arrow operator `->`  
B) Dot operator `.`  
C) Scope operator `::`  
D) Dereference operator `*`

**Answer: B) Dot operator `.`**

**Explanation:**
```cpp
Point p;
p.x = 10;  // Dot operator for regular struct variables
p.y = 20;

cout << p.x << ", " << p.y;  // 10, 20
```

---

### Question 4
Which initialization is correct?

```cpp
struct Resident {
    string name;
    int age;
    double balance;
};
```

A) `Resident r = {"Juan", 30, 1000.0};`  
B) `Resident r = (Juan, 30, 1000.0);`  
C) `Resident r = [Juan, 30, 1000.0];`  
D) `Resident r = {Juan; 30; 1000.0};`

**Answer: A) `Resident r = {"Juan", 30, 1000.0};`**

**Explanation:**
```cpp
Resident r = {"Juan Dela Cruz", 30, 1000.0};  // ✓ Initializer list

// Or member-by-member:
Resident r2;
r2.name = "Maria";
r2.age = 25;
r2.balance = 1500.0;
```

---

### Question 5
What's the output?

```cpp
struct Book {
    string title;
    int pages;
};

Book b = {"C++ Basics", 300};
cout << b.pages;
```

A) `C++ Basics`  
B) `300`  
C) Error  
D) `0`

**Answer: B) `300`**

**Explanation:**
`b.pages` accesses the `pages` member, which is `300`.

---

## Section 2: Functions and Structs

### Question 6
Which parameter passing is most efficient for read-only access?

```cpp
struct Resident {
    string name;
    int age;
    double balance;
};

// Option A
void display(Resident r);

// Option B
void display(Resident& r);

// Option C
void display(const Resident& r);
```

A) Option A  
B) Option B  
C) Option C  
D) All same

**Answer: C) Option C**

**Explanation:**
- **Option A:** Copies entire struct (slow for large structs)
- **Option B:** No copy, but can modify (not read-only)
- **Option C:** ✓ No copy (efficient) + read-only (safe)

```cpp
void display(const Resident& r) {  // ✓ Best
    cout << r.name << ": P" << r.balance << endl;
    // r.balance = 0;  // ❌ ERROR: const prevents modification
}
```

---


# Quiz 2

### Question 7
How do you modify a struct in a function?

```cpp
void deposit(_____ r, double amount) {
    r.balance += amount;
}
```

A) `Resident r`  
B) `Resident& r`  
C) `const Resident& r`  
D) `Resident* r`

**Answer: B) `Resident& r`**

**Explanation:**
```cpp
void deposit(Resident& r, double amount) {  // Pass by reference
    r.balance += amount;  // Modifies original
}

Resident person = {"Juan", 30, 1000.0};
deposit(person, 500);
cout << person.balance;  // 1500
```

---

### Question 8
Can functions return structs?

```cpp
Resident createResident(string name, int age) {
    Resident r;
    r.name = name;
    r.age = age;
    r.balance = 0;
    return r;  // Valid?
}
```

A) Yes  
B) No, must use pointers  
C) Only with references  
D) Syntax error

**Answer: A) Yes**

**Explanation:**
```cpp
Resident createResident(string name, int age, double bal) {
    Resident r = {name, age, bal};
    return r;  // ✓ Returns a copy
}

Resident person = createResident("Juan", 30, 1000.0);
cout << person.name;  // "Juan"
```

---

## Section 3: Advanced Struct Usage

### Question 9
What operator do you use with pointers to structs?

```cpp
Resident person = {"Juan", 30, 1000.0};
Resident* ptr = &person;

// Access name?
```

A) `ptr.name`  
B) `ptr->name`  
C) `(*ptr).name`  
D) Both B and C

**Answer: D) Both B and C**

**Explanation:**
```cpp
Resident* ptr = &person;

cout << ptr->name;      // ✓ Arrow operator (shorthand)
cout << (*ptr).name;    // ✓ Dereference then dot (verbose)

// Both are equivalent!
```

`->` is cleaner and more commonly used.

---


# Quiz 1

### Question 10
What's the output?

```cpp
struct Point {
    int x;
    int y;
};

Point points[3] = {
    {0, 0},
    {10, 20},
    {30, 40}
};

cout << points[1].y;
```

A) `0`  
B) `10`  
C) `20`  
D) `40`

**Answer: C) `20`**

**Explanation:**
```cpp
points[0] = {0, 0}
points[1] = {10, 20}  // Second element
points[2] = {30, 40}

points[1].y = 20  // Access y of second point
```

---

## Section 4: Nested Structs and Complex Scenarios

### Question 11
What's wrong with this code?

```cpp
struct Resident {
    string name;
    int age;
};

Resident r1 = {"Juan", 30};
Resident r2 = {"Juan", 30};

if (r1 == r2) {
    cout << "Equal";
}
```

A) Nothing wrong  
B) Structs cannot be compared with ==  
C) Wrong initialization  
D) Missing semicolon

**Answer: B) Structs cannot be compared with ==**

**Explanation:**
C++ doesn't provide default comparison for structs.

**Fix:**
```cpp
// Compare member-by-member
if (r1.name == r2.name && r1.age == r2.age) {
    cout << "Equal";
}

// Or create a function
bool areEqual(const Resident& r1, const Resident& r2) {
    return r1.name == r2.name && r1.age == r2.age;
}
```

---


# Quiz 1

### Question 12
How do you create nested structs?

```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    Address address;  // Nested struct
};

Resident r;
r.name = "Juan";
r.address.street = "123 Main St";  // How to access?
```

A) `r->address->street`  
B) `r.address.street`  
C) `r[address][street]`  
D) `r::address::street`

**Answer: B) `r.address.street`**

**Explanation:**
```cpp
Resident r;
r.name = "Juan";
r.address.street = "123 Maharlika St.";
r.address.city = "Iloilo City";

cout << r.name << " lives at " << r.address.street;
```

Chain dot operators for nested members.

---


# Quiz 1

### Question 13
What's the output?

```cpp
struct Clearance {
    int id;
    string name;
    double fee;
};

Clearance* ptr = new Clearance;
ptr->id = 1001;
ptr->name = "Juan";
ptr->fee = 50.0;

cout << ptr->fee;
delete ptr;
```

A) `1001`  
B) `Juan`  
C) `50.0`  
D) Error

**Answer: C) `50.0`**

**Explanation:**
```cpp
ptr->fee = 50.0;
cout << ptr->fee;  // 50.0

// Remember to delete!
delete ptr;
```

---


# Quiz 1

### Question 14
Which is better for organizing resident data?

```cpp
// Option A: Parallel arrays
string names[10];
int ages[10];
double balances[10];

// Option B: Array of structs
struct Resident {
    string name;
    int age;
    double balance;
};
Resident residents[10];
```

A) Option A (easier)  
B) Option B (more organized)  
C) Both same  
D) Depends

**Answer: B) Option B (more organized)**

**Explanation:**
**Option A problems:**
- Hard to keep synchronized
- Passing requires 3 separate arrays
- Easy to make mistakes (wrong index)

**Option B benefits:**
- ✓ All data grouped logically
- ✓ Pass single struct to functions
- ✓ Easier to maintain
- ✓ Clearer code

```cpp
// Option A: Messy
void display(string names[], int ages[], double balances[], int i) {
    cout << names[i] << ", " << ages[i] << ", " << balances[i];
}

// Option B: Clean
void display(const Resident& r) {
    cout << r.name << ", " << r.age << ", " << r.balance;
}
```

---


# Quiz 1

### Question 15
A barangay system needs to store clearance information (ID, name, age, purpose, fee). Which approach is best?

```cpp
// Option A: Separate variables for each clearance
int id1, id2, id3;
string name1, name2, name3;
// etc...

// Option B: Struct with arrays
struct ClearanceSystem {
    int ids[100];
    string names[100];
    int ages[100];
};

// Option C: Array of structs
struct Clearance {
    int id;
    string name;
    int age;
    string purpose;
    double fee;
};
Clearance clearances[100];
```

A) Option A  
B) Option B  
C) Option C  
D) All equally good

**Answer: C) Option C**

**Explanation:**
- **Option A:** ❌ Unmanageable! Can't scale, can't loop
- **Option B:** ❌ Still parallel arrays, same synchronization issues
- **Option C:** ✓ Perfect! Clean, organized, scalable

```cpp
Clearance clearances[100];

// Easy to add
clearances[0] = {1001, "Juan", 30, "Work", 50.0};

// Easy to loop
for (int i = 0; i < numClearances; i++) {
    cout << clearances[i].name << ": P" << clearances[i].fee << endl;
}

// Easy to pass to functions
void displayClearance(const Clearance& c) {
    cout << c.id << " - " << c.name << endl;
}
```

**Structs are the foundation of organized, maintainable code!**

---

**Score yourself:**
- 15/15: Struct Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review member access and best practices
- Below 9: Re-read struct concepts

**Key Concepts:**
1. Structs group related data of different types
2. Use `.` for regular variables, `->` for pointers
3. Pass by const reference for read-only efficiency
4. Structs cannot be compared with `==` by default
5. Nested structs use chained dot operators
6. Structs make code more organized than parallel arrays
