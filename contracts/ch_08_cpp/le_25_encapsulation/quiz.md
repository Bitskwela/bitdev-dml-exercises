# Quiz: Lesson 25 - Encapsulation

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Encapsulation Basics

### Question 1
What is encapsulation?

A) Hiding all class members  
B) Bundling data and methods while hiding implementation details  
C) Making everything private  
D) Using getters only

**Answer: B) Bundling data and methods while hiding implementation details**

**Explanation:**
Encapsulation = data + methods + controlled access. Hide how it works, expose what's needed.

---

### Question 2
What's the benefit of making `balance` private?

```cpp
class BankAccount {
private:
    double balance;
public:
    void deposit(double amt) {
        if (amt > 0) balance += amt;
    }
};
```

A) Faster code  
B) Less memory  
C) Controlled access with validation  
D) Required by C++

**Answer: C) Controlled access with validation**

**Explanation:**
Private + public methods = controlled access. Can validate before modifying data.

---


# Quiz 2

### Question 3-15
[Questions covering: getters/setters, const methods, validation, access levels, information hiding, practical barangay examples, friend functions, design patterns]

**Key Concepts:**
1. Encapsulation protects data
2. Private data, public interface
3. Validate in setters
4. Use const for read-only methods
5. Information hiding improves maintainability

---

**Score yourself:**
- 15/15: Encapsulation Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review access control
- Below 9: Re-read encapsulation concepts
