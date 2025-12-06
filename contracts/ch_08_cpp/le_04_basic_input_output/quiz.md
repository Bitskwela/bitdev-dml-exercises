# Basic Input/Output Quiz

---

# Quiz 1

## Quiz: Complete Input/Output Flow in C++

**Scenario:**

Tian is building a sari-sari store inventory system in C++. The system needs to accept product details, calculate total prices, and display formatted receipts. Let's trace the complete input/output flow and understand buffer management.

**Part 1: Basic Input Operations**

```cpp
// Tian's initial code for product entry
#include <iostream>
#include <string>
using namespace std;

int main() {
    int quantity;
    double price;
    string productName;
    
    cout << "Enter quantity: ";
    cin >> quantity;  // Step 1: Reads ________
    
    cout << "Enter price: ";
    cin >> price;     // Step 2: Reads ________
    
    cout << "Enter product name: ";
    cin >> productName;  // Step 3: Problem occurs because ________
    
    return 0;
}
```

**Execution Trace:**
```
Input Buffer Visualization:

User types: 50[Enter]199.50[Enter]Lucky Me Pancit Canton[Enter]

Buffer contents after each operation:
After cin >> quantity:
  quantity = 50
  Buffer: [newline]199.50[Enter]Lucky Me Pancit Canton[Enter]
  
After cin >> price:
  price = 199.50
  Buffer: [newline]Lucky Me Pancit Canton[Enter]
  
After cin >> productName:
  productName = ________ (only reads until first space!)
  Buffer: Me Pancit Canton[Enter]
```

**Part 2: Fixing Buffer Issues**

```cpp
// Tian's improved code with cin.ignore()
int main() {
    int quantity;
    double price;
    string productName;
    
    cout << "Enter quantity: ";
    cin >> quantity;
    cin.ignore();  // Why needed? ________
    
    cout << "Enter price: ";
    cin >> price;
    cin.ignore();
    
    cout << "Enter product name: ";
    getline(cin, productName);  // Now reads ________
    
    cout << "Product: " << productName << endl;
    return 0;
}
```

**Part 3: Formatted Output with iomanip**

```cpp
// Receipt printing system
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    string product = "Lucky Me Pancit Canton";
    int quantity = 50;
    double price = 12.50;
    double total = quantity * price;
    
    cout << "========== TIAN'S SARI-SARI STORE ==========" << endl;
    cout << left << setw(25) << "Product" 
         << right << setw(10) << "Qty" 
         << setw(15) << "Total" << endl;
    
    cout << fixed << setprecision(2);
    cout << left << setw(25) << product
         << right << setw(10) << quantity
         << setw(15) << total << endl;
    
    return 0;
}
```

**Question 1:** What does `cin >> quantity` stop reading at?

- A) End of file
- B) Whitespace (space, tab, newline)
- C) Semicolon
- D) Null character

**Answer:** B) Whitespace (space, tab, newline)

---

**Question 2:** Why does `cin >> productName` only capture "Lucky" instead of "Lucky Me Pancit Canton"?

- A) String size limit
- B) cin >> stops at whitespace, only reads first word
- C) Buffer overflow
- D) Memory allocation error

**Answer:** B) cin >> stops at whitespace, only reads first word

---

**Question 3:** What does `cin.ignore()` do?

- A) Ignores all input
- B) Clears the entire buffer
- C) Discards the next character (usually newline) from input buffer
- D) Pauses program execution

**Answer:** C) Discards the next character (usually newline) from input buffer

---

# Quiz 2

**Question 4:** What is the correct function to read a full line including spaces?

- A) cin >> variable
- B) getline(cin, variable)
- C) cin.get(variable)
- D) scanf(variable)

**Answer:** B) getline(cin, variable)

---

**Question 5:** What does `setprecision(2)` do when combined with `fixed`?

- A) Sets 2 significant figures
- B) Sets 2 decimal places (12.5 becomes 12.50)
- C) Rounds to nearest 2
- D) Sets field width to 2

**Answer:** B) Sets 2 decimal places

---

**Question 6:** What does `setw(15)` do?

- A) Sets column width to 15 characters (for next output only)
- B) Sets permanent width
- C) Sets 15 decimal places
- D) Sets 15 significant figures

**Answer:** A) Sets column width to 15 characters (for next output only)

---

## Detailed Explanation

### Part 1: Understanding cin and Input Buffer

**How cin Works (Under the Hood):**

```
User Input → Keyboard Buffer → Input Stream Buffer → cin extracts data

Example: User types "50[Enter]"
Keyboard buffer: 50\n
Input stream: [5][0][\n]
cin >> quantity extracts: 50
Remaining in buffer: [\n]
```

