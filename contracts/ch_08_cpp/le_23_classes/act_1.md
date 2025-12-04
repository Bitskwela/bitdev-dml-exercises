# Lesson 23 Activities: Classes (Introduction to OOP)

## From Structs to Objects

"Structs group data. **Classes group data AND behavior together.**" Your `displayContact()` function lives separately from your Contact struct. With classes, data and the functions that operate on it become **one unit**.

Think about a smartphone: it has data (battery level, storage, phone number) and behaviors (make calls, send messages, take photos). You don't access the battery directly. The phone exposes methods while hiding complex internals.

**This is Object-Oriented Programming!** Welcome to the paradigm that powers most of the software industry!

---

## Task 1: First Class

**Context:** Convert a struct to a class with methods.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Resident {
public:
    // Data (attributes)
    string name;
    int age;
    
    // Behavior (methods)
    void introduce() {
        cout << "Hi, I'm " << name << ", " << age << " years old." << endl;
    }
    
    void haveBirthday() {
        age++;
        cout << name << " is now " << age << " years old!" << endl;
    }
};

int main() {
    Resident resident1;
    resident1.name = "Juan Dela Cruz";
    resident1.age = 30;
    resident1.introduce();
    resident1.haveBirthday();
    
    Resident resident2;
    resident2.name = "Maria Santos";
    resident2.age = 25;
    resident2.introduce();
    
    return 0;
}
```

**Task:** Create a `Student` class with name, grade, and a method `study()` that increases grade by 5.

---

## Task 2: Public vs Private

**Context:** Hide internal data, provide controlled access.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    double balance;  // Hidden from outside!
    
public:
    string accountNumber;  // Accessible
    
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "Deposited P" << amount << endl;
        }
    }
    
    void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Withdrew P" << amount << endl;
        } else {
            cout << "Insufficient balance!" << endl;
        }
    }
    
    double getBalance() {
        return balance;
    }
    
    void setBalance(double bal) {
        if (bal >= 0) {
            balance = bal;
        }
    }
};

int main() {
    BankAccount account;
    account.accountNumber = "1001";
    account.setBalance(5000);
    
    // account.balance = 10000;  // ❌ Error! balance is private
    
    account.deposit(2000);
    account.withdraw(1500);
    
    cout << "Current balance: P" << account.getBalance() << endl;
    
    return 0;
}
```

**Note:** Can't directly access `balance`, must use methods!

---

## Task 3: Calculator Class

**Context:** Bundle related operations into a class.

**Challenge:** Create a Calculator class with methods for basic operations.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

class Calculator {
public:
    double add(double a, double b) {
        return a + b;
    }
    
    double subtract(double a, double b) {
        return a - b;
    }
    
    double multiply(double a, double b) {
        return a * b;
    }
    
    double divide(double a, double b) {
        if (b != 0) {
            return a / b;
        }
        cout << "Error: Division by zero!" << endl;
        return 0;
    }
};

int main() {
    Calculator calc;
    
    cout << "10 + 5 = " << calc.add(10, 5) << endl;
    cout << "10 - 5 = " << calc.subtract(10, 5) << endl;
    cout << "10 * 5 = " << calc.multiply(10, 5) << endl;
    cout << "10 / 5 = " << calc.divide(10, 5) << endl;
    cout << "10 / 0 = " << calc.divide(10, 0) << endl;
    
    return 0;
}
```

---

## Task 4: Resident Class with Validation

**Context:** Add business logic and validation to class methods.

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
    
public:
    // Setters with validation
    void setId(int newId) {
        if (newId > 0) {
            id = newId;
        }
    }
    
    void setName(string newName) {
        if (!newName.empty()) {
            name = newName;
        }
    }
    
    void setAge(int newAge) {
        if (newAge >= 0 && newAge <= 150) {
            age = newAge;
        }
    }
    
    // Getters
    int getId() { return id; }
    string getName() { return name; }
    int getAge() { return age; }
    double getBalance() { return balance; }
    
    // Business methods
    void addDues(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "Added dues: P" << amount << endl;
        }
    }
    
    void makePayment(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Payment successful: P" << amount << endl;
        } else {
            cout << "Invalid payment amount!" << endl;
        }
    }
    
    void display() {
        cout << "ID: " << id << endl;
        cout << "Name: " << name << endl;
        cout << "Age: " << age << endl;
        cout << "Balance: P" << balance << endl;
    }
    
    bool isSenior() {
        return age >= 60;
    }
};

int main() {
    Resident resident;
    resident.setId(1001);
    resident.setName("Juan Dela Cruz");
    resident.setAge(65);
    
    resident.display();
    
    if (resident.isSenior()) {
        cout << "Senior citizen discount applies!" << endl;
    }
    
    resident.addDues(500);
    resident.makePayment(200);
    
    cout << "\nAfter transactions:" << endl;
    resident.display();
    
    return 0;
}
```

---

## Task 5: Counter Class

**Context:** Encapsulate state and operations.

**Challenge:** Build a counter that can increment, decrement, reset.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

class Counter {
private:
    int count;
    int maxCount;
    
public:
    void initialize(int max = 100) {
        count = 0;
        maxCount = max;
    }
    
