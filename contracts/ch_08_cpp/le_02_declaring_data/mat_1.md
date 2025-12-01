## Background Story

Tian tried to build a simple game score tracker but hit a wall immediately. The program printed "Player Score:" but the score disappeared after each run. There was no way to remember anything.

"Kuya, how do programs remember information?" Tian asked, frustrated. "In JavaScript, I just wrote `let score = 100` and it worked. I tried the same in C++ and got errors everywhere!"

Kuya Miguel pulled up a chair. "That's because C++ is strict about what kind of data you're storing. Is that score a whole number? A decimal? Text? C++ makes you think like the computer's memory manager. You're not just storing data—you're allocating specific memory spaces with specific types."

"Think of it like warehouse management," Kuya Miguel continued. "You can't just throw items anywhere. Shoes go in the shoe section, electronics in the electronics section. C++ variables work the same way—each type has its place and purpose. This strictness might seem annoying now, but it's what makes C++ fast and prevents costly errors. Let's learn how to properly declare and manage data!"

---

## Theory & Lecture Content

## What are Variables?

### The Concept

A **variable** is a named storage location in computer memory that holds a value.

**Analogy:** Think of variables as labeled containers:
- A box labeled "age" can hold a number like 16
- A box labeled "name" can hold text like "Tian"
- A box labeled "isStudent" can hold true or false

**Key difference from JavaScript:**
```javascript
// JavaScript (loosely typed)
let age = 16;        // Number
age = "sixteen";     // Can change to string - OK!

// C++ (strongly typed)
int age = 16;        // Integer
age = "sixteen";     // ERROR! Can't change type
```

### Why Data Types Matter

**Memory efficiency:**
- `int` uses 4 bytes
- `char` uses 1 byte
- `double` uses 8 bytes

