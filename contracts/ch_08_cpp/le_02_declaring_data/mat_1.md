# Declaring Data

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+2.0+-+COVER.png)

## Scene

Tian tried to build a simple game score tracker but the score disappeared after each run. "Kuya, how do programs remember information?" Tian asked. "In JavaScript, I just wrote `let score = 100` and it worked!"

Kuya Miguel pulled up a chair. "C++ is strict about what kind of data you store. Is that score a whole number? A decimal? Text? You're not just storing data -- you're allocating specific memory spaces with specific types."

"Think of it like warehouse management," Kuya Miguel continued. "Shoes go in the shoe section, electronics in the electronics section. C++ variables work the same way. This strictness is what makes C++ fast and prevents costly errors!"

## C++ Topics: Variables and Data Types

![2.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+2.1.png)

### `int`

> Stores whole numbers (no decimals). Uses 4 bytes. Example: `int age = 16;`

### `double`

> Stores decimal numbers with high precision (~15 digits). Uses 8 bytes. Example: `double gpa = 91.5;`

### `char`

> Stores a single character using single quotes. Uses 1 byte. Example: `char grade = 'A';`

### `bool`

> Stores `true` or `false`. Uses 1 byte. Example: `bool isStudent = true;`

### `string`

> Stores text using double quotes. Requires `#include <string>`. Example: `string name = "Tian";`

### Constants

> Use `const` to create variables that cannot change after initialization. Convention is UPPERCASE: `const int MAX_STUDENTS = 50;`

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string fullName = "Tian Reyes";
    int age = 16;
    double gpa = 91.5;

    cout << "Name: " << fullName << endl;
    cout << "Age: " << age << endl;
    cout << "GPA: " << gpa << endl;
    return 0;
}
```

This program declares variables of different types -- a `string` for text, an `int` for a whole number, and a `double` for a decimal. Each variable must have its type declared before use. The `cout` statement chains values together with `<<` to display them.

## Common Pitfalls ⚠️

**1. Using a variable before initializing it**

```cpp
int age;
cout << age;   // ❌ undefined value — garbage
int age = 16;  // ✅ initialize when you declare
```

**2. Integer division surprises**

```cpp
int avg = 7 / 2;       // ❌ 3 (decimals truncated)
double avg = 7 / 2.0;  // ✅ 3.5 (one operand is a double)
```

**3. Picking the wrong type**

```cpp
int gpa = 91.5;     // ❌ becomes 91 — int can't hold decimals
double gpa = 91.5;  // ✅
```

**4. Overflowing a small type**

```cpp
int big = 3000000000;   // ❌ overflows 32-bit int
long long big = 3000000000;  // ✅ use a wider type
```

**5. Modern C++ tip: prefer `auto` when the type is obvious**

```cpp
auto name = string("Tian");  // ✅ compiler infers the type
auto pi = 3.14;              // double
```
