# Lesson 26: Inheritance - Building Class Hierarchies

**Estimated Reading Time:** 12 minutes

---

## The Story

"Kuya, I have `Resident`, `Business`, and `Official` classes with similar code. Can I avoid duplication?"

"Use **inheritance**!" Kuya Miguel exclaimed. "Create a base class with common features, then derive specialized classes from it!"

---

## What is Inheritance?

**Inheritance** allows a class to inherit properties and methods from another class.

```cpp
// Base class (parent)
class Person {
protected:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {}
    
    void display() {
        cout << name << " (" << age << " years old)" << endl;
    }
};

// Derived class (child)
class Resident : public Person {
private:
    string barangay;
    
public:
    Resident(string n, int a, string brgy) 
        : Person(n, a), barangay(brgy) {}
    
    void showBarangay() {
        cout << name << " lives in " << barangay << endl;
    }
};

int main() {
    Resident r("Juan Dela Cruz", 30, "San Antonio");
    r.display();           // Inherited from Person
    r.showBarangay();      // Own method
    return 0;
}
```

---

## Inheritance Syntax

```cpp
class DerivedClass : access_specifier BaseClass {
    // Additional members
};
```

**Access specifiers:**
- `public`: Public members of base remain public in derived
- `protected`: Public members of base become protected in derived
- `private`: Public members of base become private in derived

---

## Protected Members

```cpp
class Person {
private:
    int id;              // Only accessible in Person
    
protected:
    string name;         // Accessible in Person and derived classes
    int age;
    
public:
    void display() {
        cout << name << " - " << age << endl;
    }
};

class Employee : public Person {
public:
    void setDetails(string n, int a) {
        name = n;        // ✓ Can access protected members
        age = a;
        // id = 123;     // ❌ Can't access private members
    }
};
```

---

## Constructor Chaining

Derived classes must call base class constructors:

```cpp
class Person {
protected:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {
        cout << "Person constructor\n";
    }
};

class Resident : public Person {
private:
    double balance;
    
public:
    // Must call Person constructor
    Resident(string n, int a, double bal) 
        : Person(n, a), balance(bal) {
        cout << "Resident constructor\n";
    }
};

int main() {
    Resident r("Juan", 30, 1000.0);
    // Output:
    // Person constructor
    // Resident constructor
    return 0;
}
```

---

## Types of Inheritance

### 1. Single Inheritance
```cpp
class Animal {
public:
    void eat() {
        cout << "Eating...\n";
    }
};

class Dog : public Animal {
public:
    void bark() {
        cout << "Woof!\n";
    }
};
```

### 2. Multilevel Inheritance
```cpp
class Person {
public:
    string name;
};

class Resident : public Person {
public:
    string barangay;
};

class Official : public Resident {
public:
    string position;
};
```

### 3. Multiple Inheritance
```cpp
class Resident {
public:
    string address;
};

class BusinessOwner {
public:
    string businessName;
};

class ResidentBusinessOwner : public Resident, public BusinessOwner {
public:
    void display() {
        cout << "Lives at: " << address << endl;
        cout << "Owns: " << businessName << endl;
    }
};
```

---

## Method Overriding

Derived classes can override base class methods:

```cpp
class Person {
protected:
    string name;
    
public:
    Person(string n) : name(n) {}
    
    void introduce() {
        cout << "I'm " << name << endl;
    }
};

class Official : public Person {
private:
    string position;
    
public:
    Official(string n, string pos) : Person(n), position(pos) {}
    
    // Override introduce()
    void introduce() {
        cout << "I'm " << name << ", " << position << " of the barangay\n";
    }
};

int main() {
    Person p("Juan");
    p.introduce();  // "I'm Juan"
    
    Official o("Maria", "Captain");
    o.introduce();  // "I'm Maria, Captain of the barangay"
    
    return 0;
}
```

---

## Practical Example: Barangay Management System

