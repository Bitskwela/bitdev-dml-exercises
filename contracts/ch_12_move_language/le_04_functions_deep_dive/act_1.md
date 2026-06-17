
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
    // ERROR CODES
    // ============================================

    // TODO: Define error code constants
    // E_DIVISION_BY_ZERO: u64 = 1
    // E_SUBTRACTION_UNDERFLOW: u64 = 2
    // E_INVALID_OPERATION: u64 = 3

    // ============================================
    // PRIVATE HELPER FUNCTIONS
    // ============================================

    // TODO: Create a private function called 'validate_divisor'
    // Takes a u64 parameter called 'divisor'
    // Returns true if divisor is not zero, false otherwise

    // TODO: Create a private function called 'validate_subtraction'
    // Takes two u64 parameters: a and b
    // Returns true if a >= b (subtraction won't underflow)

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
    // If divisor is zero, abort with E_DIVISION_BY_ZERO
    // Otherwise return the quotient

    // ============================================
    // MULTIPLE RETURN VALUES
    // ============================================

    // TODO: Create a public function called 'divide_with_remainder'
    // Takes two u64 parameters: dividend and divisor
    // Returns TWO values: (quotient, remainder)
    // Abort with E_DIVISION_BY_ZERO if divisor is zero

    // TODO: Create a public function called 'number_stats'
    // Takes one u64 parameter: n
    // Returns THREE values: (doubled, halved, is_even)

    // ============================================
    // ENTRY FUNCTIONS (callable from transactions)
    // ============================================

    // TODO: Create a public entry function called 'perform_calculation'
    // Takes three parameters: a (u64), b (u64), operation (u8)
    // operation: 0 = add, 1 = subtract, 2 = multiply, 3 = divide
    // Abort with E_INVALID_OPERATION for any other operation code
    // This demonstrates how entry functions work
    // (In a real app, this would store the result somewhere)
}
```

## Tasks

1. **Define error code constants**

   - Declare `const E_DIVISION_BY_ZERO: u64 = 1;`
   - Declare `const E_SUBTRACTION_UNDERFLOW: u64 = 2;`
   - Declare `const E_INVALID_OPERATION: u64 = 3;`
   - These give meaningful context when an operation aborts

2. **Create private helper functions**

   - Write `validate_divisor` that returns a boolean
   - Check if the divisor equals zero
   - This helper keeps validation logic reusable
   - Also write `validate_subtraction(a: u64, b: u64): bool` that returns `true` when `a >= b`
     (used by `subtract` to guard against underflow)

   ```move
   fun validate_subtraction(a: u64, b: u64): bool {
       a >= b
   }
   ```

3. **Implement public arithmetic functions**

   - `add`, `subtract`, `multiply`, `divide`
   - Each takes two u64 parameters and returns u64
   - `subtract` must use `validate_subtraction` and abort with `E_SUBTRACTION_UNDERFLOW` when `b > a`
   - `divide` must use `validate_divisor` and abort with `E_DIVISION_BY_ZERO` on zero

4. **Implement multiple return values**

   - `divide_with_remainder` returns a tuple `(u64, u64)`
   - Use the tuple return syntax: `(quotient, remainder)`
   - Also write `number_stats(n: u64): (u64, u64, bool)` that returns the number doubled, halved,
     and whether it is even — a three-value tuple

   ```move
   public fun number_stats(n: u64): (u64, u64, bool) {
       let doubled = n * 2;
       let halved = n / 2;
       let is_even = n % 2 == 0;
       (doubled, halved, is_even)
   }
   ```

5. **Add the entry point**
   - Write a `public entry fun perform_calculation(a: u64, b: u64, operation: u8)`
   - Dispatch on `operation` (0 = add, 1 = subtract, 2 = multiply, 3 = divide)
   - Abort with `E_INVALID_OPERATION` for any other operation code

## Expected Behavior

After completing this activity:

- `add(10, 5)` returns `15`
- `subtract(10, 5)` returns `5`
- `multiply(10, 5)` returns `50`
- `divide(10, 5)` returns `2`
- `divide(10, 0)` aborts with `E_DIVISION_BY_ZERO`
- `divide_with_remainder(17, 5)` returns `(3, 2)`
- `number_stats(10)` returns `(20, 5, true)`

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
    assert!(validate_divisor(divisor), E_DIVISION_BY_ZERO);
    dividend / divisor
}
```

</details>

<details>
<summary>Hint 4: Multiple return values</summary>

Return a tuple and declare the return type accordingly:

```move
public fun divide_with_remainder(dividend: u64, divisor: u64): (u64, u64) {
    assert!(validate_divisor(divisor), E_DIVISION_BY_ZERO);
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
    } else if (operation == 3) {
        divide(a, b)
    } else {
        abort E_INVALID_OPERATION
    };
    // Result would typically be stored or emitted as an event
}
```

</details>

