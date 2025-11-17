# Quiz: Lesson 24 - Constructors and Destructors

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Constructor Basics

### Question 1
What is a constructor?

A) A function that builds classes  
B) A special method that initializes objects automatically  
C) A function that destroys objects  
D) A type of variable

**Answer: B) A special method that initializes objects automatically**

**Explanation:**
```cpp
class Resident {
public:
    string name;
    
    // Constructor - runs when object is created
    Resident() {
        name = "Unknown";
        cout << "Resident created!\n";
    }
};

Resident r;  // Constructor runs automatically!
```

---

### Question 2
What's the output?

```cpp
class Box {
public:
    int size;
    
    Box() {
        size = 10;
        cout << "Box created\n";
    }
};

int main() {
    Box b;
    cout << b.size;
}
```

A) `Box created`  
B) `10`  
C) `Box created\n10`  
D) Error

**Answer: C) `Box created\n10`**

**Explanation:**
```cpp
Box b;  // Constructor runs: prints "Box created", sets size = 10
cout << b.size;  // Prints: 10
```

---

### Question 3
Which constructor is correct?

```cpp
class Resident {
public:
    string name;
    
    // Option A
    void Resident() {
        name = "Juan";
    }
    
    // Option B
    Resident() {
        name = "Juan";
    }
    
    // Option C
    int Resident() {
        name = "Juan";
        return 0;
    }
};
```

A) Option A  
B) Option B  
C) Option C  
D) All valid

**Answer: B) Option B**

**Explanation:**
```cpp
// ❌ Wrong: has return type void
void Resident() { }

// ✓ Correct: same name as class, no return type
Resident() { }

// ❌ Wrong: has return type int
int Resident() { }

// Constructor rules:
// 1. Same name as class
// 2. NO return type (not even void)
```

---

## Section 2: Parameterized Constructors

### Question 4
What's the output?

```cpp
class Account {
public:
    string number;
    double balance;
    
    Account(string num, double bal) {
        number = num;
        balance = bal;
    }
};

int main() {
    Account acc("1001", 5000);
    cout << acc.number << " - " << acc.balance;
}
```

A) `0 - 0`  
B) `1001 - 5000`  
C) Error  
D) Nothing

**Answer: B) `1001 - 5000`**

**Explanation:**
```cpp
Account acc("1001", 5000);  // Constructor sets number="1001", balance=5000
cout << acc.number << " - " << acc.balance;  // 1001 - 5000
```

---

### Question 5
Can a class have multiple constructors?

```cpp
class Resident {
public:
    string name;
    int age;
    
    Resident() {
        name = "Unknown";
        age = 0;
    }
    
    Resident(string n, int a) {
        name = n;
        age = a;
    }
};
```

A) No, only one constructor allowed  
B) Yes, called constructor overloading  
C) Only with inheritance  
D) Depends on compiler

**Answer: B) Yes, called constructor overloading**

**Explanation:**
```cpp
Resident r1;                 // Uses Resident()
Resident r2("Juan", 30);     // Uses Resident(string, int)

// Different parameters = different constructors
// This is overloading!
```

---

## Section 3: Initialization Lists

### Question 6
Which initialization is more efficient?

```cpp
// Option A: Assignment in body
class Resident {
public:
    string name;
    Resident(string n) {
        name = n;
    }
};

// Option B: Initialization list
class Resident {
public:
    string name;
    Resident(string n) : name(n) {
    }
};
```

A) Both same  
B) Option B (initialization list)  
C) Option A  
D) Depends

**Answer: B) Option B (initialization list)**

**Explanation:**
```cpp
// Option A: Creates name, then assigns
Resident(string n) {
    name = n;  // 1. Default construct, 2. Assign
}

// Option B: Directly initializes
Resident(string n) : name(n) {  // ✓ Direct initialization
}

// Benefits:
// - More efficient
// - Required for const members
// - Preferred C++ style
```

---


# Quiz 2

### Question 7
What's the output?

```cpp
class Counter {
private:
    int count;
public:
    Counter(int c) : count(c) {
        cout << "Count: " << count << endl;
    }
};

int main() {
    Counter c1(10);
    Counter c2(20);
}
```

A) `Count: 10`  
B) `Count: 10\nCount: 20`  
C) `Count: 20`  
D) Error

