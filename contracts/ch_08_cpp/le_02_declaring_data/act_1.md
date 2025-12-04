# Lesson 2 Activities: Declaring Data

## From Static Text to Dynamic Information

Remember Tian's frustration? The game score tracker printed "Player Score:" but couldn't remember anything. The program had no memory! Just like in the lesson's background story, you've now learned that **variables are named storage locations**—labeled containers that hold values.

Kuya Miguel's warehouse analogy is key: "You can't just throw items anywhere. Shoes go in the shoe section, electronics in electronics." C++ variables work the same way—each data type has its specific purpose and memory allocation.

**Why C++ is strict about types:**
- **Memory efficiency:** `int` uses 4 bytes, `char` uses 1 byte
- **Type safety:** Prevents adding numbers to text accidentally
- **Performance:** Compiler optimizes based on types
- **Error prevention:** Catches mistakes during compilation, not at runtime

In this activity, you'll practice declaring and using different data types: `int`, `double`, `float`, `char`, `bool`, and `string`. You'll understand WHY C++ makes you think like the computer's memory manager.

---

## Task 1: Personal Profile System

**Context:**  
You're building a student information system for your school. Unlike JavaScript where you can just write `let age = 16` and later change it to `age = "sixteen"`, C++ requires you to commit to a data type. This prevents bugs and makes programs faster.

**Your Challenge:**  
Create a personal profile system that stores and displays different types of information about a student.

**What You'll Practice:**
- Declaring different variable types (`int`, `string`, `double`)
- Understanding why each type is appropriate for its data
- Displaying formatted output with mixed data types
- Using the `<string>` library for text data

**Requirements:**
Create variables for:
- Full name (`string`) - Text data
- Age (`int`) - Whole number
- Grade level (`int`) - Whole number
- Favorite subject (`string`) - Text data
- GPA (`double`) - Decimal number (precision matters!)

**Starter Code:**
```cpp
#include <iostream>
#include <string>  // Required for string type!
using namespace std;

int main() {
    // Declare your variables here with appropriate types
    
    // Display the formatted profile
    
    return 0;
}
```

**Expected Output:**
```
=== My Profile ===
Name: Tian Reyes
Age: 16
Grade: 10
Favorite Subject: Computer Science
GPA: 91.5
```

**Reflection:** Why is `double` better than `int` for GPA? What happens if you use `int` instead?

---

## Task 2: Sari-Sari Store Receipt Calculator

**Context:**  
Filipino sari-sari stores handle thousands of transactions daily. You're building a simple receipt calculator that needs to track prices (decimals) and calculate totals. This is where `double` shines—perfect for currency with centavo precision!

**Your Challenge:**  
Create a program that calculates the total cost of items from a sari-sari store and displays a formatted receipt.

**What You'll Practice:**
- Using `double` for currency (decimal values)
- Performing arithmetic with variables
- Understanding when to use `float` vs `double` (precision matters for money!)
- Formatting output for readability

**Items to Calculate:**
- Lucky Me Instant Noodles: ₱15.00
- C2 Green Tea: ₱20.00
- Pandesal (5 pcs): ₱12.50

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Declare price variables (use double for currency!)
    
    // Calculate total
    
    // Display formatted receipt
    
    return 0;
}
```

**Expected Output:**
```
=== SARI-SARI STORE RECEIPT ===
Lucky Me Noodles: ₱15.00
C2 Green Tea: ₱20.00
Pandesal (5 pcs): ₱12.50
--------------------------
TOTAL: ₱47.50
```

**Challenge:** Can you add a 5% discount for senior citizens? How would you calculate and display that?

---

## Task 3: Data Type Exploration

**Context:**  
Understanding data types isn't just theory—it affects how much memory your program uses and what operations you can perform. Let's explore the characteristics of each type.

**Your Challenge:**  
Create a program that demonstrates the size and range of different data types using `sizeof()` operator.

**What You'll Learn:**
- How much memory each type uses
- Why choosing the right type matters
- The difference between `int`, `float`, and `double`

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Declare one variable of each basic type
    int age = 16;
    float price = 99.99f;
    double piValue = 3.14159;
    char grade = 'A';
    bool isStudent = true;
    
    // Display each variable and its size in bytes
    cout << "=== DATA TYPE SIZES ===" << endl;
    cout << "int: " << sizeof(age) << " bytes" << endl;
    // Add more...
    
    return 0;
}
```

