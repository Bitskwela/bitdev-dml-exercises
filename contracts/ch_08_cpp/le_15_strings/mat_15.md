## Background Story

Tian tried to store resident names using integer arrays and hit a wall. Numbers couldn't represent text. Storing each character as a separate variable was ridiculous. How could programs handle text data?

"Kuya, I can store ages, balances, and counts easily," Tian said, frustrated, "but the moment I need to store a name, address, or message, I'm stuck. Every real application needs to work with text—usernames, messages, file names, error messages. How do I handle text in C++?"

Kuya Miguel nodded. "You've hit a fundamental question: how does a computer, which only understands numbers, represent text? The answer is **strings**—sequences of characters encoded as numbers, with tools to manipulate them as text."

"C++ gives you two approaches," Kuya Miguel explained. "C-style strings, which are raw character arrays—low-level, fast, but dangerous and tedious. And modern C++ strings, which are high-level objects with built-in methods for manipulation—safer, easier, more powerful. It's like comparing a manual transmission to an automatic. Both get you there, but one is easier for everyday use."

"Every search engine, every chat app, every database system relies on string manipulation. Let's master text handling in C++!"

---

## Theory & Lecture Content

## C-Style Strings (Character Arrays)

A **C-string** is an array of characters ending with a **null terminator** `'\0'`.

```cpp
char name[6] = {'J', 'u', 'a', 'n', '\0'};
//  Index:       0    1    2    3    4     5
```

**Simpler syntax:**
```cpp
char name[] = "Juan";  // Automatically adds '\0'
```

**The null terminator `'\0'`:**
- Marks the end of the string
- Has ASCII value 0
- Automatically added when using `"quotes"`

```cpp
char greeting[] = "Hello";
// Stored as: {'H', 'e', 'l', 'l', 'o', '\0'}
// Length: 5, but array size: 6
```

---

## The `string` Class (Modern C++)

The `string` class is easier and safer:

```cpp
#include <string>
using namespace std;

string name = "Juan Dela Cruz";
string address = "123 Maharlika St.";
```

**Advantages:**
- No need to manage null terminators
- Dynamic size (grows/shrinks automatically)
- Many built-in functions
- Safer (no buffer overflows)

---

## Declaring and Initializing Strings

### C-Style Strings
```cpp
char name1[20] = "Juan";           // Fixed size 20
char name2[] = "Maria";            // Size determined automatically
char name3[10];                    // Uninitialized
strcpy(name3, "Pedro");            // Assign later (requires <cstring>)
```

### C++ Strings
```cpp
string name1 = "Juan";             // Direct assignment
string name2("Maria");             // Constructor syntax
string name3;                      // Empty string
name3 = "Pedro";                   // Assign later (no special function needed)
```

---

## Input and Output

### C++ Strings

**Single word:**
```cpp
string name;
cout << "Enter name: ";
cin >> name;  // Stops at whitespace
cout << "Hello, " << name;
```

**Full line (with spaces):**
```cpp
string address;
cout << "Enter address: ";
cin.ignore();  // Clear input buffer
getline(cin, address);  // Reads entire line
cout << "Address: " << address;
```

### C-Style Strings

```cpp
char name[50];
cout << "Enter name: ";
cin >> name;  // Single word only

// For full line:
cin.getline(name, 50);  // Reads up to 49 chars + '\0'
```

---

## String Length

### C++ Strings
```cpp
string name = "Juan Dela Cruz";
cout << name.length();  // 14
// or
cout << name.size();    // 14 (same as length())
```

### C-Style Strings
```cpp
#include <cstring>

char name[] = "Juan";
cout << strlen(name);  // 4 (does not count '\0')
```

---

## Accessing Characters

### C++ Strings
```cpp
string name = "Juan";
cout << name[0];  // 'J'
cout << name[3];  // 'n'

name[0] = 'R';    // Modify
cout << name;     // "Ruan"
```

### Using `.at()` (Safer)
```cpp
string name = "Juan";
cout << name.at(0);  // 'J'
// name.at(10);      // Throws exception if out of bounds
```

---

## String Concatenation

### C++ Strings
```cpp
string first = "Juan";
string last = "Dela Cruz";

string full = first + " " + last;  // "Juan Dela Cruz"
cout << full;

// Append
first += " Pedro";  // "Juan Pedro"
```

### C-Style Strings
```cpp
#include <cstring>

char first[20] = "Juan";
char last[] = "Dela Cruz";
char full[50];

strcpy(full, first);     // Copy "Juan" to full
strcat(full, " ");       // Append " "
strcat(full, last);      // Append "Dela Cruz"
cout << full;            // "Juan Dela Cruz"
```

---

## String Comparison

### C++ Strings
```cpp
string password = "secret";
string input;

cout << "Enter password: ";
cin >> input;

if (input == password) {
    cout << "Access granted!";
} else {
    cout << "Access denied!";
}
```

