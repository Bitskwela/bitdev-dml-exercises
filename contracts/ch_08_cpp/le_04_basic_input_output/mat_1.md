## Background Story

Tian proudly showed Kuya Miguel the barangay dues calculator. It worked perfectly—for exactly one resident named "Juan" who owed exactly 500 pesos.

"But we have 200 residents with different names and amounts," Kuya Miguel pointed out. "Are you going to write 200 different programs?"

Tian's face fell. The calculator was useless if it only worked for hardcoded values.

"This is the difference between a toy program and a real tool," Kuya Miguel explained. "Real programs need to interact with users—ask questions, receive answers, and display results. Think about every app you use: the game asks for your username, the calculator waits for numbers, the ATM asks for your PIN. They all use **input and output**."

"Right now, your program is like a vending machine with no buttons and no display," he continued. "You've built the calculation engine, which is great! But now we need to add the interface—the way humans and programs talk to each other. Let's make your calculator actually usable!"

---

## Theory & Lecture Content

## Understanding Input and Output

Before diving into code, let's understand what input and output mean:

**Output** - Displaying information to the user (what we've been doing with `cout`)
**Input** - Receiving information from the user (new skill: using `cin`)

Think of it like texting:
- When you send a message (output), you're showing information
- When you wait for a reply (input), you're receiving information

## Basic Output with cout

We've been using `cout` already, but let's review and expand our knowledge.

### Simple Output

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, Manila!";
    return 0;
}
```

Output:
```
Hello, Manila!
```

### Multiple Items in One Line

```cpp
int main() {
    int age = 21;
    string city = "Cebu";
    
    cout << "I am " << age << " years old and I live in " << city << ".";
    return 0;
}
```

Output:
```
I am 21 years old and I live in Cebu.
```

### Using endl for New Lines

```cpp
int main() {
    cout << "First line" << endl;
    cout << "Second line" << endl;
    cout << "Third line" << endl;
    return 0;
}
```

Output:
```
First line
Second line
Third line
```

**Note:** `endl` not only adds a new line but also flushes the output buffer. For simple new lines, you can use `\n` which is faster:

```cpp
cout << "First line\n";
cout << "Second line\n";
```

## Basic Input with cin

Now for the exciting part - getting input from users!

### Reading an Integer

```cpp
#include <iostream>
using namespace std;

int main() {
    int age;
    
    cout << "Enter your age: ";
    cin >> age;
    
    cout << "You are " << age << " years old." << endl;
    
    return 0;
}
```

**How it works:**
1. We declare a variable `age`
2. We prompt the user with `cout`
3. We use `cin >>` to read input into the variable
4. The program waits for the user to type and press Enter
5. The value is stored in `age`

**Sample Run:**
```
Enter your age: 21
You are 21 years old.
```

### Reading Multiple Values

```cpp
int main() {
    int item1, item2, item3;
    
    cout << "Enter prices of 3 items: ";
    cin >> item1 >> item2 >> item3;
    
    int total = item1 + item2 + item3;
    cout << "Total: " << total << " pesos" << endl;
    
    return 0;
}
```

**Sample Run:**
```
Enter prices of 3 items: 50 75 120
Total: 245 pesos
```

**Note:** Users can enter values separated by spaces or by pressing Enter after each value.

### Reading Different Data Types

```cpp
int main() {
    // Integer
    int quantity;
    cout << "Enter quantity: ";
    cin >> quantity;
    
    // Double (for decimal numbers)
    double price;
    cout << "Enter price: ";
    cin >> price;
    
    // Character
    char rating;
    cout << "Enter rating (A-F): ";
    cin >> rating;
    
    // Boolean (0 for false, any non-zero for true)
    bool isPaid;
    cout << "Payment received? (1=yes, 0=no): ";
    cin >> isPaid;
    
    cout << "\nOrder Summary:" << endl;
    cout << "Quantity: " << quantity << endl;
    cout << "Price: " << price << endl;
    cout << "Rating: " << rating << endl;
    cout << "Paid: " << (isPaid ? "Yes" : "No") << endl;
    
    return 0;
}
```

**Sample Run:**
```
Enter quantity: 5
Enter price: 89.50
Enter rating (A-F): A
Payment received? (1=yes, 0=no): 1

