# Inheritance

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+26.0+-+COVER.png)

## Scene

Tian stared at three nearly identical classes: `Resident`, `BarangayOfficial`, and `BusinessOwner`. Each had `name`, `age`, and a `display()` method. "If I need to add a phone number, I have to change three classes!" he complained.

Kuya Miguel nodded. "You're violating the DRY principle -- Don't Repeat Yourself. All three are fundamentally 'people' with shared traits. Use inheritance: create a base `Person` class, then derive specialized classes from it."

"Add phone number once to Person, and all derived classes automatically get it. That's the power of code reuse through class hierarchies."

## C++ Topics: Inheritance

![26.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+26.1.png)

### Base and Derived Classes

> A base class (parent) holds common properties and methods. A derived class (child) inherits from the base and adds its own specialized members. Syntax: `class Derived : public Base { };`

### Protected Members

> `protected` members are accessible within the class and its derived classes, but not from outside. This is the middle ground between `private` and `public`.

### Constructor Chaining

> Derived class constructors must call the base class constructor using an initializer list: `Derived(params) : Base(baseParams), ownMember(value) { }`. The base constructor runs first.

### Method Overriding

> A derived class can redefine a base class method to provide specialized behavior. The derived version "shadows" the base version when called on a derived object.

#### Sample syntax

```cpp
class Vehicle {
protected:
    string brand;
public:
    Vehicle(string b) : brand(b) {}
    string getBrand() { return brand; }
};

class Car : public Vehicle {
private:
    int doors;
public:
    Car(string b, int d) : Vehicle(b), doors(d) {}
    int getDoors() { return doors; }
};
```

`Car` inherits `brand` and `getBrand()` from `Vehicle`, then adds its own `doors` member. The `Car` constructor chains to `Vehicle`'s constructor using `: Vehicle(b)` in the initializer list.
