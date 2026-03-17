# Nested Control

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+7.0+-+COVER.png)

## Scene

Tian's resident verification program worked for one person, but the barangay secretary needed to process 50 residents this week, each with multiple documents to verify.

"I need to loop through 50 residents," Tian said. "But for each one, I also need to check their ID, proof of address, and barangay clearance. How do I handle layers of logic?"

Kuya Miguel pulled up a chair. "Welcome to the real world of programming! Most problems need loops inside loops, or conditions inside loops. A delivery app checks restaurants in your area, then checks each restaurant's menu, then checks if each dish is available. This is called nesting -- putting control structures inside other control structures. Let's build your multi-layer system!"

## C++ Topics: Nested Loops and Conditions

![7.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+7.1.png)

### Nested `for` Loops

> A loop inside another loop. The inner loop completes all its iterations for each single iteration of the outer loop. If outer runs 10 times and inner runs 10 times, the body executes 100 times total.

### Loop Inside Condition

> Place a loop inside an `if` block to repeat an action only when a condition is met. Example: only print a report if the user is an admin.

### Condition Inside Loop

> Place an `if` inside a loop to apply different logic on each iteration. Example: flag certain rows while looping through data.

### Tab Formatting (`\t`)

> The tab character `\t` aligns output into columns, useful for tables and grids. Combine with `endl` to move to the next row.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 5; i++) {
        for (int j = 1; j <= 5; j++) {
            cout << (i * j) << "\t";
        }
        cout << endl;
    }
    return 0;
}
```

This creates a 5x5 multiplication table. The outer loop controls rows, the inner loop controls columns. For each row `i`, the inner loop prints the product of `i * j` for every column `j`, separated by tabs. After each row completes, `endl` moves to the next line.
