# Quiz: Lesson 15 - Strings

**Instructions:** Choose the best answer for each question.

---


# Quiz 1

### Question 1
What's the difference between C-strings and C++ `string`?

A) No difference  
B) C++ `string` is safer and has more features  
C) C-strings are better  
D) C++ strings can't store text

**Answer: B) C++ `string` is safer and has more features**

**Explanation:**

**C-style strings:**
- Fixed size arrays: `char name[20];`
- Manual null terminator management
- Risk of buffer overflow
- Manual functions: `strcpy`, `strlen`, `strcmp`

**C++ `string` class:**
- Dynamic size (grows/shrinks automatically)
- No null terminator worries
- Safer (no buffer overflow)
- Built-in functions: `.length()`, `.find()`, `.substr()`
- Can use `==` for comparison

```cpp
// C-style (old)
char name[20];
strcpy(name, "Juan");

// C++ style (modern) ✓
string name = "Juan";
```

---

### Question 2
How do you read a full line with spaces?

A) `cin >> text;`  
B) `getline(cin, text);`  
C) `cin.getline(text);`  
D) `scan(text);`

**Answer: B) `getline(cin, text);`**

**Explanation:**
```cpp
string address;

// ❌ WRONG - stops at first space
cin >> address;  // Input: "123 Main St" → reads only "123"

// ✓ CORRECT - reads entire line
getline(cin, address);  // Reads "123 Main St"
```

---

### Question 3
What's the output?
```cpp
string name = "Juan";
cout << name.length();
```

A) `3`  
B) `4`  
C) `5`  
D) `Juan`

**Answer: B) `4`**

**Explanation:**
`.length()` returns the number of characters (not counting null terminator for C++ strings).

```cpp
"Juan" has 4 characters: J-u-a-n
```

---

### Question 4
What's wrong with this code?
```cpp
int age;
string name;

cin >> age;
getline(cin, name);
```

A) Nothing wrong  
B) Need `cin.ignore()` after `cin >> age`  
C) Should use `cin >> name`  
D) Wrong order

**Answer: B) Need `cin.ignore()` after `cin >> age`**

**Explanation:**
`cin >> age` leaves a **newline character** in the buffer. `getline()` immediately reads that newline, resulting in an empty string.

**Fix:**
```cpp
cin >> age;
cin.ignore();  // Clear the leftover newline
getline(cin, name);
```

---

### Question 5
How do you concatenate strings?

```cpp
string first = "Juan";
string last = "Cruz";
// Combine them?
```

A) `string full = first + last;`  
B) `string full = first . last;`  
C) `string full = concat(first, last);`  
D) Cannot concatenate

**Answer: A) `string full = first + last;`**

**Explanation:**
```cpp
string first = "Juan";
string last = "Cruz";

string full = first + " " + last;  // "Juan Cruz"
cout << full;

// Or append:
first += " " + last;  // first is now "Juan Cruz"
```

---


# Quiz 2

### Question 6
What does `.substr(5, 3)` do?

```cpp
string text = "Barangay Clearance";
cout << text.substr(5, 3);
```

A) Gets 5 characters starting at position 3  
B) Gets 3 characters starting at position 5  
C) Gets characters 5 to 3  
D) Error

**Answer: B) Gets 3 characters starting at position 5**

**Explanation:**
`.substr(start, length)` — extract `length` characters starting at `start`.

```cpp
string text = "Barangay Clearance";
//  Index:     0123456789...

cout << text.substr(5, 3);  // "gay" (positions 5, 6, 7)
cout << text.substr(9, 9);  // "Clearance"
```

---




### Question 7
How do you compare strings?

```cpp
string password = "secret";
string input = "secret";

// Check if equal?
```

A) `if (password == input)`  
B) `if (strcmp(password, input))`  
C) `if (password.equals(input))`  
D) Cannot compare

**Answer: A) `if (password == input)`**

**Explanation:**
C++ `string` class overloads comparison operators.

```cpp
string a = "apple";
string b = "banana";

if (a == b) { }  // Equality
if (a < b) { }   // Lexicographic comparison
if (a != b) { }  // Inequality
```

**Note:** For C-strings, use `strcmp()`:
```cpp
char password[] = "secret";
if (strcmp(password, input) == 0) { }  // Equal
```

---

### Question 8
What's the output?
```cpp
string text = "Hello World";
text.replace(6, 5, "C++");
cout << text;
```

A) `"Hello World"`  
B) `"Hello C++"`  
C) `"C++ World"`  
D) Error

**Answer: B) `"Hello C++"`**

**Explanation:**
`.replace(start, length, newString)` — replaces `length` characters starting at `start` with `newString`.

```cpp
"Hello World"
// Starting at position 6, replace 5 characters ("World") with "C++"
// Result: "Hello C++"
```

---

### Question 9
What does `.find()` return if not found?

```cpp
string text = "Juan Dela Cruz";
int pos = text.find("Pedro");
// What's in pos?
```

A) `-1`  
B) `0`  
C) `string::npos`  
D) `NULL`

**Answer: C) `string::npos`**

**Explanation:**
```cpp
string text = "Juan Dela Cruz";

int pos = text.find("Dela");
if (pos != string::npos) {
    cout << "Found at position " << pos;  // 5
} else {
    cout << "Not found";
}

pos = text.find("Pedro");
if (pos == string::npos) {
    cout << "Pedro not found";  // This runs
}
```

`string::npos` is a special constant meaning "not found" (usually the largest possible size_t value).

---


# Quiz 1

### Question 10
A barangay system needs to format resident names (handle all caps, all lowercase, mixed case) consistently. Which approach is best?

```cpp
// Option A: Use as-is
string name;
getline(cin, name);
cout << name;  // Whatever user typed

// Option B: Convert to uppercase
transform(name.begin(), name.end(), name.begin(), ::toupper);
// "JUAN DELA CRUZ"

// Option C: Title Case (capitalize first letter of each word)
transform(name.begin(), name.end(), name.begin(), ::tolower);
name[0] = toupper(name[0]);
for (int i = 1; i < name.length(); i++) {
    if (name[i-1] == ' ') {
        name[i] = toupper(name[i]);
    }
}
// "Juan Dela Cruz"
```

A) Option A (as-is)  
B) Option B (all uppercase)  
C) Option C (title case)  
D) All are equivalent

**Answer: C) Option C (title case)**

**Explanation:**
- **Option A:** Inconsistent! Users might type "jUaN", "JUAN", "juan" — hard to search/sort
- **Option B:** Works, but ALL CAPS looks unprofessional
- **Option C:** ✓ Professional formatting! "Juan Dela Cruz" regardless of input

```cpp
// Input: "jUaN dElA cRuZ"
// Output: "Juan Dela Cruz"

// Input: "MARIA SANTOS"
// Output: "Maria Santos"

// Input: "pedro reyes"
// Output: "Pedro Reyes"
```

**Benefits:**
- Consistent database storage
- Professional appearance
- Easier searching (normalize before comparing)

---

**Score yourself:**
- 10/10: String Master! 🎯
- 8-9: Excellent!
- 6-7: Good, review getline and string functions
- Below 6: Re-read string basics

**Key Concepts:**
1. Prefer C++ `string` over C-strings
2. Use `getline()` for full lines
3. Remember `cin.ignore()` after `cin >>`
4. String concatenation: `+` operator
5. `.substr(start, length)` extracts substring
6. `.find()` returns `string::npos` if not found
7. Comparison: `==`, `<`, `>` work directly
