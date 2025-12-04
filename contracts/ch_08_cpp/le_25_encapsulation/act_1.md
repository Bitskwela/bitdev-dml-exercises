# Lesson 25 Activities: Encapsulation

## The Security Flaw

Tian proudly showed the BankAccount class: **"Look! Users can directly set balance: `account.balance = 1000000`. Instant millionaire!"**

Kuya Miguel's face went serious. **"That's a critical security flaw."** No validation, no limits, no security. Real bank software would never allow direct access.

**Encapsulation = Make data private + provide controlled access through methods.** Want to withdraw? Call `withdraw(amount)` which checks funds. Want balance? Call `getBalance()` which returns a copy.

**Think of it like an ATM.** You don't reach inside and grab cash. You interact through a controlled interface that validates, checks balance, records transactions.

---

## Task 1: Private Data Members

**Context:** Hide implementation details.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    double balance;  // Hidden!
    string accountNumber;
    
public:
    BankAccount(string accNum, double initialBalance) 
        : accountNumber(accNum), balance(initialBalance) {}
    
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "Deposited P" << amount << endl;
        }
    }
    
    bool withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Withdrew P" << amount << endl;
            return true;
        }
        cout << "Insufficient funds!" << endl;
        return false;
    }
    
    double getBalance() const {
        return balance;
    }
    
    void display() const {
        cout << "Account: " << accountNumber << ", Balance: P" << balance << endl;
    }
};

int main() {
    BankAccount account("1001", 5000.0);
    
    // account.balance = 1000000;  // ❌ Error! balance is private
    
    account.deposit(2000.0);
    account.withdraw(1500.0);
    account.withdraw(10000.0);  // Fails
    
    cout << "Current balance: P" << account.getBalance() << endl;
    
    return 0;
}
```

---

## Task 2: Getters and Setters

**Context:** Controlled read/write access with validation.

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
    Resident(string n, int a) : name(n), age(0), balance(0) {
        setAge(a);  // Use setter for validation
    }
    
    // Getters (read-only access)
    string getName() const { return name; }
    int getAge() const { return age; }
    double getBalance() const { return balance; }
    
    // Setters (write with validation)
    void setName(const string& n) {
        if (!n.empty()) {
            name = n;
        }
    }
    
    void setAge(int a) {
        if (a >= 0 && a <= 150) {
            age = a;
        } else {
            cout << "Invalid age!" << endl;
        }
    }
    
    void addBalance(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    bool deductBalance(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }
    
    void display() const {
        cout << "Name: " << name << ", Age: " << age << ", Balance: P" << balance << endl;
    }
};

int main() {
    Resident r("Juan Dela Cruz", 30);
    
    r.display();
    
    r.setAge(200);  // Rejected
    r.setAge(35);   // Accepted
    
    r.addBalance(1000);
    r.deductBalance(300);
    
    r.display();
    
    return 0;
}
```

---

## Task 3: Const Member Functions

**Context:** Promise not to modify object.

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
    Clearance(int i, string name, double f) 
        : id(i), residentName(name), fee(f), status("Pending") {}
    
    // Const functions - don't modify object
    int getId() const { return id; }
    string getName() const { return residentName; }
    double getFee() const { return fee; }
    string getStatus() const { return status; }
    
    bool isPending() const { return status == "Pending"; }
    bool isApproved() const { return status == "Approved"; }
    
    void display() const {
        cout << "Clearance #" << id << " - " << residentName 
             << " (P" << fee << ") - " << status << endl;
    }
    
    // Non-const - modifies object
    void approve() {
        if (status == "Pending") {
            status = "Approved";
        }
    }
    
    void reject() {
        if (status == "Pending") {
            status = "Rejected";
        }
    }
};

int main() {
    const Clearance c1(1001, "Juan", 50.0);
    
    // c1.approve();  // ❌ Error! Can't call non-const on const object
    
    cout << c1.getName() << endl;  // ✓ OK! Const function
    c1.display();  // ✓ OK!
    
    Clearance c2(1002, "Maria", 100.0);
    c2.approve();  // ✓ OK! Non-const object
    c2.display();
    
    return 0;
}
```

---

## Task 4: Validation in Setters

**Context:** Prevent invalid data from entering the system.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    string name;
    int grade;
    
public:
    Student(string n) : name(n), grade(75) {}
    
    string getName() const { return name; }
    int getGrade() const { return grade; }
    
    void setName(const string& n) {
        if (n.length() >= 2) {
            name = n;
        } else {
            cout << "Name too short!" << endl;
        }
    }
    
    void setGrade(int g) {
        if (g >= 0 && g <= 100) {
            grade = g;
        } else {
            cout << "Invalid grade! Must be 0-100." << endl;
        }
    }
    
    void addPoints(int points) {
        int newGrade = grade + points;
        if (newGrade <= 100) {
            grade = newGrade;
        } else {
            grade = 100;  // Cap at 100
        }
    }
    
    void display() const {
        cout << name << ": " << grade << endl;
    }
};

int main() {
    Student s("Juan");
    
    s.display();
    
    s.setGrade(150);  // Rejected
    s.setGrade(85);   // Accepted
    
    s.addPoints(20);  // 85 + 20 = 100 (capped)
    
    s.display();
    
    return 0;
}
```

