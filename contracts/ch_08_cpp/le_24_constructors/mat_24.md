# Lesson 24: Constructors and Destructors

**Estimated Reading Time:** 11 minutes

---

## The Story

"Kuya, every time I create an object, I have to call `setData()`. Can't it initialize automatically?"

"Excellent question!" Kuya Miguel grinned. "That's what **constructors** do — automatic initialization when objects are created. And **destructors** clean up when they're destroyed!"

---

## What is a Constructor?

A **constructor** is a special method that runs automatically when an object is created.

```cpp
class Resident {
private:
    string name;
    int age;
    
public:
    // Constructor (same name as class, no return type)
    Resident() {
        name = "Unknown";
        age = 0;
        cout << "Resident created!\n";
    }
    
    void display() {
        cout << name << " - " << age << endl;
    }
};

int main() {
    Resident r;  // Constructor runs automatically!
    r.display();
    return 0;
}
```

**Output:**
```
Resident created!
Unknown - 0
```

---

## Constructor with Parameters

```cpp
class Resident {
private:
    string name;
    int age;
    
public:
    // Parameterized constructor
    Resident(string n, int a) {
        name = n;
        age = a;
        cout << "Resident " << name << " created!\n";
    }
    
    void display() {
        cout << name << " - " << age << endl;
    }
};

int main() {
    Resident r1("Juan Dela Cruz", 30);
    Resident r2("Maria Santos", 25);
    
    r1.display();
    r2.display();
    
    return 0;
}
```

**Output:**
```
Resident Juan Dela Cruz created!
Resident Maria Santos created!
Juan Dela Cruz - 30
Maria Santos - 25
```

---

## Default Constructor

If you don't write a constructor, C++ provides a default one:

```cpp
class Box {
public:
    int width;
    int height;
};

int main() {
    Box b;  // Default constructor called (does nothing)
    b.width = 10;
    b.height = 20;
    return 0;
}
```

**Note:** If you define ANY constructor, the default constructor is NOT provided.

---

## Multiple Constructors (Overloading)

```cpp
class BankAccount {
private:
    string accountNumber;
    double balance;
    
public:
    // Constructor 1: No parameters
    BankAccount() {
        accountNumber = "0000";
        balance = 0;
    }
    
    // Constructor 2: Account number only
    BankAccount(string accNum) {
        accountNumber = accNum;
        balance = 0;
    }
    
    // Constructor 3: Both parameters
    BankAccount(string accNum, double bal) {
        accountNumber = accNum;
        balance = bal;
    }
    
    void display() {
        cout << "Account: " << accountNumber;
        cout << ", Balance: P" << balance << endl;
    }
};

int main() {
    BankAccount acc1;                    // Uses constructor 1
    BankAccount acc2("1001");            // Uses constructor 2
    BankAccount acc3("1002", 5000.0);    // Uses constructor 3
    
    acc1.display();
    acc2.display();
    acc3.display();
    
    return 0;
}
```

---

## Constructor Initialization List

More efficient way to initialize members:

```cpp
class Resident {
private:
    string name;
    int age;
    double balance;
    
public:
    // Old way: Assignment in body
    Resident(string n, int a, double b) {
        name = n;
        age = a;
        balance = b;
    }
    
    // Better way: Initialization list
    Resident(string n, int a, double b) : name(n), age(a), balance(b) {
        cout << "Resident initialized!\n";
    }
};
```

**Why better?**
- More efficient (especially for complex types)
- Required for const and reference members
- Preferred C++ style

---

## What is a Destructor?

A **destructor** runs automatically when an object is destroyed. Used for cleanup (free memory, close files, etc.).

```cpp
class Resident {
private:
    string name;
    
public:
    // Constructor
    Resident(string n) : name(n) {
        cout << name << " created\n";
    }
    
    // Destructor (~ + class name, no parameters, no return type)
    ~Resident() {
        cout << name << " destroyed\n";
    }
};

int main() {
    Resident r1("Juan");
    Resident r2("Maria");
    
    // Destructors called automatically when main() ends
    return 0;
}
```

**Output:**
```
Juan created
Maria created
Maria destroyed
Juan destroyed
```

---

## Constructor and Destructor with Dynamic Memory

