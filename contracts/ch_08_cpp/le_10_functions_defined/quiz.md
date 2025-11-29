# Quiz: Lesson 10 - Functions Defined

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What does `void` mean in a function declaration?

A) The function is empty  
B) The function returns nothing  
C) The function has no parameters  
D) The function is invalid

**Answer: B) The function returns nothing**

**Explanation:**
```cpp
void greet() {
    cout << "Hello!";
    // No return statement needed
}
```
`void` indicates the function performs an action but doesn't return a value to the caller.

---

### Question 2
What is the output?
```cpp
int multiply(int a, int b) {
    return a * b;
}

int main() {
    int result = multiply(4, 5);
    cout << result;
    return 0;
}
```

A) `4`  
B) `5`  
C) `20`  
D) `9`

**Answer: C) `20`**

**Explanation:**
The function multiplies 4 × 5 and returns 20, which is stored in `result` and printed.

---

### Question 3
How many times is the function called?
```cpp
void display() {
    cout << "X";
}

int main() {
    for (int i = 0; i < 3; i++) {
        display();
    }
    return 0;
}
```

A) 0 times  
B) 1 time  
C) 3 times  
D) Infinite times

**Answer: C) 3 times**

**Explanation:**
The loop runs 3 iterations, calling `display()` each time. Output: `XXX`

---

### Question 4
What is wrong with this code?
```cpp
int main() {
    int x = calculate(5);
    cout << x;
    return 0;
}

int calculate(int num) {
    return num * 2;
}
```

A) Nothing wrong  
B) Function called before declaration  
C) Missing return type  
D) Wrong parameter type

**Answer: B) Function called before declaration**

**Explanation:**
C++ reads top-to-bottom. When `main()` tries to call `calculate()`, the compiler doesn't know it exists yet.

**Fix with forward declaration:**
```cpp
int calculate(int num);  // Forward declaration

int main() {
    int x = calculate(5);
    cout << x;
    return 0;
}

int calculate(int num) {
    return num * 2;
}
```

---

### Question 5
What does this function return?
```cpp
bool isAdult(int age) {
    return age >= 18;
}
```

A) The age value  
B) `true` if age ≥ 18, `false` otherwise  
C) Always `true`  
D) Always `false`

**Answer: B) `true` if age ≥ 18, `false` otherwise**

**Explanation:**
The expression `age >= 18` evaluates to a boolean:
- If age is 18 or more: returns `true`
- If age is less than 18: returns `false`

---


# Quiz 2

### Question 6
How many parameters does this function have?
```cpp
void displayInfo(string name, int age, bool isResident) {
    cout << name << ", " << age;
}
```

A) 0  
B) 1  
C) 2  
D) 3

**Answer: D) 3**

**Explanation:**
Parameters are: `string name`, `int age`, `bool isResident` - total of 3 parameters.

---




### Question 7
What is function overloading?

A) Making functions run slower  
B) Having multiple functions with same name but different parameters  
C) Calling a function too many times  
D) A compilation error

**Answer: B) Having multiple functions with same name but different parameters**

**Explanation:**
```cpp
int add(int a, int b) { return a + b; }
double add(double a, double b) { return a + b; }

// Compiler chooses based on argument types
add(5, 3);      // Calls int version
add(5.5, 3.2);  // Calls double version
```

---

### Question 8
What's the output?
```cpp
int getValue() {
    return 10;
}

int main() {
    cout << getValue() + getValue();
    return 0;
}
```

A) `10`  
B) `1010`  
C) `20`  
D) Compilation error

**Answer: C) `20`**

**Explanation:**
Each `getValue()` call returns 10, so `10 + 10 = 20`.

---

### Question 9
Which is the best function name?

A) `x()`  
B) `doStuff()`  
C) `calculateTotalPrice()`  
D) `function1()`

**Answer: C) `calculateTotalPrice()`**

**Explanation:**
Good function names are:
- Descriptive (tells what it does)
- Use verbs (action words)
- Meaningful and specific

`calculateTotalPrice()` clearly describes its purpose.

---


# Quiz 1

### Question 10
What's a good reason to use functions?

A) To make code longer  
B) To organize code into reusable, manageable pieces  
C) Because it's required  
D) To slow down the program

**Answer: B) To organize code into reusable, manageable pieces**

**Explanation:**
Functions provide:
- **Organization** - Break complex code into logical parts
- **Reusability** - Write once, use many times
- **Readability** - Easier to understand
- **Maintenance** - Fix bugs in one place
- **Testing** - Test each function independently

---

**Score yourself:**
- 10/10: Function Master! 🏆
- 8-9: Great understanding!
- 6-7: Good, review function syntax
- Below 6: Re-read the lesson

**Key Concepts:**
1. Functions organize code into reusable blocks
2. `void` = no return value
3. Parameters pass data IN
4. Return statements send data OUT
5. Forward declarations solve ordering issues
6. Function overloading = same name, different parameters