**The cin >> Operator:**

```cpp
int number;
cin >> number;  // Extracts integer, stops at whitespace
```

**Behavior:**
1. **Skips leading whitespace** (spaces, tabs, newlines)
2. **Reads until whitespace** encountered
3. **Leaves whitespace in buffer** (causes problems!)
4. **Type-specific extraction** (fails on wrong type)

**Example Trace:**

```cpp
int age;
double salary;
string name;

// User input: 25[Enter]50000.50[Enter]Juan Dela Cruz[Enter]

cin >> age;      // Reads: 25, Buffer: [\n]50000.50[\n]Juan Dela Cruz[\n]
cin >> salary;   // Reads: 50000.50, Buffer: [\n]Juan Dela Cruz[\n]
cin >> name;     // Reads: Juan, Buffer: [ ]Dela Cruz[\n]  ← PROBLEM!
```

**Why name only captures "Juan":**
- `cin >>` stops at ANY whitespace
- Space between "Juan" and "Dela" causes stop
- Only "Juan" is extracted

---

### Part 2: The Newline Problem

**Common Bug Scenario:**

```cpp
int quantity;
string productName;

cout << "Enter quantity: ";
cin >> quantity;          // User enters: 50[Enter]

cout << "Enter product name: ";
getline(cin, productName); // This gets skipped! Why?
```

**What Happens:**

```
Input buffer after cin >> quantity:
[newline character still in buffer]

getline() immediately reads the leftover newline
Result: productName = "" (empty string)
User never gets to type product name!
```

**Visual Buffer State:**

```
After user types "50" and presses Enter:
Buffer: [5][0][\n]

After cin >> quantity:
quantity = 50
Buffer: [\n]  ← LEFTOVER NEWLINE

getline(cin, productName) executes:
Reads up to newline: ""
Buffer: []
productName = "" (empty!)
```

---

### Part 3: Solution - cin.ignore()

**What cin.ignore() Does:**

```cpp
cin.ignore();  // Removes 1 character from buffer
cin.ignore(100, '\n');  // Removes up to 100 chars OR until newline
```

**Proper Usage Pattern:**

```cpp
int quantity;
string productName;

cout << "Enter quantity: ";
cin >> quantity;
cin.ignore();  // ← CRITICAL! Removes leftover newline

cout << "Enter product name: ";
getline(cin, productName);  // Now works correctly
```

**Buffer Trace:**

```
User types: 50[Enter]

After cin >> quantity:
Buffer: [\n]

After cin.ignore():
Buffer: []  ← Clean!

getline() waits for new input:
User types: Lucky Me Pancit Canton[Enter]
productName = "Lucky Me Pancit Canton"
```

---

### Part 4: cin vs getline - Complete Comparison

**cin >> (Extraction Operator):**

```cpp
string word;
cin >> word;  // Stops at whitespace
```

**Characteristics:**
- Skips leading whitespace
- Stops at first whitespace
- Leaves newline in buffer
- Type-safe (fails on wrong type)
- Cannot read full sentences

**Example:**
```cpp
// Input: "    Hello World    "
cin >> word;
// Result: word = "Hello"
// Buffer: " World    \n"
```

---

**getline() Function:**

```cpp
string sentence;
getline(cin, sentence);  // Reads until newline
```

**Characteristics:**
- Does NOT skip leading whitespace
- Reads entire line including spaces
- Consumes and discards newline
- Always works with strings
- Perfect for full sentences

**Example:**
```cpp
// Input: "    Hello World    [Enter]"
getline(cin, sentence);
// Result: sentence = "    Hello World    "
// Buffer: [] (newline consumed)
```

---

### Part 5: iomanip Library - Professional Output

**Required Header:**
```cpp
#include <iomanip>
```

**1. setprecision() - Decimal Control**

**Without fixed:**
```cpp
double pi = 3.14159265359;

cout << setprecision(3) << pi << endl;  // 3.14 (3 significant figures)
cout << setprecision(5) << pi << endl;  // 3.1416 (5 significant figures)
```

**With fixed:**
```cpp
cout << fixed << setprecision(2);
cout << 12.5 << endl;      // 12.50 (always 2 decimals)
cout << 99.999 << endl;    // 100.00 (rounded)
cout << 0.1 << endl;       // 0.10
```

**Real-World Usage:**
```cpp
// Currency formatting (Philippine Peso)
double price = 1299.9;
cout << fixed << setprecision(2);
cout << "Price: PHP " << price << endl;
// Output: Price: PHP 1299.90
```

---

**2. setw() - Column Width**

**Important:** `setw()` applies to **next output only**, then resets!

