# Quiz: Lesson 29 - Exception Handling

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

## Section 1: Exception Basics

### Question 1
What is exception handling used for?

A) Speed optimization  
B) Handling runtime errors gracefully  
C) Debugging  
D) Memory management

**Answer: B) Handling runtime errors gracefully**

**Explanation:**
```cpp
try {
    if (error) throw "Error!";
}
catch (const char* e) {
    cout << e;  // Handle error, program continues
}
```

---


# Quiz 2

### Question 2-15
[Covers: try-catch-throw, multiple catch blocks, standard exceptions, custom exceptions, RAII, exception safety, barangay dues system with validation]

**Key Concepts:**
1. Exceptions handle runtime errors
2. try-catch-throw mechanism
3. Standard exception classes
4. Custom exceptions for specific errors
5. RAII ensures cleanup

---

**Score yourself:**
- 15/15: Exception Master! 🏆
- 12-14: Excellent!
- 9-11: Good, review custom exceptions
- Below 9: Re-read exception handling
