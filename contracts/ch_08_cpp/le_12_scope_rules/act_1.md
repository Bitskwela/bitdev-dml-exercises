# Lesson 12 Activities: Scope Rules

## The Possessed Variables

Marites' program was **haunted**—variables changed mysteriously! She declared `count` in a loop, but it disappeared outside. She made a global `total`, but a function's local `total` shadowed it.

**Scope is the "privacy zone" of variables.** Local scope = function/block only. Global scope = entire file. Understanding scope prevents ghost bugs!

---

## Task 1: Block Scope Discovery

**Context:** Variables declared in `{}` blocks only exist there.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int outer = 10;
    
    if (true) {
        int inner = 20;
        cout << "Inside block: outer=" << outer << " inner=" << inner << endl;
    }
    
    cout << "Outside block: outer=" << outer << endl;
    // cout << inner;  // ERROR: inner doesn't exist here
    
    return 0;
}
```

# Tasks for Learners

- Add a for-loop that declares `int i`. Try to access `i` after the loop. Note the error.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      int outer = 10;
      
      if (true) {
          int inner = 20;
          cout << "Inside block: outer=" << outer << " inner=" << inner << endl;
      }
      
      cout << "Outside block: outer=" << outer << endl;
      // cout << inner;  // ERROR: inner doesn't exist here
      
      // Added for-loop
      for (int i = 0; i < 3; i++) {
          cout << "Loop iteration: " << i << endl;
      }
      
      // cout << i;  // ERROR: i doesn't exist outside the loop
      
      return 0;
  }
  ```

---

## Task 2: Local vs Global

**Context:** Global variables accessible everywhere, but locals take priority.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int counter = 0;  // Global

void increment() {
    counter++;  // Accesses global
}

void showLocal() {
    int counter = 100;  // Local shadows global
    cout << "Local counter: " << counter << endl;
}

int main() {
    increment();
    increment();
    cout << "Global counter: " << counter << endl;
    showLocal();
    cout << "Global counter still: " << counter << endl;
    return 0;
}
```

# Tasks for Learners

- Run the code and observe how global variables are accessible everywhere, but local variables take priority when shadowing occurs.

  ```cpp
  #include <iostream>
  using namespace std;

  int counter = 0;  // Global

  void increment() {
      counter++;  // Accesses global
  }

  void showLocal() {
      int counter = 100;  // Local shadows global
      cout << "Local counter: " << counter << endl;
  }

  int main() {
      increment();
      increment();
      cout << "Global counter: " << counter << endl;  // Shows 2
      showLocal();  // Shows 100
      cout << "Global counter still: " << counter << endl;  // Still 2
      return 0;
  }
  ```

---

## Task 3: Shadowing Problem

**Context:** Fix Marites' bug where local variables hide globals unintentionally.

**Challenge:** Use `::` (scope resolution operator) to access the global when shadowed.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int price = 100;  // Global price

void calculateTotal() {
    int price = 50;  // Local shadows global
    int quantity = 3;
    
    cout << "Using local price: " << (price * quantity) << endl;
    cout << "Using global price: " << (::price * quantity) << endl;
}

int main() {
    calculateTotal();
    return 0;
}
```

# Tasks for Learners

- Use the scope resolution operator `::` to access the global variable when shadowed by a local variable.

  ```cpp
  #include <iostream>
  using namespace std;

  int price = 100;  // Global price

  void calculateTotal() {
      int price = 50;  // Local shadows global
      int quantity = 3;
      
      cout << "Using local price: " << (price * quantity) << endl;      // 150
      cout << "Using global price: " << (::price * quantity) << endl;  // 300
  }

  int main() {
      calculateTotal();
      return 0;
  }
  ```

---

## Task 4: Loop Variable Scope