**Expected Output:**
```
=== DATA TYPE SIZES ===
int: 4 bytes
float: 4 bytes
double: 8 bytes
char: 1 byte
bool: 1 byte
```

---

## Task 4: Barangay Resident Information Card

**Context:**  
Barangay offices need to store resident information digitally. You'll create a digital ID card that combines ALL data types you've learned.

**Your Challenge:**  
Create a comprehensive resident information system that stores:
- Name (string)
- Age (int)
- Height in meters (double)
- Blood type (char)
- Is registered voter? (bool)
- Barangay (string)
- Monthly income (double)

**What This Teaches:**
- Practical application of multiple data types
- Real-world data organization
- Choosing appropriate types for different information

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Declare all resident information variables
    
    // Display formatted ID card
    cout << "╔════════════════════════════════╗" << endl;
    cout << "║   BARANGAY RESIDENT ID CARD   ║" << endl;
    cout << "╠════════════════════════════════╣" << endl;
    // Add information display
    
    return 0;
}
```

**Expected Output:**
```
╔════════════════════════════════╗
║   BARANGAY RESIDENT ID CARD   ║
╠════════════════════════════════╣
║ Name: Juan Dela Cruz          ║
║ Age: 28 years old              ║
║ Height: 1.75 meters            ║
║ Blood Type: O                  ║
║ Registered Voter: Yes          ║
║ Barangay: San Jose             ║
║ Monthly Income: ₱25,000.00     ║
╚════════════════════════════════╝
```

---

## Task 5: Variable Initialization vs Declaration

**Context:**  
One of the most common bugs in C++ is using uninitialized variables. Unlike JavaScript, C++ doesn't automatically set variables to 0 or null—they contain garbage values from memory!

**Your Challenge:**  
Demonstrate the difference between declared and initialized variables, and understand why initialization matters.

**What You'll Learn:**
- The danger of uninitialized variables
- Best practices for variable declaration
- Why C++ doesn't auto-initialize (performance!)

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Declared but NOT initialized (dangerous!)
    int uninitializedAge;
    
    // Declared AND initialized (safe!)
    int initializedAge = 0;
    
    // Try to display both
    cout << "Uninitialized: " << uninitializedAge << endl;  // Garbage value!
    cout << "Initialized: " << initializedAge << endl;      // Safe: 0
    
    return 0;
}
```

**Experiment:** Run this program multiple times. Does the uninitialized value change? Why?

---

## Reflection Questions

After completing these activities, reflect deeply on C++'s approach to data:

1. **Why does C++ require you to declare variable types, unlike JavaScript's loose typing?**
   
   _[Your answer: Consider memory efficiency, type safety, and performance optimization]_

2. **What's the difference between `float` and `double`? When would you choose one over the other?**
   
   _[Your answer: Think about precision (7 vs 15 digits) and memory (4 vs 8 bytes)]_

3. **Why should you always initialize variables in C++? What happens if you don't?**
   
   _[Your answer: Remember the "garbage value" from uninitialized memory]_

4. **How does choosing the right data type affect your program's memory usage?**
   
   _[Your answer: Compare char (1 byte) vs int (4 bytes) vs double (8 bytes)]_

5. **In the sari-sari store example, why is `double` better than `int` for prices?**
   
   _[Your answer: Think about centavos and decimal precision]_

