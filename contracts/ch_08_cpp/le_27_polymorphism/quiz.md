# Quiz: Lesson 27 - Polymorphism

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Virtual Functions

### Question 1
What does the `virtual` keyword do?

A) Makes functions faster  
B) Enables dynamic binding for overridden methods  
C) Makes functions private  
D) Required for all functions

**Answer: B) Enables dynamic binding for overridden methods**

**Explanation:**
```cpp
class Base {
public:
    virtual void show() { cout << "Base"; }
};

class Derived : public Base {
public:
    void show() override { cout << "Derived"; }
};

Base* ptr = new Derived();
ptr->show();  // "Derived" — virtual enables this!
```

---


# Quiz 2

### Question 2-15
[Covers: pure virtual functions, abstract classes, virtual destructors, dynamic vs static binding, override keyword, polymorphic arrays, practical barangay clearance system with different clearance types]

**Key Concepts:**
1. Virtual functions enable polymorphism
2. Pure virtual (= 0) creates abstract classes
3. Virtual destructors essential
4. Dynamic binding at runtime
5. Use override for safety

---

**Score yourself:**
- 15/15: Polymorphism Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review virtual functions
- Below 9: Re-read polymorphism concepts
