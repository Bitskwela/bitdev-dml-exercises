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

# Tasks for Learners

- Create a `BankAccount` class with a default constructor that initializes the account number to "0000" and balance to 0.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class BankAccount {
  private:
      string accountNumber;
      double balance;
      
  public:
      // Constructor that sets default values
      BankAccount() {
          accountNumber = "0000";
          balance = 0.0;
          cout << "BankAccount created with default values!" << endl;
      }
      
      void display() {
          cout << "Account: " << accountNumber << ", Balance: P" << balance << endl;
      }
      
      void deposit(double amount) {
          if (amount > 0) {
              balance += amount;
          }
      }
  };

  int main() {
      BankAccount account;
      account.display();
      
      account.deposit(1000);
      account.display();
      
      return 0;
  }
  ```

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

# Tasks for Learners

- Create a `Student` class with a parameterized constructor that accepts name and grade, initializing attendance to 0.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class Student {
  private:
      string name;
      int grade;
      int attendance;
      
  public:
      // Parameterized constructor
      Student(string n, int g) {
          name = n;
          grade = g;
          attendance = 0;
          cout << "Student " << name << " created with grade " << grade << endl;
      }
      
      void display() {
          cout << name << " - Grade: " << grade << ", Attendance: " << attendance << " days" << endl;
      }
      
      void markAttendance() {
          attendance++;
      }
  };

  int main() {
      Student s1("Juan Dela Cruz", 85);
      Student s2("Maria Santos", 92);
      
      s1.display();
      s2.display();
      
      s1.markAttendance();
      s1.markAttendance();
      
      s1.display();
      
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

# Tasks for Learners

- Create a `Product` class with three overloaded constructors: default (sets name to "Unknown", price to 0), one parameter (name only), and two parameters (name and price).

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class Product {
  private:
      string name;
      double price;
      
  public:
      // Constructor 1: Default
      Product() {
          name = "Unknown";
          price = 0.0;
          cout << "Default product created" << endl;
      }
      
      // Constructor 2: Name only
      Product(string n) {
          name = n;
          price = 0.0;
          cout << "Product " << name << " created with default price" << endl;
      }
      
      // Constructor 3: Name and price
      Product(string n, double p) {
          name = n;
          price = p;
          cout << "Product " << name << " created with price P" << price << endl;
      }
      
      void display() {
          cout << "Product: " << name << ", Price: P" << price << endl;
      }
  };

  int main() {
      Product p1;                      // Default constructor
      Product p2("Rice");              // Name only
      Product p3("Sugar", 75.50);      // Name and price
      
      p1.display();
      p2.display();
      p3.display();
      
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

# Tasks for Learners

- Create a `Complaint` class using initialization list syntax to initialize id, complainant name, description, and status (default to "Open").

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class Complaint {
  private:
      int id;
      string complainantName;
      string description;
      string status;
      
  public:
      // Initialization list
      Complaint(int i, string name, string desc) 
          : id(i), complainantName(name), description(desc), status("Open") {
          cout << "Complaint #" << id << " filed by " << complainantName << endl;
      }
      
      void display() {
          cout << "Complaint #" << id << endl;
          cout << "Complainant: " << complainantName << endl;
          cout << "Description: " << description << endl;
          cout << "Status: " << status << endl;
      }
      
      void resolve() {
          status = "Resolved";
          cout << "Complaint #" << id << " has been resolved." << endl;
      }
  };

  int main() {
      Complaint c1(101, "Juan Dela Cruz", "Loud noise at night");
      Complaint c2(102, "Maria Santos", "Broken streetlight");
      
      c1.display();
      cout << endl;
      
      c1.resolve();
      c1.display();
      
      return 0;
  }
  ```

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

# Tasks for Learners

