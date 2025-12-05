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

# Tasks for Learners

- Create a `Vehicle` base class with brand and year. Create a `Car` derived class that adds numberOfDoors. Demonstrate inheritance by creating a Car object and calling both base and derived methods.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  // Base class
  class Vehicle {
  protected:
      string brand;
      int year;
      
  public:
      Vehicle(string b, int y) : brand(b), year(y) {
          cout << "Vehicle created: " << brand << " (" << year << ")" << endl;
      }
      
      void display() {
          cout << "Brand: " << brand << ", Year: " << year << endl;
      }
      
      void honk() {
          cout << brand << " says: Beep beep!" << endl;
      }
  };

  // Derived class
  class Car : public Vehicle {
  private:
      int numberOfDoors;
      
  public:
      Car(string b, int y, int doors) 
          : Vehicle(b, y), numberOfDoors(doors) {
          cout << "Car created with " << doors << " doors" << endl;
      }
      
      void showDetails() {
          cout << "Car: " << brand << " (" << year << ") - " 
               << numberOfDoors << " doors" << endl;
      }
  };

  int main() {
      Car myCar("Toyota", 2022, 4);
      
      cout << endl;
      myCar.display();      // Inherited from Vehicle
      myCar.honk();         // Inherited from Vehicle
      myCar.showDetails();  // Own method
      
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

# Tasks for Learners

- Create a `BankAccount` base class with protected accountNumber and balance. Create a `SavingsAccount` derived class that adds interestRate. Show how protected members are accessible in the derived class but not outside.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class BankAccount {
  private:
      int id;  // Only BankAccount can access
      
  protected:
      string accountNumber;  // BankAccount and derived classes can access
      double balance;
      
  public:
      BankAccount(string accNum, double bal) 
          : id(0), accountNumber(accNum), balance(bal) {
          cout << "BankAccount created: " << accountNumber << endl;
      }
      
      void display() {
          cout << "Account: " << accountNumber << ", Balance: P" << balance << endl;
      }
  };

  class SavingsAccount : public BankAccount {
  private:
      double interestRate;
      
  public:
      SavingsAccount(string accNum, double bal, double rate) 
          : BankAccount(accNum, bal), interestRate(rate) {
          cout << "SavingsAccount created with " << (rate * 100) << "% interest" << endl;
      }
      
      void applyInterest() {
          // Can access protected members
          double interest = balance * interestRate;
          balance += interest;
          cout << "Applied interest of P" << interest << " to account " << accountNumber << endl;
      }
      
      void showDetails() {
          cout << "Savings Account: " << accountNumber << endl;
          cout << "Balance: P" << balance << endl;
          cout << "Interest Rate: " << (interestRate * 100) << "%" << endl;
          
          // cout << id;  // ❌ Error! id is private to BankAccount
      }
  };

  int main() {
      SavingsAccount savings("SA-1001", 10000.0, 0.05);
      
      cout << endl;
      savings.display();
      savings.applyInterest();
      savings.showDetails();
      
      // savings.balance = 50000;  // ❌ Error! balance is protected
      
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

# Tasks for Learners

- Create an `Employee` base class and a `Manager` derived class. Show constructor chaining where the Manager constructor calls the Employee constructor, then initializes its own members.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class Employee {
  protected:
      string name;
      int id;
      double salary;
      
  public:
      Employee(string n, int i, double sal) : name(n), id(i), salary(sal) {
          cout << "Employee constructor: " << name << " (ID: " << id << ")" << endl;
      }
      
      void display() {
          cout << "Employee: " << name << ", ID: " << id << ", Salary: P" << salary << endl;
      }
  };

  class Manager : public Employee {
  private:
      string department;
      int teamSize;
      
  public:
      // Must call Employee constructor first
      Manager(string n, int i, double sal, string dept, int team) 
          : Employee(n, i, sal), department(dept), teamSize(team) {
          cout << "Manager constructor: Department=" << department 
               << ", Team Size=" << teamSize << endl;
      }
      
      void showManagerInfo() {
          cout << "Manager: " << name << endl;
          cout << "ID: " << id << endl;
          cout << "Salary: P" << salary << endl;
          cout << "Department: " << department << endl;
          cout << "Team Size: " << teamSize << " people" << endl;
      }
  };

  int main() {
      cout << "Creating manager..." << endl;
      Manager mgr("Maria Santos", 2001, 50000.0, "IT", 10);
      
      cout << "\nDisplaying info:" << endl;
      mgr.display();
      
      cout << "\nDetailed manager info:" << endl;
      mgr.showManagerInfo();
      
      return 0;
  }
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

# Tasks for Learners

- Create a `Shape` base class with a `getInfo()` method. Create derived classes `Rectangle` and `Circle` that override the method to provide shape-specific information.

  ```cpp
  #include <iostream>
  #include <string>
  #include <cmath>
  using namespace std;

  class Shape {
  protected:
      string name;
      
  public:
      Shape(string n) : name(n) {}
      
      void getInfo() {
          cout << "This is a generic shape: " << name << endl;
      }
  };

  class Rectangle : public Shape {
  private:
      double width;
      double height;
      
  public:
      Rectangle(double w, double h) 
          : Shape("Rectangle"), width(w), height(h) {}
      
      // Override base class method
      void getInfo() {
          cout << "Rectangle: " << width << " x " << height << endl;
          cout << "Area: " << (width * height) << endl;
          cout << "Perimeter: " << (2 * (width + height)) << endl;
      }
  };

  class Circle : public Shape {
  private:
      double radius;
      
  public:
      Circle(double r) 
          : Shape("Circle"), radius(r) {}
      
      // Override base class method
      void getInfo() {
          cout << "Circle with radius: " << radius << endl;
          cout << "Area: " << (M_PI * radius * radius) << endl;
          cout << "Circumference: " << (2 * M_PI * radius) << endl;
      }
  };

  int main() {
      Shape s("Generic");
      Rectangle rect(5.0, 10.0);
      Circle circ(7.0);
      
      s.getInfo();
      cout << endl;
      
      rect.getInfo();
      cout << endl;
      
      circ.getInfo();
      
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

# Tasks for Learners

- Create a three-level inheritance chain: `Animal` → `Mammal` → `Dog`. Each level should add its own properties and methods. Show how the most derived class can access methods from all levels.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  // Level 1: Base
  class Animal {
  protected:
      bool isAlive;
      int age;
      
  public:
      Animal(int a) : isAlive(true), age(a) {
          cout << "Animal created (age " << age << ")" << endl;
      }
      
      void breathe() {
          cout << "Breathing..." << endl;
      }
      
      void eat() {
          cout << "Eating..." << endl;
      }
  };

  // Level 2: Derived from Animal
  class Mammal : public Animal {
  protected:
      bool hasFur;
      
  public:
      Mammal(int a, bool fur) : Animal(a), hasFur(fur) {
          cout << "Mammal created (has fur: " << (fur ? "yes" : "no") << ")" << endl;
      }
      
      void produceMilk() {
          cout << "Producing milk for babies" << endl;
      }
      
      void regulate Temperature() {
          cout << "Regulating body temperature" << endl;
      }
  };

  // Level 3: Derived from Mammal
  class Dog : public Mammal {
  private:
      string breed;
      string name;
      
  public:
      Dog(string n, string b, int a) 
          : Mammal(a, true), name(n), breed(b) {
          cout << "Dog created: " << name << " (" << breed << ")" << endl;
      }
      
      void bark() {
          cout << name << " says: Woof! Woof!" << endl;
      }
      
      void wagTail() {
          cout << name << " is wagging its tail happily!" << endl;
      }
      
      void showInfo() {
          cout << "Name: " << name << endl;
          cout << "Breed: " << breed << endl;
          cout << "Age: " << age << " years" << endl;
          cout << "Has fur: " << (hasFur ? "Yes" : "No") << endl;
          cout << "Alive: " << (isAlive ? "Yes" : "No") << endl;
      }
  };

  int main() {
      cout << "Creating a dog..." << endl;
      Dog myDog("Bantay", "Aspin", 3);
      
      cout << "\nDog actions:" << endl;
      myDog.breathe();            // From Animal
      myDog.eat();                // From Animal
      myDog.produceMilk();        // From Mammal
      myDog.regulateTemperature(); // From Mammal
      myDog.bark();               // From Dog
      myDog.wagTail();            // From Dog
      
      cout << "\nDog info:" << endl;
      myDog.showInfo();
      
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

# Tasks for Learners

- Create a complete barangay management system with a `Person` base class, and derived `Resident`, `Official`, and `BusinessOwner` classes. Each derived class should have its own unique attributes and override the display method.

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
          : id(i), name(n), age(a), address(addr) {
          cout << "Person created: " << name << endl;
      }
      
      virtual void display() {
          cout << "ID: " << id << endl;
          cout << "Name: " << name << endl;
          cout << "Age: " << age << endl;
          cout << "Address: " << address << endl;
      }
      
      bool isSenior() {
          return age >= 60;
      }
      
      string getName() { return name; }
  };

  class Resident : public Person {
  private:
      double balance;
      bool isPaid;
      
  public:
      Resident(int i, string n, int a, string addr) 
          : Person(i, n, a, addr), balance(0), isPaid(false) {
          cout << "Resident registered" << endl;
      }
      
      void addDues(double amount) {
          balance += amount;
          isPaid = false;
      }
      
      void makePayment(double amount) {
          if (amount <= balance) {
              balance -= amount;
              if (balance == 0) {
                  isPaid = true;
              }
              cout << "Payment of P" << amount << " received from " << name << endl;
          }
      }
      
      void display() override {
          Person::display();
          cout << "Balance: P" << balance << endl;
          cout << "Payment Status: " << (isPaid ? "Paid" : "Pending") << endl;
          cout << "Type: Resident" << endl;
      }
  };

  class Official : public Person {
  private:
      string position;
      double salary;
      int yearsOfService;
      
  public:
      Official(int i, string n, int a, string addr, string pos, double sal) 
          : Person(i, n, a, addr), position(pos), salary(sal), yearsOfService(0) {
          cout << "Official appointed: " << position << endl;
      }
      
      void incrementYears() {
          yearsOfService++;
      }
      
      void display() override {
          Person::display();
          cout << "Position: " << position << endl;
          cout << "Salary: P" << salary << endl;
          cout << "Years of Service: " << yearsOfService << endl;
          cout << "Type: Official" << endl;
      }
  };

  class BusinessOwner : public Person {
  private:
      string businessName;
      string businessType;
      double businessPermitFee;
      bool permitValid;
      
  public:
      BusinessOwner(int i, string n, int a, string addr, string bname, string btype) 
          : Person(i, n, a, addr), businessName(bname), businessType(btype), 
            businessPermitFee(0), permitValid(false) {
          cout << "Business owner registered: " << businessName << endl;
      }
      
      void setPermitFee(double fee) {
          businessPermitFee = fee;
      }
      
      void renewPermit() {
          permitValid = true;
          cout << "Business permit renewed for " << businessName << endl;
      }
      
      void display() override {
          Person::display();
          cout << "Business Name: " << businessName << endl;
          cout << "Business Type: " << businessType << endl;
          cout << "Permit Fee: P" << businessPermitFee << endl;
          cout << "Permit Status: " << (permitValid ? "Valid" : "Expired") << endl;
          cout << "Type: Business Owner" << endl;
      }
  };

  int main() {
      cout << "=== BARANGAY MANAGEMENT SYSTEM ===\n" << endl;
      
      Resident r1(1001, "Juan Dela Cruz", 30, "123 Main St");
      r1.addDues(500);
      
      cout << "\n=== RESIDENT INFO ===" << endl;
      r1.display();
      
      cout << "\n" << endl;
      
      Official o1(2001, "Maria Santos", 45, "Municipal Hall", "Barangay Captain", 35000);
      o1.incrementYears();
      o1.incrementYears();
      
      cout << "\n=== OFFICIAL INFO ===" << endl;
      o1.display();
      
      cout << "\n" << endl;
      
      BusinessOwner b1(3001, "Pedro Reyes", 40, "456 Commerce Ave", 
                       "Reyes Sari-Sari Store", "Retail");
      b1.setPermitFee(2000);
      b1.renewPermit();
      
      cout << "\n=== BUSINESS OWNER INFO ===" << endl;
      b1.display();
      
      cout << "\n=== TRANSACTIONS ===" << endl;
      r1.makePayment(300);
      r1.display();
      
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
