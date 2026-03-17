# Encapsulation

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+25.0+-+COVER.png)

## Scene

Tian proudly showed his new BankAccount class to Kuya Miguel. "Look! Users can directly set the balance: `account.balance = 1000000`. Instant millionaire!" Kuya Miguel shook his head. "That's a critical flaw. Anyone can set a negative balance or bypass validation entirely."

"How do I prevent this?" Tian asked. Kuya Miguel explained: "Encapsulation. Make data private and provide controlled access through public methods. Think of it like an ATM -- you interact through a controlled interface, not by reaching into the vault."

Tian realized this is what separates amateur code from professional systems. Hide the internals, expose only what's necessary, and validate everything.

## C++ Topics: Encapsulation

![25.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+25.1.png)

### Access Specifiers

> `private` members are only accessible inside the class. `public` members are accessible from anywhere. `protected` members are accessible in the class and its derived classes.

### Getters and Setters

> Getters (accessors) return private data without exposing it directly. Setters (mutators) allow controlled modification with validation logic built in.

### Const Member Functions

> Marking a function `const` promises it will not modify the object. This allows the function to be called on const objects and documents read-only intent.

### Data Validation

> Setters should validate input before modifying private data. Reject invalid values like negative amounts or out-of-range ages to maintain data integrity.

#### Sample syntax

```cpp
class BankAccount {
private:
    double balance;
public:
    BankAccount(double b) : balance(b) {}
    double getBalance() const { return balance; }
    void deposit(double a) {
        if (a > 0) balance += a;
    }
};
```

The `balance` field is private so it cannot be modified directly. The `deposit` method validates that the amount is positive before updating. The `getBalance` getter is marked `const` since it only reads data.
