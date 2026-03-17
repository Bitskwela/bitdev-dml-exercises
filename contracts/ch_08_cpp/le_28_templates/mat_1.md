# Templates

![1.0 - COVER](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+28.0+-+COVER.png)

## Scene

Tian needed a `max()` function for integers, then doubles, then strings. Each time he wrote nearly identical code with only the type changed. "This is ridiculous!" he complained. "The logic is the same -- compare two values and return the larger one."

Kuya Miguel grinned. "Welcome to the problem that templates solve. Write the algorithm once, and it works for any type. This is how the STL works -- `vector<int>` and `vector<string>` use the same template code."

"Templates are compile-time code generation," Kuya Miguel explained. "You write generic code, and the compiler creates type-specific versions automatically. Power and efficiency without repetition."

## C++ Topics: Templates

![28.1](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_8/C8+28.1.png)

### Function Templates

> `template <typename T>` declares a generic type parameter `T`. The function can then use `T` as a placeholder type that gets replaced at compile time with the actual type used in the call.

### Type Inference

> The compiler automatically deduces the template type from the arguments. Calling `getMin(5, 10)` infers `T` as `int`, while `getMin(1.5, 0.5)` infers `T` as `double`.

### Multiple Template Parameters

> Templates can have multiple type parameters: `template <typename T1, typename T2>`. This allows functions and classes to work with two or more independent types.

### Class Templates

> Classes can also be templated. `template <typename T> class Box { T value; };` creates a generic container. Use it as `Box<int>` or `Box<string>`.

#### Sample syntax

```cpp
template <typename T>
T getMin(T a, T b) {
    return (a < b) ? a : b;
}

// Works with int, double, string -- any type with operator<
// getMin(5, 10)       -> 5
// getMin(1.5, 0.5)    -> 0.5
// getMin(string("A"), string("B")) -> "A"
```

The `template <typename T>` line tells the compiler that `T` is a placeholder. When you call `getMin(5, 10)`, the compiler generates an `int` version automatically. One function definition handles all types.
