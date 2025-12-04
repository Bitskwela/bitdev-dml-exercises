# Lesson 24 Activities: Constructors and Destructors

## The Uninitialized Data Bug

Tian's BankAccount objects sometimes started with random balances like -2847264 or billions in credit. **The problem? No initialization!**

**Constructors solve this.** A constructor runs automatically when an object is created, guaranteeing proper initialization. Every BankAccount starts at zero, every Player starts with full health, every Resident has valid defaults.

**Destructors handle cleanup.** When objects are destroyed, destructors ensure files are closed, memory is freed, connections are released. This is RAII—Resource Acquisition Is Initialization!

---

## Task 1: Default Constructor

**Context:** Constructor with no parameters, sets default values.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Resident {
private:
    string name;
    int age;
    double balance;
    
public:
    // Constructor (same name as class, no return type)
    Resident() {
        name = "Unknown";
        age = 0;
        balance = 0.0;
        cout << "Resident created with default values!" << endl;
    }
    
    void display() {
        cout << "Name: " << name << ", Age: " << age << ", Balance: P" << balance << endl;
    }
    
    void setInfo(string n, int a) {
        name = n;
        age = a;
    }
};

int main() {
    Resident r1;  // Constructor called automatically!
    r1.display();
    
    r1.setInfo("Juan Dela Cruz", 30);
    r1.display();
    
    return 0;
}
```

**Task:** Create a `BankAccount` class with constructor that sets balance to 0.

---

## Task 2: Parameterized Constructor

**Context:** Pass values during object creation.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Resident {
private:
    string name;
    int age;
    double balance;
    
public:
    // Parameterized constructor
    Resident(string n, int a) {
        name = n;
        age = a;
        balance = 0.0;
        cout << "Resident " << name << " created!" << endl;
    }
    
    Resident(string n, int a, double bal) {
        name = n;
        age = a;
        balance = bal;
        cout << "Resident " << name << " created with balance P" << bal << endl;
    }
    
    void display() {
        cout << name << " (" << age << " years old) - Balance: P" << balance << endl;
    }
};

int main() {
    Resident r1("Juan Dela Cruz", 30);
    Resident r2("Maria Santos", 25, 1000.0);
    
    r1.display();
    r2.display();
    
    return 0;
}
```

---

## Task 3: Constructor Overloading

**Context:** Multiple constructors with different parameters.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    double balance;
    