```cpp
cout << setw(10) << "Name" << setw(10) << "Age" << endl;
cout << setw(10) << "Juan" << setw(10) << 25 << endl;

// Output:
//       Name       Age
//       Juan        25
```

**Right Alignment (default for numbers):**
```cpp
cout << setw(10) << 12345 << endl;
// Output: "     12345" (5 spaces + number)
```

**Left Alignment:**
```cpp
cout << left << setw(10) << 12345 << endl;
// Output: "12345     " (number + 5 spaces)
```

---

**3. left and right Manipulators**

```cpp
cout << left << setw(20) << "Product" 
     << right << setw(10) << "Price" << endl;

cout << left << setw(20) << "Lucky Me" 
     << right << setw(10) << 12.50 << endl;

// Output:
// Product                  Price
// Lucky Me                 12.50
```

**Sticky Manipulators:**
- `left`, `right` - Stay active until changed
- `fixed` - Stays active
- `setprecision()` - Stays active
- `setw()` - Only affects next output!

---

**4. fixed Manipulator**

**Without fixed (scientific notation for large/small numbers):**
```cpp
cout << 1234567890.123 << endl;  // 1.23457e+09
cout << 0.000000123 << endl;     // 1.23e-07
```

**With fixed:**
```cpp
cout << fixed;
cout << 1234567890.123 << endl;  // 1234567890.123000
cout << 0.000000123 << endl;     // 0.000000
```

**Common Pattern:**
```cpp
cout << fixed << setprecision(2);  // Always 2 decimals
```

---

### Part 6: Complete Receipt System Example

**Professional Sari-Sari Store Receipt:**

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    // Product data
    string products[] = {"Lucky Me Pancit Canton", "C2 Apple", "Skyflakes"};
    int quantities[] = {5, 10, 3};
    double prices[] = {12.50, 18.00, 8.50};
    int numProducts = 3;
    
    // Header
    cout << "================================================" << endl;
    cout << "       TIAN'S SARI-SARI STORE RECEIPT          " << endl;
    cout << "          Barangay Proper, Iloilo City         " << endl;
    cout << "================================================" << endl;
    cout << endl;
    
    // Column headers
    cout << left << setw(25) << "Product"
         << right << setw(8) << "Qty"
         << setw(10) << "Price"
         << setw(12) << "Total" << endl;
    cout << "------------------------------------------------" << endl;
    
    // Set decimal formatting
    cout << fixed << setprecision(2);
    
    double grandTotal = 0.0;
    
    // Print each product
    for (int i = 0; i < numProducts; i++) {
        double itemTotal = quantities[i] * prices[i];
        grandTotal += itemTotal;
        
        cout << left << setw(25) << products[i]
             << right << setw(8) << quantities[i]
             << setw(10) << prices[i]
             << setw(12) << itemTotal << endl;
    }
    
    cout << "------------------------------------------------" << endl;
    
    // Totals section
    cout << left << setw(43) << "Subtotal:"
         << right << setw(12) << grandTotal << endl;
    
    double vat = grandTotal * 0.12;
    cout << left << setw(43) << "VAT (12%):"
         << right << setw(12) << vat << endl;
    
    double finalTotal = grandTotal + vat;
    cout << left << setw(43) << "TOTAL:"
         << right << setw(12) << finalTotal << endl;
    
    cout << "================================================" << endl;
    cout << "       Salamat sa inyong pagbili!              " << endl;
    cout << "================================================" << endl;
    
    return 0;
}
```

**Output:**
```
================================================
       TIAN'S SARI-SARI STORE RECEIPT          
          Barangay Proper, Iloilo City         
================================================

Product                      Qty     Price       Total
------------------------------------------------
Lucky Me Pancit Canton         5     12.50       62.50
C2 Apple                      10     18.00      180.00
Skyflakes                      3      8.50       25.50
------------------------------------------------
Subtotal:                                       268.00
VAT (12%):                                       32.16
TOTAL:                                          300.16
================================================
       Salamat sa inyong pagbili!              
================================================
```

---

### Part 7: Advanced Input Techniques

**1. Input Validation Loop:**

```cpp
int quantity;
bool validInput = false;

while (!validInput) {
    cout << "Enter quantity (1-100): ";
    cin >> quantity;
    
    if (cin.fail()) {  // User entered non-integer
        cout << "Error: Please enter a number!" << endl;
        cin.clear();  // Clear error flags
        cin.ignore(1000, '\n');  // Clear buffer
    }
    else if (quantity < 1 || quantity > 100) {
        cout << "Error: Quantity must be 1-100!" << endl;
    }
    else {
        validInput = true;
    }
}
```

**What Happens When User Enters "abc":**
```
cin >> quantity fails
cin.fail() returns true
cin.clear() resets error state
cin.ignore() removes "abc\n" from buffer
Loop continues until valid input
```

---

**2. Mixed Input Types:**

```cpp
int id;
string name;
double price;

