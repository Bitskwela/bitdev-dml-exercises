# Lesson 10 Activities: Functions Defined

## From Spaghetti Code to Clean Architecture

Tian's ATM project: 243 lines in `main()`. Finding bugs was a nightmare. Kuya Miguel introduced **functions**—breaking complex systems into small, reusable, testable pieces. Professional code!

**This lesson is about organization.** Functions transform messy spaghetti into clean, maintainable architecture. Each function does one job perfectly. Need to validate withdrawal? Call a function. Need to check PIN? Call a function. Simple!

---

## Task 1: Simple Greeting Function

**Context:**  
Create a reusable welcome message function.

**Your Challenge:**  
Define `displayWelcome()` with no parameters or return.

**Starter Code:**
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

---

## Task 2: Function with Parameter

**Context:**  
Personalized greeting for different residents.

**Your Challenge:**  
Create `greetResident(string name)` that takes one parameter.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

void greetResident(string name) {
    cout << "Welcome, " << name << "!" << endl;
}

int main() {
    greetResident("Juan");
    greetResident("Maria");
    return 0;
}
```

---

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

---

<details>
<summary><strong>📝 Complete Solutions Provided Above</strong></summary>

All solutions are already in the starter code sections. Practice modifying them:
- Add more parameters
- Change return types
- Create new functions
- Refactor your ATM project using functions!

</details>

---

**Next:** Refactor your ATM project (Lesson 9) using functions. Break it into: `authenticatePIN()`, `checkBalance()`, `deposit()`, `withdraw()`, `displayMenu()`. Clean code = professional code!
