# Functions Defined

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+10.0+-+COVER.png)

## Scene

Tian opened his ATM project and scrolled... and scrolled. The `main()` function was over 200 lines long. "Kuya, I need to fix the withdrawal logic, but I can't even find where it is!"

Kuya Miguel nodded. "You've hit the spaghetti code wall. Your program works, but it's unmaintainable. Professional developers use **functions** -- small, reusable pieces that each do one job. Need to validate a withdrawal? Call the function by name. Instead of hunting through 200 lines, you break the problem into clean, organized pieces."

"Functions are the foundation of clean code," Kuya Miguel said. "Let's refactor your ATM project and transform it from a mess into professional code!"

## C++ Topics: Functions

![10.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+10.1.png)

### Function Anatomy

> A function has a **return type**, a **name**, optional **parameters**, and a **body**. Use `void` when the function returns nothing, or a type like `int` or `double` when it sends a value back.

### Calling Functions

> Call a function by writing its name followed by parentheses with any arguments: `greet("Juan")`. The function runs its body and optionally returns a result.

### Forward Declaration

> If you define a function after `main()`, declare its signature above `main()` so the compiler knows it exists. Example: `int add(int a, int b);`

### Function Overloading

> Multiple functions can share the same name if they have different parameter lists. The compiler picks the right one based on the arguments you pass.

#### Sample syntax

```cpp
#include <iostream>
#include <string>
using namespace std;

void displayWelcome() {
    cout << "Welcome to Barangay Portal!" << endl;
}

void greetResident(string name) {
    cout << "Welcome, " << name << "!" << endl;
}

int main() {
    displayWelcome();
    greetResident("Juan");
    greetResident("Maria");
    return 0;
}
```

`displayWelcome()` is a `void` function with no parameters -- it just prints a message. `greetResident()` takes a `string` parameter so the same function works for any resident name.
