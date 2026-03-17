# Basic Input and Output

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+4.0+-+COVER.png)

## Scene

Tian's barangay dues calculator worked perfectly -- for exactly one resident named "Juan" who owed exactly 500 pesos. "But we have 200 residents with different names and amounts," Kuya Miguel pointed out.

Tian's face fell. The calculator was useless if it only worked for hardcoded values.

"Real programs need to interact with users," Kuya Miguel explained. "Think about every app you use: the game asks for your username, the ATM asks for your PIN. Right now, your program is like a vending machine with no buttons. Let's add the interface -- the way humans and programs talk to each other!"

## C++ Topics: cin, getline, and Formatting

![4.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+4.1.png)

### `cin >>`

> Reads a single value from the user. Works with `int`, `double`, `char`, and `string` (single word only). Example: `cin >> age;`

### `getline(cin, variable)`

> Reads an entire line of text including spaces. Use this for full names, addresses, or any multi-word input. Example: `getline(cin, fullName);`

### `cin.ignore()`

> Clears the leftover newline character from the input buffer. Always call this after `cin >>` and before `getline()` to prevent input skipping.

### `fixed` and `setprecision()`

> From `<iomanip>`, these format decimal output. `fixed` forces decimal notation and `setprecision(2)` limits to 2 decimal places.

#### Sample syntax

```cpp
#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main() {
    string fullName;
    int age;
    double income;

    cout << "Name: ";
    getline(cin, fullName);
    cout << "Age: ";
    cin >> age;
    cin.ignore();
    cout << "Income: ";
    cin >> income;

    cout << "Hello, " << fullName << "! Age: " << age << endl;
    cout << fixed << setprecision(2) << "Income: P" << income << endl;
    return 0;
}
```

This program collects user input using `getline` for a full name and `cin >>` for numeric values. The `cin.ignore()` call clears the buffer between numeric and text input. Output is formatted with `fixed` and `setprecision(2)` to show exactly two decimal places.
