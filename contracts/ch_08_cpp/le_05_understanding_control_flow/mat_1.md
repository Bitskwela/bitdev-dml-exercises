# Understanding Control Flow

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+5.0+-+COVER.png)

## Scene

Tian stared at the screen in disbelief. The calculator displayed: `Result: inf`. A user had divided by zero, and the program blindly executed the calculation without checking.

"Kuya Miguel, my calculator just broke!" Tian exclaimed. "One wrong input crashes everything!"

Kuya Miguel walked over calmly. "Right now, your program is like a jeepney driver who never looks at the road -- just drives straight no matter what. Red light? Keep going. Flooding ahead? Drive right into it. You need control flow -- the ability to look at conditions and decide what to do. Today, we transform your programs from mindless instruction-followers into smart decision-makers!"

## C++ Topics: Conditions and Branching

![5.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+5.1.png)

### `if` Statement

> Executes a block of code only when a condition is `true`. The condition goes inside parentheses, and the code block uses curly braces: `if (condition) { ... }`

### `else` Statement

> Provides an alternative block that runs when the `if` condition is `false`. Every `else` must follow an `if`.

### `else if` Statement

> Chains multiple conditions together. Checked in order from top to bottom; only the first true block executes.

### Comparison Operators

> Used inside conditions: `==` (equal), `!=` (not equal), `>`, `<`, `>=`, `<=`. Remember: `==` compares, `=` assigns.

### `switch` Statement

> An alternative to long `else if` chains when comparing one variable against many fixed values. Each case ends with `break;` and `default:` handles unmatched values.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    double num1 = 10, num2 = 0;

    if (num2 == 0) {
        cout << "ERROR: Cannot divide by zero!" << endl;
    } else {
        cout << "Result: " << (num1 / num2) << endl;
    }
    return 0;
}
```

This program checks whether the divisor is zero before performing division. The `if` block handles the error case, and the `else` block runs only when division is safe. This pattern of validating input before processing is fundamental to writing robust programs.
