## Background Story

Tian's inherited class system had a strange bug. An array of `Person*` pointers stored both Residents and Officials, but calling `display()` always executed the base Person version, never the specialized versions.

"Why isn't it calling the Resident's display method?" Tian asked, confused. "The pointer points to a Resident object, but it behaves like a generic Person!"

Kuya Miguel examined the code. "You're experiencing the problem that **polymorphism** solves. The compiler sees `Person*` and uses Person's method, even though the actual object is a Resident. You need to tell C++ to determine the correct method at runtime, not compile time."

"This is huge for building flexible systems," Kuya Miguel explained. "Imagine a game with an array of Enemy pointers. Some are Zombies, some are Soldiers, some are Bosses. When you call `attack()`, each enemy type should attack differently. With virtual functions and polymorphism, the correct attack method is automatically called based on the actual object type, not the pointer type."

"One interface, many implementations," Kuya Miguel said. "This is the essence of polymorphism and why it's one of OOP's most powerful features!"

---

## Theory & Lecture Content

## What is Polymorphism?

**Polymorphism** = "many forms" — same interface, different behavior.

```cpp
class Person {
public:
    virtual void introduce() {  // Virtual = can be overridden
        cout << "I'm a person\n";
    }
};

class Resident : public Person {
public:
    void introduce() override {
        cout << "I'm a resident\n";
    }
};

class Official : public Person {
public:
    void introduce() override {
        cout << "I'm an official\n";
    }
};

int main() {
    Person* p1 = new Resident();
    Person* p2 = new Official();
    
    p1->introduce();  // "I'm a resident"
    p2->introduce();  // "I'm an official"
    
    delete p1;
    delete p2;
    return 0;
}
```

---

## Virtual Functions

```cpp
class Base {
public:
    virtual void display() {  // Virtual
        cout << "Base display\n";
    }
};

class Derived : public Base {
public:
    void display() override {  // Override
        cout << "Derived display\n";
    }
};

int main() {
    Base* ptr = new Derived();
    ptr->display();  // "Derived display" — dynamic binding!
    
    delete ptr;
    return 0;
}
```

**Without `virtual`:**
```cpp
class Base {
public:
    void display() {  // NOT virtual
        cout << "Base display\n";
    }
};

class Derived : public Base {
public:
    void display() {
        cout << "Derived display\n";
    }
};

int main() {
    Base* ptr = new Derived();
    ptr->display();  // "Base display" — static binding
    
    delete ptr;
    return 0;
}
```

---

## Pure Virtual Functions (Abstract Classes)

```cpp
class Shape {  // Abstract class
public:
    virtual double area() = 0;  // Pure virtual = 0
    virtual void display() = 0;
};

class Rectangle : public Shape {
private:
    double width, height;
    
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    
    double area() override {
        return width * height;
    }
    
    void display() override {
        cout << "Rectangle: " << width << "x" << height << endl;
    }
};

class Circle : public Shape {
private:
    double radius;
    
public:
    Circle(double r) : radius(r) {}
    
    double area() override {
        return 3.14159 * radius * radius;
    }
    
    void display() override {
        cout << "Circle: radius " << radius << endl;
    }
};

int main() {
    // Shape s;  // ❌ Error! Can't instantiate abstract class
    
    Shape* shapes[2];
    shapes[0] = new Rectangle(5, 10);
    shapes[1] = new Circle(7);
    
    for (int i = 0; i < 2; i++) {
        shapes[i]->display();
        cout << "Area: " << shapes[i]->area() << endl << endl;
    }
    
    delete shapes[0];
    delete shapes[1];
    
    return 0;
}
```

---

## Virtual Destructor

**Important:** Base classes with virtual functions should have virtual destructors!

```cpp
class Base {
public:
    Base() {
        cout << "Base constructor\n";
    }
    
    virtual ~Base() {  // Virtual destructor!
        cout << "Base destructor\n";
    }
};

class Derived : public Base {
private:
    int* data;
    
public:
    Derived() {
        data = new int[100];
        cout << "Derived constructor\n";
    }
    
    ~Derived() {
        delete[] data;
        cout << "Derived destructor\n";
    }
};

int main() {
    Base* ptr = new Derived();
    delete ptr;  // Calls both destructors if virtual
    
    return 0;
}
```

---

## Practical Example: Barangay Clearance System