Order Summary:
Quantity: 5
Price: 89.5
Rating: A
Paid: Yes
```

## The String Input Problem

"Kuya Miguel, I tried to input my full name but the program only captured my first name!"

Tian showed this code:

```cpp
int main() {
    string name;
    
    cout << "Enter your full name: ";
    cin >> name;
    
    cout << "Hello, " << name << "!" << endl;
    
    return 0;
}
```

**Sample Run:**
```
Enter your full name: Maria Santos
Hello, Maria!
```

"See? It ignored 'Santos'!"

### Why This Happens

Kuya Miguel explained: "The `cin >>` operator stops reading when it encounters whitespace (spaces, tabs, or newlines). It's like reading a text message word by word, stopping at each space."

### Solution: getline()

```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    string fullName;
    
    cout << "Enter your full name: ";
    getline(cin, fullName);
    
    cout << "Hello, " << fullName << "!" << endl;
    
    return 0;
}
```

**Sample Run:**
```
Enter your full name: Maria Santos
Hello, Maria Santos!
```

**Syntax:** `getline(cin, variableName)`
- First parameter: input stream (cin)
- Second parameter: string variable to store the input

## The Buffer Problem

"This is weird, Kuya," Tian said, showing another program. "Sometimes it skips asking for input!"

```cpp
int main() {
    int age;
    string name;
    
    cout << "Enter your age: ";
    cin >> age;
    
    cout << "Enter your name: ";
    getline(cin, name);
    
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    
    return 0;
}
```

**Sample Run (Problematic):**
```
Enter your age: 21
Enter your name: Name: 
Age: 21
```

### Understanding the Buffer

Kuya Miguel drew a diagram:

```
User types: 21[Enter]
Buffer contains: 21\n

cin >> age reads: 21 (leaves \n in buffer)
getline(cin, name) reads: \n (empty line!)
```

"When you press Enter after typing 21, you're actually entering '21\n' where '\n' is the newline character. The `cin >> age` takes the 21 but leaves the '\n' in the buffer. Then `getline()` immediately reads that '\n' and thinks you entered an empty line."

### Solution: cin.ignore()

```cpp
int main() {
    int age;
    string name;
    
    cout << "Enter your age: ";
    cin >> age;
    cin.ignore();  // Ignore the leftover newline
    
    cout << "Enter your name: ";
    getline(cin, name);
    
    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    
    return 0;
}
```

**Sample Run (Fixed):**
```
Enter your age: 21
Enter your name: Maria Santos
Name: Maria Santos
Age: 21
```

**Best Practice:** Always use `cin.ignore()` after `cin >>` and before `getline()`.

You can also specify how much to ignore:
```cpp
cin.ignore(1000, '\n');  // Ignore up to 1000 characters or until newline
```

## Formatting Output

### The Decimal Problem

```cpp
int main() {
    double price = 99.5;
    double total = price * 3;
    
    cout << "Total: " << total << " pesos" << endl;
    
    return 0;
}
```

Output:
```
Total: 298.5 pesos
```

"That looks unprofessional for money," Tian noted. "It should show 298.50 pesos."

### Using iomanip Library

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double price = 99.5;
    double total = price * 3;
    
    cout << fixed << setprecision(2);
    cout << "Total: " << total << " pesos" << endl;
    
    return 0;
}
```

Output:
```
Total: 298.50 pesos
```

**Manipulators:**
- `fixed` - Use fixed-point notation (not scientific)
- `setprecision(n)` - Show n decimal places

### More Formatting Examples

```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    double price1 = 1250.5;
    double price2 = 89.99;
    double price3 = 5.0;
    
    cout << fixed << setprecision(2);
    
    cout << "Receipt" << endl;
    cout << "==================" << endl;
    cout << "Item 1: " << setw(10) << price1 << endl;
    cout << "Item 2: " << setw(10) << price2 << endl;
    cout << "Item 3: " << setw(10) << price3 << endl;
    cout << "==================" << endl;
    cout << "Total:  " << setw(10) << price1 + price2 + price3 << endl;
    
    return 0;
}
```

