# Polymorphism

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+27.0+-+COVER.png)

## Scene

Tian stored Residents and Officials in an array of `Person*` pointers, but calling `display()` always ran the base Person version. "Why isn't it calling the Resident's method?" he asked, confused.

Kuya Miguel examined the code. "Without the `virtual` keyword, the compiler uses the pointer type, not the actual object type. You need polymorphism -- one interface, many implementations. Mark the base method `virtual`, and C++ will call the correct version at runtime."

"Imagine a barangay clearance system," Kuya Miguel continued. "Residence, Business, and Travel clearances all calculate fees differently, but you process them through the same Clearance interface. That's the power of polymorphism."

## C++ Topics: Polymorphism

![27.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+27.1.png)

### Virtual Functions

> Adding `virtual` to a base class method enables dynamic binding. The correct method version is determined at runtime based on the actual object type, not the pointer type.

### The `override` Keyword

> Use `override` on derived class methods to explicitly mark them as overriding a base virtual function. This catches typos and errors at compile time.

### Pure Virtual Functions

> A pure virtual function (`virtual void method() = 0;`) has no implementation in the base class. Any class with a pure virtual function is abstract and cannot be instantiated.

### Virtual Destructors

> Base classes with virtual functions should have a virtual destructor. Without it, deleting a derived object through a base pointer causes incomplete cleanup and memory leaks.

#### Sample syntax

```cpp
class Base {
public:
    virtual string msg() { return "Base"; }
    virtual ~Base() {}
};

class Derived : public Base {
public:
    string msg() override { return "Derived"; }
};

// Base* b = new Derived();
// b->msg() returns "Derived" -- dynamic binding!
```

The `virtual` keyword on `msg()` enables runtime dispatch. When called through a `Base*` pointer pointing to a `Derived` object, the `Derived` version executes. The `override` keyword ensures we are actually overriding a base method.