```cpp
#include <iostream>
#include <string>
using namespace std;

// Base class
class Person {
protected:
    int id;
    string name;
    int age;
    
public:
    Person(int i, string n, int a) : id(i), name(n), age(a) {
        cout << "Person created: " << name << endl;
    }
    
    virtual void display() {
        cout << "\n===== PERSON INFO =====\n";
        cout << "ID: " << id << endl;
        cout << "Name: " << name << endl;
        cout << "Age: " << age << endl;
    }
    
    int getId() const { return id; }
    string getName() const { return name; }
};

// Derived class 1: Resident
class Resident : public Person {
private:
    string barangay;
    double balance;
    
public:
    Resident(int i, string n, int a, string brgy) 
        : Person(i, n, a), barangay(brgy), balance(0) {
        cout << "Resident created in " << barangay << endl;
    }
    
    void addDues(double amount) {
        balance += amount;
    }
    
    void display() override {
        Person::display();  // Call base class method
        cout << "Barangay: " << barangay << endl;
        cout << "Balance: P" << balance << endl;
        cout << "=======================\n";
    }
};

// Derived class 2: Official
class Official : public Person {
private:
    string position;
    double salary;
    
public:
    Official(int i, string n, int a, string pos, double sal) 
        : Person(i, n, a), position(pos), salary(sal) {
        cout << "Official assigned: " << position << endl;
    }
    
    void display() override {
        Person::display();
        cout << "Position: " << position << endl;
        cout << "Salary: P" << salary << endl;
        cout << "=======================\n";
    }
};

// Derived class 3: BusinessOwner (from Resident)
class BusinessOwner : public Resident {
private:
    string businessName;
    string businessType;
    
public:
    BusinessOwner(int i, string n, int a, string brgy, string bName, string bType)
        : Resident(i, n, a, brgy), businessName(bName), businessType(bType) {
        cout << "Business registered: " << businessName << endl;
    }
    
    void display() override {
        Resident::display();
        cout << "Business: " << businessName << endl;
        cout << "Type: " << businessType << endl;
        cout << "=======================\n";
    }
};

int main() {
    cout << "=== BARANGAY MANAGEMENT SYSTEM ===\n\n";
    
    Resident r(1001, "Juan Dela Cruz", 30, "San Antonio");
    r.addDues(50.0);
    r.display();
    
    Official o(2001, "Maria Santos", 45, "Barangay Captain", 25000.0);
    o.display();
    
    BusinessOwner b(3001, "Pedro Reyes", 40, "San Pedro", 
                    "Pedro's Sari-Sari Store", "Retail");
    b.addDues(100.0);
    b.display();
    
    return 0;
}
```

---

## Calling Base Class Methods

```cpp
class Base {
public:
    void show() {
        cout << "Base show()\n";
    }
};

class Derived : public Base {
public:
    void show() {
        Base::show();  // Call base class version
        cout << "Derived show()\n";
    }
};
```

---

## Access Control in Inheritance

```cpp
class Base {
private:
    int privateVar;      // Not inherited
    
protected:
    int protectedVar;    // Inherited, accessible in derived
    
public:
    int publicVar;       // Inherited, accessible everywhere
};

class Derived : public Base {
public:
    void test() {
        // privateVar = 10;    // ❌ Error!
        protectedVar = 20;     // ✓ OK
        publicVar = 30;        // ✓ OK
    }
};
```

---

## Is-A Relationship

Inheritance represents "is-a" relationship:

```cpp
// Resident IS-A Person ✓
class Resident : public Person { };

// Official IS-A Person ✓
class Official : public Person { };

// Car IS-A Vehicle ✓
class Car : public Vehicle { };

// Student IS-A School ❌ (should use composition)
```

---

## Summary

"Inheritance eliminates code duplication!" Tian exclaimed.

"Exactly!" Kuya Miguel said. "Remember:
- **Base class** = common features
- **Derived class** = specialized features
- **protected** = accessible in derived classes
- **Override** = replace base class method
- **Call base method** with `BaseClass::method()`"

"Next: **Polymorphism** — one interface, many forms!"

---

**Key Takeaways:**
1. Inheritance enables code reuse
2. Derived classes inherit base class members
3. Protected members accessible in derived classes
4. Override methods for specialization
5. Use inheritance for "is-a" relationships

**Next Lesson:** Polymorphism - The Power of Virtual Functions