**Comparison operators work naturally:**
```cpp
string a = "apple";
string b = "banana";

if (a < b) {  // Lexicographic comparison
    cout << "apple comes before banana";
}
```

### C-Style Strings
```cpp
#include <cstring>

char password[] = "secret";
char input[20];

cin >> input;

if (strcmp(password, input) == 0) {  // Returns 0 if equal
    cout << "Access granted!";
} else {
    cout << "Access denied!";
}
```

**`strcmp()` returns:**
- `0` if strings are equal
- Negative if first < second
- Positive if first > second

---

## Common String Functions (C++ `string`)

### `.length()` / `.size()`
```cpp
string text = "Hello";
cout << text.length();  // 5
```

### `.substr(start, length)`
```cpp
string text = "Barangay Clearance";
cout << text.substr(0, 8);  // "Barangay"
cout << text.substr(9, 9);  // "Clearance"
```

### `.find(substring)`
```cpp
string text = "Juan Dela Cruz";
int pos = text.find("Dela");
if (pos != string::npos) {
    cout << "Found at position " << pos;  // 5
} else {
    cout << "Not found";
}
```

### `.replace(start, length, newString)`
```cpp
string text = "Hello World";
text.replace(6, 5, "C++");
cout << text;  // "Hello C++"
```

### `.insert(position, substring)`
```cpp
string text = "Juan Cruz";
text.insert(5, "Dela ");
cout << text;  // "Juan Dela Cruz"
```

### `.erase(start, length)`
```cpp
string text = "Juan Pedro Cruz";
text.erase(5, 6);  // Remove "Pedro "
cout << text;      // "Juan Cruz"
```

### `.clear()`
```cpp
string text = "Hello";
text.clear();
cout << text.length();  // 0
```

---

## Converting Case

```cpp
#include <algorithm>
#include <string>

string text = "hello";

// To uppercase
transform(text.begin(), text.end(), text.begin(), ::toupper);
cout << text;  // "HELLO"

// To lowercase
transform(text.begin(), text.end(), text.begin(), ::tolower);
cout << text;  // "hello"
```

---

## Practical Example: Barangay Name Formatter

```cpp
#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

string formatName(string name) {
    // Convert to lowercase first
    transform(name.begin(), name.end(), name.begin(), ::tolower);
    
    // Capitalize first letter
    if (!name.empty()) {
        name[0] = toupper(name[0]);
    }
    
    // Capitalize after spaces
    for (int i = 1; i < name.length(); i++) {
        if (name[i - 1] == ' ') {
            name[i] = toupper(name[i]);
        }
    }
    
    return name;
}

int main() {
    string name;
    
    cout << "Enter resident name: ";
    getline(cin, name);
    
    string formatted = formatName(name);
    
    cout << "\n===== BARANGAY CLEARANCE =====\n";
    cout << "Name: " << formatted << endl;
    cout << "==============================\n";
    
    return 0;
}
```

**Sample Run:**
```
Enter resident name: jUaN dElA cRuZ

===== BARANGAY CLEARANCE =====
Name: Juan Dela Cruz
==============================
```

---

## String Arrays

### Array of C++ Strings
```cpp
const int SIZE = 3;
string names[SIZE] = {"Juan", "Maria", "Pedro"};

for (int i = 0; i < SIZE; i++) {
    cout << names[i] << endl;
}
```

### Input Multiple Strings
```cpp
const int NUM_RESIDENTS = 3;
string residents[NUM_RESIDENTS];

cout << "Enter " << NUM_RESIDENTS << " resident names:\n";
cin.ignore();
for (int i = 0; i < NUM_RESIDENTS; i++) {
    cout << "Resident " << (i + 1) << ": ";
    getline(cin, residents[i]);
}

cout << "\nResident list:\n";
for (int i = 0; i < NUM_RESIDENTS; i++) {
    cout << (i + 1) << ". " << residents[i] << endl;
}
```

---

## Searching in Strings

```cpp
string residents[5] = {"Juan", "Maria", "Pedro", "Ana", "Jose"};
string searchName;

cout << "Enter name to search: ";
cin >> searchName;

bool found = false;
for (int i = 0; i < 5; i++) {
    if (residents[i] == searchName) {
        cout << "Found " << searchName << " at position " << i << endl;
        found = true;
        break;
    }
}

if (!found) {
    cout << searchName << " not found" << endl;
}
```

---

## Character Classification

```cpp
#include <cctype>

char ch = 'A';

if (isalpha(ch)) cout << "Letter";
if (isdigit(ch)) cout << "Digit";
if (isspace(ch)) cout << "Whitespace";
if (isupper(ch)) cout << "Uppercase";
if (islower(ch)) cout << "Lowercase";
```

---

## Practical Example: Password Validator