**Type safety:**
- Prevents errors (can't add a number to text accidentally)
- Compiler catches mistakes before running

**Performance:**
- Compiler optimizes based on types
- Faster execution

## Basic Data Types in C++

### 1. Integer Types (`int`)

**Purpose:** Store whole numbers (no decimals)

**Syntax:**
```cpp
int age = 16;
int score = 100;
int temperature = -5;
```

**Range:** -2,147,483,648 to 2,147,483,647 (4 bytes)

**Examples:**
```cpp
int students = 45;
int year = 2025;
int balance = -500;  // Negative numbers OK
```

**Use cases:**
- Counting items
- Ages
- Scores
- Years

### 2. Floating-Point Types (`float`, `double`)

**Purpose:** Store numbers with decimals

**`float` (single precision):**
```cpp
float price = 25.50;
float grade = 88.5;
```
- 4 bytes
- ~7 decimal digits precision
- Use `f` suffix: `float pi = 3.14f;`

**`double` (double precision):**
```cpp
double pi = 3.14159265359;
double salary = 35000.75;
```
- 8 bytes
- ~15 decimal digits precision
- More accurate than float

**Which to use?**
- **float:** When memory is limited or precision doesn't matter
- **double:** Default choice for most calculations (more accurate)

**Examples:**
```cpp
float jeepneyFare = 12.0f;
double gcashBalance = 5432.50;
double piApprox = 3.14159;
```

**Common mistake:**
```cpp
float price = 99.99;  // Warning: should be 99.99f
float price = 99.99f; // Correct
```

### 3. Character Type (`char`)

**Purpose:** Store a single character

**Syntax:**
```cpp
char grade = 'A';
char initial = 'T';
char symbol = '@';
```

**Important:** Use **single quotes** `' '` not double quotes `" "`

**Size:** 1 byte

**ASCII values:**
```cpp
char letter = 'A';  // Stored as 65 internally
char digit = '5';   // Stored as 53 (not the number 5!)
```

**Examples:**
```cpp
char firstLetter = 'T';
char bloodType = 'O';
char symbol = '#';
```

### 4. Boolean Type (`bool`)

**Purpose:** Store true or false values

**Syntax:**
```cpp
bool isStudent = true;
bool hasInternet = false;
bool isPassed = true;
```

**Size:** 1 byte (though only needs 1 bit)

**Use cases:**
- Flags (on/off states)
- Conditions
- Status checks

**Examples:**
```cpp
bool isLoggedIn = false;
bool hasDiscount = true;
bool isRaining = false;
```

**Note:** In C++, `0` is false, any non-zero value is true:
```cpp
bool test1 = 0;     // false
bool test2 = 1;     // true
bool test3 = 100;   // also true!
```

### 5. String Type (`string`)

**Purpose:** Store text (sequence of characters)

**Important:** Must include `<string>` library!

**Syntax:**
```cpp
#include <iostream>
#include <string>  // Required!
using namespace std;

int main() {
    string name = "Tian";
    string city = "Batangas";
    string message = "Kumusta!";
    return 0;
}
```

**Use double quotes** `" "` not single quotes

**Examples:**
```cpp
string fullName = "Tian Reyes";
string email = "tian@email.com";
string school = "Batangas National High School";
```

**String operations:**
```cpp
string firstName = "Tian";
string lastName = "Reyes";
string fullName = firstName + " " + lastName;  // "Tian Reyes"

string greeting = "Hello, " + firstName + "!";  // "Hello, Tian!"
```

## Data Type Summary Table

| Type | Size | Range | Example | Use Case |
|------|------|-------|---------|----------|
| `int` | 4 bytes | -2 billion to 2 billion | `int age = 16;` | Whole numbers |
| `float` | 4 bytes | ~7 digits precision | `float price = 25.5f;` | Decimals (less precise) |
| `double` | 8 bytes | ~15 digits precision | `double pi = 3.14159;` | Decimals (more precise) |
| `char` | 1 byte | Single character | `char grade = 'A';` | Single character |
| `bool` | 1 byte | true or false | `bool isActive = true;` | True/false values |
| `string` | Varies | Text | `string name = "Tian";` | Text/sentences |

## Variable Declaration and Initialization

### Declaration Only

**Syntax:** `type variableName;`

```cpp
int age;           // Declared but not initialized (contains garbage value)
float price;       // Don't do this! Always initialize
string name;       // Empty string
```

**Warning:** Uninitialized variables contain random values!

### Declaration + Initialization

**Syntax:** `type variableName = value;`

```cpp
int age = 16;              // Recommended: declare and initialize
float price = 99.99f;
string name = "Tian";
```

### Multiple Declarations

```cpp
// Same type, separate lines
int x = 10;
int y = 20;
int z = 30;

// Same type, one line
int a = 1, b = 2, c = 3;

// Mixed (not recommended for beginners)
int score = 100, lives = 3;
```

## Variable Naming Rules

### Rules (MUST Follow)

1. **Start with letter or underscore:** `age`, `_count`, `myVariable`
   - NOT digits: `2score` (INVALID)

2. **Use letters, digits, underscores only:** `score2`, `total_price`
   - NOT special characters: `price$`, `name@` (INVALID)

3. **Case-sensitive:** `age` and `Age` are different

4. **No keywords:** Can't use `int`, `return`, `for`, etc. as names

**Valid names:**
```cpp
int age;
int studentCount;
int total_score;
int _temporary;
```

**Invalid names:**
```cpp
int 2fast;      // Can't start with digit
int my-name;    // Can't use hyphen
int for;        // Reserved keyword
int student count; // No spaces
```

### Naming Conventions (Best Practices)

**camelCase** (recommended for variables):
```cpp
int studentAge = 16;
string firstName = "Tian";
double totalPrice = 199.99;
```

**snake_case** (also common):
```cpp
int student_age = 16;
string first_name = "Tian";
double total_price = 199.99;
```

**Meaningful names:**
```cpp
// Good
int studentCount = 45;
double averageScore = 87.5;

// Bad
int x = 45;  // What does x mean?
double a = 87.5;  // What is a?
```

## Constants (`const`)

**Purpose:** Variables that cannot be changed after initialization

**Syntax:**
```cpp
const int MAX_STUDENTS = 50;
const float PI = 3.14159f;
const string SCHOOL_NAME = "Batangas NHS";
```

**Convention:** Use UPPERCASE for constants

**Why use constants?**
- Prevent accidental changes
- Make code more readable
- Easier to maintain

**Example:**
```cpp
const int PASSING_GRADE = 75;
const float TAX_RATE = 0.12f;  // 12% VAT in Philippines

int yourGrade = 80;
if (yourGrade >= PASSING_GRADE) {
    cout << "Passed!" << endl;
}
```

**Error if you try to change:**
```cpp
const int MAX = 100;
MAX = 200;  // ERROR: assignment of read-only variable 'MAX'
```

## Type Conversion (Casting)

### Implicit Conversion (Automatic)

Compiler automatically converts compatible types:

```cpp
int x = 10;
double y = x;  // int → double (safe, no data loss)
cout << y;     // 10.0
```

**Widening conversion (safe):**
- `int` → `double`
- `float` → `double`
- `char` → `int`

### Explicit Conversion (Manual Casting)

You manually convert types:

```cpp
double price = 99.99;
int roundedPrice = (int)price;  // 99 (decimal part lost!)

// Alternative syntax
int rounded = int(price);
```

**Narrowing conversion (data loss possible):**
- `double` → `int` (decimals lost)
- `int` → `char` (if value > 255, overflow)

**Examples:**
```cpp
// double to int
double score = 88.7;
int finalScore = (int)score;  // 88

// int to char
int asciiValue = 65;
char letter = (char)asciiValue;  // 'A'

// float to int
float average = 87.5f;
int rounded = (int)average;  // 87
```

**Warning: Precision loss**
```cpp
double precise = 123.456789;
float lessPreci se = (float)precise;  // Loses some precision
int noDecimal = (int)precise;        // 123 (loses .456789)
```

## Input and Output with Variables

### Output with `cout`

```cpp
int age = 16;
string name = "Tian";

cout << "Name: " << name << endl;
cout << "Age: " << age << endl;

// Or in one line:
cout << "Name: " << name << ", Age: " << age << endl;
```

**Output:**
```
Name: Tian
Age: 16
```

### Input with `cin` (Preview)

```cpp
int age;
cout << "Enter your age: ";
cin >> age;

string name;
cout << "Enter your name: ";
cin >> name;

cout << "Hello, " << name << "! You are " << age << " years old." << endl;
```

**We'll explore `cin` more in Lesson 4!**

## Common Beginner Mistakes

### Mistake 1: Forgetting to Declare Type

**Wrong:**
```cpp
age = 16;  // ERROR: 'age' was not declared
```

**Correct:**
```cpp
int age = 16;
```

### Mistake 2: Using Wrong Quotes

**Wrong:**
```cpp
char letter = "A";  // ERROR: double quotes for char
string name = 'Tian';  // ERROR: single quotes for string
```

**Correct:**
```cpp
char letter = 'A';   // Single quotes
string name = "Tian"; // Double quotes
```

### Mistake 3: Mixing Types

**Wrong:**
```cpp
int age = "16";  // ERROR: string assigned to int
```

**Correct:**
```cpp
int age = 16;    // No quotes for numbers
```

### Mistake 4: Forgetting `f` for Float

**Wrong (warning):**
```cpp
float price = 25.50;  // Treated as double, then converted
```

**Correct:**
```cpp
float price = 25.50f;  // Explicitly float
```

### Mistake 5: Using Reserved Keywords

**Wrong:**
```cpp
int for = 10;  // ERROR: 'for' is a keyword
int int = 5;   // ERROR: 'int' is a keyword
```

**Correct:**
```cpp
int loopCount = 10;
int number = 5;
```

## Practical Examples

### Example 1: Student Information

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Student data
    string studentName = "Tian Reyes";
    int age = 16;
    char section = 'A';
    float gpa = 91.5f;
    bool hasScholarship = true;
    
    // Display information
    cout << "=== Student Information ===" << endl;
    cout << "Name: " << studentName << endl;
    cout << "Age: " << age << endl;
    cout << "Section: " << section << endl;
    cout << "GPA: " << gpa << endl;
    cout << "Scholarship: " << (hasScholarship ? "Yes" : "No") << endl;
    
    return 0;
}
```

### Example 2: Shopping Calculator

```cpp
#include <iostream>
using namespace std;