6. **How would you store someone's phone number in C++? String or int? Why?**
   
   _[Your answer: Consider leading zeros and the fact that you don't do math with phone numbers]_

---

## What You've Learned

Through these activities, you've practiced:

✅ **Variable Declaration**: Creating named storage locations with specific types  
✅ **Data Types**: Understanding `int`, `double`, `float`, `char`, `bool`, `string`  
✅ **Type Selection**: Choosing appropriate types for different kinds of data  
✅ **Memory Awareness**: Understanding how much space each type uses  
✅ **Initialization**: Always giving variables starting values to avoid bugs  
✅ **Real-World Application**: Building practical systems like receipts and ID cards

**Connection to Real World:**
- Every database field has a data type (varchar, int, decimal)
- Game engines track different data types (position=float, health=int, name=string)
- Financial systems require precise decimal types for money
- Embedded systems optimize memory by choosing smallest appropriate types

**Philippine Context:**
- Sari-sari store systems process thousands of `double` transactions
- Barangay information systems store mixed data types for residents
- BPO databases handle billions of properly-typed records
- Game studios optimize memory using appropriate types for each game asset

---

## Answer Key

<details>
<summary><strong>📝 Click to view all solutions</strong></summary>

### Task 1: Personal Profile System

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Declare variables with appropriate types
    string fullName = "Tian Reyes";
    int age = 16;
    int gradeLevel = 10;
    string favoriteSubject = "Computer Science";
    double gpa = 91.5;  // double for decimal precision
    
    // Display formatted profile
    cout << "=== My Profile ===" << endl;
    cout << "Name: " << fullName << endl;
    cout << "Age: " << age << endl;
    cout << "Grade: " << gradeLevel << endl;
    cout << "Favorite Subject: " << favoriteSubject << endl;
    cout << "GPA: " << gpa << endl;
    
    return 0;
}
```

**Why these types?**
- `string` for names and text (variable length)
- `int` for age and grade (whole numbers, no decimals needed)
- `double` for GPA (need decimal precision: 91.5 not 91)

---

### Task 2: Sari-Sari Store Receipt

```cpp
#include <iostream>
#include <iomanip>  // For formatting currency
using namespace std;

int main() {
    // Declare price variables (double for currency precision)
    double luckyMePrice = 15.00;
    double c2Price = 20.00;
    double pandesalPrice = 12.50;
    
    // Calculate total
    double total = luckyMePrice + c2Price + pandesalPrice;
    
    // Display formatted receipt
    cout << "=== SARI-SARI STORE RECEIPT ===" << endl;
    cout << fixed << setprecision(2);  // Always show 2 decimal places
    cout << "Lucky Me Noodles: ₱" << luckyMePrice << endl;
    cout << "C2 Green Tea: ₱" << c2Price << endl;
    cout << "Pandesal (5 pcs): ₱" << pandesalPrice << endl;
    cout << "--------------------------" << endl;
    cout << "TOTAL: ₱" << total << endl;
    
    return 0;
}
```

**With Senior Discount:**
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double luckyMePrice = 15.00;
    double c2Price = 20.00;
    double pandesalPrice = 12.50;
    
    double subtotal = luckyMePrice + c2Price + pandesalPrice;
    
    // Senior citizen discount (5%)
    double discount = subtotal * 0.05;
    double total = subtotal - discount;
    
    cout << "=== SARI-SARI STORE RECEIPT ===" << endl;
    cout << fixed << setprecision(2);
    cout << "Lucky Me Noodles: ₱" << luckyMePrice << endl;
    cout << "C2 Green Tea: ₱" << c2Price << endl;
    cout << "Pandesal (5 pcs): ₱" << pandesalPrice << endl;
    cout << "--------------------------" << endl;
    cout << "Subtotal: ₱" << subtotal << endl;
    cout << "Senior Discount (5%): -₱" << discount << endl;
    cout << "TOTAL: ₱" << total << endl;
    
    return 0;
}
```

---

### Task 3: Data Type Exploration

```cpp
#include <iostream>
using namespace std;

int main() {
    // Declare one variable of each type
    int age = 16;
    float price = 99.99f;
    double piValue = 3.14159265359;
    char grade = 'A';
    bool isStudent = true;
    
    // Display sizes
    cout << "=== DATA TYPE SIZES ===" << endl;
    cout << "int: " << sizeof(age) << " bytes (value: " << age << ")" << endl;
    cout << "float: " << sizeof(price) << " bytes (value: " << price << ")" << endl;
    cout << "double: " << sizeof(piValue) << " bytes (value: " << piValue << ")" << endl;
    cout << "char: " << sizeof(grade) << " byte (value: " << grade << ")" << endl;
    cout << "bool: " << sizeof(isStudent) << " byte (value: " << isStudent << ")" << endl;
    
    cout << "\n=== MEMORY COMPARISON ===" << endl;
    cout << "A char uses " << sizeof(int) / sizeof(char) << "x less memory than an int" << endl;
    cout << "A double uses " << sizeof(double) / sizeof(float) << "x more memory than a float" << endl;
    
    return 0;
}
```