**Context:** Modern C++ allows loop variables to stay in loop scope only.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // i only exists inside this loop
    for (int i = 0; i < 3; i++) {
        cout << "Loop 1, i=" << i << endl;
    }
    
    // Can reuse i in another loop!
    for (int i = 10; i < 13; i++) {
        cout << "Loop 2, i=" << i << endl;
    }
    
    // cout << i;  // ERROR: i doesn't exist here
    
    return 0;
}
```

# Tasks for Learners

- Understand why this code works without redeclaration errors: Loop variables have block scope and exist only within the loop.

  ```cpp
  #include <iostream>
  using namespace std;

  int main() {
      // i only exists inside this loop
      for (int i = 0; i < 3; i++) {
          cout << "Loop 1, i=" << i << endl;
      }
      
      // Can reuse i in another loop because the previous i is out of scope!
      for (int i = 10; i < 13; i++) {
          cout << "Loop 2, i=" << i << endl;
      }
      
      // cout << i;  // ERROR: i doesn't exist here
      
      return 0;
  }
  ```

---

## Task 5: Function Parameter Scope

**Context:** Parameters are local to the function.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int balance = 1000;  // Global

void deduct(int amount) {
    // amount is local to this function
    balance -= amount;
    cout << "Deducted " << amount << ", balance now: " << balance << endl;
}

int main() {
    deduct(200);
    deduct(300);
    // cout << amount;  // ERROR: amount doesn't exist here
    return 0;
}
```

# Tasks for Learners

- Observe that function parameters are local to the function and cannot be accessed outside.

  ```cpp
  #include <iostream>
  using namespace std;

  int balance = 1000;  // Global

  void deduct(int amount) {
      // amount is local to this function
      balance -= amount;
      cout << "Deducted " << amount << ", balance now: " << balance << endl;
  }

  int main() {
      deduct(200);  // Balance becomes 800
      deduct(300);  // Balance becomes 500
      // cout << amount;  // ERROR: amount doesn't exist here
      return 0;
  }
  ```

---

## Task 6: Barangay Clearance System

**Context:** Multiple functions with proper scope management.

**Challenge:** Build a system with global resident count, local processing variables.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int totalResidents = 0;  // Global counter

void registerResident(string name) {
    totalResidents++;
    int newID = totalResidents;  // Local ID
    cout << "Registered: " << name << " (ID: " << newID << ")" << endl;
}

void showStatistics() {
    double averagePerDay = totalResidents / 7.0;  // Local calculation
    cout << "Total residents: " << totalResidents << endl;
    cout << "Average per day: " << averagePerDay << endl;
}

int main() {
    registerResident("Juan");
    registerResident("Maria");
    registerResident("Pedro");
    
    showStatistics();
    
    return 0;
}
```

# Tasks for Learners

- Build a barangay clearance system with proper scope management using global counters and local processing variables.

  ```cpp
  #include <iostream>
  using namespace std;

  int totalResidents = 0;  // Global counter

  void registerResident(string name) {
      totalResidents++;
      int newID = totalResidents;  // Local ID
      cout << "Registered: " << name << " (ID: " << newID << ")" << endl;
  }

  void showStatistics() {
      double averagePerDay = totalResidents / 7.0;  // Local calculation
      cout << "Total residents: " << totalResidents << endl;
      cout << "Average per day: " << averagePerDay << endl;
  }

  int main() {
      registerResident("Juan");
      registerResident("Maria");
      registerResident("Pedro");
      
      showStatistics();
      
      return 0;
  }
  ```

---

<details>
<summary><strong>📝 Scope Summary</strong></summary>

**Scope Levels:**
1. **Block scope:** `{ int x; }` - exists only in block
2. **Function scope:** Parameters and locals exist only in function
3. **Global scope:** Declared outside all functions, accessible everywhere

**Shadowing:** Local variable with same name hides global. Use `::globalVar` to access global.

**Best Practices:**
- Minimize global variables (hard to track, dangerous)
- Keep variables in smallest scope needed
- Avoid shadowing (confusing!)
- Use meaningful names to prevent conflicts

</details>

---

**Remember:** Scope controls where variables live and die. Master it to prevent mysterious bugs!
