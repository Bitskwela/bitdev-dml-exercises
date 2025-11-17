# Quiz: Lesson 23 - Classes and Objects

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Class Basics

### Question 1
What's the main difference between struct and class in C++?

A) Structs can't have functions  
B) Default access: struct is public, class is private  
C) Classes are faster  
D) No difference

**Answer: B) Default access: struct is public, class is private**

**Explanation:**
```cpp
struct MyStruct {
    int x;  // Public by default
};

class MyClass {
    int x;  // Private by default
};

// Both can have functions, inheritance, etc.
// Only difference is default access
```

---

### Question 2
What's the output?

```cpp
class Resident {
public:
    string name;
    int age;
    
    void display() {
        cout << name << " - " << age;
    }
};

int main() {
    Resident r;
    r.name = "Juan";
    r.age = 30;
    r.display();
}
```

A) `Juan - 30`  
B) Error: display() not defined  
C) Error: name is private  
D) Nothing

**Answer: A) `Juan - 30`**

**Explanation:**
```cpp
// All members are public
r.name = "Juan";    // ✓ Public
r.age = 30;         // ✓ Public
r.display();        // ✓ Public method
// Output: Juan - 30
```

---

### Question 3
Which code is correct?

```cpp
class BankAccount {
private:
    double balance;
public:
    string accountNumber;
};

int main() {
    BankAccount acc;
    
    // Option A
    acc.balance = 5000;
    
    // Option B
    acc.accountNumber = "1001";
}
```

A) Both valid  
B) Only A valid  
C) Only B valid  
D) Neither valid

**Answer: C) Only B valid**

**Explanation:**
```cpp
// balance is private - cannot access from main()
acc.balance = 5000;  // ❌ Error!

// accountNumber is public - can access
acc.accountNumber = "1001";  // ✓ OK
```

---

## Section 2: Methods

### Question 4
How do you define a method outside the class?

```cpp
class Resident {
public:
    string name;
    void display();  // Declaration
};

// Definition outside?
```

A) `void display() { ... }`  
B) `void Resident::display() { ... }`  
C) `Resident.display() { ... }`  
D) `display() { ... }`

**Answer: B) `void Resident::display() { ... }`**

**Explanation:**
```cpp
class Resident {
public:
    string name;
    void display();  // Declaration
};

// Definition outside - use ClassName::
void Resident::display() {
    cout << name << endl;
}

// :: is the scope resolution operator
```

---

### Question 5
What's the output?

```cpp
class Counter {
private:
    int count;
public:
    void setCount(int c) {
        count = c;
    }
    
    void increment() {
        count++;
    }
    
    int getCount() {
        return count;
    }
};

int main() {
    Counter c;
    c.setCount(10);
    c.increment();
    c.increment();
    cout << c.getCount();
}
```

A) `10`  
B) `11`  
C) `12`  
D) Error

**Answer: C) `12`**

**Explanation:**
```cpp
c.setCount(10);  // count = 10
c.increment();   // count = 11
c.increment();   // count = 12
cout << c.getCount();  // 12
```

---

## Section 3: Access Control

### Question 6
Why make data members private?

```cpp
class BankAccount {
private:
    double balance;
public:
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
};
```

A) Faster execution  
B) Save memory  
C) Control access and add validation  
D) Required by C++

**Answer: C) Control access and add validation**

**Explanation:**
```cpp
// Private with public methods = controlled access

class BankAccount {
private:
    double balance;  // Hidden
    
public:
    void deposit(double amount) {
        if (amount > 0) {  // ✓ Validation!
            balance += amount;
        } else {
            cout << "Invalid amount\n";
        }
    }
};

// Can't do this:
// account.balance = -5000;  // ❌ Private! Can't set negative

// Must use method (with validation):
account.deposit(-5000);  // Rejected by validation
```

---


# Quiz 2

### Question 7
What's the output?

```cpp
class Box {
private:
    int value;
public:
    void setValue(int v) {
        value = v;
    }
    int getValue() {
        return value;
    }
};

int main() {
    Box b;
    b.setValue(100);
    cout << b.getValue();
}
```

A) `0`  
B) `100`  
C) Error  
D) Undefined

**Answer: B) `100`**

**Explanation:**
```cpp
b.setValue(100);  // value = 100
cout << b.getValue();  // Returns 100
```

---

### Question 8
Which is better practice?

```cpp
// Option A
class Resident {
public:
    string name;
    int age;
};

// Option B
class Resident {
private:
    string name;
    int age;
public:
    void setName(string n) { name = n; }
    string getName() { return name; }
    void setAge(int a) { if (a > 0) age = a; }
    int getAge() { return age; }
};
```

A) Option A (simpler)  
B) Option B (encapsulation)  
C) Both same  
D) Depends

**Answer: B) Option B (encapsulation)**

**Explanation:**
**Option A:** Direct access, no validation

**Option B:** 
- ✓ Data hiding
- ✓ Validation (age > 0)
- ✓ Can change implementation without breaking code
- ✓ Better maintainability

```cpp
// With Option B:
Resident r;
r.setAge(-5);  // ✓ Rejected by validation
r.setAge(25);  // ✓ Accepted
```

---

## Section 4: This Pointer

### Question 9
What does `this` refer to?

```cpp
class Resident {
private:
    string name;
public:
    void setName(string name) {
        this->name = name;
    }
};
```

A) The class itself  
B) The current object  
C) The parameter  
D) The base class

**Answer: B) The current object**

**Explanation:**
```cpp
void setName(string name) {
    this->name = name;
    // this->name = member variable (object's name)
    // name = parameter
}

Resident r1;
r1.setName("Juan");  // Inside setName(), this points to r1

Resident r2;
r2.setName("Maria");  // Inside setName(), this points to r2
```

