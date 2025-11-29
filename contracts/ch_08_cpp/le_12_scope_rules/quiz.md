# Quiz: Lesson 12 - Scope Rules and Lifetime of Variables

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
Where can a local variable be accessed?

A) Anywhere in the program  
B) Only inside its function or block  
C) Only in main()  
D) Only after it's declared globally

**Answer: B) Only inside its function or block**

**Explanation:**
Local variables have **local scope** — they exist only within the `{ }` where they're declared.

```cpp
void example() {
    int x = 10;  // Local to example()
    cout << x;   // ✓ OK here
}

int main() {
    // cout << x;  // ❌ ERROR: x doesn't exist here
    return 0;
}
```

---

### Question 2
What's the output?
```cpp
int count = 5;  // Global

void display() {
    int count = 10;  // Local
    cout << count;
}

int main() {
    display();
    return 0;
}
```

A) `5`  
B) `10`  
C) Compilation error  
D) `15`

**Answer: B) `10`**

**Explanation:**
The local variable `count` **shadows** (hides) the global one inside the function. The function prints the local value.

---

### Question 3
How long does a local variable exist?

A) Until the program ends  
B) Until its block `{ }` ends  
C) Forever  
D) Until main() ends

**Answer: B) Until its block `{ }` ends**

**Explanation:**
Local variables are **destroyed** when execution leaves their block.

```cpp
void test() {
    int x = 5;
    if (x > 0) {
        int y = 10;  // Created here
    }  // y is destroyed here
    // cout << y;  // ❌ ERROR: y no longer exists
}
```

---

### Question 4
What does `static` do to a local variable?

A) Makes it global  
B) Makes it constant  
C) Keeps its value between function calls  
D) Deletes it immediately

**Answer: C) Keeps its value between function calls**

**Explanation:**
`static` local variables are initialized **once** and retain their value across function calls.

```cpp
void counter() {
    static int count = 0;  // Initialized only once
    count++;
    cout << count << endl;
}

int main() {
    counter();  // 1
    counter();  // 2
    counter();  // 3
    return 0;
}
```

---

### Question 5
What's the output?
```cpp
void test() {
    static int x = 5;
    x += 2;
    cout << x << " ";
}

int main() {
    test();
    test();
    test();
    return 0;
}
```

A) `5 5 5`  
B) `7 7 7`  
C) `7 9 11`  
D) `5 7 9`

**Answer: C) `7 9 11`**

**Explanation:**
- First call: `x = 5`, then `x += 2` → `7`
- Second call: `x` is still `7` (static), then `x += 2` → `9`
- Third call: `x` is still `9`, then `x += 2` → `11`

Static variables remember their value!

---


# Quiz 2

### Question 6
How do you access a global variable that's shadowed by a local one?

A) Use `global.variableName`  
B) Use `::variableName`  
C) Cannot access it  
D) Use `&variableName`

**Answer: B) Use `::variableName`**

**Explanation:**
The **scope resolution operator** `::` accesses the global variable.

```cpp
int value = 100;  // Global

void test() {
    int value = 50;  // Local (shadows global)
    
    cout << value << endl;    // 50 (local)
    cout << ::value << endl;  // 100 (global)
}
```

---




### Question 7
Which variable type exists for the entire program duration?

A) Local variables  
B) Block variables  
C) Global and static variables  
D) Loop variables

**Answer: C) Global and static variables**

**Explanation:**
- **Global variables:** Created at program start, destroyed at program end
- **Static local variables:** Also exist for the entire program, but only accessible in their function
- **Local variables:** Created/destroyed with their block

---

### Question 8
What's the scope of variable `i`?
```cpp
for (int i = 0; i < 5; i++) {
    cout << i;
}
// cout << i;  // What happens here?
```

A) Global scope  
B) Loop scope only  
C) Function scope  
D) File scope

**Answer: B) Loop scope only**

**Explanation:**
Variables declared in a `for` loop exist **only** within that loop.

```cpp
for (int i = 0; i < 5; i++) {
    // i exists here
}
// i doesn't exist here - ERROR

for (int i = 10; i > 0; i--) {
    // This is a DIFFERENT i - OK!
}
```

---

### Question 9
Which is a best practice?

A) Use global variables for everything  
B) Prefer local variables  
C) Never use static variables  
D) Avoid function parameters

**Answer: B) Prefer local variables**

**Explanation:**
Local variables are safer and easier to debug. Global variables can be modified anywhere, making bugs hard to track.

**Good:**
```cpp
void calculate() {
    int fee = 50;  // Local - clear and safe
}
```

**Risky:**
```cpp
int fee = 50;  // Global - any function can change this!
void calculate() {
    fee += 10;  // Side effect - harder to debug
}
```

---


# Quiz 1

### Question 10
A barangay system needs to generate unique IDs that increment. Which implementation is best?

```cpp
// Option A
int idCounter = 1000;  // Global
int generateID() {
    return idCounter++;
}

// Option B
int generateID() {
    int idCounter = 1000;  // Local
    return idCounter++;
}

// Option C
int generateID() {
    static int idCounter = 1000;  // Static local
    return idCounter++;
}
```

A) Option A  
B) Option B  
C) Option C  
D) All are equivalent

**Answer: C) Option C**

**Explanation:**
- **Option A:** Works but uses global variable (not ideal — can be modified anywhere)
- **Option B:** Wrong! Resets to 1000 every call. Always returns 1000.
- **Option C:** Perfect! ✓ Static keeps value between calls, but stays encapsulated in the function.

```cpp
// Option C usage:
cout << generateID() << endl;  // 1000
cout << generateID() << endl;  // 1001
cout << generateID() << endl;  // 1002
```

**Why C is best:**
- Counter persists (static)
- Encapsulated (not global)
- Can't be accidentally modified outside function

---

**Score yourself:**
- 10/10: Scope Master! 🎯
- 8-9: Excellent understanding!
- 6-7: Good, review static and shadowing
- Below 6: Re-read scope and lifetime concepts

**Key Concepts:**
1. Local scope = inside block `{ }`
2. Global scope = entire file
3. Static = persists between calls
4. Shadowing = local hides global
5. Lifetime ≠ Scope
6. Prefer local over global