public:
    // Constructor 1: No parameters
    BankAccount() {
        accountNumber = "0000";
        balance = 0.0;
    }
    
    // Constructor 2: Account number only
    BankAccount(string accNum) {
        accountNumber = accNum;
        balance = 0.0;
    }
    
    // Constructor 3: Both parameters
    BankAccount(string accNum, double bal) {
        accountNumber = accNum;
        balance = bal;
    }
    
    void display() {
        cout << "Account: " << accountNumber << ", Balance: P" << balance << endl;
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

## Task 4: Initialization List

**Context:** Modern C++ way to initialize members.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Clearance {
private:
    int id;
    string residentName;
    double fee;
    string status;
    
public:
    // Initialization list (more efficient!)
    Clearance(int i, string name, double f) 
        : id(i), residentName(name), fee(f), status("Pending") {
        cout << "Clearance #" << id << " created for " << residentName << endl;
    }
    
    void display() {
        cout << "ID: " << id << ", Name: " << residentName 
             << ", Fee: P" << fee << ", Status: " << status << endl;
    }
};

int main() {
    Clearance c1(1001, "Juan Dela Cruz", 50.0);
    Clearance c2(1002, "Maria Santos", 100.0);
    
    c1.display();
    c2.display();
    
    return 0;
}
```

**Note:** Initialization list is preferred for efficiency and const members!

---

## Task 5: Destructor Basics

**Context:** Cleanup code that runs when object is destroyed.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Logger {
private:
    string name;
    
public:
    // Constructor
    Logger(string n) : name(n) {
        cout << "[" << name << "] Logger created" << endl;
    }
    
    // Destructor (~ prefix, no parameters, no return)
    ~Logger() {
        cout << "[" << name << "] Logger destroyed" << endl;
    }
    
    void log(string message) {
        cout << "[" << name << "] " << message << endl;
    }
};

int main() {
    cout << "Program start" << endl;
    
    {
        Logger log1("Main");
        log1.log("Doing some work...");
        
        {
            Logger log2("Inner");
            log2.log("Inner work...");
        }  // log2 destroyed here
        
        log1.log("Back to main work...");
    }  // log1 destroyed here
    
    cout << "Program end" << endl;
    
    return 0;
}
```

**Output shows:** Objects destroyed in reverse order of creation!

---

## Task 6: Dynamic Memory in Constructor/Destructor

**Context:** RAII pattern—acquire resources in constructor, release in destructor.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class DynamicArray {
private:
    int* data;
    int size;
    
public:
    // Constructor: allocate memory
    DynamicArray(int s) : size(s) {
        data = new int[size];
        cout << "Array of size " << size << " created" << endl;
    }
    
    // Destructor: free memory
    ~DynamicArray() {
        delete[] data;
        cout << "Array destroyed (memory freed)" << endl;
    }
    
    void set(int index, int value) {
        if (index >= 0 && index < size) {
            data[index] = value;
        }
    }
    
    int get(int index) {
        if (index >= 0 && index < size) {
            return data[index];
        }
        return 0;
    }
    
    void display() {
        cout << "Array: ";
        for (int i = 0; i < size; i++) {
            cout << data[i] << " ";
        }
        cout << endl;
    }
};

int main() {
    DynamicArray arr(5);
    
    arr.set(0, 10);
    arr.set(1, 20);
    arr.set(2, 30);
    
    arr.display();
    
    return 0;
}  // Destructor called automatically, memory freed!
```

**This is RAII:** Resource Acquisition Is Initialization—automatic resource management!

---

## Task 7: Complete Resident System

**Context:** Professional class with proper initialization and cleanup.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Resident {
private:
    int id;
    string name;
    int age;
    double balance;
    bool active;
    
public:
    // Default constructor
    Resident() : id(0), name("Unknown"), age(0), balance(0.0), active(true) {
        cout << "Default resident created" << endl;
    }
    
    // Parameterized constructor
    Resident(int i, string n, int a) : id(i), name(n), age(a), balance(0.0), active(true) {
        cout << "Resident #" << id << " (" << name << ") created" << endl;
    }
    
    // Full constructor
    Resident(int i, string n, int a, double bal) 
        : id(i), name(n), age(a), balance(bal), active(true) {
        cout << "Resident #" << id << " (" << name << ") created with balance P" << bal << endl;
    }
    
    // Destructor
    ~Resident() {
        cout << "Resident #" << id << " (" << name << ") destroyed" << endl;
    }
    
    void addDues(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    void makePayment(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
        }
    }
    
    void display() {
        cout << "ID: " << id << ", Name: " << name 
             << ", Age: " << age << ", Balance: P" << balance << endl;
    }
};

int main() {
    cout << "=== Creating residents ===" << endl;
    
    Resident r1;
    Resident r2(1001, "Juan Dela Cruz", 30);
    Resident r3(1002, "Maria Santos", 25, 500.0);
    
    cout << "\n=== Displaying residents ===" << endl;
    r1.display();
    r2.display();
    r3.display();
    
    cout << "\n=== Program ending ===" << endl;
    return 0;
}  // All destructors called automatically!
```

---

<details>
<summary><strong>📝 Constructor/Destructor Summary</strong></summary>

**Constructor:**
- Same name as class
- No return type
- Called automatically when object created
- Can be overloaded
- Initializes members

**Syntax:**
```cpp
class Example {
public:
    Example() { }                    // Default
    Example(int x) : value(x) { }    // Parameterized
    ~Example() { }                   // Destructor
};
```

**Initialization List (Preferred):**
```cpp
Example(int x, string s) : value(x), name(s) { }
```

**Destructor:**
- `~ClassName()`
- No parameters, no return type
- Called when object destroyed
- Cleanup resources (memory, files, etc.)
- One destructor per class

**RAII Pattern:**
- Acquire resources in constructor
- Release resources in destructor
- Automatic resource management
- No memory leaks!

</details>

---

**Constructors guarantee initialization. Destructors guarantee cleanup. Professional C++ uses both!**
