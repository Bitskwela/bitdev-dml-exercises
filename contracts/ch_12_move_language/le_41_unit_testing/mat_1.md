# Unit Testing

## Scene: The Untested Code

EJ pushes back from his keyboard with a groan. "I just deployed an update and now the whole system is acting weird. Users can't withdraw their tokens."

Neri walks over, eyebrow raised. "Did you test it before deploying?"

"I mean... I compiled it successfully?" EJ offers weakly.

Neri sighs. "Compilation just means the syntax is correct. It doesn't mean your logic works. You need unit tests."

"Unit tests?" EJ perks up. "I've heard of those. But how do we write them in Move?"

Neri pulls up a fresh file. "Move has built-in testing support. You write test functions right alongside your code, mark them with special attributes, and the framework runs them automatically. Let me show you."

---

## Topics

### The `#[test]` Attribute

In Move, you mark a function as a test by adding the `#[test]` attribute above it:

```move
module movestack::calculator {
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    #[test]
    fun test_add() {
        let result = add(2, 3);
        assert!(result == 5, 0);
    }
}
```

**Key points:**

- Test functions are only compiled when running tests, not in production
- They don't need to be `public`—they're internal to the module
- Each test should focus on one specific behavior

### The `assert!` Macro

`assert!` is your primary tool for checking conditions in tests:

```move
#[test]
fun test_assertions() {
    let value = 100;

    // assert!(condition, error_code)
    assert!(value == 100, 0);        // Passes
    assert!(value > 50, 1);          // Passes
    assert!(value != 0, 2);          // Passes

    // If condition is false, test aborts with the error code
    // assert!(value == 200, 3);     // Would fail with error 3
}
```

**The two arguments:**

1. **condition**: A boolean expression that should be `true`
2. **error_code**: A `u64` that identifies which assertion failed

### Testing with Signers

Many Move functions need a `signer` to work with accounts. Use `#[test]` with parameters:

```move
module movestack::wallet {
    use std::signer;

    struct Balance has key {
        amount: u64
    }

    public fun initialize(account: &signer) {
        move_to(account, Balance { amount: 0 });
    }

    public fun get_balance(addr: address): u64 acquires Balance {
        borrow_global<Balance>(addr).amount
    }

    #[test(user = @0x123)]
    fun test_initialize(user: &signer) acquires Balance {
        initialize(user);

        let addr = signer::address_of(user);
        assert!(get_balance(addr) == 0, 0);
    }
}
```

**The syntax `#[test(user = @0x123)]`:**

- Creates a test signer with address `0x123`
- Passes it as the `user` parameter to your test function

### Expected Failures with `#[expected_failure]`

Sometimes you want to verify that code correctly aborts under certain conditions:

```move
module movestack::safe_math {
    const E_DIVISION_BY_ZERO: u64 = 1;

    public fun divide(a: u64, b: u64): u64 {
        assert!(b != 0, E_DIVISION_BY_ZERO);
        a / b
    }

    #[test]
    fun test_divide_success() {
        assert!(divide(10, 2) == 5, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_DIVISION_BY_ZERO)]
    fun test_divide_by_zero() {
        divide(10, 0); // This should abort!
    }
}
```

**Expected failure options:**

```move
// Expect any abort
#[expected_failure]

// Expect a specific abort code
#[expected_failure(abort_code = 1)]

// Expect abort with a named constant
#[expected_failure(abort_code = E_NOT_FOUND)]

// Expect arithmetic error (overflow, division by zero)
#[expected_failure(arithmetic_error, location = movestack::module_name)]
```

### Multiple Test Parameters

You can create multiple signers for testing interactions between accounts:

```move
module movestack::transfer {
    use std::signer;

    struct Coins has key {
        value: u64
    }

    public fun mint(account: &signer, amount: u64) {
        move_to(account, Coins { value: amount });
    }

    public fun transfer(from: &signer, to: address, amount: u64) acquires Coins {
        let from_coins = borrow_global_mut<Coins>(signer::address_of(from));
        assert!(from_coins.value >= amount, 1);
        from_coins.value = from_coins.value - amount;

        let to_coins = borrow_global_mut<Coins>(to);
        to_coins.value = to_coins.value + amount;
    }

    #[test(alice = @0x1, bob = @0x2)]
    fun test_transfer(alice: &signer, bob: &signer) acquires Coins {
        // Setup
        mint(alice, 100);
        mint(bob, 50);

        // Action
        transfer(alice, @0x2, 30);

        // Verify
        assert!(borrow_global<Coins>(@0x1).value == 70, 0);
        assert!(borrow_global<Coins>(@0x2).value == 80, 1);
    }
}
```

---

## Scene: Tests to the Rescue

Neri finishes explaining, and EJ immediately starts writing tests for his buggy code.

"Found it!" EJ exclaims after a few minutes. "My subtraction was happening before the balance check. The test caught it right away."

```move
#[test(user = @0x1)]
#[expected_failure(abort_code = E_INSUFFICIENT_BALANCE)]
fun test_withdraw_insufficient_funds(user: &signer) acquires Account {
    initialize(user);
    deposit(user, 50);
    withdraw(user, 100);  // Should fail—only has 50!
}
```

"That's the power of testing," Neri says. "You catch bugs before your users do. Write tests for every important behavior, especially edge cases."

EJ nods, already adding more test cases. "From now on, no deployment without tests."

---

## Running Tests

To run your tests, use the Move CLI:

```bash
# Run all tests
aptos move test

# Run with verbose output
aptos move test --verbose

# Run tests matching a filter
aptos move test --filter test_transfer
```

**Test output:**

```
Running Move unit tests
[ PASS    ] 0x1::calculator::test_add
[ PASS    ] 0x1::safe_math::test_divide_success
[ PASS    ] 0x1::safe_math::test_divide_by_zero
Test result: OK. Total tests: 3; passed: 3; failed: 0
```

---

## Summary

| Concept          | Syntax                                | Purpose                               |
| ---------------- | ------------------------------------- | ------------------------------------- |
| Basic test       | `#[test]`                             | Mark a function as a test             |
| Assertion        | `assert!(condition, code)`            | Verify expected behavior              |
| Test signer      | `#[test(name = @0x1)]`                | Provide signer for account operations |
| Expected failure | `#[expected_failure]`                 | Verify code aborts correctly          |
| Specific abort   | `#[expected_failure(abort_code = N)]` | Check for exact error code            |
