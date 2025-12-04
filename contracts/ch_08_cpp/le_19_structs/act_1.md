# Lesson 19 Activities: Structs

## No More Parallel Arrays!

Tian's resident tracking system was a **nightmare**:
```cpp
string names[100];
int ages[100];
string addresses[100];
```

**If indices got misaligned, chaos!** Resident 0's name with resident 12's age? Disaster.

**Structs bundle related data together.** One `Resident` struct holds name, age, and address. No more parallel array hell!

---

## Task 1: Basic Struct Declaration

**Context:** Group related data into a custom type.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

int main() {
    // Create a Resident
    Resident r1;
    r1.name = "Juan Dela Cruz";
    r1.age = 35;
    r1.address = "123 Main St, Iloilo";
    
    // Access members with dot operator
    cout << "Name: " << r1.name << endl;
    cout << "Age: " << r1.age << endl;
    cout << "Address: " << r1.address << endl;
    
    return 0;
}
```

**Task:** Create a `Student` struct with name, grade, and section.

---

## Task 2: Struct Initialization

**Context:** Different ways to create and initialize structs.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Product {
    string name;
    double price;
    int quantity;
};

int main() {
    // Method 1: Declare then assign
    Product p1;
    p1.name = "Rice";
    p1.price = 50.0;
    p1.quantity = 10;
    
    // Method 2: Aggregate initialization
    Product p2 = {"Sardines", 25.0, 20};
    
    // Method 3: Uniform initialization (C++11)
    Product p3{"Cooking Oil", 150.0, 5};
    
    cout << "Product 1: " << p1.name << " - P" << p1.price << endl;
    cout << "Product 2: " << p2.name << " - P" << p2.price << endl;
    cout << "Product 3: " << p3.name << " - P" << p3.price << endl;
    
    return 0;
}
```

---

## Task 3: Array of Structs

**Context:** Replace parallel arrays with struct array.

**Challenge:** Manage multiple residents cleanly.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string barangay;
};

int main() {
    Resident residents[5] = {
        {"Juan Dela Cruz", 35, "Poblacion"},
        {"Maria Santos", 28, "San Jose"},
        {"Pedro Garcia", 42, "Santa Maria"},
        {"Ana Reyes", 31, "Del Pilar"},
        {"Jose Mendoza", 39, "San Antonio"}
    };
    
    cout << "=== RESIDENT LIST ===" << endl;
    for (int i = 0; i < 5; i++) {
        cout << (i+1) << ". " << residents[i].name 
             << " (" << residents[i].age << " years old) - " 
             << residents[i].barangay << endl;
    }
    
    return 0;
}
```

**Compare:** 1 array of structs vs 3 parallel arrays. Which is cleaner?

---

## Task 4: Structs with Functions

**Context:** Pass structs to functions.

**Challenge:** Create functions to process resident data.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

void displayResident(Resident r) {
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Address: " << r.address << endl;
}

bool isSenior(Resident r) {
    return r.age >= 60;
}

int main() {
    Resident r1 = {"Juan Dela Cruz", 65, "123 Main St"};
    Resident r2 = {"Maria Santos", 28, "456 Oak Ave"};
    
    displayResident(r1);
    cout << "Senior citizen: " << (isSenior(r1) ? "Yes" : "No") << endl;
    cout << endl;
    
    displayResident(r2);
    cout << "Senior citizen: " << (isSenior(r2) ? "Yes" : "No") << endl;
    
    return 0;
}
```

---

## Task 5: Modifying Structs in Functions

**Context:** Pass by reference to modify original struct.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct BankAccount {
    string owner;
    double balance;
};

void deposit(BankAccount& account, double amount) {
    account.balance += amount;
    cout << "Deposited P" << amount << endl;
}

void withdraw(BankAccount& account, double amount) {
    if (account.balance >= amount) {
        account.balance -= amount;
        cout << "Withdrew P" << amount << endl;
    } else {
        cout << "Insufficient balance!" << endl;
    }
}

void displayAccount(const BankAccount& account) {
    cout << "Owner: " << account.owner << endl;
    cout << "Balance: P" << account.balance << endl;
}