```cpp
#include <iostream>
#include <string>
#include <cctype>
using namespace std;

bool isStrongPassword(string password) {
    if (password.length() < 8) {
        return false;  // Too short
    }
    
    bool hasUpper = false;
    bool hasLower = false;
    bool hasDigit = false;
    
    for (int i = 0; i < password.length(); i++) {
        if (isupper(password[i])) hasUpper = true;
        if (islower(password[i])) hasLower = true;
        if (isdigit(password[i])) hasDigit = true;
    }
    
    return hasUpper && hasLower && hasDigit;
}

int main() {
    string password;
    
    cout << "Create a password: ";
    cin >> password;
    
    if (isStrongPassword(password)) {
        cout << "Strong password! ✓" << endl;
    } else {
        cout << "Weak password. Requirements:\n";
        cout << "- At least 8 characters\n";
        cout << "- At least one uppercase letter\n";
        cout << "- At least one lowercase letter\n";
        cout << "- At least one digit\n";
    }
    
    return 0;
}
```

---

## Common Mistakes

### Mistake 1: Using `cin` for Strings with Spaces
```cpp
string name;
cin >> name;  // Only reads "Juan" from "Juan Dela Cruz"

// ✓ CORRECT
getline(cin, name);  // Reads full line
```

### Mistake 2: Forgetting `cin.ignore()`
```cpp
int age;
string name;

cin >> age;     // Leaves newline in buffer
getline(cin, name);  // Reads the leftover newline!

// ✓ CORRECT
cin >> age;
cin.ignore();   // Clear buffer
getline(cin, name);
```

### Mistake 3: C-String Buffer Overflow
```cpp
char name[5];
strcpy(name, "Juan Dela Cruz");  // ❌ DISASTER! Overflows buffer

// ✓ CORRECT: Use C++ strings (dynamic)
string name = "Juan Dela Cruz";
```

### Mistake 4: Comparing C-Strings with `==`
```cpp
char password[] = "secret";
char input[20];
cin >> input;

if (input == password) {  // ❌ WRONG! Compares addresses, not content
    // ...
}

// ✓ CORRECT
if (strcmp(input, password) == 0) {
    // ...
}
```

---

## Best Practices

1. **Prefer C++ `string` over C-strings**
```cpp
string name = "Juan";  // ✓ Safe, dynamic, easy
```

2. **Use `getline()` for input with spaces**
```cpp
getline(cin, address);  // ✓ Reads entire line
```

3. **Clear input buffer after `cin >>`**
```cpp
cin >> age;
cin.ignore();
getline(cin, name);
```

4. **Use `.at()` for bounds-checked access**
```cpp
char ch = name.at(0);  // ✓ Throws exception if out of bounds
```

---

## Challenge Exercises

1. **Name Reverser:**
   - Input: "Juan Dela Cruz"
   - Output: "Cruz Dela Juan"

2. **Vowel Counter:**
   - Count a, e, i, o, u in a string

3. **Palindrome Checker:**
   - Check if string reads same forwards/backwards
   - Example: "racecar" → palindrome

4. **Clearance Number Generator:**
   - Input: resident name
   - Generate: "CLR-" + first 3 letters + random number
   - Example: "Juan" → "CLR-JUA-1234"

---

## Summary

Tian typed various string operations. "Strings are just like arrays, but smarter!"

"Perfect analogy!" Kuya Miguel said. "Remember:
- **C++ `string`** — modern, safe, easy (use this!)
- **C-strings** — old-school, manual memory management
- Use `getline()` for input with spaces
- String operations: length, substr, find, replace
- Strings are **arrays of characters** with superpowers"

"Next," Kuya Miguel said with a grin, "we dive into **pointers** — the most powerful (and dangerous) weapon!"

---

**Key Takeaways:**
1. Prefer C++ `string` over C-strings
2. Use `getline()` for full-line input
3. Remember to `cin.ignore()` to clear buffer
4. Strings have many built-in functions (.length(), .find(), .substr(), etc.)
5. String comparison uses `==` (C++) or `strcmp()` (C-style)

---

## Closing Story

Tian's name formatter worked perfectly, converting "jUaN dElA cRuZ" into "Juan Dela Cruz". He experimented with substring extraction, searching, replacing characters. "Strings are amazing, Kuya! So much easier than managing character arrays manually."

"That's why modern C++ developers always use the string class," Kuya Miguel agreed. "C-strings with their null terminators and manual memory management? That's old-school and error-prone. Buffer overflows, forgotten null terminators, comparison nightmares. The string class handles all that for you."

Tian practiced getline for full names with spaces, remembering to cin.ignore to clear the buffer. "And strings grow automatically. No worrying about fixed sizes."

"Exactly! They're dynamic, safe, and packed with useful functions. Find, substr, replace, insert, erase. Everything you need for text processing. But remember: strings are still collections of characters. You can access individual characters just like arrays."

Tian nodded, feeling confident. "Arrays for numbers, strings for text. Two weapons mastered. What's next?"

Kuya Miguel's expression turned serious. "Pointers. The most powerful and dangerous weapon. With great power comes great responsibility."

**Next Lesson:** Pointers - Introduction to Memory Addresses
