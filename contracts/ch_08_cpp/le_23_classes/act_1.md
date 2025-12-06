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

# Tasks for Learners

- Create a Student class with name, grade, and a study() method that increases grade by 5.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class Student {
  public:
      string name;
      int grade;
      
      void introduce() {
          cout << "Student: " << name << ", Grade: " << grade << endl;
      }
      
      void study() {
          grade += 5;
          if (grade > 100) {
              grade = 100;  // Cap at 100
          }
          cout << name << " studied hard! Grade is now " << grade << endl;
      }
  };

  int main() {
      Student student1;
      student1.name = "Pedro Garcia";
      student1.grade = 75;
      
      student1.introduce();
      student1.study();
      student1.study();
      student1.introduce();
      
      Student student2;
      student2.name = "Ana Reyes";
      student2.grade = 85;
      student2.introduce();
      student2.study();
      student2.introduce();
      
      return 0;
  }
  ```

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

# Tasks for Learners

- Use the BankAccount class to demonstrate encapsulation with private data and public methods.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  class BankAccount {
  private:
      double balance;
      
  public:
      string accountNumber;
      string ownerName;
      
      void deposit(double amount) {
          if (amount > 0) {
              balance += amount;
              cout << "Deposited P" << amount << endl;
          } else {
              cout << "Invalid deposit amount!" << endl;
          }
      }
      
      void withdraw(double amount) {
          if (amount > 0 && amount <= balance) {
              balance -= amount;
              cout << "Withdrew P" << amount << endl;
          } else {
              cout << "Insufficient balance or invalid amount!" << endl;
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
      
      void displayInfo() {
          cout << "\n=== Account Info ===" << endl;
          cout << "Account: " << accountNumber << endl;
          cout << "Owner: " << ownerName << endl;
          cout << "Balance: P" << balance << endl;
      }
  };

  int main() {
      BankAccount account1;
      account1.accountNumber = "1001";
      account1.ownerName = "Juan Dela Cruz";
      account1.setBalance(5000);
      
      account1.displayInfo();
      
      account1.deposit(2000);
      account1.withdraw(1500);
      account1.withdraw(10000);  // Should fail
      
      account1.displayInfo();
      
      return 0;
  }
  ```

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

# Tasks for Learners