int main() {
    BankAccount acc = {"Juan Dela Cruz", 5000.0};
    
    displayAccount(acc);
    cout << endl;
    
    deposit(acc, 2000.0);
    withdraw(acc, 1500.0);
    cout << endl;
    
    displayAccount(acc);
    
    return 0;
}
```

**Expected:** Balance: 5000 → 7000 → 5500

---

## Task 6: Comparing Structs

**Context:** Find specific records in struct array.

**Challenge:** Search for resident by name.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

int findResident(Resident residents[], int size, string searchName) {
    for (int i = 0; i < size; i++) {
        if (residents[i].name == searchName) {
            return i;  // Found!
        }
    }
    return -1;  // Not found
}

int main() {
    Resident residents[5] = {
        {"Juan Dela Cruz", 35, "123 Main St"},
        {"Maria Santos", 28, "456 Oak Ave"},
        {"Pedro Garcia", 42, "789 Pine Rd"},
        {"Ana Reyes", 31, "321 Elm St"},
        {"Jose Mendoza", 39, "654 Maple Dr"}
    };
    
    string searchName;
    cout << "Enter name to search: ";
    getline(cin, searchName);
    
    int index = findResident(residents, 5, searchName);
    
    if (index != -1) {
        cout << "Found!" << endl;
        cout << "Name: " << residents[index].name << endl;
        cout << "Age: " << residents[index].age << endl;
        cout << "Address: " << residents[index].address << endl;
    } else {
        cout << "Resident not found." << endl;
    }
    
    return 0;
}
```

---

## Task 7: Barangay Management System

**Context:** Build complete system using structs.

**Challenge:** Register residents, display list, search.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
    string contactNumber;
};

void displayResident(const Resident& r, int number) {
    cout << "\nResident #" << number << endl;
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Address: " << r.address << endl;
    cout << "Contact: " << r.contactNumber << endl;
}

void displayAllResidents(Resident residents[], int count) {
    cout << "\n=== ALL RESIDENTS ===" << endl;
    for (int i = 0; i < count; i++) {
        displayResident(residents[i], i + 1);
    }
    cout << "Total: " << count << " residents" << endl;
}

int countSeniors(Resident residents[], int count) {
    int seniors = 0;
    for (int i = 0; i < count; i++) {
        if (residents[i].age >= 60) seniors++;
    }
    return seniors;
}

int main() {
    const int MAX_RESIDENTS = 100;
    Resident residents[MAX_RESIDENTS];
    int count = 0;
    
    cout << "=== BARANGAY RESIDENT REGISTRATION ===" << endl;
    
    char addMore = 'y';
    while (addMore == 'y' && count < MAX_RESIDENTS) {
        cout << "\n--- Resident " << (count + 1) << " ---" << endl;
        
        cin.ignore();
        cout << "Name: ";
        getline(cin, residents[count].name);
        
        cout << "Age: ";
        cin >> residents[count].age;
        
        cin.ignore();
        cout << "Address: ";
        getline(cin, residents[count].address);
        
        cout << "Contact Number: ";
        getline(cin, residents[count].contactNumber);
        
        count++;
        
        if (count < MAX_RESIDENTS) {
            cout << "Add another resident? (y/n): ";
            cin >> addMore;
        }
    }
    
    displayAllResidents(residents, count);
    
    int seniors = countSeniors(residents, count);
    cout << "\nSenior citizens: " << seniors << endl;
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Struct Essentials</strong></summary>

**Syntax:**
```cpp
struct StructName {
    type1 member1;
    type2 member2;
    // ...
};

StructName obj;
obj.member1 = value;
```

**Why Structs?**
- Bundle related data together
- Create custom data types
- Cleaner than parallel arrays
- Foundation for OOP (classes are structs with methods)

**Struct vs Parallel Arrays:**

**Before (Parallel Arrays - BAD):**
```cpp
string names[100];
int ages[100];
string addresses[100];
// If indices misalign = disaster!
```

**After (Struct Array - GOOD):**
```cpp
struct Resident {
    string name;
    int age;
    string address;
};
Resident residents[100];
// Data stays together!
```

**Pass by Value vs Reference:**
```cpp
// Pass by value: copies entire struct (expensive!)
void display(Resident r);

// Pass by reference: modify original
void update(Resident& r);

// Const reference: read-only, no copy (efficient!)
void display(const Resident& r);
```

**Common Patterns:**
```cpp
// Array of structs
Resident residents[100];

// Loop through struct array
for (int i = 0; i < size; i++) {
    cout << residents[i].name << endl;
}

// Search in struct array
for (int i = 0; i < size; i++) {
    if (residents[i].name == searchName) {
        return i;
    }
}
```

</details>

---

**Structs are the gateway to OOP!** Next lessons add methods to structs → classes!
