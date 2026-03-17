# Lesson 24: Constructors

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+24.0+-+COVER.png)

## Scene

Tian's BankAccount class had a critical bug. Sometimes account objects were created without initializing the balance, leading to random garbage values. Users started with millions in debt or billions in credit -- chaos.

"Why isn't the balance starting at zero?" Tian asked, frustrated.

Kuya Miguel examined the code. "You're creating objects without initialization. In C++, uninitialized variables contain whatever random data was in that memory. Can't the class initialize itself automatically? That's what **constructors** do -- a special function that runs the moment an object is created."

"And when objects are destroyed?" Tian asked. "**Destructors** handle cleanup," Kuya Miguel said. "If your object allocated memory, the destructor frees it automatically."

## C++ Topics: Constructors and Destructors

![24.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+24.1.png)

### Default Constructor

> A constructor with no parameters that sets safe default values. It has the same name as the class and no return type. It runs automatically when an object is created.

### Parameterized Constructor

> A constructor that accepts arguments to initialize an object with specific values at creation time: `BankAccount("1001", 5000.0)`.

### Constructor Overloading

> You can define multiple constructors with different parameter lists. C++ picks the right one based on the arguments provided.

### Destructors

> A destructor (`~ClassName()`) runs automatically when an object goes out of scope. Used for cleanup like freeing dynamic memory.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    double balance;

public:
    BankAccount() {
        accountNumber = "0000";
        balance = 0.0;
    }

    BankAccount(string accNo, double initBalance) {
        accountNumber = accNo;
        balance = initBalance;
    }

    ~BankAccount() {
        cout << "Account " << accountNumber << " closed." << endl;
    }

    void display() {
        cout << "Account: " << accountNumber
             << " | Balance: P" << balance << endl;
    }
};

int main() {
    BankAccount acc1;
    BankAccount acc2("ACC-123", 5000.0);
    acc1.display();
    acc2.display();
    return 0;
}
```

The default constructor guarantees every account starts with zero balance. The parameterized constructor allows custom initialization. The destructor runs automatically at the end of scope, cleaning up resources. No more forgotten initialization.
