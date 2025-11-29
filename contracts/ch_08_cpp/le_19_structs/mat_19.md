## Background Story

Tian's resident management system was a nightmare. Tracking 100 residents required three parallel arrays: `names[100]`, `ages[100]`, and `dues[100]`. Adding a new resident meant updating three arrays. If indices got misaligned, resident data became corrupted.

"This is insane!" Tian exclaimed, debugging an error where resident 42's data appeared under resident 41's name. "If I add phone numbers and addresses, I'll need five more arrays! How do real databases manage thousands of fields per record?"

Kuya Miguel laughed. "They don't use parallel arrays. They use **structs**—custom data types that bundle related information into a single package. Instead of three separate arrays, you create one array of Resident objects, where each Resident contains name, age, and dues together. It's impossible for data to get misaligned."

"Think of it like this," Kuya Miguel explained. "Right now, you're managing resident information like loose papers—name on one sheet, age on another, dues on a third. Lose one paper, and the connection is broken. Structs are like folders that keep all related documents together. It's organized, maintainable, and reflects how we actually think about data."

---

## Theory & Lecture Content

## What is a Struct?

A **struct** (structure) is a user-defined data type that groups related variables under one name.

```cpp
struct Resident {
    string name;
    int age;
    double balance;
};
```

Think of it as a **template** or **blueprint** for creating objects.

---

## Declaring a Struct

```cpp
struct StructName {
    dataType member1;
    dataType member2;
    // ...
};  // Don't forget the semicolon!
```

**Example:**
```cpp
struct Point {
    int x;
    int y;
};

struct Book {
    string title;
    string author;
    int pages;
    double price;
};
```

---

## Creating Struct Variables

```cpp
struct Resident {
    string name;
    int age;
    double balance;
};

int main() {
    Resident r1;  // Create a resident
    Resident r2, r3;  // Create multiple residents
    
    return 0;
}
```

---

## Accessing Members

Use the **dot operator** `.`:

```cpp
struct Resident {
    string name;
    int age;
    double balance;
};

int main() {
    Resident person;
    
    person.name = "Juan Dela Cruz";
    person.age = 30;
    person.balance = 1000.0;
    
    cout << "Name: " << person.name << endl;
    cout << "Age: " << person.age << endl;
    cout << "Balance: P" << person.balance << endl;
    
    return 0;
}
```

---

## Initializing Structs

### Method 1: Member-by-Member
```cpp
Resident person;
person.name = "Juan";
person.age = 30;
person.balance = 1000.0;
```

### Method 2: Initializer List (C++11+)
```cpp
Resident person = {"Juan Dela Cruz", 30, 1000.0};
```

### Method 3: Designated Initializers (C++20)
```cpp
Resident person = {
    .name = "Juan Dela Cruz",
    .age = 30,
    .balance = 1000.0
};
```

---

## Arrays of Structs

```cpp
const int SIZE = 3;
Resident residents[SIZE] = {
    {"Juan Dela Cruz", 30, 1000.0},
    {"Maria Santos", 25, 1500.0},
    {"Pedro Reyes", 35, 2000.0}
};

for (int i = 0; i < SIZE; i++) {
    cout << residents[i].name << " (Age " << residents[i].age << ")" << endl;
}
```

---

## Structs as Function Parameters

### Pass by Value (Copy)
```cpp
void displayResident(Resident r) {
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Balance: P" << r.balance << endl;
}
```

### Pass by Reference (Modify Original)
```cpp
void deposit(Resident& r, double amount) {
    r.balance += amount;
}
```

### Pass by Const Reference (Efficient, Read-Only)
```cpp
void display(const Resident& r) {
    cout << r.name << ": P" << r.balance << endl;
}
```

---

## Returning Structs from Functions

```cpp
Resident createResident(string name, int age, double balance) {
    Resident r;
    r.name = name;
    r.age = age;
    r.balance = balance;
    return r;
}

int main() {
    Resident person = createResident("Juan", 30, 1000.0);
    cout << person.name << endl;
    return 0;
}
```

---

## Practical Example: Barangay Clearance System

```cpp
#include <iostream>
#include <string>
using namespace std;

struct Clearance {
    int id;
    string residentName;
    int age;
    string purpose;
    double fee;
};

double calculateFee(int age) {
    if (age >= 60) return 30.0;  // Senior discount
    return 50.0;  // Regular fee
}

Clearance issueClearance(int id, string name, int age, string purpose) {
    Clearance c;
    c.id = id;
    c.residentName = name;
    c.age = age;
    c.purpose = purpose;
    c.fee = calculateFee(age);
    return c;
}

void displayClearance(const Clearance& c) {
    cout << "\n===== BARANGAY CLEARANCE =====\n";
    cout << "ID: " << c.id << endl;
    cout << "Name: " << c.residentName << endl;
    cout << "Age: " << c.age << endl;
    cout << "Purpose: " << c.purpose << endl;
    cout << "Fee: P" << c.fee << endl;
    cout << "==============================\n";
}

int main() {
    const int MAX_CLEARANCES = 3;
    Clearance clearances[MAX_CLEARANCES];
    
    for (int i = 0; i < MAX_CLEARANCES; i++) {
        string name, purpose;
        int age;
        
        cout << "\nClearance " << (i + 1) << ":\n";
        cout << "Name: ";
        cin.ignore();
        getline(cin, name);
        cout << "Age: ";
        cin >> age;
        cout << "Purpose: ";
        cin.ignore();
        getline(cin, purpose);
        
        clearances[i] = issueClearance(i + 1001, name, age, purpose);
    }
    
    cout << "\n===== CLEARANCES ISSUED =====\n";
    for (int i = 0; i < MAX_CLEARANCES; i++) {
        displayClearance(clearances[i]);
    }
    
    double totalRevenue = 0;
    for (int i = 0; i < MAX_CLEARANCES; i++) {
        totalRevenue += clearances[i].fee;
    }
    
    cout << "\nTotal Revenue: P" << totalRevenue << endl;
    
    return 0;
}
```