Output:
```
Receipt
==================
Item 1:    1250.50
Item 2:      89.99
Item 3:       5.00
==================
Total:     1345.49
```

**setw(n)** - Sets the width of the next output to n characters, right-aligned by default.

### Left Alignment

```cpp
cout << left;  // Set left alignment
cout << "Item 1: " << setw(10) << price1 << endl;
```

Output:
```
Item 1: 1250.50   
```

## Practical Example 1: GCash Transfer

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string recipientName;
    double amount;
    string message;
    
    cout << "=== GCash Transfer ===" << endl;
    cout << endl;
    
    // Get recipient name
    cout << "Recipient name: ";
    getline(cin, recipientName);
    
    // Get amount
    cout << "Amount to send: ";
    cin >> amount;
    cin.ignore();  // Important!
    
    // Get message
    cout << "Message (optional): ";
    getline(cin, message);
    
    // Display confirmation
    cout << endl;
    cout << "=== Transfer Summary ===" << endl;
    cout << "To: " << recipientName << endl;
    cout << fixed << setprecision(2);
    cout << "Amount: PHP " << amount << endl;
    cout << "Message: " << (message.empty() ? "None" : message) << endl;
    cout << "Fee: PHP 0.00" << endl;
    cout << "Total: PHP " << amount << endl;
    
    return 0;
}
```

**Sample Run:**
```
=== GCash Transfer ===

Recipient name: Juan Dela Cruz
Amount to send: 500.50
Message (optional): Thanks for the help!

=== Transfer Summary ===
To: Juan Dela Cruz
Amount: PHP 500.50
Message: Thanks for the help!
Fee: PHP 0.00
Total: PHP 500.50
```

## Practical Example 2: Grade Calculator

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string studentName;
    double quiz1, quiz2, midterm, finalExam;
    
    cout << "=== Grade Calculator ===" << endl;
    cout << endl;
    
    cout << "Student name: ";
    getline(cin, studentName);
    
    cout << "Quiz 1 (0-100): ";
    cin >> quiz1;
    
    cout << "Quiz 2 (0-100): ";
    cin >> quiz2;
    
    cout << "Midterm (0-100): ";
    cin >> midterm;
    
    cout << "Final Exam (0-100): ";
    cin >> finalExam;
    
    // Calculate weighted average
    // Quizzes: 20% each, Midterm: 30%, Final: 30%
    double average = (quiz1 * 0.20) + (quiz2 * 0.20) + 
                     (midterm * 0.30) + (finalExam * 0.30);
    
    // Determine grade
    char grade;
    if (average >= 90) grade = 'A';
    else if (average >= 80) grade = 'B';
    else if (average >= 70) grade = 'C';
    else if (average >= 60) grade = 'D';
    else grade = 'F';
    
    // Display results
    cout << endl;
    cout << "=== Grade Report ===" << endl;
    cout << "Student: " << studentName << endl;
    cout << fixed << setprecision(2);
    cout << "Quiz 1:     " << quiz1 << endl;
    cout << "Quiz 2:     " << quiz2 << endl;
    cout << "Midterm:    " << midterm << endl;
    cout << "Final Exam: " << finalExam << endl;
    cout << "-------------------" << endl;
    cout << "Average:    " << average << endl;
    cout << "Grade:      " << grade << endl;
    
    return 0;
}
```

**Sample Run:**
```
=== Grade Calculator ===

Student name: Maria Santos
Quiz 1 (0-100): 85
Quiz 2 (0-100): 90
Midterm (0-100): 88
Final Exam (0-100): 92

=== Grade Report ===
Student: Maria Santos
Quiz 1:     85.00
Quiz 2:     90.00
Midterm:    88.00
Final Exam: 92.00
-------------------
Average:    89.40
Grade:      B
```

