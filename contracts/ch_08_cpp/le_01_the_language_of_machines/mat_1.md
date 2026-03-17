# The Language of Machines

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+1.0+-+COVER.png)

## Scene

Tian's JavaScript calculator worked, but it felt sluggish. While watching a Dota 2 tournament, the commentator mentioned: "This game processes millions of calculations per second thanks to C++."

Intrigued, Tian called Kuya Miguel. "Kuya, I want to learn the language that makes games run at 60 FPS! I want to learn C++!"

Kuya Miguel grinned. "Ready to talk directly to the machine? C++ gives you power and speed, but demands precision. Let's start your journey into the language of machines!"

## C++ Topics: Program Structure

![1.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+1.1.png)

### What is C++?

> C++ is a compiled, strongly-typed programming language created by Bjarne Stroustrup. It powers games, operating systems, and embedded systems because it runs directly on your hardware for maximum speed.

### `#include <iostream>`

> This line includes the Input/Output stream library, giving access to `cout` (console output) and `cin` (console input). Without it, you cannot print or read data.

### `using namespace std;`

> This tells the compiler to use the standard namespace so you can write `cout` instead of `std::cout`. It keeps your code shorter and cleaner.

### `int main()`

> Every C++ program must have a `main()` function. This is the entry point where execution begins. The `int` means it returns a status code to the operating system.

### `cout` and `return 0`

> `cout << "text" << endl;` prints text to the console. The `<<` operator sends data to the output stream. `return 0;` signals that the program executed successfully.

#### Sample syntax

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Mabuhay, Pilipinas!" << endl;
    return 0;
}
```

This program includes the iostream library, uses the standard namespace, defines the main entry point, prints a greeting with `cout`, and returns 0 to indicate success. Every statement ends with a semicolon, and C++ is case-sensitive.
