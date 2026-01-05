````markdown
# Activity: Building a Calculator Module

## Objective

Create a comprehensive calculator module that demonstrates function syntax, parameters, return values, and visibility modifiers in Move.

## Scenario

Det leans back in his chair, watching Neri and Jaymart collaborate at a workstation. "Functions are the building blocks of any program," he begins. "But in Move, we have some specific patterns—visibility modifiers, multiple return values, and the distinction between entry functions and regular public functions."

Neri nods. "I noticed that some functions use `public entry` and others just use `public`. What's the difference?"

"Entry functions can be called directly from transactions," Det explains. "Regular public functions are meant to be called by other modules. Let's build a calculator to explore both."

Jaymart grabs a notepad. "So we'll have internal helpers, public utilities, and entry points for users?"

"Exactly," Det smiles. "Three layers of visibility, each with a purpose."

## Starter Code

```move
module movestack::calculator {
    // ============================================
    // PRIVATE HELPER FUNCTIONS
    // ============================================

    // TODO: Create a private function called 'validate_divisor'
    // Takes a u64 parameter called 'divisor'
    // Returns true if divisor is not zero, false otherwise

    // ============================================
    // PUBLIC FUNCTIONS (callable by other modules)
    // ============================================

    // TODO: Create a public function called 'add'
    // Takes two u64 parameters: a and b
    // Returns their sum as u64

    // TODO: Create a public function called 'subtract'
    // Takes two u64 parameters: a and b
    // Returns (a - b) as u64
    // Note: Will abort if b > a (Move doesn't have negative integers)

    // TODO: Create a public function called 'multiply'
    // Takes two u64 parameters: a and b
    // Returns their product as u64

    // TODO: Create a public function called 'divide'
    // Takes two u64 parameters: dividend and divisor
    // Use validate_divisor to check for zero
    // If divisor is zero, abort with error code 1
    // Otherwise return the quotient

    // ============================================
    // MULTIPLE RETURN VALUES
    // ============================================

    // TODO: Create a public function called 'divide_with_remainder'
    // Takes two u64 parameters: dividend and divisor
    // Returns TWO values: (quotient, remainder)
    // Abort with error code 1 if divisor is zero

    // ============================================
    // ENTRY FUNCTIONS (callable from transactions)
    // ============================================

    // TODO: Create a public entry function called 'perform_calculation'
    // Takes three parameters: a (u64), b (u64), operation (u8)
    // operation: 0 = add, 1 = subtract, 2 = multiply, 3 = divide
    // This demonstrates how entry functions work
    // (In a real app, this would store the result somewhere)
}
```

## Tasks

1. **Create private helper function**

   - Write `validate_divisor` that returns a boolean
   - Check if the divisor equals zero
   - This helper keeps validation logic reusable

2. **Implement public arithmetic functions**

   - `add`, `subtract`, `multiply`, `divide`
   - Each takes two u64 parameters and returns u64
   - `divide` must use `validate_divisor` and abort on zero

3. **Implement multiple return values**
   - `divide_with_remainder` returns a tuple `(u64, u64)`
   - Use the tuple return syntax: `(quotient, remainder)`

## Expected Behavior

After completing this activity:

- `add(10, 5)` returns `15`
- `subtract(10, 5)` returns `5`
- `multiply(10, 5)` returns `50`
- `divide(10, 5)` returns `2`
- `divide(10, 0)` aborts with error code 1
- `divide_with_remainder(17, 5)` returns `(3, 2)`

## Hints

<details>
<summary>Hint 1: Private function syntax</summary>

Functions without `public` keyword are module-private:

```move
fun validate_divisor(divisor: u64): bool {
    divisor != 0
}
```

</details>

<details>
<summary>Hint 2: Public function with return value</summary>

Public functions use the `public` keyword:

```move
public fun add(a: u64, b: u64): u64 {
    a + b
}
```

</details>

<details>
<summary>Hint 3: Abort on invalid input</summary>

Use `assert!` or `if` with `abort` for error handling:

```move
public fun divide(dividend: u64, divisor: u64): u64 {
    assert!(validate_divisor(divisor), 1);
    dividend / divisor
}
```

</details>

<details>
<summary>Hint 4: Multiple return values</summary>

Return a tuple and declare the return type accordingly:

```move
public fun divide_with_remainder(dividend: u64, divisor: u64): (u64, u64) {
    assert!(divisor != 0, 1);
    let quotient = dividend / divisor;
    let remainder = dividend % divisor;
    (quotient, remainder)
}
```

</details>

<details>
<summary>Hint 5: Entry function syntax</summary>

Entry functions can be called directly from transactions:

```move
public entry fun perform_calculation(a: u64, b: u64, operation: u8) {
    let _result = if (operation == 0) {
        add(a, b)
    } else if (operation == 1) {
        subtract(a, b)
    } else if (operation == 2) {
        multiply(a, b)
    } else {
        divide(a, b)
    };
    // Result would typically be stored or emitted as an event
}
```

</details>
````