```cpp
class DynamicArray {
private:
    int* arr;
    int size;
    
public:
    // Constructor: Allocate memory
    DynamicArray(int s) : size(s) {
        arr = new int[size];
        cout << "Array of size " << size << " created\n";
    }
    
    // Destructor: Free memory
    ~DynamicArray() {
        delete[] arr;
        cout << "Array destroyed and memory freed\n";
    }
    
    void set(int index, int value) {
        if (index >= 0 && index < size) {
            arr[index] = value;
        }
    }
    
    int get(int index) {
        if (index >= 0 && index < size) {
            return arr[index];
        }
        return -1;
    }
};

int main() {
    DynamicArray arr(5);
    arr.set(0, 100);
    arr.set(1, 200);
    
    cout << arr.get(0) << endl;
    cout << arr.get(1) << endl;
    
    // Destructor automatically frees memory when arr goes out of scope
    return 0;
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
    static int nextId;  // Shared across all instances
    int id;
    string residentName;
    string type;
    double fee;
    string status;
    
public:
    // Default constructor
    Clearance() : id(nextId++), status("pending") {
        residentName = "Unknown";
        type = "General";
        fee = 0;
        cout << "Clearance #" << id << " created\n";
    }
    
    // Parameterized constructor
    Clearance(string name, string t, double f) 
        : id(nextId++), residentName(name), type(t), fee(f), status("pending") {
        cout << "Clearance #" << id << " for " << residentName << " created\n";
    }
    
    // Destructor
    ~Clearance() {
        cout << "Clearance #" << id << " destroyed\n";
    }
    
    void approve() {
        status = "approved";
        cout << "Clearance #" << id << " approved\n";
    }
    
    void display() {
        cout << "\n===== CLEARANCE #" << id << " =====\n";
        cout << "Resident: " << residentName << endl;
        cout << "Type: " << type << endl;
        cout << "Fee: P" << fee << endl;
        cout << "Status: " << status << endl;
        cout << "=============================\n";
    }
};

// Initialize static member
int Clearance::nextId = 1001;

int main() {
    cout << "Creating clearances...\n";
    
    Clearance c1("Juan Dela Cruz", "Residence", 50.0);
    c1.display();
    c1.approve();
    
    Clearance c2("Maria Santos", "Business", 100.0);
    c2.display();
    
    cout << "\nExiting main...\n";
    // Destructors called automatically
    return 0;
}
```

---

## Copy Constructor

Used when copying objects:

```cpp
class Resident {
private:
    string name;
    int age;
    
public:
    // Regular constructor
    Resident(string n, int a) : name(n), age(a) {
        cout << "Resident " << name << " created\n";
    }
    
    // Copy constructor
    Resident(const Resident& other) : name(other.name), age(other.age) {
        cout << "Resident " << name << " copied\n";
    }
    
    ~Resident() {
        cout << "Resident " << name << " destroyed\n";
    }
    
    void display() {
        cout << name << " - " << age << endl;
    }
};

int main() {
    Resident r1("Juan", 30);
    Resident r2 = r1;  // Copy constructor called
    
    r1.display();
    r2.display();
    
    return 0;
}
```

---

## Constructor Best Practices

```cpp
class BankAccount {
private:
    string accountNumber;
    double balance;
    
public:
    // Use initialization list
    BankAccount(string accNum, double bal) 
        : accountNumber(accNum), balance(bal) {
        
        // Validate in constructor body
        if (balance < 0) {
            balance = 0;
            cout << "Warning: Negative balance set to 0\n";
        }
    }
    
    // Destructor for cleanup
    ~BankAccount() {
        cout << "Account " << accountNumber << " closed\n";
    }
};
```

---

## Summary

"Constructors and destructors automate setup and cleanup!" Tian exclaimed.

"Exactly!" Kuya Miguel said. "Remember:
- **Constructor**: Runs when object is created
- **Destructor**: Runs when object is destroyed
- **Initialization list**: Efficient way to initialize
- **Overloading**: Multiple constructors for flexibility
- **Copy constructor**: For copying objects
- **RAII pattern**: Resource Acquisition Is Initialization"

"Next: **Encapsulation** — proper data hiding!"

---

**Key Takeaways:**
1. Constructors initialize objects automatically
2. Destructors clean up resources
3. Use initialization lists for efficiency
4. Overload constructors for flexibility
5. Destructors free dynamic memory

**Next Lesson:** Encapsulation - Data Hiding Done Right
