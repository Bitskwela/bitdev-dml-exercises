# Quiz: Lesson 26 - Inheritance

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Inheritance Basics

### Question 1
What is inheritance in C++?

A) Copying code between classes  
B) A class acquiring properties and methods from another class  
C) Sharing global variables  
D) Including header files

**Answer: B) A class acquiring properties and methods from another class**

**Explanation:**
```cpp
class Person {
public:
    string name;
    void display() { cout << name; }
};

class Resident : public Person {  // Resident inherits from Person
    // Inherits name and display()
};

Resident r;
r.name = "Juan";  // ✓ Inherited from Person
r.display();      // ✓ Inherited from Person
```

---

### Question 2
What's the output?

```cpp
class Base {
public:
    void show() {
        cout << "Base";
    }
};

class Derived : public Base {
};

int main() {
    Derived d;
    d.show();
}
```

A) Error  
B) `Base`  
C) `Derived`  
D) Nothing

**Answer: B) `Base`**

**Explanation:**
Derived inherits `show()` from Base, so it can call it.

---


# Quiz 2

### Question 3-15
[Covers: protected members, constructor chaining, method overriding, access control, is-a relationship, calling base methods, multilevel inheritance, practical barangay examples]

**Key Concepts:**
1. Inheritance enables code reuse
2. Protected = accessible in derived classes
3. Constructors chain from base to derived
4. Override methods for specialization
5. Use for "is-a" relationships

---

**Score yourself:**
- 15/15: Inheritance Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review protected members
- Below 9: Re-read inheritance concepts