---

### Task 4: Barangay Resident Information Card

```cpp
#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

int main() {
    // Declare resident information with appropriate types
    string name = "Juan Dela Cruz";
    int age = 28;
    double height = 1.75;  // meters
    char bloodType = 'O';
    bool isRegisteredVoter = true;
    string barangay = "San Jose";
    double monthlyIncome = 25000.00;
    
    // Display formatted ID card
    cout << "╔════════════════════════════════╗" << endl;
    cout << "║   BARANGAY RESIDENT ID CARD   ║" << endl;
    cout << "╠════════════════════════════════╣" << endl;
    cout << "║ Name: " << setw(23) << left << name << " ║" << endl;
    cout << "║ Age: " << age << " years old" << setw(14) << " " << "║" << endl;
    cout << "║ Height: " << fixed << setprecision(2) << height << " meters" << setw(13) << " " << "║" << endl;
    cout << "║ Blood Type: " << bloodType << setw(18) << " " << "║" << endl;
    cout << "║ Registered Voter: " << (isRegisteredVoter ? "Yes" : "No") << setw(10) << " " << "║" << endl;
    cout << "║ Barangay: " << setw(20) << left << barangay << " ║" << endl;
    cout << "║ Monthly Income: ₱" << fixed << setprecision(2) << monthlyIncome << setw(7) << " " << "║" << endl;
    cout << "╚════════════════════════════════╝" << endl;
    
    return 0;
}
```

---

### Task 5: Variable Initialization

```cpp
#include <iostream>
using namespace std;

int main() {
    // DANGEROUS: Declared but not initialized
    int uninitializedAge;
    int uninitializedScore;
    
    // SAFE: Declared and initialized
    int initializedAge = 0;
    int initializedScore = 0;
    
    cout << "=== UNINITIALIZED VARIABLES (GARBAGE VALUES) ===" << endl;
    cout << "Uninitialized Age: " << uninitializedAge << endl;
    cout << "Uninitialized Score: " << uninitializedScore << endl;
    
    cout << "\n=== INITIALIZED VARIABLES (SAFE) ===" << endl;
    cout << "Initialized Age: " << initializedAge << endl;
    cout << "Initialized Score: " << initializedScore << endl;
    
    cout << "\n=== BEST PRACTICE ===" << endl;
    cout << "Always initialize variables!" << endl;
    cout << "int age = 0;  // Good" << endl;
    cout << "int age;      // Bad - contains garbage!" << endl;
    
    return 0;
}
```

**Note:** The uninitialized variables will show random values from memory. These values can be different each time you run the program!

</details>

---

**Next Lesson Preview:**  
In Lesson 3, you'll learn about **operators**—the mathematical and logical tools that let you perform calculations and make decisions. From simple addition to complex comparisons, operators turn static data into dynamic programs!

**Ready to calculate like a pro? Let's master operators! 🚀**

**Expected Output:**
```
=== Sari-Sari Store Receipt ===
Lucky Me: ₱15.00
C2 Drink: ₱20.00
Bread: ₱12.50
Total: ₱47.50
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    double noodles = 15.00;
    double drink = 20.00;
    double bread = 12.50;
    
    double total = noodles + drink + bread;
    
    cout << "=== Sari-Sari Store Receipt ===" << endl;
    cout << "Lucky Me: ₱" << noodles << endl;
    cout << "C2 Drink: ₱" << drink << endl;
    cout << "Bread: ₱" << bread << endl;
    cout << "Total: ₱" << total << endl;
    
    return 0;
}
```

---

## Activity 3: Type Conversion Practice

**Objective:** Understand how type conversion works and when data loss occurs.

