# Test Fixtures: Building Reusable Test Helpers

EJ found Jaymart surrounded by multiple test files, each with nearly identical setup code repeated over and over.

"Bro, why does every test file have the same 20 lines at the start?" EJ asked, scrolling through the repetitive code.

Jaymart sighed. "I know, I know. Every time I write a new test, I copy-paste the setup. It's getting out of hand."

"There's a better way," EJ said. "Move has **test fixtures**—reusable helpers that only exist during testing."

---

## The Problem with Repeated Setup

Without fixtures, tests often look like this:

```move
#[test]
fun test_deposit() {
    let account = create_account();
    let balance = 0;
    let is_active = true;
    // ... same setup in every test
}

#[test]
fun test_withdraw() {
    let account = create_account();
    let balance = 0;
    let is_active = true;
    // ... same setup again!
}
```

"Every test repeats the same initialization," Jaymart groaned.

---

## The `#[test_only]` Attribute

EJ pulled up a cleaner approach. "Use `#[test_only]` to create helpers that only compile during tests."

```move
module fixtures::bank {
    struct Account has drop {
        balance: u64,
        is_active: bool
    }

    // Production code
    public fun deposit(account: &mut Account, amount: u64) {
        account.balance = account.balance + amount;
    }

    public fun withdraw(account: &mut Account, amount: u64) {
        assert!(account.balance >= amount, 1);
        account.balance = account.balance - amount;
    }

    // ========== TEST HELPERS ==========

    #[test_only]
    /// Creates a fresh account for testing
    public fun setup_account(): Account {
        Account {
            balance: 0,
            is_active: true
        }
    }

    #[test_only]
    /// Creates an account with a specific starting balance
    public fun setup_account_with_balance(initial: u64): Account {
        Account {
            balance: initial,
            is_active: true
        }
    }

    #[test_only]
    /// Gets the current balance (for test assertions)
    public fun get_balance(account: &Account): u64 {
        account.balance
    }
}
```

"The `#[test_only]` functions are invisible to production code," EJ explained. "They only exist when running tests."

---

## Using Fixtures in Tests

```move
#[test]
fun test_deposit_increases_balance() {
    let mut account = setup_account();
    deposit(&mut account, 100);
    assert!(get_balance(&account) == 100, 0);
}

#[test]
fun test_withdraw_decreases_balance() {
    let mut account = setup_account_with_balance(500);
    withdraw(&mut account, 200);
    assert!(get_balance(&account) == 300, 0);
}

#[test]
#[expected_failure(abort_code = 1)]
fun test_withdraw_fails_when_insufficient() {
    let mut account = setup_account_with_balance(50);
    withdraw(&mut account, 100); // Should fail!
}
```

Jaymart's eyes lit up. "So I define the setup once and reuse it everywhere!"

---

## Test-Only Modules

For larger projects, you can create entire modules dedicated to testing:

```move
#[test_only]
module fixtures::test_helpers {
    use fixtures::bank::{Self, Account};

    public fun create_funded_account(): Account {
        bank::setup_account_with_balance(1000)
    }

    public fun create_multiple_accounts(count: u64): vector<Account> {
        let mut accounts = vector[];
        let mut i = 0;
        while (i < count) {
            vector::push_back(&mut accounts, bank::setup_account());
            i = i + 1;
        };
        accounts
    }
}
```

"An entire module marked `#[test_only]` is completely excluded from production builds," EJ noted.

---

## Best Practices for Test Fixtures

1. **Name helpers clearly**: `setup_*`, `create_*`, `mock_*`
2. **Keep fixtures simple**: They should set up state, not test logic
3. **Parameterize when needed**: Let tests customize the setup
4. **Group related helpers**: Use test-only modules for organization

---

"This is gonna clean up my test files so much," Jaymart said, already refactoring.

"Clean tests are maintainable tests," EJ replied. "When tests are easy to read, bugs have nowhere to hide."
