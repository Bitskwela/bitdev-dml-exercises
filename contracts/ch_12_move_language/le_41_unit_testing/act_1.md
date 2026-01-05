## Smart contract activity

```move
module movestack::token_vault {
    use std::signer;

    const E_NOT_INITIALIZED: u64 = 1;
    const E_ALREADY_INITIALIZED: u64 = 2;
    const E_INSUFFICIENT_BALANCE: u64 = 3;

    struct Vault has key {
        balance: u64
    }

    public fun initialize(account: &signer) {
        let addr = signer::address_of(account);
        assert!(!exists<Vault>(addr), E_ALREADY_INITIALIZED);
        move_to(account, Vault { balance: 0 });
    }

    public fun deposit(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        assert!(exists<Vault>(addr), E_NOT_INITIALIZED);
        let vault = borrow_global_mut<Vault>(addr);
        vault.balance = vault.balance + amount;
    }

    public fun withdraw(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        assert!(exists<Vault>(addr), E_NOT_INITIALIZED);
        let vault = borrow_global_mut<Vault>(addr);
        assert!(vault.balance >= amount, E_INSUFFICIENT_BALANCE);
        vault.balance = vault.balance - amount;
    }

    public fun get_balance(addr: address): u64 acquires Vault {
        assert!(exists<Vault>(addr), E_NOT_INITIALIZED);
        borrow_global<Vault>(addr).balance
    }

    // TODO: Write a test that initializes a vault and checks the balance is 0
    // Hint: Use #[test(user = @0x1)] to create a test signer

    // TODO: Write a test that deposits tokens and verifies the new balance
    // Hint: Initialize first, then deposit, then check balance

    // TODO: Write a test that expects failure when withdrawing more than balance
    // Hint: Use #[expected_failure(abort_code = E_INSUFFICIENT_BALANCE)]

    // TODO: Write a test that expects failure when double-initializing
    // Hint: Call initialize twice on the same account
}
```

## Tasks for Learners

Write unit tests for the `token_vault` module. Each test should verify a specific behavior of the contract.

- Write a test called `test_initialize` that creates a vault and verifies the initial balance is 0:

  ```move
  #[test(user = @0x1)]
  fun test_initialize(user: &signer) acquires Vault {
      initialize(user);
      assert!(get_balance(@0x1) == 0, 0);
  }
  ```

- Write a test called `test_deposit` that deposits tokens and checks the balance:

  ```move
  #[test(user = @0x1)]
  fun test_deposit(user: &signer) acquires Vault {
      initialize(user);
      deposit(user, 100);
      assert!(get_balance(@0x1) == 100, 0);
  }
  ```

- Write a test called `test_withdraw_insufficient` that expects failure when withdrawing more than available:

  ```move
  #[test(user = @0x1)]
  #[expected_failure(abort_code = E_INSUFFICIENT_BALANCE)]
  fun test_withdraw_insufficient(user: &signer) acquires Vault {
      initialize(user);
      deposit(user, 50);
      withdraw(user, 100);  // Should abort!
  }
  ```

- Write a test called `test_double_initialize` that expects failure when initializing twice:

  ```move
  #[test(user = @0x1)]
  #[expected_failure(abort_code = E_ALREADY_INITIALIZED)]
  fun test_double_initialize(user: &signer) {
      initialize(user);
      initialize(user);  // Should abort!
  }
  ```

### Breakdown for learners

**The `#[test]` attribute** marks a function as a unit test. Test functions are only compiled during testing, not in production builds.

**Test signers** are created using `#[test(name = @address)]`. This provides a signer that you can use to call functions requiring account authorization.

**The `assert!` macro** takes a condition and an error code. If the condition is false, the test aborts with that error code, indicating which assertion failed.

**Expected failures** use `#[expected_failure]` to verify that code correctly aborts. You can specify the exact abort code to ensure the right error is triggered.

**Testing strategy:**

1. Test the happy path (normal operations work correctly)
2. Test edge cases (zero values, maximum values)
3. Test error conditions (verify proper aborts)
4. Test state changes (verify storage is updated correctly)
