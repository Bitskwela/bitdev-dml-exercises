# Lesson 20: Nested Structs and Complex Data Structures

**Estimated Reading Time:** 11 minutes

---

## The Story

"Kuya," Tian said, "what if a resident has an address with street, barangay, and city? Do I make separate variables?"

"No! Use **nested structs** — structs inside structs. Build complex data structures from simple building blocks."

---

## Nested Structs

Structs can contain other structs as members:

```cpp
struct Address {
    string street;
    string barangay;
    string city;
    string zipCode;
};

struct Resident {
    string name;
    int age;
    Address address;  // Nested struct
};
```

---

## Accessing Nested Members

Chain the dot operator:

```cpp
Resident person;
person.name = "Juan Dela Cruz";
person.age = 30;
person.address.street = "123 Maharlika Street";
person.address.barangay = "San Antonio";
person.address.city = "Iloilo City";
person.address.zipCode = "5000";

cout << person.name << " lives at:" << endl;
cout << person.address.street << endl;
cout << person.address.barangay << ", " << person.address.city << endl;
```

---

## Initializing Nested Structs

```cpp
Resident person = {
    "Juan Dela Cruz",
    30,
    {"123 Maharlika St", "San Antonio", "Iloilo City", "5000"}
};

// Or step by step:
Address addr = {"123 Maharlika St", "San Antonio", "Iloilo City", "5000"};
Resident person2 = {"Maria Santos", 25, addr};
```

---

## Practical Example: Barangay Resident Management

```cpp
#include <iostream>
#include <string>
using namespace std;

struct Address {
    string street;
    string barangay;
    string city;
};

struct ContactInfo {
    string phone;
    string email;
};

struct Resident {
    int id;
    string name;
    int age;
    Address address;
    ContactInfo contact;
    double balance;
};

void displayResident(const Resident& r) {
    cout << "\n===== RESIDENT INFORMATION =====\n";
    cout << "ID: " << r.id << endl;
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "\nAddress:\n";
    cout << "  " << r.address.street << endl;
    cout << "  " << r.address.barangay << ", " << r.address.city << endl;
    cout << "\nContact:\n";
    cout << "  Phone: " << r.contact.phone << endl;
    cout << "  Email: " << r.contact.email << endl;
    cout << "Balance: P" << r.balance << endl;
    cout << "================================\n";
}

int main() {
    Resident resident = {
        1001,
        "Juan Dela Cruz",
        30,
        {"123 Maharlika St", "San Antonio", "Iloilo City"},
        {"09171234567", "juan@example.com"},
        1000.0
    };
    
    displayResident(resident);
    
    return 0;
}
```

---

## Arrays of Nested Structs

```cpp
const int MAX_RESIDENTS = 3;
Resident residents[MAX_RESIDENTS] = {
    {1001, "Juan Dela Cruz", 30, 
     {"123 Main St", "San Antonio", "Iloilo City"},
     {"09171234567", "juan@example.com"}, 1000.0},
    
    {1002, "Maria Santos", 25,
     {"456 Rizal Ave", "San Pedro", "Iloilo City"},
     {"09187654321", "maria@example.com"}, 1500.0},
    
    {1003, "Pedro Reyes", 35,
     {"789 Luna St", "San Jose", "Iloilo City"},
     {"09199876543", "pedro@example.com"}, 2000.0}
};

// Access nested data
for (int i = 0; i < MAX_RESIDENTS; i++) {
    cout << residents[i].name << " - " << residents[i].address.barangay << endl;
}
```

---

## Pointers to Nested Structs

```cpp
Resident person = {1001, "Juan", 30, {"123 Main", "Brgy A", "City"}, {"0917", "email"}, 1000.0};
Resident* ptr = &person;

// Access nested members
cout << ptr->name << endl;
cout << ptr->address.street << endl;  // Arrow for pointer, dot for nested
cout << ptr->contact.phone << endl;

// Or fully with arrows (if address was also a pointer)
// cout << ptr->address->street;  // If address was Address*
```

---

## Deeply Nested Structs

```cpp
struct Country {
    string name;
    string code;
};

struct City {
    string name;
    Country country;
};

struct Address {
    string street;
    string barangay;
    City city;
};

struct Resident {
    string name;
    Address address;
};

int main() {
    Resident r = {
        "Juan",
        {"123 Main", "Brgy A", {"Iloilo City", {"Philippines", "PH"}}}
    };
    
    cout << r.name << " lives in " << r.address.city.name << ", ";
    cout << r.address.city.country.name << endl;
    
    return 0;
}
```

---

## Struct with Array Members

```cpp
struct Student {
    string name;
    double grades[5];
    int numGrades;
};

void displayStudent(const Student& s) {
    cout << "Student: " << s.name << endl;
    cout << "Grades: ";
    for (int i = 0; i < s.numGrades; i++) {
        cout << s.grades[i] << " ";
    }
    cout << endl;
}

int main() {
    Student student = {"Juan", {85.5, 90.0, 88.5, 92.0, 87.5}, 5};
    displayStudent(student);
    return 0;
}
```

---

## Typedef for Cleaner Code

Use `typedef` to create aliases:

```cpp
typedef struct {
    string street;
    string barangay;
    string city;
} Address;

typedef struct {
    string name;
    int age;
    Address address;
} Resident;

// Now use directly:
Resident person = {"Juan", 30, {"Main St", "Brgy A", "City"}};
```

**C++11 alternative:** `using`
```cpp
using Address = struct {
    string street;
    string barangay;
    string city;
};
```

---

## Best Practices

### 1. Keep Nesting Reasonable
```cpp
// ✓ GOOD: 2-3 levels
struct Resident {
    string name;
    Address address;  // One level
};

// ❌ TOO DEEP: Hard to maintain
struct A {
    B b;
    struct B {
        C c;
        struct C {
            D d;
            struct D {
                // ...
            };
        };
    };
};
```

### 2. Reuse Struct Definitions
```cpp
struct Address {
    string street;
    string city;
};

struct Resident {
    string name;
    Address homeAddress;
    Address workAddress;  // Reuse!
};
```

### 3. Use Const References
```cpp
void display(const Resident& r) {  // Efficient
    cout << r.address.street;
}
```

---

## Common Patterns

### Pattern 1: Database Record
```cpp
struct Employee {
    int id;
    string name;
    string department;
    double salary;
    Address address;
    ContactInfo contact;
};
```

### Pattern 2: Linked Data
```cpp
struct Transaction {
    int id;
    double amount;
    string type;
    string date;
    Resident resident;  // Related resident data
};
```

### Pattern 3: Hierarchical Data
```cpp
struct Department {
    string name;
    Employee manager;
    Employee employees[50];
    int employeeCount;
};
```

---

## Summary

"Now I can model real-world data!" Tian exclaimed.

"Exactly!" Kuya Miguel said. "Nested structs let you:
- **Build complex types** from simple ones
- **Model real-world relationships** (person has address)
- **Organize data hierarchically**
- **Keep code maintainable**"

"Next: **Enums** — giving names to numbers!"

---

**Key Takeaways:**
1. Structs can contain other structs
2. Access nested members with chained dots
3. Keep nesting levels reasonable (2-3 max)
4. Reuse struct definitions
5. Use const references for efficiency

**Next Lesson:** Enums - Named Constants
