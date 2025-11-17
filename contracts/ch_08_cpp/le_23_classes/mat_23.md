# Lesson 23: Classes and Objects - The Heart of OOP

**Estimated Reading Time:** 12 minutes

---

## The Story

"Kuya, structs are great, but I heard about **classes**. What's the difference?"

"Ah!" Kuya Miguel smiled. "Classes are like structs, but with **superpowers**. They can have **functions inside them** and control **who can access what**. Welcome to **Object-Oriented Programming (OOP)**!"

---

## What is a Class?

A **class** is a blueprint for creating objects. It bundles **data** (variables) and **behavior** (functions) together.

```cpp
class Resident {
public:
    // Data (attributes/properties)
    string name;
    int age;
    
    // Behavior (methods/functions)
    void introduce() {
        cout << "Hi, I'm " << name << ", " << age << " years old.\n";
    }
};
```

---

## Creating Objects

```cpp
int main() {
    Resident resident1;  // Create object
    resident1.name = "Juan Dela Cruz";
    resident1.age = 30;
    resident1.introduce();  // Call method
    
    Resident resident2;
    resident2.name = "Maria Santos";
    resident2.age = 25;
    resident2.introduce();
    
    return 0;
}
```

**Output:**
```
Hi, I'm Juan Dela Cruz, 30 years old.
Hi, I'm Maria Santos, 25 years old.
```

---

## Class vs Struct

In C++, classes and structs are almost identical, with ONE key difference:

```cpp
// Struct: members PUBLIC by default
struct Person {
    string name;  // Public
    int age;      // Public
};

// Class: members PRIVATE by default
class Person {
    string name;  // Private
    int age;      // Private
};
```

**Convention:**
- Use **struct** for simple data containers
- Use **class** for objects with behavior and data hiding

---

## Access Specifiers

Control who can access class members:

```cpp
class BankAccount {
private:
    double balance;  // Only accessible inside the class
    
public:
    string accountNumber;  // Accessible from anywhere
    
    void deposit(double amount) {
        balance += amount;  // Can access private member
    }
    
    double getBalance() {
        return balance;  // Can return private data
    }
};

int main() {
    BankAccount account;
    account.accountNumber = "1001";
    
    // account.balance = 10000;  // ❌ Error! balance is private
    
    account.deposit(5000);  // ✓ OK! Public method
    cout << account.getBalance();  // ✓ OK! Get balance through public method
    
    return 0;
}
```

---

## Public vs Private

```cpp
class Resident {
private:
    int id;           // Hidden from outside
    double balance;   // Hidden from outside
    
public:
    string name;      // Accessible
    
    void setId(int newId) {
        id = newId;
    }
    
    int getId() {
        return id;
    }
    
    void addBalance(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    double getBalance() {
        return balance;
    }
};
```

---

## Methods Inside vs Outside Class

### Method Inside Class
```cpp
class Resident {
public:
    string name;
    
    void introduce() {  // Defined inside
        cout << "I'm " << name << endl;
    }
};
```

### Method Outside Class
```cpp
class Resident {
public:
    string name;
    void introduce();  // Declaration only
};

// Definition outside (use ::)
void Resident::introduce() {
    cout << "I'm " << name << endl;
}
```

---

## Practical Example: Barangay Clearance System

```cpp
#include <iostream>
#include <string>
using namespace std;

class Clearance {
private:
    int id;
    string residentName;
    string type;
    double fee;
    string status;  // "pending", "approved", "rejected"
    
public:
    // Set data
    void setDetails(int _id, string _name, string _type, double _fee) {
        id = _id;
        residentName = _name;
        type = _type;
        fee = _fee;
        status = "pending";
    }
    
    // Get data
    int getId() {
        return id;
    }
    
    string getStatus() {
        return status;
    }
    
    // Actions
    void approve() {
        status = "approved";
        cout << "Clearance #" << id << " approved!\n";
    }
    
    void reject(string reason) {
        status = "rejected";
        cout << "Clearance #" << id << " rejected: " << reason << endl;
    }
    
    void display() {
        cout << "\n===== CLEARANCE #" << id << " =====\n";
        cout << "Resident: " << residentName << endl;
        cout << "Type: " << type << endl;
        cout << "Fee: P" << fee << endl;
        cout << "Status: " << status << endl;
        cout << "==============================\n";
    }
};

int main() {
    Clearance c1;
    c1.setDetails(1001, "Juan Dela Cruz", "Residence", 50.0);
    c1.display();
    
    c1.approve();
    c1.display();
    
    Clearance c2;
    c2.setDetails(1002, "Maria Santos", "Business", 100.0);
    c2.display();
    
    c2.reject("Missing documents");
    c2.display();
    
    return 0;
}
```

