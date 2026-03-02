# C++ Activity: Exception Handling

Protect your program from crashing by handling runtime errors gracefully.

```cpp
#include <iostream>
#include <stdexcept>
using namespace std;

// Your code here: Create a function 'divideResidents' that throws an exception if divisor is 0

int main() {
    int totalFund = 10000;
    int divisor;

    cout << "Enter number of residents to split the fund among: ";
    cin >> divisor;

    // Your code here: Use a try-catch block to call the function and handle the error

    return 0;
}
```

**Time Allotment: 20 minutes**

## Tasks for students

Topics Covered: `try`, `throw`, `catch`, `std::runtime_error`.

1.  **Implement Function**: Create a function `double divideFund(int fund, int residents)` that returns `fund / residents`.
2.  **Throw Exception**: Inside the function, check if `residents` is 0. If it is, `throw runtime_error("Error: Cannot divide by zero residents.");`.
3.  **Try Block**: In `main()`, place the function call inside a `try` block.
4.  **Catch Block**: Add a `catch (const runtime_error& e)` block that prints the error message using `e.what()`.
5.  **Test**: Run the program twice: once with a valid number (e.g., 5) and once with 0 to see the error handling in action.  
     for (int age : ages) {
    try {
    processAge(age);
    }
    catch (int e) {
    cout << "Error: Negative age" << endl;
    }
    catch (const char\* msg) {
    cout << "Error: " << msg << endl;
    }
    catch (char c) {
    cout << "Error: Minor (not allowed)" << endl;
    }
    }
        return 0;
    }

````

# Tasks for Learners

- Use multiple catch blocks to handle different exception types for age validation.

  ```cpp
  #include <iostream>
  using namespace std;

  void processAge(int age) {
      if (age < 0) {
          throw -1;
      }
      if (age > 150) {
          throw "Age too high!";
      }
      if (age < 18) {
          throw 'M';
      }

      cout << "Age " << age << " is valid" << endl;
  }

  int main() {
      int ages[] = {25, -5, 200, 15};

      for (int age : ages) {
          try {
              processAge(age);
          }
          catch (int e) {
              cout << "Error: Negative age" << endl;
          }
          catch (const char* msg) {
              cout << "Error: " << msg << endl;
          }
          catch (char c) {
              cout << "Error: Minor (not allowed)" << endl;
          }
      }

      return 0;
  }
````

---

## Task 3: Standard Exception Classes

**Context:** Use C++ standard exception types.

**Starter Code:**

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
        acc.withdraw(800);  // Throws runtime_error
    }
    catch (exception& e) {  // Catches all standard exceptions
        cout << "Exception: " << e.what() << endl;
    }

    return 0;
}
```

# Tasks for Learners

- Use standard exception classes (invalid_argument, runtime_error) for bank account validation.

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
          acc.withdraw(500);
          acc.withdraw(-100);
      }
      catch (invalid_argument& e) {
          cout << "Invalid: " << e.what() << endl;
      }
      catch (runtime_error& e) {
          cout << "Runtime error: " << e.what() << endl;
      }

      try {
          acc.withdraw(800);
      }
      catch (exception& e) {
          cout << "Exception: " << e.what() << endl;
      }

      return 0;
  }
  ```

---

## Task 4: Custom Exception Class

**Context:** Create your own exception types.

**Starter Code:**

```cpp
#include <iostream>
#include <string>
#include <exception>
using namespace std;

class InsufficientFundsException : public exception {
private:
    string message;

public:
    InsufficientFundsException(double amount, double balance) {
        message = "Insufficient funds: tried to withdraw P" + to_string(amount)
                + " but only P" + to_string(balance) + " available";
    }

    const char* what() const noexcept override {
        return message.c_str();
    }
};

class BankAccount {
private:
    double balance;

public:
    BankAccount(double bal) : balance(bal) {}

    void withdraw(double amount) {
        if (amount > balance) {
            throw InsufficientFundsException(amount, balance);
        }
        balance -= amount;
        cout << "Withdrew P" << amount << endl;
    }

    double getBalance() { return balance; }
};

int main() {
    BankAccount acc(1000);

    try {
        acc.withdraw(500);
        acc.withdraw(800);
    }
    catch (InsufficientFundsException& e) {
        cout << "Error: " << e.what() << endl;
        cout << "Current balance: P" << acc.getBalance() << endl;
    }

    return 0;
}
```

# Tasks for Learners

- Create a custom exception class (InsufficientFundsException) for specific bank account errors.

  ```cpp
  #include <iostream>
  #include <string>
  #include <exception>
  using namespace std;

  class InsufficientFundsException : public exception {
  private:
      string message;

  public:
      InsufficientFundsException(double amount, double balance) {
          message = "Insufficient funds: tried to withdraw P" + to_string(amount)
                  + " but only P" + to_string(balance) + " available";
      }

      const char* what() const noexcept override {
          return message.c_str();
      }
  };

  class BankAccount {
  private:
      double balance;

  public:
      BankAccount(double bal) : balance(bal) {}

      void withdraw(double amount) {
          if (amount > balance) {
              throw InsufficientFundsException(amount, balance);
          }
          balance -= amount;
          cout << "Withdrew P" << amount << endl;
      }

      double getBalance() { return balance; }
  };

  int main() {
      BankAccount acc(1000);

      try {
          acc.withdraw(500);
          acc.withdraw(800);
      }
      catch (InsufficientFundsException& e) {
          cout << "Error: " << e.what() << endl;
          cout << "Current balance: P" << acc.getBalance() << endl;
      }

      return 0;
  }
  ```

---

## Task 5: Input Validation with Exceptions

**Context:** Handle invalid user input.

**Starter Code:**

```cpp
#include <iostream>
#include <string>
#include <stdexcept>
using namespace std;

