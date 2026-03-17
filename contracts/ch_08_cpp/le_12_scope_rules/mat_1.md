# Scope Rules

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+12.0+-+COVER.png)

## Scene

Tian's refactored ATM code had a mysterious bug. Sometimes the `balance` variable showed the correct amount, sometimes it was zero. He had declared `balance` in multiple places and lost track of which one was being used.

"Kuya, variables appear and disappear randomly! I declare `int counter` in one function, try to use it in another, and get errors. But sometimes variables with the same name don't conflict. I'm confused!"

Kuya Miguel sat down seriously. "This is **scope** -- one of the most important concepts in programming. Think of scope like rooms in a house. Each function is a room. Local variables are furniture in that room. You can't use the bedroom chair while you're in the kitchen, even though it exists. Some information, like your name, is global. Let's master this once and for all!"

## C++ Topics: Scope Rules

![12.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+12.1.png)

### Local Scope

> Variables declared inside a function or block `{ }` only exist within that block. They are created when execution enters the block and destroyed when it exits.

### Global Scope

> Variables declared outside all functions are accessible from any function in the file. They exist for the entire program duration. Use sparingly -- any function can modify them.

### Shadowing

> When a local variable has the same name as a global one, the local variable **shadows** (hides) the global. Use the scope resolution operator `::` to access the global version.

### Static Variables

> A `static` local variable retains its value between function calls. It has local scope but program-long lifetime -- like a counter on a wall that persists even after you leave the room.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int total = 0;  // Global variable

void addToTotal(int amount) {
    total += amount;  // Modifies global
}

void shadowTest() {
    int total = 100;  // Local shadows global
    cout << "Local total: " << total << endl;
    cout << "Global total: " << ::total << endl;
}

int main() {
    addToTotal(50);
    shadowTest();
    cout << "Final Global Total: " << total << endl;
    return 0;
}
```

`total` declared globally is modified by `addToTotal()`. Inside `shadowTest()`, a local `total` hides the global one, but `::total` still accesses the global version.
