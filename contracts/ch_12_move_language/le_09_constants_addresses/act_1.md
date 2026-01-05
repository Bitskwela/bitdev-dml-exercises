## Smart contract activity

```move
module movestack::config {
    // ============================================
    // ERROR CODES
    // ============================================

    // TODO: Define constant error codes
    // EINVALID_AMOUNT: u64 = 1
    // EUNAUTHORIZED: u64 = 2
    // ELIMIT_EXCEEDED: u64 = 3

    // ============================================
    // SYSTEM LIMITS
    // ============================================

    // TODO: Define system limit constants
    // MAX_SUPPLY: u64 = 1_000_000_000
    // MIN_STAKE: u64 = 100
    // MAX_VALIDATORS: u64 = 100

    // ============================================
    // CONFIGURATION GETTERS
    // ============================================

    // TODO: Create a public function called 'get_max_supply'
    // Returns the MAX_SUPPLY constant

    // TODO: Create a public function called 'get_min_stake'
    // Returns the MIN_STAKE constant

    // TODO: Create a public function called 'get_max_validators'
    // Returns the MAX_VALIDATORS constant

    // ============================================
    // VALIDATION FUNCTIONS
    // ============================================

    // TODO: Create a public function called 'validate_amount'
    // Takes amount: u64
    // Asserts that amount > 0 using EINVALID_AMOUNT
    // Asserts that amount <= MAX_SUPPLY using ELIMIT_EXCEEDED

    // TODO: Create a public function called 'validate_stake'
    // Takes stake: u64
    // Asserts stake >= MIN_STAKE using EINVALID_AMOUNT
    // Returns true if valid

    // ============================================
    // ADDRESS UTILITIES
    // ============================================

    // TODO: Create a public function called 'get_module_address'
    // Returns the movestack named address as an address type
}
```

## Tasks for Learners

- Define error code constants using the `const` keyword with `u64` type. Use SCREAMING_SNAKE_CASE naming convention:

  ```move
  const EINVALID_AMOUNT: u64 = 1;
  const EUNAUTHORIZED: u64 = 2;
  const ELIMIT_EXCEEDED: u64 = 3;
  ```

- Define system limit constants. Use underscores for readability in large numbers:

  ```move
  const MAX_SUPPLY: u64 = 1_000_000_000;
  const MIN_STAKE: u64 = 100;
  const MAX_VALIDATORS: u64 = 100;
  ```

- Create getter functions that return the constant values. These allow other modules to access configuration without exposing constants directly:

  ```move
  public fun get_max_supply(): u64 {
      MAX_SUPPLY
  }

  public fun get_min_stake(): u64 {
      MIN_STAKE
  }

  public fun get_max_validators(): u64 {
      MAX_VALIDATORS
  }
  ```

- Create validation functions that use `assert!` with your error constants to enforce rules:

  ```move
  public fun validate_amount(amount: u64) {
      assert!(amount > 0, EINVALID_AMOUNT);
      assert!(amount <= MAX_SUPPLY, ELIMIT_EXCEEDED);
  }

  public fun validate_stake(stake: u64): bool {
      assert!(stake >= MIN_STAKE, EINVALID_AMOUNT);
      true
  }
  ```

- Create an address utility function that returns the named address using the `@` syntax:

  ```move
  public fun get_module_address(): address {
      @movestack
  }
  ```

### Breakdown for Learners

**Constants in Move:** Constants are compile-time values declared with the `const` keyword. They must be uppercase with underscores (SCREAMING_SNAKE_CASE). Constants are evaluated at compile time, so there is zero runtime cost for using them.

**Named Addresses:** Named addresses like `@movestack` are symbolic references resolved at compile time based on the `Move.toml` configuration. This allows the same code to be deployed to different addresses depending on the environment.

**Error Code Convention:** Error constants in Move typically start with `E` (like `EINVALID_AMOUNT`). This makes it easy to identify them and provides meaningful context when transactions abort.

**Why use getter functions?** Even though constants are fixed, wrapping them in functions provides abstraction. Other modules call `get_max_supply()` instead of depending on the constant directly, making future changes easier.