**Answer: B) `Count: 10\nCount: 20`**

**Explanation:**
```cpp
Counter c1(10);  // Constructor runs: Count: 10
Counter c2(20);  // Constructor runs: Count: 20
```

---

## Section 4: Destructors

### Question 8
What is a destructor?

A) Deletes the class  
B) Runs automatically when object is destroyed  
C) A type of constructor  
D) Optional cleanup function

**Answer: B) Runs automatically when object is destroyed**

**Explanation:**
```cpp
class Resident {
public:
    string name;
    
    Resident(string n) : name(n) {
        cout << name << " created\n";
    }
    
    ~Resident() {  // Destructor
        cout << name << " destroyed\n";
    }
};

int main() {
    Resident r("Juan");
    // Destructor runs automatically when r goes out of scope
}
```

---

### Question 9
What's the output?

```cpp
class Box {
public:
    int id;
    
    Box(int i) : id(i) {
        cout << "Box " << id << " created\n";
    }
    
    ~Box() {
        cout << "Box " << id << " destroyed\n";
    }
};

int main() {
    Box b1(1);
    Box b2(2);
    return 0;
}
```

A) `Box 1 created\nBox 2 created`  
B) `Box 1 created\nBox 2 created\nBox 2 destroyed\nBox 1 destroyed`  
C) `Box 1 destroyed\nBox 2 destroyed`  
D) Error

**Answer: B) `Box 1 created\nBox 2 created\nBox 2 destroyed\nBox 1 destroyed`**

**Explanation:**
```cpp
Box b1(1);  // Constructor: Box 1 created
Box b2(2);  // Constructor: Box 2 created

// main() ends - objects destroyed in REVERSE order (LIFO - Last In First Out)
// ~Box() for b2: Box 2 destroyed
// ~Box() for b1: Box 1 destroyed
```

---


# Quiz 1

### Question 10
When is a destructor essential?

```cpp
class DynamicArray {
private:
    int* arr;
    int size;
public:
    DynamicArray(int s) : size(s) {
        arr = new int[size];
    }
    
    ~DynamicArray() {
        delete[] arr;  // ← Essential!
    }
};
```

A) Never, optional  
B) When using dynamic memory  
C) Only with large classes  
D) Only with pointers

**Answer: B) When using dynamic memory**

**Explanation:**
```cpp
// Without destructor:
DynamicArray(int s) : size(s) {
    arr = new int[size];  // Allocate memory
}
// When object destroyed, arr pointer deleted, but memory NOT freed = MEMORY LEAK!

// With destructor:
~DynamicArray() {
    delete[] arr;  // ✓ Free memory
}

// Essential for: dynamic memory, file handles, network connections, etc.
```

---

## Section 5: Advanced Concepts

### Question 11
What's wrong with this code?

```cpp
class Resident {
private:
    string name;
public:
    Resident() {
        name = "Unknown";
    }
};

int main() {
    Resident r("Juan");  // ← Problem?
}
```

A) Nothing wrong  
B) No constructor accepts string parameter  
C) name is private  
D) Missing destructor

**Answer: B) No constructor accepts string parameter**

**Explanation:**
```cpp
class Resident {
public:
    Resident() { ... }  // Takes NO parameters
};

Resident r("Juan");  // ❌ Error! No constructor takes string

// Fix: Add parameterized constructor
Resident(string n) : name(n) { }
```

---


# Quiz 1

### Question 12
What's the output?

```cpp
class Counter {
private:
    static int count;
public:
    Counter() {
        count++;
    }
    ~Counter() {
        count--;
    }
    static int getCount() {
        return count;
    }
};

int Counter::count = 0;

int main() {
    Counter c1;
    Counter c2;
    cout << Counter::getCount() << endl;
    {
        Counter c3;
        cout << Counter::getCount() << endl;
    }
    cout << Counter::getCount();
}
```

A) `2\n3\n2`  
B) `2\n2\n2`  
C) `1\n2\n1`  
D) `3\n3\n3`

**Answer: A) `2\n3\n2`**

**Explanation:**
```cpp
Counter c1;  // count = 1
Counter c2;  // count = 2
cout << Counter::getCount();  // 2

{
    Counter c3;  // count = 3
    cout << Counter::getCount();  // 3
}  // c3 destroyed, count = 2

cout << Counter::getCount();  // 2
```