---


# Quiz 1

### Question 10
What's the output?

```cpp
class Counter {
private:
    int count;
public:
    void setCount(int count) {
        this->count = count;
    }
    void increment() {
        this->count++;
    }
    int getCount() {
        return count;
    }
};

int main() {
    Counter c1, c2;
    c1.setCount(5);
    c2.setCount(10);
    c1.increment();
    cout << c1.getCount() << " " << c2.getCount();
}
```

A) `5 10`  
B) `6 10`  
C) `6 11`  
D) `11 11`

**Answer: B) `6 10`**

**Explanation:**
```cpp
c1.setCount(5);   // c1.count = 5
c2.setCount(10);  // c2.count = 10
c1.increment();   // c1.count = 6 (only c1 incremented!)

// Each object has its own data
cout << c1.getCount() << " " << c2.getCount();  // 6 10
```

---

## Section 5: Practical Applications

### Question 11
What's wrong with this getter?

```cpp
class BankAccount {
private:
    double balance;
public:
    double getBalance() {
        return balance++;  // ← Problem?
    }
};
```

A) Nothing wrong  
B) Getter should not modify data  
C) Missing return type  
D) balance is private

**Answer: B) Getter should not modify data**

**Explanation:**
```cpp
// ❌ BAD: Getter modifies data
double getBalance() {
    return balance++;  // Changes balance!
}

// ✓ GOOD: Getter only reads
double getBalance() {
    return balance;  // Read-only
}

// Or make it const:
double getBalance() const {
    return balance;  // Guaranteed not to modify
}
```

---


# Quiz 1

### Question 12
How do you create an array of objects?

```cpp
class Resident {
public:
    string name;
    int age;
};

int main() {
    // ???
}
```

A) `Resident residents[3];`  
B) `Resident* residents = new Resident[3];`  
C) `vector<Resident> residents;`  
D) All valid

**Answer: D) All valid**

**Explanation:**
```cpp
// Static array
Resident residents[3];
residents[0].name = "Juan";

// Dynamic array
Resident* residents = new Resident[3];
residents[1].name = "Maria";
delete[] residents;

// Vector (best for dynamic size)
vector<Resident> residents;
Resident r;
r.name = "Pedro";
residents.push_back(r);
```

---


# Quiz 1

### Question 13
What's the output?

```cpp
class DuesAccount {
private:
    double balance;
public:
    void addDues(double amount) {
        balance += amount;
    }
    void pay(double amount) {
        if (amount <= balance) {
            balance -= amount;
        }
    }
    double getBalance() {
        return balance;
    }
};

int main() {
    DuesAccount acc;
    acc.addDues(100);
    acc.pay(60);
    acc.pay(50);  // Only 40 left
    cout << acc.getBalance();
}
```

A) `0`  
B) `40`  
C) `-10`  
D) Undefined

**Answer: B) `40`**

**Explanation:**
```cpp
acc.addDues(100);  // balance = 100
acc.pay(60);       // balance = 40
acc.pay(50);       // 50 > 40, payment rejected!
cout << acc.getBalance();  // Still 40
```

---


# Quiz 1

### Question 14
Which design is better for a clearance system?

```cpp
// Option A: Public data
class Clearance {
public:
    int id;
    string status;
    double fee;
};

// Option B: Private data with methods
class Clearance {
private:
    int id;
    string status;
    double fee;
public:
    void approve() {
        status = "approved";
    }
    void reject() {
        status = "rejected";
    }
    string getStatus() {
        return status;
    }
};
```

A) Option A (simpler)  
B) Option B (controlled)  
C) Both same  
D) Neither

**Answer: B) Option B (controlled)**

**Explanation:**
**Option A problems:**
```cpp
Clearance c;
c.status = "xyz";  // ❌ Invalid status! No validation
```

**Option B benefits:**
```cpp
Clearance c;
// c.status = "xyz";  // ❌ Compile error! Can't access

c.approve();  // ✓ Only valid operations allowed
c.reject();

// Status can only be set through controlled methods
```

**Encapsulation ensures data integrity!**

---


# Quiz 1

### Question 15
Design a barangay resident class. Which is best?

```cpp
// Option A: All public
class Resident {
public:
    int id;
    string name;
    double balance;
};

// Option B: All private
class Resident {
private:
    int id;
    string name;
    double balance;
};

// Option C: Mixed with methods
class Resident {
private:
    int id;
    double balance;
public:
    string name;  // OK to read/write directly
    
    void setId(int newId) { id = newId; }
    int getId() { return id; }
    
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

A) Option A  
B) Option B  
C) Option C  
D) All same

**Answer: C) Option C**

**Explanation:**
**Option A:** No protection, can set invalid data

**Option B:** Can't access anything, even to read!

**Option C:** ✓ Balanced approach
- **ID:** Private (shouldn't change after creation)
- **Name:** Public (simple string, OK to access directly)
- **Balance:** Private with validation (financial data needs protection)

```cpp
Resident r;
r.setId(1001);       // ✓ Set once
r.name = "Juan";     // ✓ Direct access OK for name
r.addBalance(500);   // ✓ Validated
r.addBalance(-100);  // ✓ Rejected by validation

// r.id = 2000;      // ❌ Can't change ID directly
// r.balance = -500; // ❌ Can't set negative balance
```

**Choose access level based on data sensitivity and validation needs!**

---

**Score yourself:**
- 15/15: OOP Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review encapsulation
- Below 9: Re-read class concepts

**Key Concepts:**
1. Classes bundle data and behavior
2. Private hides, public exposes
3. Methods provide controlled access
4. Use getters/setters for validation
5. this-> refers to current object
