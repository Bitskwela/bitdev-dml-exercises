# Quiz: Lesson 28 - Templates

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Template Basics

### Question 1
What is a template in C++?

A) A design pattern  
B) A way to write generic code that works with any type  
C) A header file  
D) A class type

**Answer: B) A way to write generic code that works with any type**

**Explanation:**
```cpp
template <typename T>
T max(T a, T b) {
    return (a > b) ? a : b;
}

// Works with any type!
max(10, 20);         // int
max(3.14, 2.71);     // double
max('a', 'z');       // char
```

---


# Quiz 2

### Question 2-15
[Covers: function templates, class templates, multiple parameters, template specialization, non-type parameters, generic array/storage examples, barangay applications]

**Key Concepts:**
1. Templates = generic programming
2. Write once, use for any type
3. Function and class templates
4. Specialization for custom types
5. Compile-time code generation

---

**Score yourself:**
- 15/15: Template Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review class templates
- Below 9: Re-read template concepts