**Task:**  
Practice converting between different data types and observe the results.

**Operations to perform:**
1. Convert int to double
2. Convert double to int (observe decimal loss)
3. Convert char to int (ASCII value)
4. Convert int to char

**Expected Output:**
```
Int to double: 42.0
Double to int: 99
Char 'A' to int: 65
Int 66 to char: B
```

**Solution:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Integer to double
    int wholeNumber = 42;
    double decimal = wholeNumber;
    cout << "Int to double: " << decimal << endl;
    
    // Double to int (loses decimal)
    double price = 99.99;
    int rounded = (int)price;
    cout << "Double to int: " << rounded << endl;
    
    // Char to int (ASCII value)
    char letter = 'A';
    int asciiValue = (int)letter;
    cout << "Char 'A' to int: " << asciiValue << endl;
    
    // Int to char
    int code = 66;
    char character = (char)code;
    cout << "Int 66 to char: " << character << endl;
    
    return 0;
}
```

---

## Challenge Activity: GCash Balance Tracker

**Objective:** Apply variable concepts to a real-world Philippine context.

**Task:**  
Create a program that simulates a GCash account display.

**Variables needed:**
- Account name (string)
- Phone number (string)
- Current balance (double)
- Is verified (bool)
- Last transaction amount (double)

**Expected Output:**
```
=== GCash Account ===
Name: Tian Reyes
Phone: 09171234567
Balance: ₱5,432.50
Verified: Yes
Last Transaction: ₱250.00
```

**Hint:** Use conditional output for the boolean value (if verified, print "Yes", otherwise "No")

<details>
<summary>Click to view solution</summary>

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string accountName = "Tian Reyes";
    string phoneNumber = "09171234567";
    double balance = 5432.50;
    bool isVerified = true;
    double lastTransaction = 250.00;
    
    cout << "=== GCash Account ===" << endl;
    cout << "Name: " << accountName << endl;
    cout << "Phone: " << phoneNumber << endl;
    cout << "Balance: ₱" << balance << endl;
    cout << "Verified: " << (isVerified ? "Yes" : "No") << endl;
    cout << "Last Transaction: ₱" << lastTransaction << endl;
    
    return 0;
}
```

</details>

---

## Debugging Exercise: Fix the Variable Errors

**Objective:** Practice identifying and fixing variable-related errors.

**Task:**  
The following program has 5 errors related to variables. Find and fix them.

**Buggy Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    int age = "25";
    string name = John;
    double price = 99,99;
    bool isActive;
    
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    cout << "Price: " << price << endl;
    cout << "Active: " << isActive << endl;
    
    return 0;
}
```

**Errors to find:**
1. Wrong type assignment (int with string value)
2. Missing quotes on string value
3. Wrong decimal separator (comma instead of period)
4. Uninitialized boolean variable used

<details>
<summary>Click to view corrected code</summary>

```cpp
#include <iostream>
#include <string>  // Added <string> header
using namespace std;

int main() {
    int age = 25;  // Removed quotes
    string name = "John";  // Added quotes
    double price = 99.99;  // Changed comma to period
    bool isActive = true;  // Initialized the variable
    
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    cout << "Price: " << price << endl;
    cout << "Active: " << isActive << endl;
    
    return 0;
}
```

</details>

---

## Reflection Questions

After completing these activities, consider:

1. **Why does C++ require you to specify data types?**
   - For memory efficiency, type safety, and performance optimization

2. **What happens when you convert a double to an int?**
   - The decimal part is truncated (cut off), not rounded

3. **When would you use `const` for a variable?**
   - When the value should never change (like PI, tax rates, maximum limits)

4. **What's the difference between `float` and `double`?**
   - `double` has more precision (8 bytes vs 4 bytes) and is preferred for most calculations

---

## Next Steps

Excellent work! You now understand:
- ✅ How to declare variables with specific types
- ✅ Different data types (int, double, string, char, bool)
- ✅ Type conversion and potential data loss
- ✅ When to use const for unchanging values

**Ready for Lesson 3?**  
Next, you'll learn about **operators** - the tools that let you perform calculations, comparisons, and logical operations with your variables!
