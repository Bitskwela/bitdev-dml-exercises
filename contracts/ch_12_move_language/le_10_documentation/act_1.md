## Smart contract activity

```move
module movestack::math_utils {
    // ============================================
    // CONSTANTS
    // ============================================

    // TODO: Add doc comment for this constant
    const MAX_U64: u64 = 18446744073709551615;

    // TODO: Add doc comment for this error constant
    const EDIVISION_BY_ZERO: u64 = 1;

    // TODO: Add doc comment for this error constant
    const EOVERFLOW: u64 = 2;

    // ============================================
    // SAFE ARITHMETIC FUNCTIONS
    // ============================================

    // TODO: Create 'safe_add' with doc comments
    // Takes a: u64, b: u64
    // Returns a + b, aborts on overflow

    // TODO: Create 'safe_sub' with doc comments
    // Takes a: u64, b: u64
    // Returns a - b, aborts if b > a

    // TODO: Create 'safe_div' with doc comments
    // Takes a: u64, b: u64
    // Returns a / b, aborts if b == 0

    // ============================================
    // UTILITY FUNCTIONS
    // ============================================

    // TODO: Create 'max' with doc comments
    // Returns the larger of two u64 values

    // TODO: Create 'min' with doc comments
    // Returns the smaller of two u64 values

    // TODO: Create 'is_even' with doc comments
    // Returns true if the number is even
}
```

## Tasks for Learners

- Add doc comments (`///`) to constants explaining their purpose. Doc comments generate documentation and describe the public interface:

  ```move
  /// The maximum value a u64 can hold.
  /// Useful for overflow checking.
  const MAX_U64: u64 = 18446744073709551615;

  /// Error code: Division by zero attempted.
  const EDIVISION_BY_ZERO: u64 = 1;

  /// Error code: Arithmetic overflow or underflow.
  const EOVERFLOW: u64 = 2;
  ```

- Create `safe_add` with full documentation including parameters, return value, and abort conditions:

  ```move
  /// Safely adds two u64 values with overflow protection.
  ///
  /// # Parameters
  /// * `a` - The first operand
  /// * `b` - The second operand
  ///
  /// # Returns
  /// The sum of `a` and `b`
  ///
  /// # Aborts
  /// * `EOVERFLOW` - If the sum would exceed MAX_U64
  public fun safe_add(a: u64, b: u64): u64 {
      assert!(MAX_U64 - a >= b, EOVERFLOW);
      a + b
  }
  ```

- Create `safe_sub` with documentation explaining the underflow check:

  ```move
  /// Safely subtracts b from a with underflow protection.
  ///
  /// # Parameters
  /// * `a` - The value to subtract from
  /// * `b` - The value to subtract
  ///
  /// # Returns
  /// The difference: a - b
  ///
  /// # Aborts
  /// * `EOVERFLOW` - If `b` is greater than `a`
  public fun safe_sub(a: u64, b: u64): u64 {
      assert!(a >= b, EOVERFLOW);
      a - b
  }
  ```

- Create `safe_div` with documentation for division-by-zero protection:

  ```move
  /// Safely divides a by b with division-by-zero protection.
  ///
  /// # Parameters
  /// * `a` - The dividend
  /// * `b` - The divisor
  ///
  /// # Returns
  /// The quotient: a / b
  ///
  /// # Aborts
  /// * `EDIVISION_BY_ZERO` - If `b` is zero
  public fun safe_div(a: u64, b: u64): u64 {
      assert!(b != 0, EDIVISION_BY_ZERO);
      a / b
  }
  ```

- Create utility functions with concise doc comments:

  ```move
  /// Returns the larger of two u64 values.
  public fun max(a: u64, b: u64): u64 {
      if (a > b) a else b
  }

  /// Returns the smaller of two u64 values.
  public fun min(a: u64, b: u64): u64 {
      if (a < b) a else b
  }

  /// Returns true if the number is even.
  public fun is_even(n: u64): bool {
      n % 2 == 0
  }
  ```

### Breakdown for Learners

**Comment Types in Move:**

- `//` - Line comments for quick notes and inline explanations
- `/* */` - Block comments for longer explanations or disabling code
- `///` - Doc comments that generate documentation for the public interface

**Doc Comment Best Practices:** Doc comments should explain _what_ something does and _why_, not _how_. Focus on parameters, return values, and abort conditions. The code itself shows the implementation details.

**Standard Sections:** Use markdown-style headers in doc comments:

- `# Parameters` - Describe each parameter
- `# Returns` - Describe the return value
- `# Aborts` - List conditions that cause the function to abort

**Why Document?** Good documentation serves as a contract with other developers. When someone calls your function, they should know exactly what to expect without reading the implementation.