---

## Structs vs Arrays

| Feature | Array | Struct |
|---------|-------|--------|
| **Data types** | Same type only | Different types |
| **Access** | Index (`arr[0]`) | Member name (`.name`) |
| **Purpose** | Collection of same items | Group related attributes |

**Example:**
```cpp
// Array: Same type
int ages[3] = {25, 30, 28};

// Struct: Different types
struct Person {
    string name;  // string
    int age;      // int
    double balance;  // double
};
```

---

## Nested Structs

Structs can contain other structs:

```cpp
struct Address {
    string street;
    string barangay;
    string city;
};

struct Resident {
    string name;
    int age;
    Address address;  // Nested struct
};

int main() {
    Resident person;
    person.name = "Juan";
    person.age = 30;
    person.address.street = "123 Maharlika St.";
    person.address.barangay = "San Antonio";
    person.address.city = "Iloilo City";
    
    cout << person.name << " lives at " << person.address.street << endl;
    
    return 0;
}
```

---

## Pointers to Structs

```cpp
Resident person = {"Juan", 30, 1000.0};
Resident* ptr = &person;

// Access via pointer: use ->
cout << ptr->name << endl;       // "Juan"
cout << ptr->age << endl;        // 30

// Equivalent to:
cout << (*ptr).name << endl;
```

**Arrow operator `->` is shorthand for `(*ptr).member`**

---

## Dynamic Allocation of Structs

```cpp
Resident* ptr = new Resident;
ptr->name = "Juan";
ptr->age = 30;
ptr->balance = 1000.0;

cout << ptr->name << endl;

delete ptr;
```

**Array of structs:**
```cpp
int n = 5;
Resident* residents = new Resident[n];

for (int i = 0; i < n; i++) {
    residents[i].name = "Resident " + to_string(i + 1);
    residents[i].age = 25 + i;
}

delete[] residents;
```

---

## Comparing Structs

C++ doesn't have default comparison for structs:

```cpp
Resident r1 = {"Juan", 30, 1000.0};
Resident r2 = {"Juan", 30, 1000.0};

// if (r1 == r2) { }  // ❌ ERROR! No default comparison
```

**You must compare member-by-member:**
```cpp
if (r1.name == r2.name && r1.age == r2.age && r1.balance == r2.balance) {
    cout << "Equal!" << endl;
}
```

**Or create a function:**
```cpp
bool areEqual(const Resident& r1, const Resident& r2) {
    return r1.name == r2.name && 
           r1.age == r2.age && 
           r1.balance == r2.balance;
}
```

---

## Best Practices

### 1. Use Meaningful Names
```cpp
struct Resident {  // ✓ Clear
    string name;
    int age;
};
```

### 2. Use Const Reference for Read-Only
```cpp
void display(const Resident& r) {  // ✓ Efficient, safe
    cout << r.name;
}
```

### 3. Initialize Structs
```cpp
Resident person = {"Juan", 30, 1000.0};  // ✓ Initialized
```

### 4. Group Related Data
```cpp
// ❌ BAD: Separate arrays
string names[10];
int ages[10];
double balances[10];

// ✓ GOOD: Struct array
Resident residents[10];
```

---

## Common Mistakes

### Mistake 1: Forgetting Semicolon
```cpp
struct Resident {
    string name;
    int age;
}  // ❌ Missing semicolon

struct Resident {
    string name;
    int age;
};  // ✓ Correct
```

### Mistake 2: Wrong Access Operator
```cpp
Resident person;
Resident* ptr = &person;

cout << ptr.name;   // ❌ WRONG (. for pointers)
cout << ptr->name;  // ✓ CORRECT (-> for pointers)
```

### Mistake 3: Uninitialized Members
```cpp
Resident person;  // Members have garbage values!
cout << person.age;  // Unpredictable

// ✓ Initialize
Resident person = {"Juan", 30, 1000.0};
```

---

## Summary

Tian organized data into structs. "This is so much cleaner than ten arrays!"

"Exactly!" Kuya Miguel said. "Structs let you:
- **Group related data** together
- **Create custom types** for your domain
- **Pass complex data** to functions easily
- **Organize code** logically"

"Next," Kuya Miguel said, "we'll take structs further with **nested structs** and build more complex systems!"

---

**Key Takeaways:**
1. Structs group related variables of different types
2. Access members with `.` (dot operator)
3. Pass by const reference for efficiency
4. Use `->` for pointers to structs
5. Structs make code more organized and maintainable

---

## Closing Story

"This changes everything!" Tian said, looking at his clearance system. Instead of ten separate arrays, he now had one clean Clearance struct array holding all related data together.

Kuya Miguel nodded. "That's the power of grouping. Name, age, purpose, fee, status: all bundled as one logical unit. One clearance object, not five disconnected pieces of data."

Tian practiced passing structs to functions, using const reference for read-only efficiency, regular reference for modifications, and the arrow operator for pointers. "And I can create arrays of structs, return structs from functions, even nest structs inside other structs."

"Exactly! Structs let you model real-world entities. A resident isn't just a name and an age: it's a complete package of information. Now imagine if that resident also has an address with street, barangay, city."

Tian's eyes widened. "Nested structs!"

"That's next. Building complex structures from simple building blocks."

**Next Lesson:** Nested Structs and Complex Data Structures
