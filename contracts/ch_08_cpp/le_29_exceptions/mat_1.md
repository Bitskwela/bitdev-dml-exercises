# Exception Handling

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+29.0+-+COVER.png)

## Scene

Tian's program crashed during a demo when a user entered text where a number was expected. No error message, no recovery -- just an instant crash. "This is unprofessional!" the barangay captain said.

Kuya Miguel explained: "Exception handling. Instead of crashing, you detect problems, throw exceptions, and handle them gracefully. Invalid input? Catch it, show an error, let the user try again."

"Think of exceptions like safety nets," Kuya Miguel continued. "Trapeze artists perform high-risk moves, but nets catch them if they fall. Your code attempts risky operations, but exception handlers catch failures and keep the program running."

## C++ Topics: Exception Handling

![29.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+29.1.png)

### Try-Catch-Throw

> `try` wraps code that might fail. `throw` signals an error by creating an exception. `catch` handles the exception and decides what to do -- log it, retry, or show a message.

### Standard Exception Classes

> C++ provides `runtime_error`, `invalid_argument`, `out_of_range`, and others in `<stdexcept>`. They all inherit from `exception` and provide a `what()` method describing the error.

### Multiple Catch Blocks

> You can have multiple `catch` blocks to handle different exception types. They are checked in order, so put specific catches before general ones. `catch (...)` catches anything.

### Custom Exceptions

> Create your own exception classes by inheriting from `exception` and overriding `what()`. This lets you provide specific error information for your application's domain.

#### Sample syntax

```cpp
#include <stdexcept>

double safeDivide(double a, double b) {
    if (b == 0) throw runtime_error("Division by zero!");
    return a / b;
}

try {
    cout << safeDivide(10, 0);
} catch (const runtime_error& e) {
    cout << "Error: " << e.what() << endl;
}
// Program continues safely...
```

The `throw` statement creates a `runtime_error` exception when division by zero is detected. The `catch` block receives it by reference and prints the error message via `what()`. The program does not crash -- it continues after the catch block.
