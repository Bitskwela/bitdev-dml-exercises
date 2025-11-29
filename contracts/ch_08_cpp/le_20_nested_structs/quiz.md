# Quiz: Lesson 20 - Nested Structs

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Nested Struct Basics

### Question 1
How do you access nested struct members?

```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    Address address;
};

Resident r;
r.name = "Juan";
// How to set street?
```

A) `r->address->street`  
B) `r.address.street`  
C) `r[address][street]`  
D) `r::address::street`

**Answer: B) `r.address.street`**

**Explanation:**
```cpp
r.address.street = "123 Main St";
r.address.city = "Iloilo City";

// Chain dot operators for nested access
```

---

### Question 2
What's the output?

```cpp
struct Point {
    int x;
    int y;
};

struct Rectangle {
    Point topLeft;
    Point bottomRight;
};

Rectangle rect = {{0, 10}, {20, 0}};
cout << rect.topLeft.y;
```

A) `0`  
B) `10`  
C) `20`  
D) Error

**Answer: B) `10`**

**Explanation:**
```cpp
rect.topLeft = {0, 10}     // topLeft.x=0, topLeft.y=10
rect.bottomRight = {20, 0}

rect.topLeft.y = 10
```

---

### Question 3
How do you initialize nested structs?

```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    int age;
    Address address;
};
```

A) `Resident r = {"Juan", 30, "Main St", "Iloilo"};`  
B) `Resident r = {"Juan", 30, {"Main St", "Iloilo"}};`  
C) `Resident r = {"Juan", 30, Address("Main St", "Iloilo")};`  
D) All are valid

**Answer: B) `Resident r = {"Juan", 30, {"Main St", "Iloilo"}};`**

**Explanation:**
```cpp
Resident r = {
    "Juan",
    30,
    {"Main St", "Iloilo"}  // Nested initializer
};
```

---

## Section 2: Complex Nested Structures

### Question 4
What's the output?

```cpp
struct City {
    string name;
    int population;
};

struct Address {
    string street;
    City city;
};

struct Resident {
    string name;
    Address address;
};

Resident r = {"Juan", {"Main St", {"Iloilo", 400000}}};
cout << r.address.city.name;
```

A) `Juan`  
B) `Main St`  
C) `Iloilo`  
D) `400000`

**Answer: C) `Iloilo`**

**Explanation:**
```cpp
r.name = "Juan"
r.address.street = "Main St"
r.address.city.name = "Iloilo"      // ← This
r.address.city.population = 400000
```

---

### Question 5
Which is the correct way to access deeply nested data?

```cpp
struct Country {
    string name;
};

struct City {
    string name;
    Country country;
};

struct Address {
    City city;
};

struct Person {
    string name;
    Address address;
};

Person p = {"Juan", {{"Iloilo", {"Philippines"}}}};
// Access country name?
```

A) `p.address.city.country.name`  
B) `p->address->city->country->name`  
C) `p.country.name`  
D) `p.address.country`

**Answer: A) `p.address.city.country.name`**

**Explanation:**
```cpp
cout << p.address.city.country.name;  // "Philippines"

// Chain dots for each level:
// p → address → city → country → name
```

---

## Section 3: Practical Applications

### Question 6
A struct has an array member. How do you access array elements?

```cpp
struct Student {
    string name;
    double grades[5];
};

Student s = {"Juan", {85, 90, 88, 92, 87}};
// Access second grade?
```

A) `s.grades[1]`  
B) `s->grades[1]`  
C) `s.grades.1`  
D) `s[grades][1]`

**Answer: A) `s.grades[1]`**

**Explanation:**
```cpp
s.grades[0] = 85
s.grades[1] = 90  // Second element
s.grades[2] = 88

cout << s.grades[1];  // 90
```

---


# Quiz 2

### Question 7
What's wrong with this code?

```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    Address address;
};

Resident* ptr = new Resident;
ptr.name = "Juan";
ptr.address.street = "Main St";
```

A) Nothing wrong  
B) Should use -> for pointer  
C) Cannot nest structs with pointers  
D) Missing initialization

**Answer: B) Should use -> for pointer**

**Explanation:**
```cpp
Resident* ptr = new Resident;

// ❌ WRONG
ptr.name = "Juan";

// ✓ CORRECT
ptr->name = "Juan";
ptr->address.street = "Main St";  // -> for pointer, then . for nested

delete ptr;
```

---

### Question 8
How do you pass nested structs to functions efficiently?

```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    Address address;
};

void display(_____ r) {
    cout << r.name << " - " << r.address.city;
}
```

A) `Resident r`  
B) `Resident& r`  
C) `const Resident& r`  
D) `Resident* r`

**Answer: C) `const Resident& r`**

**Explanation:**
```cpp
void display(const Resident& r) {  // ✓ Efficient + safe
    cout << r.name << " - " << r.address.city;
}

// No copying, read-only access
```

---

## Section 4: Advanced Scenarios

### Question 9
What's the output?

```cpp
struct Contact {
    string phone;
    string email;
};

struct Resident {
    string name;
    Contact contact;
};

Resident residents[2] = {
    {"Juan", {"0917111", "juan@ex.com"}},
    {"Maria", {"0918222", "maria@ex.com"}}
};

cout << residents[1].contact.phone;
```

A) `0917111`  
B) `0918222`  
C) `juan@ex.com`  
D) `Maria`

**Answer: B) `0918222`**

**Explanation:**
```cpp
residents[0] = {"Juan", {"0917111", "juan@ex.com"}}
residents[1] = {"Maria", {"0918222", "maria@ex.com"}}  // Second element

residents[1].contact.phone = "0918222"
```

---


# Quiz 1