---

## Task 5: Computed Properties

**Context:** Some properties are calculated, not stored.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Rectangle {
private:
    double width;
    double height;
    
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    
    // Getters
    double getWidth() const { return width; }
    double getHeight() const { return height; }
    
    // Computed properties (not stored, calculated on demand)
    double getArea() const {
        return width * height;
    }
    
    double getPerimeter() const {
        return 2 * (width + height);
    }
    
    bool isSquare() const {
        return width == height;
    }
    
    // Setters with validation
    void setWidth(double w) {
        if (w > 0) width = w;
    }
    
    void setHeight(double h) {
        if (h > 0) height = h;
    }
    
    void display() const {
        cout << "Rectangle: " << width << " x " << height << endl;
        cout << "Area: " << getArea() << endl;
        cout << "Perimeter: " << getPerimeter() << endl;
        cout << "Is square: " << (isSquare() ? "Yes" : "No") << endl;
    }
};

int main() {
    Rectangle rect(5, 10);
    rect.display();
    
    cout << endl;
    
    Rectangle square(7, 7);
    square.display();
    
    return 0;
}
```

---

## Task 6: Encapsulated Payment System

**Context:** Complete payment class with full encapsulation.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Payment {
private:
    int id;
    string residentName;
    double amount;
    string status;  // "Pending", "Paid", "Overdue", "Cancelled"
    int daysOverdue;
    
public:
    Payment(int paymentId, string name, double amt) 
        : id(paymentId), residentName(name), amount(amt), 
          status("Pending"), daysOverdue(0) {}
    
    // Getters
    int getId() const { return id; }
    string getName() const { return residentName; }
    double getAmount() const { return amount; }
    string getStatus() const { return status; }
    
    // Query methods
    bool isPending() const { return status == "Pending"; }
    bool isPaid() const { return status == "Paid"; }
    bool isOverdue() const { return status == "Overdue"; }
    
    // Computed properties
    double getPenalty() const {
        if (isOverdue()) {
            return amount * 0.05 * daysOverdue;  // 5% per day
        }
        return 0.0;
    }
    
    double getTotalDue() const {
        return amount + getPenalty();
    }
    
    // State transitions
    void markPaid() {
        if (isPending() || isOverdue()) {
            status = "Paid";
            cout << "Payment #" << id << " marked as paid." << endl;
        }
    }
    
    void markOverdue(int days) {
        if (isPending()) {
            status = "Overdue";
            daysOverdue = days;
            cout << "Payment #" << id << " is " << days << " days overdue!" << endl;
        }
    }
    
    void cancel() {
        if (isPending()) {
            status = "Cancelled";
            cout << "Payment #" << id << " cancelled." << endl;
        }
    }
    
    void display() const {
        cout << "Payment #" << id << " - " << residentName << endl;
        cout << "Amount: P" << amount << endl;
        cout << "Status: " << status << endl;
        if (isOverdue()) {
            cout << "Days overdue: " << daysOverdue << endl;
            cout << "Penalty: P" << getPenalty() << endl;
            cout << "Total due: P" << getTotalDue() << endl;
        }
    }
};

int main() {
    Payment p1(101, "Juan Dela Cruz", 500.0);
    
    p1.display();
    cout << endl;
    
    p1.markOverdue(3);
    p1.display();
    cout << endl;
    
    p1.markPaid();
    p1.display();
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Encapsulation Principles</strong></summary>

**Core Concept:**
- Hide data (private)
- Expose interface (public methods)
- Validate inputs
- Control access

**Benefits:**
1. **Data protection:** Can't set invalid values
2. **Flexibility:** Change implementation without breaking code
3. **Validation:** All writes go through setters
4. **Security:** Controlled access
5. **Maintainability:** Clear interface

**Common Pattern:**
```cpp
class Example {
private:
    int value;  // Hidden
    
public:
    // Getter
    int getValue() const { 
        return value; 
    }
    
    // Setter with validation
    void setValue(int v) {
        if (v >= 0) {
            value = v;
        }
    }
};
```

**Const Correctness:**
- Mark methods `const` if they don't modify object
- Allows const objects to call them
- Documents intent
- Enables compiler optimizations

</details>

---

**Encapsulation is the foundation of secure, maintainable OOP!** Always hide data, expose interface!