---


# Quiz 1

### Question 13
What's a copy constructor?

```cpp
class Resident {
public:
    string name;
    
    Resident(const Resident& other) {
        name = other.name;
        cout << "Copy constructor called\n";
    }
};
```

A) A constructor that copies classes  
B) A constructor for copying objects  
C) A duplicate constructor  
D) Not valid

**Answer: B) A constructor for copying objects**

**Explanation:**
```cpp
Resident r1;
r1.name = "Juan";

Resident r2 = r1;  // Copy constructor called
// r2.name = "Juan" (copied from r1)
```

---


# Quiz 1

### Question 14
Which design is better?

```cpp
// Option A: Manual cleanup
class FileHandler {
public:
    FILE* file;
    
    void open(string filename) {
        file = fopen(filename.c_str(), "r");
    }
    
    void close() {
        fclose(file);
    }
};

// Usage:
FileHandler fh;
fh.open("data.txt");
// ... use file ...
fh.close();  // ← Must remember!

// Option B: RAII pattern
class FileHandler {
private:
    FILE* file;
public:
    FileHandler(string filename) {
        file = fopen(filename.c_str(), "r");
    }
    
    ~FileHandler() {
        if (file) {
            fclose(file);  // Automatic cleanup!
        }
    }
};

// Usage:
FileHandler fh("data.txt");
// ... use file ...
// Automatic cleanup when fh goes out of scope
```

A) Option A (explicit control)  
B) Option B (RAII)  
C) Both same  
D) Neither

**Answer: B) Option B (RAII)**

**Explanation:**
**Option A problems:**
- Must remember to call close()
- If exception occurs, file not closed
- Easy to forget cleanup

**Option B benefits (RAII):**
- ✓ Automatic cleanup (guaranteed!)
- ✓ Exception-safe
- ✓ Can't forget to close

**RAII = Resource Acquisition Is Initialization**

---


# Quiz 1

### Question 15
Design a barangay clearance class with proper initialization and cleanup. Which is best?

```cpp
// Option A: Manual setup
class Clearance {
public:
    int id;
    string name;
    double fee;
    
    void setup(int i, string n, double f) {
        id = i;
        name = n;
        fee = f;
    }
};

// Usage:
Clearance c;
c.setup(1001, "Juan", 50.0);

// Option B: Constructor with validation
class Clearance {
private:
    int id;
    string name;
    double fee;
    string status;
public:
    Clearance(int i, string n, double f) 
        : id(i), name(n), status("pending") {
        
        fee = (f >= 0) ? f : 0;  // Validate
        cout << "Clearance #" << id << " created\n";
    }
    
    ~Clearance() {
        cout << "Clearance #" << id << " archived\n";
    }
    
    // Getters for private data
    int getId() { return id; }
    string getStatus() { return status; }
};

// Usage:
Clearance c(1001, "Juan", 50.0);
// Automatic initialization with validation
// Automatic cleanup
```

A) Option A (simpler)  
B) Option B (proper OOP)  
C) Both same  
D) Neither

**Answer: B) Option B (proper OOP)**

**Explanation:**
**Option A problems:**
- Must remember to call setup()
- No validation
- Public data (no encapsulation)
- Can create uninitialized object

**Option B benefits:**
- ✓ Automatic initialization (can't forget!)
- ✓ Validation in constructor
- ✓ Private data with getters
- ✓ Automatic logging/cleanup
- ✓ Object always in valid state

```cpp
// Option A - can create invalid object
Clearance c;  // Uninitialized!
// forgot to call setup()

// Option B - always initialized
Clearance c(1001, "Juan", 50.0);  // ✓ Guaranteed initialization
Clearance c2(1002, "Maria", -100);  // ✓ Validated (fee = 0)
```

**Constructors ensure objects are NEVER in invalid state!**

---

**Score yourself:**
- 15/15: Constructor Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review RAII
- Below 9: Re-read constructor concepts

**Key Concepts:**
1. Constructors initialize automatically
2. Destructors clean up automatically
3. Initialization lists are efficient
4. RAII pattern manages resources
5. Copy constructors for object copying