cout << "Enter product ID: ";
cin >> id;
cin.ignore();  // ← Important!

cout << "Enter product name: ";
getline(cin, name);

cout << "Enter price: ";
cin >> price;
cin.ignore();  // ← Good practice
```

**Rule of Thumb:**
- Use `cin.ignore()` after EVERY `cin >>` if `getline()` follows
- Always pair them to avoid buffer issues

---

### Part 8: Common Filipino Developer Mistakes

**Mistake 1: Forgetting cin.ignore()**
```cpp
// WRONG
int age;
string fullName;

cin >> age;
getline(cin, fullName);  // Skipped!
```

**Fix:**
```cpp
cin >> age;
cin.ignore();  // ← Add this!
getline(cin, fullName);
```

---

**Mistake 2: Using cin >> for full names**
```cpp
// WRONG
string fullName;
cin >> fullName;  // Only gets first name!
```

**Fix:**
```cpp
string fullName;
getline(cin, fullName);  // Gets full name
```

---

**Mistake 3: Not setting fixed for currency**
```cpp
// WRONG - Inconsistent decimals
double price = 12.5;
cout << price << endl;  // Output: 12.5 (not 12.50)
```

**Fix:**
```cpp
cout << fixed << setprecision(2);
cout << price << endl;  // Output: 12.50
```

---

**Mistake 4: Forgetting setw() for each column**
```cpp
// WRONG - setw() only affects next output
cout << setw(10);
cout << "Name" << "Age" << endl;  // Only "Name" is formatted!
```

**Fix:**
```cpp
cout << setw(10) << "Name" << setw(10) << "Age" << endl;
```

---

**Mistake 5: Not validating input**
```cpp
// WRONG - Crashes on invalid input
int quantity;
cin >> quantity;  // User enters "ten" → crash!
```

**Fix:**
```cpp
int quantity;
cin >> quantity;

if (cin.fail()) {
    cout << "Invalid input!" << endl;
    cin.clear();
    cin.ignore(1000, '\n');
}
```

---

### Part 9: Philippine Context - Real Applications

**GCash Transaction Receipt:**
```cpp
cout << fixed << setprecision(2);
cout << "========================================" << endl;
cout << "           GCash Receipt                " << endl;
cout << "========================================" << endl;
cout << left << setw(20) << "Transaction ID:" 
     << right << "TXN123456789" << endl;
cout << left << setw(20) << "Amount:" 
     << "PHP " << right << setw(10) << 500.00 << endl;
cout << left << setw(20) << "Fee:" 
     << "PHP " << right << setw(10) << 5.00 << endl;
cout << "========================================" << endl;
```

**Jeepney Fare Calculator:**
```cpp
double distance;
cout << "Enter distance (km): ";
cin >> distance;
cin.ignore();

double baseFare = 13.00;
double additionalFare = (distance - 4) * 1.50;
double totalFare = baseFare + (additionalFare > 0 ? additionalFare : 0);

cout << fixed << setprecision(2);
cout << "Total Fare: PHP " << totalFare << endl;
```

**Restaurant Order System:**
```cpp
string customerName;
int quantity;
double itemPrice = 85.50;

cout << "Enter customer name: ";
getline(cin, customerName);

cout << "Enter quantity: ";
cin >> quantity;
cin.ignore();

cout << fixed << setprecision(2);
cout << "\n===== ORDER SUMMARY =====" << endl;
cout << "Customer: " << customerName << endl;
cout << "Item: Pork Sisig" << endl;
cout << "Quantity: " << quantity << endl;
cout << "Total: PHP " << (quantity * itemPrice) << endl;
```

---

### Summary

**Input Operations:**
- `cin >>` - Reads until whitespace, leaves newline in buffer
- `getline(cin, var)` - Reads full line, consumes newline
- `cin.ignore()` - Removes leftover characters from buffer
- Always use `cin.ignore()` after `cin >>` before `getline()`

**Output Formatting:**
- `fixed` - Force fixed-point notation (no scientific)
- `setprecision(n)` - With fixed, sets n decimal places
- `setw(n)` - Sets width for next output only
- `left` / `right` - Alignment (sticky)

**Best Practices:**
1. Always validate input
2. Use `cin.ignore()` after `cin >>` if `getline()` follows
3. Use `fixed` and `setprecision(2)` for currency
4. Apply `setw()` to each column separately
5. Check `cin.fail()` for input errors