```cpp
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// Abstract base class
class Clearance {
protected:
    int id;
    string residentName;
    double baseFee;
    string status;
    
public:
    Clearance(int i, string name, double fee) 
        : id(i), residentName(name), baseFee(fee), status("pending") {}
    
    virtual ~Clearance() {}
    
    // Pure virtual - must be implemented
    virtual double calculateFee() = 0;
    virtual void displayDetails() = 0;
    
    // Common methods
    void approve() {
        status = "approved";
        cout << "Clearance #" << id << " approved\n";
    }
    
    void reject() {
        status = "rejected";
        cout << "Clearance #" << id << " rejected\n";
    }
    
    string getStatus() const {
        return status;
    }
};

// Derived class 1: Residence Clearance
class ResidenceClearance : public Clearance {
private:
    int yearsResident;
    
public:
    ResidenceClearance(int i, string name, int years) 
        : Clearance(i, name, 50.0), yearsResident(years) {}
    
    double calculateFee() override {
        // Discount for long-time residents
        double discount = (yearsResident >= 5) ? 0.2 : 0;
        return baseFee * (1 - discount);
    }
    
    void displayDetails() override {
        cout << "\n===== RESIDENCE CLEARANCE =====\n";
        cout << "ID: " << id << endl;
        cout << "Resident: " << residentName << endl;
        cout << "Years: " << yearsResident << endl;
        cout << "Fee: P" << calculateFee() << endl;
        cout << "Status: " << status << endl;
        cout << "===============================\n";
    }
};

// Derived class 2: Business Clearance
class BusinessClearance : public Clearance {
private:
    string businessType;
    int employees;
    
public:
    BusinessClearance(int i, string name, string type, int emp) 
        : Clearance(i, name, 100.0), businessType(type), employees(emp) {}
    
    double calculateFee() override {
        // Fee based on employees
        return baseFee + (employees * 10);
    }
    
    void displayDetails() override {
        cout << "\n===== BUSINESS CLEARANCE =====\n";
        cout << "ID: " << id << endl;
        cout << "Owner: " << residentName << endl;
        cout << "Type: " << businessType << endl;
        cout << "Employees: " << employees << endl;
        cout << "Fee: P" << calculateFee() << endl;
        cout << "Status: " << status << endl;
        cout << "==============================\n";
    }
};

// Derived class 3: Travel Clearance
class TravelClearance : public Clearance {
private:
    string destination;
    int days;
    
public:
    TravelClearance(int i, string name, string dest, int d) 
        : Clearance(i, name, 150.0), destination(dest), days(d) {}
    
    double calculateFee() override {
        // Fee based on travel duration
        double extra = (days > 30) ? 50.0 : 0;
        return baseFee + extra;
    }
    
    void displayDetails() override {
        cout << "\n===== TRAVEL CLEARANCE =====\n";
        cout << "ID: " << id << endl;
        cout << "Traveler: " << residentName << endl;
        cout << "Destination: " << destination << endl;
        cout << "Days: " << days << endl;
        cout << "Fee: P" << calculateFee() << endl;
        cout << "Status: " << status << endl;
        cout << "============================\n";
    }
};

int main() {
    vector<Clearance*> clearances;
    
    clearances.push_back(new ResidenceClearance(1001, "Juan Dela Cruz", 6));
    clearances.push_back(new BusinessClearance(1002, "Maria Santos", "Retail", 5));
    clearances.push_back(new TravelClearance(1003, "Pedro Reyes", "Manila", 45));
    
    cout << "=== BARANGAY CLEARANCE SYSTEM ===\n";
    
    // Polymorphism in action!
    for (Clearance* c : clearances) {
        c->displayDetails();      // Calls appropriate version
        cout << "Fee: P" << c->calculateFee() << endl;
        c->approve();
    }
    
    // Cleanup
    for (Clearance* c : clearances) {
        delete c;
    }
    
    return 0;
}
```

---

## Dynamic Binding vs Static Binding

```cpp
class Base {
public:
    virtual void vfunc() {  // Virtual
        cout << "Base virtual\n";
    }
    
    void nfunc() {  // Non-virtual
        cout << "Base non-virtual\n";
    }
};

class Derived : public Base {
public:
    void vfunc() override {
        cout << "Derived virtual\n";
    }
    
    void nfunc() {
        cout << "Derived non-virtual\n";
    }
};

int main() {
    Base* ptr = new Derived();
    
    ptr->vfunc();  // "Derived virtual" — dynamic binding
    ptr->nfunc();  // "Base non-virtual" — static binding
    
    delete ptr;
    return 0;
}
```

---

## Override Keyword (C++11)

Use `override` to catch errors:

```cpp
class Base {
public:
    virtual void display() {
        cout << "Base\n";
    }
};

class Derived : public Base {
public:
    // void displya() override {  // ❌ Error caught! Typo in name
    void display() override {     // ✓ Correct
        cout << "Derived\n";
    }
};
```

---

## Summary

"Polymorphism is powerful!" Tian exclaimed.

"Yes!" Kuya Miguel said. "Remember:
- **virtual** = can be overridden
- **override** = replace base implementation
- **Pure virtual (= 0)** = must be implemented
- **Abstract class** = has pure virtual functions
- **Virtual destructor** = essential with inheritance
- **Dynamic binding** = runtime decision"

"Next: **Templates** — generic programming!"

---

**Key Takeaways:**
1. Polymorphism = one interface, many forms
2. Virtual functions enable dynamic binding
3. Pure virtual functions create abstract classes
4. Virtual destructors essential for polymorphism
5. Use override keyword for safety

---

## Closing Story

"This is magic!" Tian said, watching his array of Clearance pointers call the right calculateFee() and displayDetails() methods automatically. ResidenceClearance, BusinessClearance, TravelClearance: all different implementations, but treated uniformly through the base Clearance pointer.

Kuya Miguel grinned. "That's polymorphism: one interface, many forms. Your code doesn't need to know what type of clearance it is. Just call calculateFee() and the right version executes at runtime. Dynamic binding."

Tian practiced using virtual functions, watching how the virtual keyword enabled runtime type resolution. "And pure virtual functions with = 0 make the base class abstract. Can't instantiate Clearance directly, must use a derived class. Forces implementation of required methods."

"Exactly! And notice the virtual destructor. Essential when using polymorphism with dynamic memory. Without it, only the base destructor fires when you delete through a base pointer. Memory leak. With virtual, the entire destruction chain fires: derived destructor, then base destructor."

Tian added override keywords to catch typos and mistakes. "This is powerful. I can add new clearance types without changing existing code. Just derive from Clearance, implement the pure virtuals, done."

"That's the Open-Closed Principle: open for extension, closed for modification. Next: templates for truly generic code."

**Next Lesson:** Templates - Generic Programming