## Practical Example 3: Simple Shopping Cart

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string item1Name, item2Name, item3Name;
    double item1Price, item2Price, item3Price;
    int item1Qty, item2Qty, item3Qty;
    
    cout << "=== Sari-Sari Store ===" << endl;
    cout << endl;
    
    // Item 1
    cout << "Item 1 name: ";
    getline(cin, item1Name);
    cout << "Price: ";
    cin >> item1Price;
    cout << "Quantity: ";
    cin >> item1Qty;
    cin.ignore();
    
    // Item 2
    cout << "\nItem 2 name: ";
    getline(cin, item2Name);
    cout << "Price: ";
    cin >> item2Price;
    cout << "Quantity: ";
    cin >> item2Qty;
    cin.ignore();
    
    // Item 3
    cout << "\nItem 3 name: ";
    getline(cin, item3Name);
    cout << "Price: ";
    cin >> item3Price;
    cout << "Quantity: ";
    cin >> item3Qty;
    
    // Calculate totals
    double item1Total = item1Price * item1Qty;
    double item2Total = item2Price * item2Qty;
    double item3Total = item3Price * item3Qty;
    double grandTotal = item1Total + item2Total + item3Total;
    
    // Display receipt
    cout << endl;
    cout << "========================================" << endl;
    cout << "              RECEIPT                   " << endl;
    cout << "========================================" << endl;
    cout << fixed << setprecision(2);
    cout << left;
    
    cout << setw(20) << "Item" 
         << setw(8) << "Price" 
         << setw(5) << "Qty" 
         << setw(10) << "Total" << endl;
    cout << "----------------------------------------" << endl;
    
    cout << setw(20) << item1Name 
         << setw(8) << item1Price 
         << setw(5) << item1Qty 
         << setw(10) << item1Total << endl;
         
    cout << setw(20) << item2Name 
         << setw(8) << item2Price 
         << setw(5) << item2Qty 
         << setw(10) << item2Total << endl;
         
    cout << setw(20) << item3Name 
         << setw(8) << item3Price 
         << setw(5) << item3Qty 
         << setw(10) << item3Total << endl;
    
    cout << "========================================" << endl;
    cout << setw(33) << "GRAND TOTAL: " << grandTotal << endl;
    cout << "========================================" << endl;
    
    return 0;
}
```

**Sample Run:**
```
=== Sari-Sari Store ===

Item 1 name: Lucky Me
Price: 15.50
Quantity: 3

Item 2 name: Coke 1L
Price: 45
Quantity: 2

Item 3 name: Bread
Price: 55
Quantity: 1

========================================
              RECEIPT                   
========================================
Item                Price   Qty  Total     
----------------------------------------
Lucky Me            15.50   3    46.50     
Coke 1L             45.00   2    90.00     
Bread               55.00   1    55.00     
========================================
                 GRAND TOTAL: 191.50
========================================
```

## Common Input Errors

### 1. Type Mismatch

```cpp
int age;
cout << "Enter your age: ";
cin >> age;
```

If user enters "twenty" instead of 20, the program will fail or behave unexpectedly.

**What happens:**
- `cin` fails to convert "twenty" to an integer
- The variable contains garbage or zero
- The input remains in the buffer

### 2. Buffer Overflow

When reading into a fixed-size array (we'll cover arrays later), inputting too much data can cause problems.

### 3. Forgetting cin.ignore()

As discussed earlier, this is the most common mistake when mixing `cin >>` and `getline()`.

### 4. Not Validating Input

```cpp
int age;
cout << "Enter your age (1-150): ";
cin >> age;

// No validation - user could enter -5 or 999
```

**Better approach** (we'll learn more about this later):
```cpp
int age;
cout << "Enter your age (1-150): ";
cin >> age;

if (age < 1 || age > 150) {
    cout << "Invalid age!" << endl;
    return 1;  // Exit with error
}
```

## Common Mistakes to Avoid

### 1. Forgetting to Include Headers

```cpp
// Wrong - missing <iomanip>
#include <iostream>
using namespace std;

int main() {
    cout << fixed << setprecision(2);  // Error!
    return 0;
}
```

**Fix:** Include `<iomanip>` for formatting manipulators.

### 2. Not Using cin.ignore()

```cpp
// Wrong
int age;
string name;

