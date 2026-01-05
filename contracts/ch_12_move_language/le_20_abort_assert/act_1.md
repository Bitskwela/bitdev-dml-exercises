### Smart contract activity

```move
module savings::secure_fund {

    /// Error codes
    const E_INSUFFICIENT_BALANCE: u64 = 1;
    const E_INVALID_AMOUNT: u64 = 2;
    const E_NOT_AUTHORIZED: u64 = 3;
    const E_FUND_CLOSED: u64 = 4;
    const E_ALREADY_CLAIMED: u64 = 5;

    // TODO: Implement safe_withdraw function

    // TODO: Implement validate_deposit function

    // TODO: Implement claim_relief function

    // TODO: Implement admin_transfer function
}
```

## Tasks for Learners

- Implement `safe_withdraw` using `abort` to prevent overdrafts:

  - Abort with E_INVALID_AMOUNT if amount is 0
  - Abort with E_INSUFFICIENT_BALANCE if amount > balance
  - Return the new balance after withdrawal

  ```move
  public fun safe_withdraw(balance: u64, amount: u64): u64 {
      if (amount == 0) {
          abort E_INVALID_AMOUNT
      };
      if (amount > balance) {
          abort E_INSUFFICIENT_BALANCE
      };
      balance - amount
  }
  ```

- Implement `validate_deposit` using `assert!` for cleaner validation:

  - Assert that amount > 0 (error: E_INVALID_AMOUNT)
  - Assert that is_fund_open is true (error: E_FUND_CLOSED)
  - Return the new balance after deposit

  ```move
  public fun validate_deposit(balance: u64, amount: u64, is_fund_open: bool): u64 {
      assert!(amount > 0, E_INVALID_AMOUNT);
      assert!(is_fund_open, E_FUND_CLOSED);
      balance + amount
  }
  ```

- Implement `claim_relief` with multiple validation checks:

  - Assert is_registered is true (error: E_NOT_AUTHORIZED)
  - Assert has_claimed is false (error: E_ALREADY_CLAIMED)
  - Assert is_distribution_open is true (error: E_FUND_CLOSED)
  - Return the relief amount (1000)

  ```move
  public fun claim_relief(
      is_registered: bool,
      has_claimed: bool,
      is_distribution_open: bool
  ): u64 {
      assert!(is_registered, E_NOT_AUTHORIZED);
      assert!(!has_claimed, E_ALREADY_CLAIMED);
      assert!(is_distribution_open, E_FUND_CLOSED);
      1000
  }
  ```

- Implement `admin_transfer` combining abort and assert patterns:

  - Assert is_admin is true (error: E_NOT_AUTHORIZED)
  - Use abort for complex balance check: amount must be > 0 AND <= balance
  - Return the remaining balance

  ```move
  public fun admin_transfer(
      is_admin: bool,
      balance: u64,
      amount: u64
  ): u64 {
      assert!(is_admin, E_NOT_AUTHORIZED);

      if (amount == 0 || amount > balance) {
          abort E_INVALID_AMOUNT
      };

      balance - amount
  }
  ```

### Breakdown for learners

- Abort Statement:

  - `abort error_code` immediately stops execution
  - All transaction changes are reverted
  - Error code is a u64 that identifies the failure reason

- Assert! Macro:

  - `assert!(condition, error_code)` is shorthand for if-abort
  - If condition is false, aborts with the error code
  - Cleaner than writing explicit if-abort blocks

- Error Code Conventions:

  - Define error codes as constants at module top
  - Use meaningful names like E_INSUFFICIENT_BALANCE
  - Group by category (1xx validation, 2xx auth, etc.)

- Fail Fast Pattern:

  - Put all validations at the beginning of functions
  - Check preconditions before any state changes
  - Makes debugging easier by failing early

- Combining Patterns:

  - Use assert! for simple boolean checks
  - Use abort for complex conditions requiring if statements
  - Both achieve the same result: stopping invalid transactions
