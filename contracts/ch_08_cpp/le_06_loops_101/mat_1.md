# Loops 101

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+6.0+-+COVER.png)

## Scene

The barangay secretary needed a program to send reminder messages to 200 residents about unpaid dues. Tian started typing each line manually: "Reminder to Resident 1... Reminder to Resident 2..." After 20 lines, his fingers were tired.

"There has to be a better way!" Tian groaned.

Kuya Miguel laughed. "You've just discovered why loops are one of the most important concepts in programming! Imagine if Facebook engineers wrote separate code for each of their 3 billion users. Loops are automation -- write the pattern once, tell the computer how many times to repeat it, and you're done. Let's turn those 200 lines into just 3!"

## C++ Topics: for, while, and do-while Loops

![6.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+6.1.png)

### `for` Loop

> Best when you know exactly how many times to repeat. Has three parts: initialization, condition, and update. Syntax: `for (int i = 0; i < n; i++) { ... }`

### `while` Loop

> Repeats as long as a condition is true. Check happens before each iteration, so the body may never execute. Syntax: `while (condition) { ... }`

### `do-while` Loop

> Like `while`, but the body executes at least once because the check happens after. Syntax: `do { ... } while (condition);`

### `break`

> Immediately exits the loop, skipping all remaining iterations. Useful for stopping early when a condition is met.

### `continue`

> Skips the rest of the current iteration and jumps to the next one. The loop keeps running.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 5; i++) {
        cout << "Reminder #" << i
             << ": Please segregate your waste properly." << endl;
    }
    return 0;
}
```

This `for` loop starts with `i = 1`, checks if `i <= 5`, executes the body, then increments `i` with `i++`. It prints 5 numbered reminders automatically. To print 200, just change `5` to `200` -- that is the power of loops.
