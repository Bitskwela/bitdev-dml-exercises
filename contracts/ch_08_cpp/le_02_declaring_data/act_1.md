# Lesson 2 Activities: Variables and Data Types

---

## Activity 1: Personal Profile

**Objective:** Learn to declare variables of different types and display them.

**Task:**  
Create variables to store your personal information and display them in a formatted profile.

**Required variables:**
- Full name (string)
- Age (int)
- Grade level (int)
- Favorite subject (string)
- GPA (double)

**Starter Code:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // Declare your variables here
    
    // Display the profile
    
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

**Solution:**
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string fullName = "Tian Reyes";
    int age = 16;
    int gradeLevel = 10;
    string favoriteSubject = "Computer Science";
    double gpa = 91.5;
    
    cout << "=== My Profile ===" << endl;
    cout << "Name: " << fullName << endl;
    cout << "Age: " << age << endl;
    cout << "Grade: " << gradeLevel << endl;
    cout << "Favorite Subject: " << favoriteSubject << endl;
    cout << "GPA: " << gpa << endl;
    
    return 0;
}
```

---

## Activity 2: Sari-Sari Store Receipt

**Objective:** Practice using double variables for currency calculations.

**Task:**  
Calculate the total cost of items bought from a sari-sari store and display a receipt.

**Items to include:**
- Lucky Me noodles: ₱15.00
- C2 drink: ₱20.00
- Bread: ₱12.50

**Starter Code:**
```cpp
#include <iostream>
using namespace std;

int main() {
    // Declare price variables
    
    // Calculate total
    
    // Display receipt
    
    return 0;
}
```

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
