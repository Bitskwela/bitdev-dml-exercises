# C++ Activity: Structs

Group related data into a single custom data type using structs.

```cpp
#include <iostream>
#include <string>
using namespace std;

// Your code here: Define a Resident struct with name (string), age (int), and isVaccinated (bool)

int main() {
    // Your code here: Create a Resident variable

    // Your code here: Initialize the members with data

    // Your code here: Print the resident's information

    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: `struct` definition, Member Access (dot operator), Data Grouping.

1. **Define the Struct**: Create a `struct` named `Resident` that contains three members: a `name` (string), an `age` (int), and `isVaccinated` (bool).
2. **Instantiate a Resident**: In the `main` function, declare a variable of type `Resident` (e.g., `Resident person1`).
3. **Assign Values**: Use the dot operator (`.`) to assign values to each of the struct members.
4. **Display Data**: Print all the members of your `Resident` variable to the console in a clear format. string name;
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

````

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
````

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
