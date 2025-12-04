# Lesson 26 Activities: Inheritance

## The Code Duplication Problem

Three classes: `Resident`, `BarangayOfficial`, `BusinessOwner`. Each had `name`, `age`, `address`, and `display()`. **Nearly identical code across all three!**

"If I add phone number to all three, I modify three classes. If I fix a bug, I fix it three times. **Maintenance hell!**"

**Inheritance solves this.** Create a base `Person` class with common properties. Then `Resident extends Person`, `Official extends Person`. Shared code lives in **one place**. Add phone to Person once → all derived classes get it automatically!

**Inheritance models real-world relationships:** A dog is an animal. A student is a person. This is how large systems stay organized!

---

## Task 1: Basic Inheritance

**Context:** Derive a class from a base class.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

// Base class
class Person {
protected:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {}
    
    void display() {
        cout << "Name: " << name << ", Age: " << age << endl;
    }
};

// Derived class
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
    
    r.display();        // Inherited from Person
    r.showBarangay();   // Own method
    
    return 0;
}
```

---

## Task 2: Protected Members

**Context:** Members accessible in base and derived classes.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Person {
private:
    int id;  // Only Person can access
    
protected:
    string name;  // Person and derived classes can access
    int age;
    
public:
    Person(string n, int a) : id(0), name(n), age(a) {}
    
    void display() {
        cout << name << " (" << age << " years old)" << endl;
    }
};

class Employee : public Person {
private:
    double salary;
    
public:
    Employee(string n, int a, double sal) 
        : Person(n, a), salary(sal) {}
    
    void showInfo() {
        // Can access protected members
        cout << "Employee: " << name << endl;
        cout << "Age: " << age << endl;
        cout << "Salary: P" << salary << endl;
        
        // cout << id;  // ❌ Error! id is private to Person
    }
};

int main() {
    Employee emp("Juan Dela Cruz", 30, 25000.0);
    emp.showInfo();
    
    return 0;
}
```

---

## Task 3: Constructor Chaining

**Context:** Derived class must call base class constructor.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Person {
protected:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {
        cout << "Person constructor: " << name << endl;
    }
};

class Resident : public Person {
private:
    double balance;
    
public:
    // Must call Person constructor
    Resident(string n, int a, double bal) 
        : Person(n, a), balance(bal) {
        cout << "Resident constructor: " << balance << endl;
    }
    
    void display() {
        cout << name << " - Balance: P" << balance << endl;
    }
};

int main() {
    cout << "Creating resident..." << endl;
    Resident r("Juan Dela Cruz", 30, 1000.0);
    cout << endl;
    
    r.display();
    
    return 0;
}
```

**Output:**
```
Creating resident...
Person constructor: Juan Dela Cruz
Resident constructor: 1000
```

---

## Task 4: Method Overriding

**Context:** Derived class can redefine base class methods.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Person {
protected:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {}
    
    void introduce() {
        cout << "Hi, I'm " << name << endl;
    }
};

class Student : public Person {
private:
    string school;
    
public:
    Student(string n, int a, string s) 
        : Person(n, a), school(s) {}
    
    // Override base class method
    void introduce() {
        cout << "Hi, I'm " << name << ", a student at " << school << endl;
    }
};

class Teacher : public Person {
private:
    string subject;
    
public:
    Teacher(string n, int a, string subj) 
        : Person(n, a), subject(subj) {}
    
    void introduce() {
        cout << "Hi, I'm " << name << ", I teach " << subject << endl;
    }
};

int main() {
    Person p("Juan", 30);
    Student s("Maria", 20, "UP Diliman");
    Teacher t("Pedro", 45, "Mathematics");
    
    p.introduce();
    s.introduce();
    t.introduce();
    
    return 0;
}
```

---

## Task 5: Multiple Levels of Inheritance

**Context:** Chain of inheritance (grandparent → parent → child).

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

// Level 1: Base
class LivingBeing {
protected:
    bool isAlive;
    
public:
    LivingBeing() : isAlive(true) {}
    
    void breathe() {
        cout << "Breathing..." << endl;
    }
};

// Level 2: Derived from LivingBeing
class Person : public LivingBeing {
protected:
    string name;
    int age;
    
public:
    Person(string n, int a) : name(n), age(a) {}
    
    void talk() {
        cout << name << " is talking." << endl;
    }
};

// Level 3: Derived from Person
class Student : public Person {
private:
    string school;
    
public:
    Student(string n, int a, string s) 
        : Person(n, a), school(s) {}
    
    void study() {
        cout << name << " is studying at " << school << endl;
    }
};

int main() {
    Student s("Juan", 20, "UP Diliman");
    
    s.breathe();  // From LivingBeing
    s.talk();     // From Person
    s.study();    // From Student
    
    return 0;
}
```

---

## Task 6: Barangay System with Inheritance

**Context:** Complete hierarchy for barangay management.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Person {
protected:
    int id;
    string name;
    int age;
    string address;
    
public:
    Person(int i, string n, int a, string addr) 
        : id(i), name(n), age(a), address(addr) {}
    
    virtual void display() {
        cout << "ID: " << id << endl;
        cout << "Name: " << name << endl;
        cout << "Age: " << age << endl;
        cout << "Address: " << address << endl;
    }
    
    bool isSenior() {
        return age >= 60;
    }
};

class Resident : public Person {
private:
    double balance;
    
public:
    Resident(int i, string n, int a, string addr) 
        : Person(i, n, a, addr), balance(0) {}
    
    void addDues(double amount) {
        balance += amount;
    }
    
    void makePayment(double amount) {
        if (amount <= balance) {
            balance -= amount;
        }
    }
    
    void display() override {
        Person::display();  // Call base class version
        cout << "Balance: P" << balance << endl;
        cout << "Type: Resident" << endl;
    }
};

class Official : public Person {
private:
    string position;
    double salary;
    
public:
    Official(int i, string n, int a, string addr, string pos, double sal) 
        : Person(i, n, a, addr), position(pos), salary(sal) {}
    
    void display() override {
        Person::display();
        cout << "Position: " << position << endl;
        cout << "Salary: P" << salary << endl;
        cout << "Type: Official" << endl;
    }
};

int main() {
    Resident r(1001, "Juan Dela Cruz", 30, "123 Main St");
    r.addDues(500);
    
    cout << "=== RESIDENT ===" << endl;
    r.display();
    cout << endl;
    
    Official o(2001, "Maria Santos", 45, "Municipal Hall", "Barangay Captain", 35000);
    
    cout << "=== OFFICIAL ===" << endl;
    o.display();
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Inheritance Essentials</strong></summary>

**Syntax:**
```cpp
class Derived : public Base {
    // Additional members
};
```

**Access Levels:**
- `private`: Only in class
- `protected`: In class + derived classes
- `public`: Everywhere

**Constructor Chain:**
```cpp
Derived(params) : Base(baseParams), memberInit {
    // Derived initialization
}
```

**Benefits:**
1. **Code reuse:** Write once in base class
2. **DRY principle:** Don't Repeat Yourself
3. **Organization:** Logical hierarchy
4. **Maintainability:** Change once, affects all
5. **Polymorphism:** Use base pointer for derived objects

**Is-A Relationship:**
- Student IS-A Person ✓
- Car IS-A Vehicle ✓
- Dog IS-A Animal ✓

**Method Overriding:**
- Derived class redefines base method
- Use `override` keyword (C++11+)
- Call base version: `Base::method()`

</details>

---

**Inheritance models real-world hierarchies and eliminates code duplication!**