- Create a Calculator class with methods for basic arithmetic operations.

  ```cpp
  #include <iostream>
  #include <cmath>
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
      
      double power(double base, double exponent) {
          return pow(base, exponent);
      }
      
      double squareRoot(double num) {
          if (num >= 0) {
              return sqrt(num);
          }
          cout << "Error: Cannot take square root of negative number!" << endl;
          return 0;
      }
  };

  int main() {
      Calculator calc;
      
      cout << "=== CALCULATOR DEMO ===" << endl;
      cout << "10 + 5 = " << calc.add(10, 5) << endl;
      cout << "10 - 5 = " << calc.subtract(10, 5) << endl;
      cout << "10 * 5 = " << calc.multiply(10, 5) << endl;
      cout << "10 / 5 = " << calc.divide(10, 5) << endl;
      cout << "10 / 0 = " << calc.divide(10, 0) << endl;
      cout << "2 ^ 3 = " << calc.power(2, 3) << endl;
      cout << "sqrt(16) = " << calc.squareRoot(16) << endl;
      cout << "sqrt(-4) = " << calc.squareRoot(-4) << endl;
      
      // Complex calculation
      double result = calc.add(calc.multiply(5, 3), calc.divide(20, 4));
      cout << "\n(5 * 3) + (20 / 4) = " << result << endl;
      
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

# Tasks for Learners

- Create a Resident class with validation and business logic for barangay management.

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
      void setId(int newId) {
          if (newId > 0) {
              id = newId;
          } else {
              cout << "Invalid ID!" << endl;
          }
      }
      
      void setName(string newName) {
          if (!newName.empty()) {
              name = newName;
          } else {
              cout << "Name cannot be empty!" << endl;
          }
      }
      
      void setAge(int newAge) {
          if (newAge >= 0 && newAge <= 150) {
              age = newAge;
          } else {
              cout << "Invalid age!" << endl;
          }
      }
      
      int getId() { return id; }
      string getName() { return name; }
      int getAge() { return age; }
      double getBalance() { return balance; }
      
      void addDues(double amount) {
          if (amount > 0) {
              balance += amount;
              cout << "Added dues: P" << amount << endl;
          } else {
              cout << "Invalid dues amount!" << endl;
          }
      }
      
      void makePayment(double amount) {
          if (amount <= 0) {
              cout << "Invalid payment amount!" << endl;
          } else if (amount > balance) {
              cout << "Payment exceeds balance! Balance: P" << balance << endl;
          } else {
              balance -= amount;
              cout << "Payment successful: P" << amount << endl;
              cout << "Remaining balance: P" << balance << endl;
          }
      }
      
      void display() {
          cout << "\n=== RESIDENT INFO ===" << endl;
          cout << "ID: " << id << endl;
          cout << "Name: " << name << endl;
          cout << "Age: " << age << endl;
          cout << "Balance: P" << balance << endl;
          if (isSenior()) {
              cout << "Status: Senior Citizen" << endl;
          }
      }
      
      bool isSenior() {
          return age >= 60;
      }
      
      double calculateDiscountedFee(double fee) {
          if (isSenior()) {
              return fee * 0.80;  // 20% discount
          }
          return fee;
      }
  };

  int main() {
      Resident resident1;
      resident1.setId(1001);
      resident1.setName("Juan Dela Cruz");
      resident1.setAge(65);
      
      resident1.display();
      
      resident1.addDues(500);
      resident1.addDues(300);
      resident1.makePayment(200);
      resident1.makePayment(1000);  // Should fail
      
      cout << "\nClearance fee with discount: P" 
           << resident1.calculateDiscountedFee(100) << endl;
      
      resident1.display();
      
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

# Tasks for Learners

- Create a Counter class with increment, decrement, and reset functionality.

  ```cpp
  #include <iostream>
  using namespace std;

  class Counter {
  private:
      int count;
      int maxCount;
      int minCount;
      
  public:
      void initialize(int min = 0, int max = 100) {
          minCount = min;
          maxCount = max;
          count = min;
      }
      
      void increment(int step = 1) {
          if (count + step <= maxCount) {
              count += step;
          } else {
              cout << "Cannot increment: would exceed maximum (" << maxCount << ")" << endl;
          }
      }
      
      void decrement(int step = 1) {
          if (count - step >= minCount) {
              count -= step;
          } else {
              cout << "Cannot decrement: would go below minimum (" << minCount << ")" << endl;
          }
      }
      
      void reset() {
          count = minCount;
          cout << "Counter reset to " << count << endl;
      }
      
      int getValue() {
          return count;
      }
      
      void display() {
          cout << "Counter: " << count << " (Range: " << minCount << " - " << maxCount << ")" << endl;
      }
      
      bool isAtMax() {
          return count == maxCount;
      }
      
      bool isAtMin() {
          return count == minCount;
      }
  };

  int main() {
      Counter counter;
      counter.initialize(0, 10);
      
      cout << "=== COUNTER DEMO ===" << endl;
      counter.display();
      
      counter.increment();
      counter.increment();
      counter.increment(5);
      counter.display();
      
      counter.increment(5);  // Should fail
      
      counter.decrement(3);
      counter.display();
      
      for (int i = 0; i < 10; i++) {
          counter.increment();
      }
      
      if (counter.isAtMax()) {
          cout << "\nCounter is at maximum!" << endl;
      }
      
      counter.reset();
      counter.display();
      
      counter.decrement();  // Should fail
      
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

# Tasks for Learners

- Create a Product Inventory class for managing store products.

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
      int soldCount;
      
  public:
      void setInfo(int productId, string productName, double productPrice, int productQty) {
          id = productId;
          name = productName;
          price = productPrice;
          quantity = productQty;
          soldCount = 0;
      }
      
      void addStock(int amount) {
          if (amount > 0) {
              quantity += amount;
              cout << "✓ Added " << amount << " units. New stock: " << quantity << endl;
          } else {
              cout << "Invalid stock amount!" << endl;
          }
      }
      
      bool sell(int amount) {
          if (amount <= 0) {
              cout << "Invalid quantity!" << endl;
              return false;
          }
          if (amount > quantity) {
              cout << "Insufficient stock! Available: " << quantity << endl;
              return false;
          }
          
          quantity -= amount;
          soldCount += amount;
          double total = amount * price;
          cout << "✓ Sold " << amount << " units for P" << total << endl;
          cout << "Remaining stock: " << quantity << endl;
          return true;
      }
      
      void updatePrice(double newPrice) {
          if (newPrice > 0) {
              cout << "Price updated: P" << price << " → P" << newPrice << endl;
              price = newPrice;
          } else {
              cout << "Invalid price!" << endl;
          }
      }
      
      void display() {
          cout << "\n=== PRODUCT INFO ===" << endl;
          cout << "ID: " << id << endl;
          cout << "Name: " << name << endl;
          cout << "Price: P" << price << endl;
          cout << "Stock: " << quantity << " units" << endl;
          cout << "Total Sold: " << soldCount << " units" << endl;
          cout << "Inventory Value: P" << getInventoryValue() << endl;
          cout << "Total Revenue: P" << getTotalRevenue() << endl;
      }
      
      bool isLowStock(int threshold = 10) {
          return quantity < threshold;
      }
      
      double getInventoryValue() {
          return price * quantity;
      }
      
      double getTotalRevenue() {
          return price * soldCount;
      }
  };

  int main() {
      Product product1;
      product1.setInfo(101, "Rice (1kg)", 50.0, 100);
      
      product1.display();
      
      cout << "\n--- Transactions ---" << endl;
      product1.sell(15);
      product1.sell(30);
      product1.sell(200);  // Should fail
      
      product1.addStock(50);
      
      if (product1.isLowStock(150)) {
          cout << "\n⚠ Warning: Stock below threshold!" << endl;
      }
      
      product1.updatePrice(55.0);
      product1.sell(20);
      
      product1.display();
      
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

# Tasks for Learners

- Create a complete Clearance System class with workflow management.

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
      string remarks;
      
  public:
      void create(int clearanceId, string name, string clearanceType, double clearanceFee) {
          id = clearanceId;
          residentName = name;
          type = clearanceType;
          fee = clearanceFee;
          status = "Pending";
          remarks = "";
          cout << "✓ Clearance created successfully!" << endl;
      }
      
      void approve(string approvalRemarks = "") {
          if (status == "Pending") {
              status = "Approved";
              remarks = approvalRemarks;
              cout << "✓ Clearance #" << id << " approved!" << endl;
          } else {
              cout << "❌ Clearance already processed (Status: " << status << ")" << endl;
          }
      }
      
      void reject(string rejectionReason) {
          if (status == "Pending") {
              status = "Rejected";
              remarks = rejectionReason;
              cout << "❌ Clearance #" << id << " rejected!" << endl;
          } else {
              cout << "❌ Clearance already processed (Status: " << status << ")" << endl;
          }
      }
      
      void markPaid() {
          if (status == "Approved") {
              status = "Paid";
              cout << "✓ Payment recorded for Clearance #" << id << "!" << endl;
          } else if (status == "Paid") {
              cout << "❌ Already paid!" << endl;
          } else {
              cout << "❌ Cannot mark as paid. Must be approved first! (Current: " << status << ")" << endl;
          }
      }
      
      void release() {
          if (status == "Paid") {
              status = "Released";
              cout << "✓ Clearance #" << id << " released to " << residentName << "!" << endl;
          } else {
              cout << "❌ Cannot release. Payment required! (Current: " << status << ")" << endl;
          }
      }
      
      void display() {
          cout << "\n=== CLEARANCE #" << id << " ===" << endl;
          cout << "Resident: " << residentName << endl;
          cout << "Type: " << type << endl;
          cout << "Fee: P" << fee << endl;
          cout << "Status: " << status << endl;
          if (!remarks.empty()) {
              cout << "Remarks: " << remarks << endl;
          }
      }
      
      bool isPending() {
          return status == "Pending";
      }
      
      bool isComplete() {
          return status == "Released";
      }
      
      string getStatus() {
          return status;
      }
  };

  int main() {
      cout << "=== BARANGAY CLEARANCE SYSTEM ===" << endl << endl;
      
      Clearance clearance1;
      clearance1.create(1001, "Juan Dela Cruz", "Residence", 50.0);
      clearance1.display();
      
      cout << "\n--- Processing Clearance #1001 ---" << endl;
      clearance1.approve("All documents verified");
      clearance1.markPaid();
      clearance1.release();
      clearance1.display();
      
      cout << "\n\n--- Another Clearance ---" << endl;
      Clearance clearance2;
      clearance2.create(1002, "Maria Santos", "Business", 100.0);
      clearance2.display();
      
      cout << "\n--- Attempting to pay without approval ---" << endl;
      clearance2.markPaid();  // Should fail
      
      cout << "\n--- Rejecting clearance ---" << endl;
      clearance2.reject("Incomplete requirements");
      clearance2.display();
      
      cout << "\n\n--- Third Clearance ---" << endl;
      Clearance clearance3;
      clearance3.create(1003, "Pedro Garcia", "Travel", 150.0);
      clearance3.approve();
      clearance3.display();
      
      cout << "\n--- Attempting to release without payment ---" << endl;
      clearance3.release();  // Should fail
      
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