int main() {
    // Product prices
    double riceBag = 1850.00;
    double soySource = 45.50;
    double eggs = 120.00;
    
    // Calculate total
    double subtotal = riceBag + soySource + eggs;
    double taxRate = 0.12;  // 12% VAT
    double tax = subtotal * taxRate;
    double total = subtotal + tax;
    
    // Display
    cout << "Subtotal: ₱" << subtotal << endl;
    cout << "Tax (12%): ₱" << tax << endl;
    cout << "Total: ₱" << total << endl;
    
    return 0;
}
```

### Example 3: Grade Calculator

```cpp
#include <iostream>
using namespace std;

int main() {
    // Scores
    int quiz1 = 85;
    int quiz2 = 92;
    int exam = 88;
    
    // Calculate average
    double average = (quiz1 + quiz2 + exam) / 3.0;  // 3.0 to get decimal result
    
    // Display
    cout << "Quiz 1: " << quiz1 << endl;
    cout << "Quiz 2: " << quiz2 << endl;
    cout << "Exam: " << exam << endl;
    cout << "Average: " << average << endl;
    
    return 0;
}
```

## Philippine Context

**Real-world variable usage in PH:**

**E-wallet app (GCash):**
```cpp
string accountName = "Tian Reyes";
double balance = 5432.50;
string phoneNumber = "09171234567";
bool isVerified = true;
```

**Grade management system:**
```cpp
string studentID = "2024-00123";
double mathGrade = 89.5;
double scienceGrade = 92.0;
double englishGrade = 87.5;
int absences = 3;
```

**Jeepney fare calculator:**
```cpp
const double BASE_FARE = 13.00;
double distance = 5.5;  // kilometers
double totalFare = BASE_FARE + (distance * 2.0);
```

## Summary

**Key Takeaways:**

1. **Variables store data** in named memory locations

2. **C++ is strongly typed** - must declare type before use

3. **Basic data types:**
   - `int` - whole numbers
   - `float`/`double` - decimals
   - `char` - single character (single quotes)
   - `bool` - true/false
   - `string` - text (double quotes, need `<string>`)

4. **Always initialize variables** before use

5. **Use meaningful names** (camelCase or snake_case)

6. **Constants** use `const` keyword (can't be changed)

7. **Type casting** converts between types (may lose data)

---

## Closing Story

Tian closed his laptop with a satisfied grin. "Kuya, I finally understand why C++ needs data types! It's like labeling boxes in a warehouse - you need to know what's inside to handle it properly."

Kuya Miguel nodded approvingly. "Exactly! JavaScript is like throwing everything into one big box. C++ is more organized - int for counting, double for money calculations, string for names. Each has its purpose."

"What's next?" Tian asked, already opening his notes.

"Now that you know how to store data, you need to learn how to manipulate it. Operators are the tools that let you calculate, compare, and transform your data."

Tian's eyes lit up. "Like doing math operations and checking if someone passed an exam?"

"Precisely. Get ready to build some real logic!"

**Next Lesson Preview:**
In Lesson 3, you'll learn about **operators** - the tools that let you perform calculations, compare values, and make logical decisions. You'll discover how to build expressions and manipulate your variables!

Ready to do math like a computer? Let's go!