---

## Arrays of Objects

```cpp
class Resident {
public:
    string name;
    int age;
    
    void display() {
        cout << name << " (" << age << " years old)\n";
    }
};

int main() {
    Resident residents[3];
    
    residents[0].name = "Juan";
    residents[0].age = 30;
    
    residents[1].name = "Maria";
    residents[1].age = 25;
    
    residents[2].name = "Pedro";
    residents[2].age = 35;
    
    for (int i = 0; i < 3; i++) {
        residents[i].display();
    }
    
    return 0;
}
```

---

## Getter and Setter Pattern

**Why?** Control access to private data.

```cpp
class BankAccount {
private:
    double balance;
    
public:
    // Setter with validation
    void setBalance(double amount) {
        if (amount >= 0) {
            balance = amount;
        } else {
            cout << "Invalid amount!\n";
        }
    }
    
    // Getter (read-only access)
    double getBalance() {
        return balance;
    }
};

int main() {
    BankAccount account;
    
    account.setBalance(5000);  // ✓ Valid
    cout << account.getBalance() << endl;  // 5000
    
    account.setBalance(-1000);  // ❌ Rejected by validation
    cout << account.getBalance() << endl;  // Still 5000
    
    return 0;
}
```

---

## This Pointer

`this` is a pointer to the current object:

```cpp
class Resident {
private:
    string name;
    int age;
    
public:
    void setName(string name) {
        this->name = name;  // this->name (class member) = name (parameter)
    }
    
    void setAge(int age) {
        this->age = age;
    }
    
    void display() {
        cout << this->name << " is " << this->age << " years old\n";
    }
};
```

---

## Real-World Example: Barangay Dues System

```cpp
class DuesAccount {
private:
    int residentId;
    string residentName;
    double balance;
    double totalPaid;
    
public:
    void initialize(int id, string name) {
        residentId = id;
        residentName = name;
        balance = 0;
        totalPaid = 0;
    }
    
    void addDues(double amount) {
        balance += amount;
        cout << "Added P" << amount << " to " << residentName << "'s dues\n";
    }
    
    void makePayment(double amount) {
        if (amount > balance) {
            cout << "Payment exceeds balance!\n";
            return;
        }
        
        balance -= amount;
        totalPaid += amount;
        cout << residentName << " paid P" << amount << endl;
    }
    
    void displayAccount() {
        cout << "\n===== ACCOUNT: " << residentName << " =====\n";
        cout << "ID: " << residentId << endl;
        cout << "Current Balance: P" << balance << endl;
        cout << "Total Paid: P" << totalPaid << endl;
        cout << "===================================\n";
    }
    
    double getBalance() {
        return balance;
    }
};

int main() {
    DuesAccount accounts[3];
    
    accounts[0].initialize(1001, "Juan Dela Cruz");
    accounts[1].initialize(1002, "Maria Santos");
    accounts[2].initialize(1003, "Pedro Reyes");
    
    // Add monthly dues
    for (int i = 0; i < 3; i++) {
        accounts[i].addDues(50.0);
    }
    
    // Display all
    for (int i = 0; i < 3; i++) {
        accounts[i].displayAccount();
    }
    
    // Maria makes payment
    accounts[1].makePayment(50.0);
    accounts[1].displayAccount();
    
    return 0;
}
```

---

## Why Use Classes?

1. **Encapsulation:** Bundle data and functions together
2. **Data Hiding:** Control access with private/public
3. **Validation:** Add checks in setters
4. **Organization:** Code is cleaner and more maintainable
5. **Reusability:** Create multiple objects from one class

---

## Summary

"Now I understand!" Tian exclaimed. "Classes let me create my own data types with built-in behavior!"

"Exactly!" Kuya Miguel said. "Remember:
- **Class** = Blueprint
- **Object** = Instance of a class
- **Private** = Hidden data
- **Public** = Accessible interface
- **Methods** = Functions inside class
- **Encapsulation** = Bundling data + behavior"

"Next: **Constructors** — automatic initialization!"

---

**Key Takeaways:**
1. Classes bundle data and behavior
2. Private hides implementation details
3. Public provides interface
4. Methods operate on object data
5. Use this-> to reference current object

**Next Lesson:** Constructors and Destructors
