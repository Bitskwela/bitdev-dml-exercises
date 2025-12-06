# Lesson 19 Activities: Structs

## No More Parallel Arrays!

Tian's resident tracking system was a **nightmare**:
```cpp
string names[100];
int ages[100];
string addresses[100];
```

**If indices got misaligned, chaos!** Resident 0's name with resident 12's age? Disaster.

**Structs bundle related data together.** One `Resident` struct holds name, age, and address. No more parallel array hell!

---

## Task 1: Basic Struct Declaration

**Context:** Group related data into a custom type.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

int main() {
    // Create a Resident
    Resident r1;
    r1.name = "Juan Dela Cruz";
    r1.age = 35;
    r1.address = "123 Main St, Iloilo";
    
    // Access members with dot operator
    cout << "Name: " << r1.name << endl;
    cout << "Age: " << r1.age << endl;
    cout << "Address: " << r1.address << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create a `Student` struct with name, grade, and section. Declare a student, initialize the members, and display the information.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Student {
      string name;
      int grade;
      string section;
  };

  int main() {
      Student s1;
      s1.name = "Maria Clara";
      s1.grade = 95;
      s1.section = "A";
      
      cout << "Name: " << s1.name << endl;
      cout << "Grade: " << s1.grade << endl;
      cout << "Section: " << s1.section << endl;
      
      return 0;
  }
  ```

---

## Task 2: Struct Initialization

**Context:** Different ways to create and initialize structs.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Product {
    string name;
    double price;
    int quantity;
};

int main() {
    // Method 1: Declare then assign
    Product p1;
    p1.name = "Rice";
    p1.price = 50.0;
    p1.quantity = 10;
    
    // Method 2: Aggregate initialization
    Product p2 = {"Sardines", 25.0, 20};
    
    // Method 3: Uniform initialization (C++11)
    Product p3{"Cooking Oil", 150.0, 5};
    
    cout << "Product 1: " << p1.name << " - P" << p1.price << endl;
    cout << "Product 2: " << p2.name << " - P" << p2.price << endl;
    cout << "Product 3: " << p3.name << " - P" << p3.price << endl;
    
    return 0;
}
```

# Tasks for Learners

- Practice all three initialization methods by creating a `Book` struct with title, author, and price. Initialize three books using different methods and display them.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Book {
      string title;
      string author;
      double price;
  };

  int main() {
      // Method 1: Declare then assign
      Book b1;
      b1.title = "Noli Me Tangere";
      b1.author = "Jose Rizal";
      b1.price = 250.0;
      
      // Method 2: Aggregate initialization
      Book b2 = {"El Filibusterismo", "Jose Rizal", 300.0};
      
      // Method 3: Uniform initialization
      Book b3{"Florante at Laura", "Francisco Balagtas", 200.0};
      
      cout << "Book 1: " << b1.title << " by " << b1.author << " - P" << b1.price << endl;
      cout << "Book 2: " << b2.title << " by " << b2.author << " - P" << b2.price << endl;
      cout << "Book 3: " << b3.title << " by " << b3.author << " - P" << b3.price << endl;
      
      return 0;
  }
  ```

---

## Task 3: Array of Structs

**Context:** Replace parallel arrays with struct array.

**Challenge:** Manage multiple residents cleanly.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string barangay;
};

int main() {
    Resident residents[5] = {
        {"Juan Dela Cruz", 35, "Poblacion"},
        {"Maria Santos", 28, "San Jose"},
        {"Pedro Garcia", 42, "Santa Maria"},
        {"Ana Reyes", 31, "Del Pilar"},
        {"Jose Mendoza", 39, "San Antonio"}
    };
    
    cout << "=== RESIDENT LIST ===" << endl;
    for (int i = 0; i < 5; i++) {
        cout << (i+1) << ". " << residents[i].name 
             << " (" << residents[i].age << " years old) - " 
             << residents[i].barangay << endl;
    }
    
    return 0;
}
```

# Tasks for Learners

- Create an array of 4 `Employee` structs with name, position, and salary. Display all employees in a formatted list.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Employee {
      string name;
      string position;
      double salary;
  };

  int main() {
      Employee employees[4] = {
          {"Juan Dela Cruz", "Manager", 50000.0},
          {"Maria Santos", "Developer", 40000.0},
          {"Pedro Garcia", "Designer", 35000.0},
          {"Ana Reyes", "Analyst", 38000.0}
      };
      
      cout << "=== EMPLOYEE LIST ===" << endl;
      for (int i = 0; i < 4; i++) {
          cout << (i+1) << ". " << employees[i].name 
               << " - " << employees[i].position
               << " (P" << employees[i].salary << ")" << endl;
      }
      
      return 0;
  }
  ```

**Compare:** 1 array of structs vs 3 parallel arrays. Which is cleaner?

---

## Task 4: Structs with Functions

**Context:** Pass structs to functions.

**Challenge:** Create functions to process resident data.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

void displayResident(Resident r) {
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Address: " << r.address << endl;
}

bool isSenior(Resident r) {
    return r.age >= 60;
}

int main() {
    Resident r1 = {"Juan Dela Cruz", 65, "123 Main St"};
    Resident r2 = {"Maria Santos", 28, "456 Oak Ave"};
    
    displayResident(r1);
    cout << "Senior citizen: " << (isSenior(r1) ? "Yes" : "No") << endl;
    cout << endl;
    
    displayResident(r2);
    cout << "Senior citizen: " << (isSenior(r2) ? "Yes" : "No") << endl;
    
    return 0;
}
```

# Tasks for Learners

- Create a `Student` struct with name, grade, and course. Write functions to display student info and check if they passed (grade >= 75). Test with two students.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Student {
      string name;
      int grade;
      string course;
  };

  void displayStudent(Student s) {
      cout << "Name: " << s.name << endl;
      cout << "Grade: " << s.grade << endl;
      cout << "Course: " << s.course << endl;
  }

  bool hasPassed(Student s) {
      return s.grade >= 75;
  }

  int main() {
      Student s1 = {"Maria Clara", 85, "Computer Science"};
      Student s2 = {"Jose Rizal", 72, "Mathematics"};
      
      displayStudent(s1);
      cout << "Passed: " << (hasPassed(s1) ? "Yes" : "No") << endl;
      cout << endl;
      
      displayStudent(s2);
      cout << "Passed: " << (hasPassed(s2) ? "Yes" : "No") << endl;
      
      return 0;
  }
  ```

---

## Task 5: Modifying Structs in Functions

**Context:** Pass by reference to modify original struct.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct BankAccount {
    string owner;
    double balance;
};

void deposit(BankAccount& account, double amount) {
    account.balance += amount;
    cout << "Deposited P" << amount << endl;
}

void withdraw(BankAccount& account, double amount) {
    if (account.balance >= amount) {
        account.balance -= amount;
        cout << "Withdrew P" << amount << endl;
    } else {
        cout << "Insufficient balance!" << endl;
    }
}

void displayAccount(const BankAccount& account) {
    cout << "Owner: " << account.owner << endl;
    cout << "Balance: P" << account.balance << endl;
}

int main() {
    BankAccount acc = {"Juan Dela Cruz", 5000.0};
    
    displayAccount(acc);
    cout << endl;
    
    deposit(acc, 2000.0);
    withdraw(acc, 1500.0);
    cout << endl;
    
    displayAccount(acc);
    
    return 0;
}
```

# Tasks for Learners

- Create a `Product` struct with name, stock, and price. Write functions to add stock and sell product (decrease stock). Test by adding 50 units and selling 20 units.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Product {
      string name;
      int stock;
      double price;
  };

  void addStock(Product& product, int quantity) {
      product.stock += quantity;
      cout << "Added " << quantity << " units to stock" << endl;
  }

  void sellProduct(Product& product, int quantity) {
      if (product.stock >= quantity) {
          product.stock -= quantity;
          cout << "Sold " << quantity << " units" << endl;
      } else {
          cout << "Insufficient stock!" << endl;
      }
  }

  void displayProduct(const Product& product) {
      cout << "Product: " << product.name << endl;
      cout << "Stock: " << product.stock << endl;
      cout << "Price: P" << product.price << endl;
  }

  int main() {
      Product p = {"Rice", 100, 50.0};
      
      displayProduct(p);
      cout << endl;
      
      addStock(p, 50);
      sellProduct(p, 20);
      cout << endl;
      
      displayProduct(p);
      
      return 0;
  }
  ```

**Expected:** Balance: 5000 → 7000 → 5500

---

## Task 6: Comparing Structs

**Context:** Find specific records in struct array.

**Challenge:** Search for resident by name.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
};

int findResident(Resident residents[], int size, string searchName) {
    for (int i = 0; i < size; i++) {
        if (residents[i].name == searchName) {
            return i;  // Found!
        }
    }
    return -1;  // Not found
}

int main() {
    Resident residents[5] = {
        {"Juan Dela Cruz", 35, "123 Main St"},
        {"Maria Santos", 28, "456 Oak Ave"},
        {"Pedro Garcia", 42, "789 Pine Rd"},
        {"Ana Reyes", 31, "321 Elm St"},
        {"Jose Mendoza", 39, "654 Maple Dr"}
    };
    
    string searchName;
    cout << "Enter name to search: ";
    getline(cin, searchName);
    
    int index = findResident(residents, 5, searchName);
    
    if (index != -1) {
        cout << "Found!" << endl;
        cout << "Name: " << residents[index].name << endl;
        cout << "Age: " << residents[index].age << endl;
        cout << "Address: " << residents[index].address << endl;
    } else {
        cout << "Resident not found." << endl;
    }
    
    return 0;
}
```

# Tasks for Learners

- Create an array of 4 `Student` structs with name, id, and grade. Write a search function to find a student by ID and display their information.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Student {
      string name;
      int id;
      int grade;
  };

  int findStudent(Student students[], int size, int searchId) {
      for (int i = 0; i < size; i++) {
          if (students[i].id == searchId) {
              return i;
          }
      }
      return -1;
  }

  int main() {
      Student students[4] = {
          {"Juan Dela Cruz", 101, 85},
          {"Maria Santos", 102, 92},
          {"Pedro Garcia", 103, 78},
          {"Ana Reyes", 104, 88}
      };
      
      int searchId;
      cout << "Enter student ID to search: ";
      cin >> searchId;
      
      int index = findStudent(students, 4, searchId);
      
      if (index != -1) {
          cout << "Found!" << endl;
          cout << "Name: " << students[index].name << endl;
          cout << "ID: " << students[index].id << endl;
          cout << "Grade: " << students[index].grade << endl;
      } else {
          cout << "Student not found." << endl;
      }
      
      return 0;
  }
  ```

---

## Task 7: Barangay Management System

**Context:** Build complete system using structs.

**Challenge:** Register residents, display list, search.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

struct Resident {
    string name;
    int age;
    string address;
    string contactNumber;
};

void displayResident(const Resident& r, int number) {
    cout << "\nResident #" << number << endl;
    cout << "Name: " << r.name << endl;
    cout << "Age: " << r.age << endl;
    cout << "Address: " << r.address << endl;
    cout << "Contact: " << r.contactNumber << endl;
}

void displayAllResidents(Resident residents[], int count) {
    cout << "\n=== ALL RESIDENTS ===" << endl;
    for (int i = 0; i < count; i++) {
        displayResident(residents[i], i + 1);
    }
    cout << "Total: " << count << " residents" << endl;
}

int countSeniors(Resident residents[], int count) {
    int seniors = 0;
    for (int i = 0; i < count; i++) {
        if (residents[i].age >= 60) seniors++;
    }
    return seniors;
}

int main() {
    const int MAX_RESIDENTS = 100;
    Resident residents[MAX_RESIDENTS];
    int count = 0;
    
    cout << "=== BARANGAY RESIDENT REGISTRATION ===" << endl;
    
    char addMore = 'y';
    while (addMore == 'y' && count < MAX_RESIDENTS) {
        cout << "\n--- Resident " << (count + 1) << " ---" << endl;
        
        cin.ignore();
        cout << "Name: ";
        getline(cin, residents[count].name);
        
        cout << "Age: ";
        cin >> residents[count].age;
        
        cin.ignore();
        cout << "Address: ";
        getline(cin, residents[count].address);
        
        cout << "Contact Number: ";
        getline(cin, residents[count].contactNumber);
        
        count++;
        
        if (count < MAX_RESIDENTS) {
            cout << "Add another resident? (y/n): ";
            cin >> addMore;
        }
    }
    
    displayAllResidents(residents, count);
    
    int seniors = countSeniors(residents, count);
    cout << "\nSenior citizens: " << seniors << endl;
    
    return 0;
}
```

# Tasks for Learners

- Build a complete Barangay Management System that registers residents with name, age, address, and contact number. Display all residents and count senior citizens.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  struct Resident {
      string name;
      int age;
      string address;
      string contactNumber;
  };

  void displayResident(const Resident& r, int number) {
      cout << "\nResident #" << number << endl;
      cout << "Name: " << r.name << endl;
      cout << "Age: " << r.age << endl;
      cout << "Address: " << r.address << endl;
      cout << "Contact: " << r.contactNumber << endl;
  }

  void displayAllResidents(Resident residents[], int count) {
      cout << "\n=== ALL RESIDENTS ===" << endl;
      for (int i = 0; i < count; i++) {
          displayResident(residents[i], i + 1);
      }
      cout << "Total: " << count << " residents" << endl;
  }

  int countSeniors(Resident residents[], int count) {
      int seniors = 0;
      for (int i = 0; i < count; i++) {
          if (residents[i].age >= 60) seniors++;
      }
      return seniors;
  }

  int main() {
      const int MAX_RESIDENTS = 100;
      Resident residents[MAX_RESIDENTS];
      int count = 0;
      
      cout << "=== BARANGAY RESIDENT REGISTRATION ===" << endl;
      
      char addMore = 'y';
      while (addMore == 'y' && count < MAX_RESIDENTS) {
          cout << "\n--- Resident " << (count + 1) << " ---" << endl;
          
          if (count == 0) {
              cin.ignore();
          }
          
          cout << "Name: ";
          getline(cin, residents[count].name);
          
          cout << "Age: ";
          cin >> residents[count].age;
          
          cin.ignore();
          cout << "Address: ";
          getline(cin, residents[count].address);
          
          cout << "Contact Number: ";
          getline(cin, residents[count].contactNumber);
          
          count++;
          
          if (count < MAX_RESIDENTS) {
              cout << "Add another resident? (y/n): ";
              cin >> addMore;
          }
      }
      
      displayAllResidents(residents, count);
      
      int seniors = countSeniors(residents, count);
      cout << "\nSenior citizens: " << seniors << endl;
      
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Struct Essentials</strong></summary>

**Syntax:**
```cpp
struct StructName {
    type1 member1;
    type2 member2;
    // ...
};

StructName obj;
obj.member1 = value;
```

**Why Structs?**
- Bundle related data together
- Create custom data types
- Cleaner than parallel arrays
- Foundation for OOP (classes are structs with methods)

**Struct vs Parallel Arrays:**

**Before (Parallel Arrays - BAD):**
```cpp
string names[100];
int ages[100];
string addresses[100];
// If indices misalign = disaster!
```

**After (Struct Array - GOOD):**
```cpp
struct Resident {
    string name;
    int age;
    string address;
};
Resident residents[100];
// Data stays together!
```

**Pass by Value vs Reference:**
```cpp
// Pass by value: copies entire struct (expensive!)
void display(Resident r);

// Pass by reference: modify original
void update(Resident& r);

// Const reference: read-only, no copy (efficient!)
void display(const Resident& r);
```

**Common Patterns:**
```cpp
// Array of structs
Resident residents[100];

// Loop through struct array
for (int i = 0; i < size; i++) {
    cout << residents[i].name << endl;
}

// Search in struct array
for (int i = 0; i < size; i++) {
    if (residents[i].name == searchName) {
        return i;
    }
}
```

</details>

---

**Structs are the gateway to OOP!** Next lessons add methods to structs → classes!
