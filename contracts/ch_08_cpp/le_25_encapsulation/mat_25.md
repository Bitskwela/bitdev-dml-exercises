# Lesson 25: Encapsulation - Data Hiding Done Right

**Estimated Reading Time:** 10 minutes

---

## The Story

"Kuya, I made `balance` private with getters/setters. Is that encapsulation?"

"Exactly!" Kuya Miguel nodded. "**Encapsulation** hides internal details and exposes only what's needed. It's the foundation of secure, maintainable code!"

---

## What is Encapsulation?

**Encapsulation** = Bundling data + methods + hiding implementation details

```cpp
class BankAccount {
private:
    // Hidden implementation
    double balance;
    string accountNumber;
    
public:
    // Public interface
    BankAccount(string accNum, double initialBalance) 
        : accountNumber(accNum), balance(initialBalance) {}
    
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    bool withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            return true;
        }
        return false;
    }
    
    double getBalance() const {
        return balance;
    }
};
```

**Benefits:**
- ✓ Data protection
- ✓ Validation logic
- ✓ Can change implementation without breaking code
- ✓ Clear interface

---

## Access Levels

```cpp
class Example {
private:
    int privateVar;      // Only accessible inside this class
    
protected:
    int protectedVar;    // Accessible in this class + derived classes
    
public:
    int publicVar;       // Accessible everywhere
};
```

---

## Getters and Setters (Accessors and Mutators)

```cpp
class Resident {
private:
    string name;
    int age;
    double balance;
    
public:
    // Getters (read-only access)
    string getName() const {
        return name;
    }
    
    int getAge() const {
        return age;
    }
    
    double getBalance() const {
        return balance;
    }
    
    // Setters (controlled write access)
    void setName(const string& n) {
        if (!n.empty()) {
            name = n;
        }
    }
    
    void setAge(int a) {
        if (a >= 0 && a <= 150) {  // Validation!
            age = a;
        }
    }
    
    void addBalance(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
};
```

---

## Const Member Functions

Mark functions that don't modify object:

```cpp
class Clearance {
private:
    int id;
    string status;
    double fee;
    
public:
    // Const functions - promise not to modify object
    int getId() const {
        return id;
    }
    
    string getStatus() const {
        return status;
    }
    
    double getFee() const {
        return fee;
    }
    
    // Non-const - modifies object
    void approve() {
        status = "approved";
    }
};
```

---

## Information Hiding

Don't expose internal data structures:

```cpp
// ❌ BAD: Exposes internal array
class ResidentList {
public:
    Resident residents[100];
    int count;
};

// ✓ GOOD: Hides implementation
class ResidentList {
private:
    Resident residents[100];
    int count;
    
public:
    void addResident(const Resident& r) {
        if (count < 100) {
            residents[count++] = r;
        }
    }
    
    Resident* getResident(int index) {
        if (index >= 0 && index < count) {
            return &residents[index];
        }
        return nullptr;
    }
    
    int getCount() const {
        return count;
    }
};
```

---

## Practical Example: Barangay Dues System

```cpp
#include <iostream>
#include <string>
using namespace std;

class DuesAccount {
private:
    // Hidden data
    int residentId;
    string residentName;
    double balance;
    double totalPaid;
    bool active;
    
    // Private helper method
    void log(const string& message) {
        cout << "[LOG] " << residentName << ": " << message << endl;
    }
    
public:
    // Constructor
    DuesAccount(int id, const string& name) 
        : residentId(id), residentName(name), balance(0), totalPaid(0), active(true) {
        log("Account created");
    }
    
    // Public interface
    void addMonthlyDues(double amount) {
        if (!active) {
            cout << "Account inactive!\n";
            return;
        }
        
        if (amount > 0) {
            balance += amount;
            log("Dues added: P" + to_string(amount));
        }
    }
    
    bool makePayment(double amount) {
        if (!active) {
            cout << "Account inactive!\n";
            return false;
        }
        
        if (amount <= 0) {
            cout << "Invalid amount!\n";
            return false;
        }
        
        if (amount > balance) {
            cout << "Payment exceeds balance!\n";
            return false;
        }
        
        balance -= amount;
        totalPaid += amount;
        log("Payment made: P" + to_string(amount));
        return true;
    }
    
    void deactivate() {
        active = false;
        log("Account deactivated");
    }
    
    void reactivate() {
        active = true;
        log("Account reactivated");
    }
    
    // Getters (const)
    int getId() const {
        return residentId;
    }
    
    string getName() const {
        return residentName;
    }
    
    double getBalance() const {
        return balance;
    }
    
    double getTotalPaid() const {
        return totalPaid;
    }
    
    bool isActive() const {
        return active;
    }
    
    void displaySummary() const {
        cout << "\n===== ACCOUNT SUMMARY =====\n";
        cout << "ID: " << residentId << endl;
        cout << "Name: " << residentName << endl;
        cout << "Balance: P" << balance << endl;
        cout << "Total Paid: P" << totalPaid << endl;
        cout << "Status: " << (active ? "Active" : "Inactive") << endl;
        cout << "===========================\n";
    }
};

int main() {
    DuesAccount account(1001, "Juan Dela Cruz");
    
    account.addMonthlyDues(50.0);
    account.addMonthlyDues(50.0);
    account.addMonthlyDues(50.0);
    
    account.displaySummary();
    
    account.makePayment(100.0);
    account.displaySummary();
    
    account.deactivate();
    account.makePayment(50.0);  // Should fail
    
    return 0;
}
```

---

## Data Validation Examples

```cpp
class ClearanceRequest {
private:
    int id;
    string residentName;
    string clearanceType;
    double fee;
    string status;
    
public:
    // Validated setters
    void setResidentName(const string& name) {
        if (name.length() >= 2) {
            residentName = name;
        } else {
            cout << "Name too short!\n";
        }
    }
    
    void setClearanceType(const string& type) {
        if (type == "Residence" || type == "Business" || type == "Travel") {
            clearanceType = type;
        } else {
            cout << "Invalid clearance type!\n";
        }
    }
    
    void setFee(double f) {
        if (f >= 0 && f <= 1000) {
            fee = f;
        } else {
            cout << "Invalid fee amount!\n";
        }
    }
};
```

---

## Friend Functions (Breaking Encapsulation)

Sometimes you need to break encapsulation (use sparingly):

```cpp
class BankAccount {
private:
    double balance;
    
public:
    BankAccount(double bal) : balance(bal) {}
    
    // Friend function can access private members
    friend void auditAccount(const BankAccount& acc);
};

void auditAccount(const BankAccount& acc) {
    cout << "Audit: Balance = " << acc.balance << endl;
}
```

---

## Summary

"Encapsulation protects my data!" Tian exclaimed.

"Yes!" Kuya Miguel said. "Remember:
- **Hide implementation details**
- **Expose only necessary interface**
- **Validate in setters**
- **Use const for getters**
- **Private by default, public only when needed**"

"Next: **Inheritance** — code reuse through class hierarchies!"

---

**Key Takeaways:**
1. Encapsulation = data hiding + controlled access
2. Private data, public methods
3. Validate in setters
4. Const methods for read-only
5. Information hiding improves maintainability

**Next Lesson:** Inheritance - Building Class Hierarchies