cin >> age;
getline(cin, name);  // Will skip waiting for input!
```

**Fix:** Add `cin.ignore()` after `cin >> age;`

### 3. Using cout Instead of cin for Input

```cpp
// Wrong
int number;
cout >> number;  // This won't work!
```

**Fix:** Use `cin >>` for input, `cout <<` for output.

### 4. Forgetting Data Types in Declarations

```cpp
// Wrong
number = 5;  // What is 'number'?
```

**Fix:** Always declare with data type:
```cpp
int number = 5;
```

### 5. Mixing Up << and >>

Remember the direction:
- `cout <<` - Data flows OUT to screen
- `cin >>` - Data flows IN from keyboard

Think of the arrows pointing where data goes:
```cpp
cout << data;  // Data goes to cout (screen)
cin >> data;   // Data comes from cin (keyboard) into variable
```

### 6. Not Formatting Money Properly

```cpp
// Bad
double price = 99.5;
cout << "Price: " << price << endl;  // Shows 99.5, not 99.50
```

**Fix:**
```cpp
cout << fixed << setprecision(2);
cout << "Price: " << price << endl;  // Shows 99.50
```

### 7. Forgetting Quotes for Strings

```cpp
// Wrong
cout << Enter your name: ;  // Error!
```

**Fix:**
```cpp
cout << "Enter your name: ";
```

## Quick Reference

### Input/Output Basics

```cpp
// Output
cout << "text" << variable << endl;

// Input - single value
cin >> variable;

// Input - multiple values
cin >> var1 >> var2 >> var3;

// Input - string with spaces
getline(cin, stringVariable);

// Clear buffer
cin.ignore();
```

### Formatting

```cpp
#include <iomanip>

// Decimal places
cout << fixed << setprecision(2);

// Field width
cout << setw(10) << value;

// Alignment
cout << left;   // Left align
cout << right;  // Right align (default)
```

### Common Patterns

```cpp
// Pattern 1: Number then string
int age;
string name;

cin >> age;
cin.ignore();  // Important!
getline(cin, name);

// Pattern 2: Multiple numbers
double price, tax;
cin >> price >> tax;

// Pattern 3: Character choice
char choice;
cin >> choice;
```

## Summary

Today you learned how to make your programs interactive:

**Input:**
- Use `cin >>` for simple input (numbers, single words)
- Use `getline(cin, var)` for strings with spaces
- Always use `cin.ignore()` between `cin >>` and `getline()`

**Output:**
- Use `cout <<` to display information
- Chain multiple items with `<<`
- Use `endl` or `\n` for new lines

**Formatting:**
- `fixed` and `setprecision(n)` for decimal places
- `setw(n)` for field width
- `left` and `right` for alignment

**Best Practices:**
- Always prompt users clearly
- Format money with 2 decimal places
- Validate input when necessary
- Clear the buffer with `cin.ignore()` when needed

"Now your programs can actually talk to users!" Tian said excitedly.

"Exactly," Kuya Miguel replied. "Next lesson, we'll dive deeper into control structures - making decisions with if-else statements and loops. You'll be able to create programs that can make complex decisions, just like a traffic light system that knows when to turn red or green."

## Next Lesson Preview

In Lesson 5, you'll learn:
- If statements and conditions
- If-else chains
- Switch statements
- Nested conditions
- Logical operators (AND, OR, NOT)
- Building decision trees
- Real-world examples: ATM logic, grade evaluation, discount systems

Keep practicing input and output - it's the foundation for everything that comes next!

---

## Closing Story

Tian leaned back with a satisfied smile. "Kuya, my programs can finally talk to people! No more hardcoded values - users can input their own data!"

"That's the power of interaction," Kuya Miguel said. "Now your calculator works for any numbers, your grade calculator for any scores, your GCash simulator for any amount. See the difference?"

"Huge difference!" Tian agreed. "But I noticed something - my programs just do their thing and end. What if I want to check if the user entered a valid age? Or what if I want different outputs based on the grade?"

Kuya Miguel grinned. "Perfect observation! That's exactly what we'll tackle next - control flow. You'll learn how to make your programs smart enough to make decisions, just like a traffic light that knows when to turn red or green."

Tian opened a new file, excited to learn how to add intelligence to his programs.
