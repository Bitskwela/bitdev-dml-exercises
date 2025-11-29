# Quiz: Lesson 11 - Parameters and Return Values

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What happens when you pass by value?

A) Function gets the original variable  
B) Function gets a copy of the variable  
C) Variable is deleted  
D) Compilation error

**Answer: B) Function gets a copy of the variable**

**Explanation:**
Pass by value means the function receives a **copy**. Changes to the copy don't affect the original.

```cpp
void change(int x) {
    x = 100;  // Only changes the copy
}

int main() {
    int num = 50;
    change(num);
    cout << num;  // Still 50
}
```

---

### Question 2
What's the output?
```cpp
void modify(int& x) {
    x = 20;
}

int main() {
    int num = 10;
    modify(num);
    cout << num;
    return 0;
}
```

A) `10`  
B) `20`  
C) Compilation error  
D) `0`

**Answer: B) `20`**

**Explanation:**
The `&` makes it pass by reference. The function works with the original variable, so changes affect it.

---

### Question 3
Which is correct for passing large data efficiently without modification?

A) `void func(string s)`  
B) `void func(string& s)`  
C) `void func(const string& s)`  
D) `void func(string* s)`

**Answer: C) `void func(const string& s)`**

**Explanation:**
- `const` prevents modification (safe)
- `&` avoids copying (efficient)
- Best of both worlds!

```cpp
void display(const string& text) {
    cout << text;  // Can read
    // text = "x";  // ERROR: Cannot modify
}
```

---

### Question 4
What does this function return?
```cpp
double calculate(int a, int b) {
    return a / b;
}
```

A) An integer  
B) A double  
C) Nothing  
D) A boolean

**Answer: B) A double**

**Explanation:**
The return type is `double`, so the function returns a double value. Note: `a / b` is integer division, but it's converted to double when returned.

---

### Question 5
How many values does this function "return"?
```cpp
void getMinMax(int arr[], int size, int& min, int& max) {
    // Sets min and max
}
```

A) 0 (void returns nothing)  
B) 1  
C) 2 (via reference parameters)  
D) 4

**Answer: C) 2 (via reference parameters)**

**Explanation:**
While the function is `void`, it effectively "returns" 2 values by modifying the reference parameters `min` and `max`.

```cpp
int minimum, maximum;
getMinMax(numbers, 5, minimum, maximum);
// Now minimum and maximum have values
```

---


# Quiz 2

### Question 6
What's wrong with this code?
```cpp
void process(const int& value) {
    value = 100;
}
```

A) Nothing wrong  
B) Cannot modify const reference  
C) Missing return statement  
D) Wrong parameter type

**Answer: B) Cannot modify const reference**

**Explanation:**
`const` means the value cannot be changed. The compiler will give an error.

**Fix:**
```cpp
// Option 1: Remove const
void process(int& value) {
    value = 100;
}

// Option 2: Keep const (read-only)
void process(const int& value) {
    cout << value;  // Only read
}
```

---




### Question 7
Which statement about arrays as parameters is TRUE?

A) Arrays are always passed by value  
B) Arrays are always passed by reference  
C) You must use & with arrays  
D) Arrays cannot be function parameters

**Answer: B) Arrays are always passed by reference**

**Explanation:**
Arrays are automatically passed by reference (technically as pointers). Changes in the function affect the original array.

```cpp
void modify(int arr[], int size) {
    arr[0] = 999;  // Modifies original array
}
```

---

### Question 8
What's the output?
```cpp
int square(int n) {
    return n * n;
}

int main() {
    cout << square(4) + square(3);
    return 0;
}
```

A) `7`  
B) `12`  
C) `25`  
D) `49`

**Answer: C) `25`**

**Explanation:**
- `square(4)` returns 16
- `square(3)` returns 9
- `16 + 9 = 25`

---

### Question 9
Which default parameter usage is CORRECT?

A) `void func(int a = 1, int b)`  
B) `void func(int a, int b = 1)`  
C) `void func(int a = 1, int b = 2, int c)`  
D) All are correct

**Answer: B) `void func(int a, int b = 1)`**

**Explanation:**
Default parameters must be **rightmost**. You can't have a required parameter after a default one.

```cpp
// ✓ CORRECT
void func(int a, int b = 1, int c = 2) { }

// ❌ WRONG
void func(int a = 1, int b) { }
```

---


# Quiz 1

### Question 10
A barangay system needs to update resident balance and return success status. Which is best?

```cpp
// Option A
bool updateBalance(double balance, double amount) {
    if (balance >= amount) {
        balance -= amount;
        return true;
    }
    return false;
}

// Option B
bool updateBalance(double& balance, double amount) {
    if (balance >= amount) {
        balance -= amount;
        return true;
    }
    return false;
}

// Option C
void updateBalance(double& balance, double amount) {
    balance -= amount;
}
```

A) Option A  
B) Option B  
C) Option C  
D) All are equivalent

**Answer: B) Option B**

**Explanation:**
- **Option A**: Wrong! Pass by value means `balance` is just a copy. Original won't change.
- **Option B**: Correct! ✓ Pass by reference updates original balance AND returns success status.
- **Option C**: No validation, no error checking.

```cpp
// Option B usage:
double myBalance = 1000.0;
if (updateBalance(myBalance, 500)) {
    cout << "Success! New balance: " << myBalance;  // 500
} else {
    cout << "Insufficient funds!";
}
```

---

**Score yourself:**
- 10/10: Parameter Master! 🏆
- 8-9: Excellent grasp!
- 6-7: Good, review references
- Below 6: Re-read pass by value vs reference

**Key Concepts:**
1. Pass by value = copy
2. Pass by reference (`&`) = original
3. `const&` = efficient + safe for read-only
4. Arrays always passed by reference
5. Default parameters must be rightmost
6. Multiple returns via reference parameters
