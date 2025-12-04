# Lesson 27 Activities: Polymorphism

## The Wrong Method Bug

Tian's array of `Person*` pointers stored both Residents and Officials, but calling `display()` always executed the base Person version. **"Why isn't it calling Resident's display?"**

**Polymorphism solves this!** Tell C++ to determine the correct method at **runtime**, not compile time. Use `virtual` functions.

One interface, many implementations. An array of `Enemy*` calls `attack()`—each enemy type attacks differently automatically!

---

## Task 1: Virtual Functions

**Context:** Enable runtime method resolution.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Person {
protected:
    string name;
    
public:
    Person(string n) : name(n) {}
    
    virtual void introduce() {  // Virtual = can be overridden
        cout << "I'm " << name << ", a person" << endl;
    }
};

class Resident : public Person {
public:
    Resident(string n) : Person(n) {}
    
    void introduce() override {
        cout << "I'm " << name << ", a resident" << endl;
    }
};

class Official : public Person {
public:
    Official(string n) : Person(n) {}
    
    void introduce() override {
        cout << "I'm " << name << ", an official" << endl;
    }
};

int main() {
    Person* p1 = new Resident("Juan");
    Person* p2 = new Official("Maria");
    
    p1->introduce();  // "I'm Juan, a resident"
    p2->introduce();  // "I'm Maria, an official"
    
    delete p1;
    delete p2;
    
    return 0;
}
```

**Magic:** Correct method called based on actual object type!

---

## Task 2: Without Virtual (Static Binding)

**Context:** See the difference without `virtual`.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

class Base {
public:
    void display() {  // NOT virtual
        cout << "Base display" << endl;
    }
};

class Derived : public Base {
public:
    void display() {
        cout << "Derived display" << endl;
    }
};

int main() {
    Base* ptr = new Derived();
    ptr->display();  // "Base display" — wrong!
    
    Derived* dptr = new Derived();
    dptr->display();  // "Derived display" — correct
    
    delete ptr;
    delete dptr;
    
    return 0;
}
```

**Without `virtual`:** Compiler uses pointer type, not object type!

---

## Task 3: Pure Virtual Functions (Abstract Classes)

**Context:** Force derived classes to implement methods.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Shape {  // Abstract class
protected:
    string name;
    
public:
    Shape(string n) : name(n) {}
    
    virtual double area() = 0;  // Pure virtual = must implement
    virtual void display() = 0;
};

class Rectangle : public Shape {
private:
    double width, height;
    
public:
    Rectangle(double w, double h) : Shape("Rectangle"), width(w), height(h) {}
    
    double area() override {
        return width * height;
    }
    
    void display() override {
        cout << name << ": " << width << "x" << height << " = " << area() << endl;
    }
};

class Circle : public Shape {
private:
    double radius;
    
public:
    Circle(double r) : Shape("Circle"), radius(r) {}
    
    double area() override {
        return 3.14159 * radius * radius;
    }
    
    void display() override {
        cout << name << ": radius " << radius << " = " << area() << endl;
    }
};

int main() {
    // Shape s;  // ❌ Error! Can't instantiate abstract class
    
    Shape* shapes[3];
    shapes[0] = new Rectangle(5, 10);
    shapes[1] = new Circle(7);
    shapes[2] = new Rectangle(3, 3);
    
    cout << "=== ALL SHAPES ===" << endl;
    for (int i = 0; i < 3; i++) {
        shapes[i]->display();
    }
    
    for (int i = 0; i < 3; i++) {
        delete shapes[i];
    }
    
    return 0;
}
```

---

## Task 4: Virtual Destructor

**Context:** Ensure proper cleanup in inheritance.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

class Base {
public:
    Base() {
        cout << "Base constructor" << endl;
    }
    
    virtual ~Base() {  // Virtual destructor!
        cout << "Base destructor" << endl;
    }
};

class Derived : public Base {
private:
    int* data;
    
public:
    Derived() : data(new int[100]) {
        cout << "Derived constructor (allocated memory)" << endl;
    }
    
    ~Derived() {
        delete[] data;
        cout << "Derived destructor (freed memory)" << endl;
    }
};

int main() {
    cout << "Creating derived through base pointer:" << endl;
    Base* ptr = new Derived();
    
    cout << "\nDeleting through base pointer:" << endl;
    delete ptr;  // Without virtual destructor, only Base destructor called!
    
    return 0;
}
```

**Without `virtual ~Base()`:** Memory leak! Derived destructor not called!

---

## Task 5: Polymorphic Array