    void increment() {
        if (count < maxCount) {
            count++;
        } else {
            cout << "Counter at maximum!" << endl;
        }
    }
    
    void decrement() {
        if (count > 0) {
            count--;
        } else {
            cout << "Counter at minimum!" << endl;
        }
    }
    
    void reset() {
        count = 0;
    }
    
    int getValue() {
        return count;
    }
    
    void display() {
        cout << "Count: " << count << " / " << maxCount << endl;
    }
};

int main() {
    Counter counter;
    counter.initialize(10);
    
    counter.increment();
    counter.increment();
    counter.increment();
    counter.display();
    
    counter.decrement();
    counter.display();
    
    counter.reset();
    counter.display();
    
    return 0;
}
```

---

## Task 6: Product Inventory Class

**Context:** Model real-world business objects.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Product {
private:
    int id;
    string name;
    double price;
    int quantity;
    
public:
    void setInfo(int productId, string productName, double productPrice, int productQty) {
        id = productId;
        name = productName;
        price = productPrice;
        quantity = productQty;
    }
    
    void addStock(int amount) {
        if (amount > 0) {
            quantity += amount;
            cout << "Added " << amount << " units. New stock: " << quantity << endl;
        }
    }
    
    bool sell(int amount) {
        if (amount > 0 && amount <= quantity) {
            quantity -= amount;
            double total = amount * price;
            cout << "Sold " << amount << " units for P" << total << endl;
            cout << "Remaining stock: " << quantity << endl;
            return true;
        }
        cout << "Insufficient stock!" << endl;
        return false;
    }
    
    void display() {
        cout << "\n=== PRODUCT INFO ===" << endl;
        cout << "ID: " << id << endl;
        cout << "Name: " << name << endl;
        cout << "Price: P" << price << endl;
        cout << "Stock: " << quantity << " units" << endl;
    }
    
    bool isLowStock(int threshold = 10) {
        return quantity < threshold;
    }
    
    double getInventoryValue() {
        return price * quantity;
    }
};

int main() {
    Product product;
    product.setInfo(101, "Rice (1kg)", 50.0, 100);
    
    product.display();
    
    product.sell(15);
    product.addStock(50);
    
    if (product.isLowStock(20)) {
        cout << "\n⚠ Warning: Low stock!" << endl;
    }
    
    cout << "\nTotal inventory value: P" << product.getInventoryValue() << endl;
    
    return 0;
}
```

---

## Task 7: Clearance System Class

**Context:** Complete class-based system for barangay clearances.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

class Clearance {
private:
    int id;
    string residentName;
    string type;
    double fee;
    string status;
    
public:
    void create(int clearanceId, string name, string clearanceType, double clearanceFee) {
        id = clearanceId;
        residentName = name;
        type = clearanceType;
        fee = clearanceFee;
        status = "Pending";
    }
    
    void approve() {
        if (status == "Pending") {
            status = "Approved";
            cout << "Clearance approved!" << endl;
        } else {
            cout << "Clearance already processed!" << endl;
        }
    }
    
    void reject() {
        if (status == "Pending") {
            status = "Rejected";
            cout << "Clearance rejected!" << endl;
        } else {
            cout << "Clearance already processed!" << endl;
        }
    }
    
    void markPaid() {
        if (status == "Approved") {
            status = "Paid";
            cout << "Payment recorded!" << endl;
        } else {
            cout << "Cannot mark as paid. Must be approved first!" << endl;
        }
    }
    
    void display() {
        cout << "\n=== CLEARANCE #" << id << " ===" << endl;
        cout << "Resident: " << residentName << endl;
        cout << "Type: " << type << endl;
        cout << "Fee: P" << fee << endl;
        cout << "Status: " << status << endl;
    }
    
    bool isPending() {
        return status == "Pending";
    }
    
    bool isComplete() {
        return status == "Paid";
    }
};

int main() {
    Clearance clearance1;
    clearance1.create(1001, "Juan Dela Cruz", "Residence", 50.0);
    
    clearance1.display();
    
    clearance1.approve();
    clearance1.markPaid();
    
    clearance1.display();
    
    return 0;
}
```

---

<details>
<summary><strong>📝 Class Essentials</strong></summary>

**Class vs Struct:**
```cpp
// Struct: members public by default
struct Person {
    string name;  // Public
};

// Class: members private by default
class Person {
    string name;  // Private
public:
    void setName(string n) { name = n; }
};
```

**Access Specifiers:**
- `private`: Only accessible inside the class
- `public`: Accessible from anywhere
- `protected`: Accessible in class + derived classes (later lesson)

**Benefits of Classes:**
1. **Encapsulation:** Hide implementation details
2. **Data protection:** Validate inputs through methods
3. **Organization:** Related data and functions together
4. **Reusability:** Create multiple objects from one class
5. **Maintainability:** Change implementation without breaking code

**Common Pattern:**
```cpp
class Example {
private:
    // Data members
    int value;
    
public:
    // Getters (read)
    int getValue() { return value; }
    
    // Setters (write with validation)
    void setValue(int v) {
        if (v >= 0) value = v;
    }
    
    // Business logic
    void doSomething() {
        // Operations
    }
};
```

</details>

---

**Classes are the foundation of OOP!** Master them before moving to constructors, inheritance, and polymorphism!
