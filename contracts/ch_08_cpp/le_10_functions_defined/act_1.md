# C++ Activity:

```cpp
#include <iostream>
using namespace std;

// Define function here
void displayWelcome() {
    // Print welcome message
}

int main() {
    displayWelcome();  // Call it
    return 0;
}
```

**Time Allotment: 15 minutes**

## Tasks for students

Topics Covered: Function definition, function call, `void` return type.

- Create a simple welcome function:

  - Define `displayWelcome()` that prints a greeting message like "Welcome to Barangay Portal!".
  - Call the function inside `main()`.

  ```cpp
  #include <iostream>
  using namespace std;

  void displayWelcome() {
      cout << "Welcome to Barangay Portal!" << endl;
  }

  int main() {
      displayWelcome();
      return 0;
  }
  ```

## Task 3: Function with Return Value

**Context:**  
Calculate fees based on age, return the amount.

**Your Challenge:**  
Write `calculateFee(int age)` that returns `int`.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

int calculateFee(int age) {
    if (age < 18) return 50;
    else if (age >= 60) return 30;
    else return 100;
}

int main() {
    int fee = calculateFee(25);
    cout << "Fee: PHP " << fee << endl;
    return 0;
}
```

# Tasks for Learners

- Calculate fees with return value: Create `calculateFee(int age)` that returns different fees based on age.

  ```cpp
  #include <iostream>
  using namespace std;

  int calculateFee(int age) {
      if (age < 18) return 50;
      else if (age >= 60) return 30;
      else return 100;
  }

  int main() {
      int fee = calculateFee(25);
      cout << "Fee: PHP " << fee << endl;
      return 0;
  }
  ```

---

## Task 4: Multiple Parameters

**Context:**  
Calculate total cost from price and quantity.

**Your Challenge:**  
Create `calculateTotal(double price, int quantity)`.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

double calculateTotal(double price, int quantity) {
    return price * quantity;
}

int main() {
    double total = calculateTotal(50.0, 3);
    cout << "Total: PHP " << total << endl;
    return 0;
}
```

# Tasks for Learners

- Calculate total with multiple parameters: Create `calculateTotal(double price, int quantity)` that multiplies price by quantity.

  ```cpp
  #include <iostream>
  using namespace std;

  double calculateTotal(double price, int quantity) {
      return price * quantity;
  }

  int main() {
      double total = calculateTotal(50.0, 3);
      cout << "Total: PHP " << total << endl;
      return 0;
  }
  ```

---

## Task 5: Discount Calculator

**Context:**  
Apply percentage discounts with a reusable function.

**Your Challenge:**  
Write `applyDiscount(double amount, double percent)`.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

double applyDiscount(double amount, double percent) {
    double discount = amount * (percent / 100.0);
    return amount - discount;
}

int main() {
    double original = 200.0;
    double senior = applyDiscount(original, 20.0);
    double pwd = applyDiscount(original, 25.0);

    cout << "Regular: PHP " << original << endl;
    cout << "Senior: PHP " << senior << endl;
    cout << "PWD: PHP " << pwd << endl;

    return 0;
}
```

# Tasks for Learners

- Apply percentage discount: Create `applyDiscount(double amount, double percent)` that calculates discounted amount.

  ```cpp
  #include <iostream>
  using namespace std;

  double applyDiscount(double amount, double percent) {
      double discount = amount * (percent / 100.0);
      return amount - discount;
  }

  int main() {
      double original = 200.0;
      double senior = applyDiscount(original, 20.0);
      double pwd = applyDiscount(original, 25.0);

      cout << "Regular: PHP " << original << endl;
      cout << "Senior: PHP " << senior << endl;
      cout << "PWD: PHP " << pwd << endl;

      return 0;
  }
  ```

---

**Next:** Refactor your ATM project (Lesson 9) using functions. Break it into: `authenticatePIN()`, `checkBalance()`, `deposit()`, `withdraw()`, `displayMenu()`. Clean code = professional code!