int getPositiveInteger(const string& prompt) {
    cout << prompt;
    int value;
    cin >> value;

    if (cin.fail()) {
        cin.clear();
        cin.ignore(10000, '\n');
        throw invalid_argument("Invalid input: not a number");
    }

    if (value <= 0) {
        throw out_of_range("Value must be positive");
    }

    return value;
}

int main() {
    while (true) {
        try {
            int age = getPositiveInteger("Enter your age: ");
            cout << "Age accepted: " << age << endl;
            break;  // Success, exit loop
        }
        catch (invalid_argument& e) {
            cout << "Error: " << e.what() << ". Try again." << endl;
        }
        catch (out_of_range& e) {
            cout << "Error: " << e.what() << ". Try again." << endl;
        }
    }

    cout << "Input successful!" << endl;
    return 0;
}
```

# Tasks for Learners

- Handle invalid user input with exceptions, allowing retry until valid input is provided.

  ```cpp
  #include <iostream>
  #include <string>
  #include <stdexcept>
  using namespace std;

  int getPositiveInteger(const string& prompt) {
      cout << prompt;
      int value;
      cin >> value;

      if (cin.fail()) {
          cin.clear();
          cin.ignore(10000, '\n');
          throw invalid_argument("Invalid input: not a number");
      }

      if (value <= 0) {
          throw out_of_range("Value must be positive");
      }

      return value;
  }

  int main() {
      while (true) {
          try {
              int age = getPositiveInteger("Enter your age: ");
              cout << "Age accepted: " << age << endl;
              break;
          }
          catch (invalid_argument& e) {
              cout << "Error: " << e.what() << ". Try again." << endl;
          }
          catch (out_of_range& e) {
              cout << "Error: " << e.what() << ". Try again." << endl;
          }
      }

      cout << "Input successful!" << endl;
      return 0;
  }
  ```

---

## Task 6: RAII and Exception Safety

**Context:** Resources cleaned up even when exceptions occur.

**Starter Code:**

```cpp
#include <iostream>
using namespace std;

class Resource {
private:
    string name;

public:
    Resource(string n) : name(n) {
        cout << "[" << name << "] Acquired" << endl;
    }

    ~Resource() {
        cout << "[" << name << "] Released" << endl;
    }

    void use() {
        cout << "[" << name << "] Using..." << endl;
    }
};

void riskyOperation() {
    Resource r1("Database");
    Resource r2("File");

    r1.use();
    r2.use();

    throw runtime_error("Something went wrong!");

    // Resources still cleaned up by destructors!
}

int main() {
    try {
        riskyOperation();
    }
    catch (exception& e) {
        cout << "Caught: " << e.what() << endl;
    }

    cout << "Resources were cleaned up automatically!" << endl;
    return 0;
}
```

# Tasks for Learners

- Demonstrate RAII (Resource Acquisition Is Initialization) and automatic cleanup even when exceptions occur.

  ```cpp
  #include <iostream>
  #include <stdexcept>
  #include <string>
  using namespace std;

  class Resource {
  private:
      string name;

  public:
      Resource(string n) : name(n) {
          cout << "[" << name << "] Acquired" << endl;
      }

      ~Resource() {
          cout << "[" << name << "] Released" << endl;
      }

      void use() {
          cout << "[" << name << "] Using..." << endl;
      }
  };

  void riskyOperation() {
      Resource r1("Database");
      Resource r2("File");

      r1.use();
      r2.use();

      throw runtime_error("Something went wrong!");
  }

  int main() {
      try {
          riskyOperation();
      }
      catch (exception& e) {
          cout << "Caught: " << e.what() << endl;
      }

      cout << "Resources were cleaned up automatically!" << endl;
      return 0;
  }
  ```

**Note:** Even with exception, destructors called—RAII ensures cleanup!

---

<details>
<summary><strong>📝 Exception Handling Summary</strong></summary>

**Syntax:**

```cpp
try {
    // Code that might throw
    if (error) throw ExceptionType();
}
catch (ExceptionType& e) {
    // Handle exception
}
```

**Standard Exceptions:**

- `exception` - Base class
- `runtime_error` - Runtime problems
- `invalid_argument` - Invalid parameters
- `out_of_range` - Index out of bounds
- `logic_error` - Logic errors

**Custom Exceptions:**

```cpp
class MyException : public exception {
public:
    const char* what() const noexcept override {
        return "My error message";
    }
};
```

**Best Practices:**

1. Use standard exceptions when possible
2. Catch by reference
3. Use RAII for resource management
4. Don't throw in destructors
5. Provide meaningful error messages

**Benefits:**

- Graceful error handling
- Separation of error handling from logic
- Automatic cleanup (RAII)
- Robust, professional software

</details>

---

**Exceptions turn crashes into recoverable errors—essential for production code!**