- Create a `FileHandler` class with constructor and destructor that prints messages indicating when a file is opened and closed.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class FileHandler {
  private:
      string filename;
      
  public:
      // Constructor
      FileHandler(string fname) : filename(fname) {
          cout << "[Opening file: " << filename << "]" << endl;
      }
      
      // Destructor
      ~FileHandler() {
          cout << "[Closing file: " << filename << "]" << endl;
      }
      
      void write(string data) {
          cout << "[Writing to " << filename << "]: " << data << endl;
      }
      
      void read() {
          cout << "[Reading from " << filename << "]" << endl;
      }
  };

  int main() {
      cout << "Program start" << endl;
      
      {
          FileHandler file1("data.txt");
          file1.write("Hello World");
          file1.read();
          
          {
              FileHandler file2("log.txt");
              file2.write("Log entry");
          }  // file2 destroyed here
          
          file1.write("More data");
      }  // file1 destroyed here
      
      cout << "Program end" << endl;
      
      return 0;
  }
  ```

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

# Tasks for Learners

- Create a `DynamicString` class that allocates a character array in the constructor and frees it in the destructor.

  ```cpp
  #include <iostream>
  #include <cstring>
  using namespace std;

  class DynamicString {
  private:
      char* data;
      int length;
      
  public:
      // Constructor: allocate memory
      DynamicString(const char* str) {
          length = strlen(str);
          data = new char[length + 1];
          strcpy(data, str);
          cout << "String '" << data << "' created (length: " << length << ")" << endl;
      }
      
      // Destructor: free memory
      ~DynamicString() {
          cout << "String '" << data << "' destroyed (memory freed)" << endl;
          delete[] data;
      }
      
      void display() {
          cout << "String: " << data << endl;
      }
      
      int getLength() {
          return length;
      }
  };

  int main() {
      DynamicString s1("Hello");
      DynamicString s2("Barangay Management System");
      
      s1.display();
      s2.display();
      
      cout << "Length of s1: " << s1.getLength() << endl;
      cout << "Length of s2: " << s2.getLength() << endl;
      
      return 0;
  }  // Destructors called automatically, memory freed!
  ```

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

# Tasks for Learners

- Create a complete `BankAccount` class with default, parameterized, and full constructors, plus a destructor that logs account closure.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class BankAccount {
  private:
      string accountNumber;
      string ownerName;
      double balance;
      bool isActive;
      
  public:
      // Default constructor
      BankAccount() : accountNumber("0000"), ownerName("Unknown"), balance(0.0), isActive(true) {
          cout << "Default account created" << endl;
      }
      
      // Parameterized constructor
      BankAccount(string accNum, string owner) 
          : accountNumber(accNum), ownerName(owner), balance(0.0), isActive(true) {
          cout << "Account " << accountNumber << " created for " << ownerName << endl;
      }
      
      // Full constructor
      BankAccount(string accNum, string owner, double initialBalance) 
          : accountNumber(accNum), ownerName(owner), balance(initialBalance), isActive(true) {
          cout << "Account " << accountNumber << " created for " << ownerName 
               << " with initial balance P" << balance << endl;
      }
      
      // Destructor
      ~BankAccount() {
          cout << "Account " << accountNumber << " (" << ownerName << ") closed" << endl;
      }
      
      void deposit(double amount) {
          if (amount > 0 && isActive) {
              balance += amount;
              cout << "Deposited P" << amount << " to account " << accountNumber << endl;
          }
      }
      
      bool withdraw(double amount) {
          if (amount > 0 && amount <= balance && isActive) {
              balance -= amount;
              cout << "Withdrew P" << amount << " from account " << accountNumber << endl;
              return true;
          }
          cout << "Withdrawal failed!" << endl;
          return false;
      }
      
      void display() {
          cout << "Account: " << accountNumber << ", Owner: " << ownerName 
               << ", Balance: P" << balance << ", Active: " << (isActive ? "Yes" : "No") << endl;
      }
  };

  int main() {
      cout << "=== Creating accounts ===" << endl;
      
      BankAccount acc1;
      BankAccount acc2("1001", "Juan Dela Cruz");
      BankAccount acc3("1002", "Maria Santos", 5000.0);
      
      cout << "\n=== Account details ===" << endl;
      acc1.display();
      acc2.display();
      acc3.display();
      
      cout << "\n=== Transactions ===" << endl;
      acc2.deposit(2000);
      acc3.withdraw(1500);
      
      cout << "\n=== Updated details ===" << endl;
      acc2.display();
      acc3.display();
      
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
