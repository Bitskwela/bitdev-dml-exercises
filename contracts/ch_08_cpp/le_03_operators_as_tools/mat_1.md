# Operators as Tools

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+3.0+-+COVER.png)

## Scene

Tian was building a barangay dues calculator. Residents owed 500 pesos monthly, but some paid partial amounts, others had penalties, and some had discounts.

"I have all these numbers stored in variables," Tian said, "but they're just sitting there! How do I actually calculate who owes what?"

Kuya Miguel laughed. "You've got the ingredients but no cooking tools! In programming, operators are your mathematical tools. Think of them like a jeepney driver's skills -- knowing when to add speed, subtract by braking, multiply distance by time, or divide the fare among passengers. Let's turn those static variables into dynamic calculations!"

## C++ Topics: Arithmetic Operators

![3.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+3.1.png)

### Addition (`+`)

> Adds two values together. Also used for string concatenation: `string full = first + " " + last;`

### Subtraction (`-`)

> Subtracts one value from another. Example: `int remaining = balance - withdrawal;`

### Multiplication (`*`)

> Multiplies two values. Example: `int total = price * quantity;`

### Division (`/`)

> Divides two values. Integer division truncates decimals: `10 / 3` gives `3`, not `3.33`. Use `double` for decimal results.

### Modulo (`%`)

> Returns the remainder after division. Works only with integers: `10 % 3` gives `1`. Useful for checking even/odd numbers.

### Operator Precedence

> C++ follows PEMDAS: parentheses first, then `*`, `/`, `%`, then `+`, `-`. Use parentheses to make your intent clear.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    double num1 = 10, num2 = 3;
    cout << "Sum: " << (num1 + num2) << endl;
    cout << "Difference: " << (num1 - num2) << endl;
    cout << "Product: " << (num1 * num2) << endl;
    cout << "Quotient: " << (num1 / num2) << endl;
    cout << "Remainder: " << ((int)num1 % (int)num2) << endl;
    return 0;
}
```

This program performs all five arithmetic operations on two numbers. Note that modulo (`%`) requires integer operands, so we cast the doubles to `int` using `(int)`. Division between two doubles gives a decimal result automatically.

## Common Pitfalls ⚠️

**1. `=` (assign) vs `==` (compare)**

```cpp
if (x = 5) { ... }   // ❌ assigns 5, always true
if (x == 5) { ... }  // ✅ compares
```

**2. Modulo on doubles**

```cpp
double r = 10.0 % 3;  // ❌ % only works on integers
int r = 10 % 3;       // ✅ 1
```

**3. Forgetting operator precedence**

```cpp
int x = 2 + 3 * 4;    // 14, not 20 — * binds tighter than +
int x = (2 + 3) * 4;  // ✅ 20 if that's what you meant
```

**4. Pre vs post increment confusion**

```cpp
int a = 5; int b = a++;  // b = 5, then a = 6
int a = 5; int b = ++a;  // a = 6, then b = 6
```

**5. Dividing by a variable that might be zero**

```cpp
int q = total / count;          // ❌ crashes if count == 0
if (count != 0) q = total/count; // ✅ guard first
```
