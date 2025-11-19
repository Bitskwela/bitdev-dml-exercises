# Lesson 29: Exception Handling - Dealing with Errors Gracefully

**Estimated Reading Time:** 11 minutes

---

## The Story

"Kuya, my program crashes when users enter invalid data. How do I handle errors gracefully?"

"Use **exception handling**!" Kuya Miguel said. "**try-catch-throw** — detect errors, throw exceptions, catch and handle them!"

---

## What is Exception Handling?

**Exceptions** = runtime errors that disrupt normal program flow.

```cpp
#include <iostream>
using namespace std;

int divide(int a, int b) {
    if (b == 0) {
        throw "Division by zero!";  // Throw exception
    }
    return a / b;
}

int main() {
    try {
        cout << divide(10, 2) << endl;  // OK: 5
        cout << divide(10, 0) << endl;  // Throws exception
    }
    catch (const char* msg) {
        cout << "Error: " << msg << endl;
    }
    
    cout << "Program continues...\n";
    return 0;
}
```

---

## Try-Catch-Throw

```cpp
try {
    // Code that might throw exception
    if (error_condition) {
        throw exception_object;
    }
}
catch (ExceptionType e) {
    // Handle the exception
}
```

---

## Multiple Catch Blocks

```cpp
#include <iostream>
using namespace std;

void processAge(int age) {
    if (age < 0) {
        throw -1;  // Throw int
    }
    if (age > 150) {
        throw "Age too high!";  // Throw string
    }
    if (age < 18) {
        throw 'M';  // Throw char (Minor)
    }
    
    cout << "Age " << age << " is valid\n";
}

int main() {
    int ages[] = {25, -5, 200, 15};
    
    for (int age : ages) {
        try {
            processAge(age);
        }
        catch (int e) {
            cout << "Error: Negative age (" << e << ")\n";
        }
        catch (const char* msg) {
            cout << "Error: " << msg << endl;
        }
        catch (char c) {
            cout << "Error: Minor (code: " << c << ")\n";
        }
    }
    
    return 0;
}
```

---

## Standard Exception Classes

```cpp
#include <iostream>
#include <stdexcept>
using namespace std;

class BankAccount {
private:
    double balance;
    
public:
    BankAccount(double bal) : balance(bal) {}
    
    void withdraw(double amount) {
        if (amount < 0) {
            throw invalid_argument("Amount cannot be negative");
        }
        if (amount > balance) {
            throw runtime_error("Insufficient balance");
        }
        
        balance -= amount;
        cout << "Withdrew P" << amount << ", Balance: P" << balance << endl;
    }
    
    double getBalance() {
        return balance;
    }
};

int main() {
    BankAccount acc(1000);
    
    try {
        acc.withdraw(500);   // OK
        acc.withdraw(-100);  // Throws invalid_argument
    }
    catch (invalid_argument& e) {
        cout << "Invalid: " << e.what() << endl;
    }
    catch (runtime_error& e) {
        cout << "Runtime error: " << e.what() << endl;
    }
    
    try {
        acc.withdraw(1000);  // Throws runtime_error
    }
    catch (exception& e) {  // Catches all standard exceptions
        cout << "Exception: " << e.what() << endl;
    }
    
    return 0;
}
```

---

## Custom Exception Classes

```cpp
#include <iostream>
#include <string>
#include <exception>
using namespace std;

class InsufficientBalanceException : public exception {
private:
    string message;
    
public:
    InsufficientBalanceException(double required, double available) {
        message = "Insufficient balance. Required: P" + to_string(required) 
                + ", Available: P" + to_string(available);
    }
    
    const char* what() const noexcept override {
        return message.c_str();
    }
};

class BankAccount {
private:
    string accountNumber;
    double balance;
    
public:
    BankAccount(string acc, double bal) : accountNumber(acc), balance(bal) {}
    
    void withdraw(double amount) {
        if (amount > balance) {
            throw InsufficientBalanceException(amount, balance);
        }
        
        balance -= amount;
        cout << "Withdrew P" << amount << endl;
    }
    
    double getBalance() {
        return balance;
    }
};

int main() {
    BankAccount acc("1001", 500);
    
    try {
        acc.withdraw(300);  // OK
        acc.withdraw(500);  // Throws exception
    }
    catch (InsufficientBalanceException& e) {
        cout << "Error: " << e.what() << endl;
    }
    
    return 0;
}
```