### Question 10
A barangay system needs to store resident info including address (street, barangay, city) and contact (phone, email). Which structure is best?

```cpp
// Option A: Flat struct
struct Resident {
    string name;
    string street;
    string barangay;
    string city;
    string phone;
    string email;
};

// Option B: Nested structs
struct Address {
    string street;
    string barangay;
    string city;
};

struct Contact {
    string phone;
    string email;
};

struct Resident {
    string name;
    Address address;
    Contact contact;
};

// Option C: Separate arrays
string names[100];
string streets[100];
string cities[100];
// etc...
```

A) Option A  
B) Option B  
C) Option C  
D) All same

**Answer: B) Option B**

**Explanation:**
- **Option A:** Works but less organized, no reusability
- **Option B:** ✓ Best! Organized, reusable components, clear structure
- **Option C:** ❌ Worst! Hard to maintain, error-prone

**Benefits of Option B:**
```cpp
// Clear organization
Resident r;
r.address.street = "123 Main";  // Address info grouped
r.contact.phone = "0917";       // Contact info grouped

// Reusable
void displayAddress(const Address& addr) {
    cout << addr.street << ", " << addr.city;
}

// Can use for both home and work address
Resident person;
person.homeAddress = {"Home St", "Brgy A", "City"};
person.workAddress = {"Work Ave", "Brgy B", "City"};
```

---

## Section 5: Best Practices

### Question 11
What's the recommended maximum nesting depth?

A) 1 level  
B) 2-3 levels  
C) 5+ levels  
D) No limit

**Answer: B) 2-3 levels**

**Explanation:**
```cpp
// ✓ GOOD: 2 levels
struct Resident {
    string name;
    Address address;  // 1 level deep
};

// ⚠️ OK: 3 levels
struct Resident {
    string name;
    Address address;  // 1 level
    // address contains City which contains Country  // 2-3 levels
};

// ❌ BAD: Too deep, hard to maintain
struct A {
    B b;
    // b contains C
    // C contains D
    // D contains E
    // E contains F...  // Too confusing!
};
```

---


# Quiz 1

### Question 12
How do you reuse struct definitions?

```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    // Want home and work address
};
```

A) Copy the Address struct twice  
B) Use Address type for both  
C) Create AddressHome and AddressWork structs  
D) Use arrays

**Answer: B) Use Address type for both**

**Explanation:**
```cpp
struct Resident {
    string name;
    Address homeAddress;  // ✓ Reuse
    Address workAddress;  // ✓ Reuse
};

// Don't duplicate:
struct HomeAddress { ... };   // ❌ Unnecessary
struct WorkAddress { ... };   // ❌ Unnecessary
```

---


# Quiz 1

### Question 13
What's the output?

```cpp
struct Score {
    int math;
    int science;
};

struct Student {
    string name;
    Score scores;
};

Student students[2] = {
    {"Juan", {85, 90}},
    {"Maria", {92, 88}}
};

int total = 0;
for (int i = 0; i < 2; i++) {
    total += students[i].scores.math;
}
cout << total;
```

A) `85`  
B) `177`  
C) `355`  
D) `180`

**Answer: B) `177`**

**Explanation:**
```cpp
students[0].scores.math = 85
students[1].scores.math = 92

total = 85 + 92 = 177
```

---


# Quiz 1

### Question 14
Can structs contain pointers to other structs?

```cpp
struct Node {
    int data;
    Node* next;  // Pointer to another Node
};
```

A) Yes  
B) No, causes circular definition  
C) Only with typedef  
D) Only in classes

**Answer: A) Yes**

**Explanation:**
```cpp
struct Node {
    int data;
    Node* next;  // ✓ Valid! Pointer to same struct type
};

// Linked list example:
Node* head = new Node;
head->data = 10;
head->next = new Node;
head->next->data = 20;
head->next->next = nullptr;
```

This enables **linked data structures**!

---


# Quiz 1

### Question 15
What's the best way to organize this barangay clearance system?

**Requirements:**
- Clearance has: ID, date, fee
- Resident has: name, age, address (street, barangay, city)
- Each clearance is issued to one resident

```cpp
// Option A: Everything flat
struct Clearance {
    int id;
    string date;
    double fee;
    string residentName;
    int residentAge;
    string street;
    string barangay;
    string city;
};

// Option B: Nested organization
struct Address {
    string street;
    string barangay;
    string city;
};

struct Resident {
    string name;
    int age;
    Address address;
};

struct Clearance {
    int id;
    string date;
    double fee;
    Resident resident;
};
```

A) Option A (simpler)  
B) Option B (organized)  
C) Both same  
D) Neither works

**Answer: B) Option B (organized)**

**Explanation:**
**Option A problems:**
- All fields mixed together
- Hard to reuse Resident info
- Unclear relationships

**Option B benefits:**
- ✓ Clear hierarchy (Clearance → Resident → Address)
- ✓ Reusable components
- ✓ Easy to maintain and extend

```cpp
// Clean access with Option B:
Clearance c;
c.id = 1001;
c.date = "2024-11-17";
c.fee = 50.0;
c.resident.name = "Juan";
c.resident.age = 30;
c.resident.address.street = "Main St";
c.resident.address.barangay = "San Antonio";

// Functions become clearer:
void displayResident(const Resident& r) { ... }
void displayAddress(const Address& addr) { ... }
```

**Nested structs model real-world relationships naturally!**

---

**Score yourself:**
- 15/15: Nested Struct Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review nested access patterns
- Below 9: Re-read nested struct concepts

**Key Concepts:**
1. Chain dot operators for nested access
2. Keep nesting 2-3 levels max
3. Reuse struct definitions
4. Use const references for efficiency
5. Nested structs model hierarchical data
