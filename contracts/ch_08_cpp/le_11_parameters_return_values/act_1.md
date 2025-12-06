# Lesson 11 Activities: Parameters and Return Values

## The Photocopy vs The Key

Tian's `deductFee()` function didn't work—the balance never changed! Kuya Miguel explained: **"Pass by value gives a photocopy. Pass by reference gives the key to the original."**

**This lesson masters data flow.** Functions need to receive data (parameters) and send results back (return values). Understanding pass-by-value vs pass-by-reference determines whether your functions actually work!

---

## Task 1: Pass by Value Test

**Context:** See how pass-by-value creates copies that don't affect originals.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

void tryChange(int num) {
    num = 100;
    cout << "Inside: " << num << endl;
}

int main() {
    int original = 50;
    cout << "Before: " << original << endl;
    tryChange(original);
    cout << "After: " << original << endl;
    return 0;
}
```

# Tasks for Learners

- Demonstrate pass by value: Show that modifying a parameter doesn't affect the original variable.

  ```cpp
  #include <iostream>
  using namespace std;

  void tryChange(int num) {
      num = 100;
      cout << "Inside: " << num << endl;
  }

  int main() {
      int original = 50;
      cout << "Before: " << original << endl;
      tryChange(original);
      cout << "After: " << original << endl;
      return 0;
  }
  ```

---

## Task 2: Pass by Reference

**Context:** Use `&` to modify the actual variable.

**Challenge:** Create `updateBalance(double& balance, double amount)` that actually changes the balance.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

void updateBalance(double& balance, double amount) {
    balance += amount;
}

int main() {
    double myBalance = 1000.0;
    updateBalance(myBalance, 500.0);
    cout << "New balance: " << myBalance << endl;
    return 0;
}
```

# Tasks for Learners

- Use pass by reference to modify original: Create `updateBalance` that actually changes the balance parameter.

  ```cpp
  #include <iostream>
  using namespace std;

  void updateBalance(double& balance, double amount) {
      balance += amount;
  }

  int main() {
      double myBalance = 1000.0;
      updateBalance(myBalance, 500.0);
      cout << "New balance: " << myBalance << endl;
      return 0;
  }
  ```

---

## Task 3: Multiple Return Values

**Context:** Use references to "return" multiple values from one function.

**Challenge:** Create `getMinMax(int arr[], int size, int& min, int& max)` that finds both minimum and maximum.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

void getMinMax(int arr[], int size, int& min, int& max) {
    min = max = arr[0];
    for (int i = 1; i < size; i++) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }
}

int main() {
    int grades[] = {85, 92, 78, 95, 68};
    int minimum, maximum;
    
    getMinMax(grades, 5, minimum, maximum);
    
    cout << "Lowest: " << minimum << endl;
    cout << "Highest: " << maximum << endl;
    
    return 0;
}
```

# Tasks for Learners

- Return multiple values using reference parameters: Use output parameters to find both minimum and maximum.

  ```cpp
  #include <iostream>
  using namespace std;

  void getMinMax(int arr[], int size, int& min, int& max) {
      min = max = arr[0];
      for (int i = 1; i < size; i++) {
          if (arr[i] < min) min = arr[i];
          if (arr[i] > max) max = arr[i];
      }
  }

  int main() {
      int grades[] = {85, 92, 78, 95, 68};
      int minimum, maximum;
      
      getMinMax(grades, 5, minimum, maximum);
      
      cout << "Lowest: " << minimum << endl;
      cout << "Highest: " << maximum << endl;
      
      return 0;
  }
  ```

---

## Task 4: Const References

**Context:** Pass large data efficiently without allowing modification.

**Challenge:** Create `displayResident(const string& name, const string& address)` that reads but doesn't modify.

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

void displayResident(const string& name, const string& address) {
    cout << "Resident: " << name << endl;
    cout << "Address: " << address << endl;
    // name = "Changed";  // ERROR: can't modify const reference
}

int main() {
    string residentName = "Juan Dela Cruz";
    string residentAddress = "123 Main St, Iloilo";
    
    displayResident(residentName, residentAddress);
    
    return 0;
}
```

# Tasks for Learners

- Use const reference for read-only access: Pass large data efficiently without allowing modification.

  ```cpp
  #include <iostream>
  #include <string>
  using namespace std;

  void displayResident(const string& name, const string& address) {
      cout << "Resident: " << name << endl;
      cout << "Address: " << address << endl;
  }

  int main() {
      string residentName = "Juan Dela Cruz";
      string residentAddress = "123 Main St, Iloilo";
      
      displayResident(residentName, residentAddress);
      
      return 0;
  }
  ```

---

## Task 5: Return Values vs Output Parameters

**Context:** Compare returning values vs modifying parameters.

**Challenge:** Create two versions—one that returns result, one that uses output parameter.

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

// Version 1: Return value
double calculateDiscount(double price, double percent) {
    return price * (percent / 100.0);
}

// Version 2: Output parameter
void calculateDiscount(double price, double percent, double& discount) {
    discount = price * (percent / 100.0);
}

int main() {
    double price = 1000.0;
    
    // Method 1
    double discount1 = calculateDiscount(price, 20.0);
    cout << "Discount (return): " << discount1 << endl;
    
    // Method 2
    double discount2;
    calculateDiscount(price, 20.0, discount2);
    cout << "Discount (output param): " << discount2 << endl;
    
    return 0;
}
```

# Tasks for Learners

- Compare return values vs output parameters: Implement two versions of the same function using different approaches.

  ```cpp
  #include <iostream>
  using namespace std;

  // Version 1: Return value
  double calculateDiscount(double price, double percent) {
      return price * (percent / 100.0);
  }

  // Version 2: Output parameter
  void calculateDiscount(double price, double percent, double& discount) {
      discount = price * (percent / 100.0);
  }

  int main() {
      double price = 1000.0;
      
      // Method 1
      double discount1 = calculateDiscount(price, 20.0);
      cout << "Discount (return): " << discount1 << endl;
      
      // Method 2
      double discount2;
      calculateDiscount(price, 20.0, discount2);
      cout << "Discount (output param): " << discount2 << endl;
      
      return 0;
  }
  ```

---

**Master this:** Every function parameter decision affects performance and correctness. Choose wisely!