---

## Practical Example: Barangay Dues System

```cpp
#include <iostream>
#include <string>
#include <exception>
using namespace std;

class InvalidAmountException : public exception {
private:
    string msg;
public:
    InvalidAmountException(string m) : msg(m) {}
    const char* what() const noexcept override {
        return msg.c_str();
    }
};

class AccountNotFoundException : public exception {
public:
    const char* what() const noexcept override {
        return "Account not found";
    }
};

class DuesAccount {
private:
    int id;
    string name;
    double balance;
    bool active;
    
public:
    DuesAccount(int i, string n) : id(i), name(n), balance(0), active(true) {}
    
    void addDues(double amount) {
        if (!active) {
            throw runtime_error("Account is inactive");
        }
        if (amount <= 0) {
            throw InvalidAmountException("Dues amount must be positive");
        }
        
        balance += amount;
        cout << name << ": Added P" << amount << " dues\n";
    }
    
    void makePayment(double amount) {
        if (!active) {
            throw runtime_error("Account is inactive");
        }
        if (amount <= 0) {
            throw InvalidAmountException("Payment must be positive");
        }
        if (amount > balance) {
            throw InvalidAmountException("Payment exceeds balance (P" + 
                                       to_string(balance) + ")");
        }
        
        balance -= amount;
        cout << name << ": Paid P" << amount << endl;
    }
    
    int getId() { return id; }
    string getName() { return name; }
    double getBalance() { return balance; }
    
    void deactivate() {
        active = false;
        cout << name << ": Account deactivated\n";
    }
};

class DuesManager {
private:
    DuesAccount* accounts[100];
    int count;
    
public:
    DuesManager() : count(0) {}
    
    void addAccount(DuesAccount* acc) {
        if (count >= 100) {
            throw runtime_error("Account limit reached");
        }
        accounts[count++] = acc;
    }
    
    DuesAccount* findAccount(int id) {
        for (int i = 0; i < count; i++) {
            if (accounts[i]->getId() == id) {
                return accounts[i];
            }
        }
        throw AccountNotFoundException();
    }
    
    ~DuesManager() {
        for (int i = 0; i < count; i++) {
            delete accounts[i];
        }
    }
};

int main() {
    DuesManager manager;
    
    try {
        manager.addAccount(new DuesAccount(1001, "Juan Dela Cruz"));
        manager.addAccount(new DuesAccount(1002, "Maria Santos"));
        
        DuesAccount* acc1 = manager.findAccount(1001);
        acc1->addDues(100);
        acc1->makePayment(50);
        
        // Try invalid operations
        acc1->makePayment(-10);  // Will throw
    }
    catch (InvalidAmountException& e) {
        cout << "Amount Error: " << e.what() << endl;
    }
    catch (AccountNotFoundException& e) {
        cout << "Not Found: " << e.what() << endl;
    }
    catch (runtime_error& e) {
        cout << "Runtime Error: " << e.what() << endl;
    }
    catch (...) {  // Catch all
        cout << "Unknown error occurred\n";
    }
    
    cout << "Program continues safely...\n";
    
    return 0;
}
```

---

## RAII and Exception Safety

```cpp
class FileHandler {
private:
    FILE* file;
    
public:
    FileHandler(const char* filename) {
        file = fopen(filename, "r");
        if (!file) {
            throw runtime_error("Cannot open file");
        }
    }
    
    ~FileHandler() {
        if (file) {
            fclose(file);
            cout << "File closed safely\n";
        }
    }
    
    // ... other methods
};

void processFile() {
    FileHandler fh("data.txt");  // RAII
    
    // If exception occurs here, destructor still called!
    throw runtime_error("Processing error");
    
    // File automatically closed
}
```

---

## Summary

"Exception handling makes my code robust!" Tian exclaimed.

"Exactly!" Kuya Miguel said. "Remember:
- **try** = code that might throw
- **throw** = signal an error
- **catch** = handle the error
- **Custom exceptions** = specific error types
- **RAII** = automatic cleanup even with exceptions"

"Next: **STL Basics** — powerful standard library!"

---

**Key Takeaways:**
1. Exceptions handle runtime errors gracefully
2. try-catch-throw for error handling
3. Standard exception classes available
4. Create custom exceptions for specific errors
5. RAII ensures cleanup even with exceptions

**Next Lesson:** STL Basics - Standard Template Library