**Context:** Store different types, call correct methods.

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
    virtual ~Person() {}
    
    virtual void display() {
        cout << "Person: " << name << " (" << age << ")" << endl;
    }
    
    virtual double getSalary() {
        return 0;  // Persons don't have salary
    }
};

class Resident : public Person {
private:
    double balance;
    
public:
    Resident(string n, int a, double bal) 
        : Person(n, a), balance(bal) {}
    
    void display() override {
        cout << "Resident: " << name << " (" << age << ") - Balance: P" << balance << endl;
    }
};

class Official : public Person {
private:
    string position;
    double salary;
    
public:
    Official(string n, int a, string pos, double sal) 
        : Person(n, a), position(pos), salary(sal) {}
    
    void display() override {
        cout << "Official: " << name << " (" << age << ") - " 
             << position << " - Salary: P" << salary << endl;
    }
    
    double getSalary() override {
        return salary;
    }
};

int main() {
    Person* people[4];
    people[0] = new Resident("Juan", 30, 500);
    people[1] = new Official("Maria", 45, "Captain", 35000);
    people[2] = new Resident("Pedro", 25, 300);
    people[3] = new Official("Ana", 38, "Kagawad", 25000);
    
    cout << "=== ALL PEOPLE ===" << endl;
    for (int i = 0; i < 4; i++) {
        people[i]->display();  // Correct version called!
    }
    
    cout << "\n=== TOTAL SALARIES ===" << endl;
    double total = 0;
    for (int i = 0; i < 4; i++) {
        total += people[i]->getSalary();
    }
    cout << "Total: P" << total << endl;
    
    for (int i = 0; i < 4; i++) {
        delete people[i];
    }
    
    return 0;
}
```

---

## Task 6: Payment System with Polymorphism

**Context:** Different payment types, unified interface.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Payment {
protected:
    double amount;
    string date;
    
public:
    Payment(double amt, string d) : amount(amt), date(d) {}
    virtual ~Payment() {}
    
    virtual void process() = 0;  // Pure virtual
    virtual string getType() = 0;
    
    void display() {
        cout << getType() << " - P" << amount << " (" << date << ")" << endl;
    }
};

class CashPayment : public Payment {
public:
    CashPayment(double amt, string d) : Payment(amt, d) {}
    
    void process() override {
        cout << "Processing cash payment of P" << amount << endl;
    }
    
    string getType() override {
        return "Cash";
    }
};

class OnlinePayment : public Payment {
private:
    string referenceNumber;
    
public:
    OnlinePayment(double amt, string d, string ref) 
        : Payment(amt, d), referenceNumber(ref) {}
    
    void process() override {
        cout << "Processing online payment of P" << amount 
             << " (Ref: " << referenceNumber << ")" << endl;
    }
    
    string getType() override {
        return "Online";
    }
};

class CheckPayment : public Payment {
private:
    string checkNumber;
    
public:
    CheckPayment(double amt, string d, string chk) 
        : Payment(amt, d), checkNumber(chk) {}
    
    void process() override {
        cout << "Processing check payment of P" << amount 
             << " (Check #" << checkNumber << ")" << endl;
    }
    
    string getType() override {
        return "Check";
    }
};

int main() {
    Payment* payments[3];
    payments[0] = new CashPayment(500, "2024-12-04");
    payments[1] = new OnlinePayment(1000, "2024-12-04", "REF123456");
    payments[2] = new CheckPayment(750, "2024-12-04", "CHK789");
    
    cout << "=== PROCESSING PAYMENTS ===" << endl;
    for (int i = 0; i < 3; i++) {
        payments[i]->display();
        payments[i]->process();
        cout << endl;
    }
    
    for (int i = 0; i < 3; i++) {
        delete payments[i];
    }
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Polymorphism Summary</strong></summary>

**Key Concepts:**
- **Virtual functions:** `virtual returnType methodName()`
- **Override:** `void methodName() override`
- **Pure virtual:** `virtual void method() = 0`
- **Abstract class:** Has at least one pure virtual function

**Rules:**
1. Base class needs `virtual` keyword
2. Derived class uses `override` (optional but recommended)
3. Virtual destructor needed for proper cleanup
4. Abstract classes can't be instantiated

**Benefits:**
- Same interface, different implementations
- Flexible, extensible code
- Runtime polymorphism
- Open/Closed Principle (open for extension, closed for modification)

**Common Uses:**
- Shape hierarchies (area, draw)
- Employee types (calculatePay)
- Payment methods (process)
- Game entities (update, render)

</details>

---

**Polymorphism is OOP's most powerful feature—master it to write truly flexible code!**
