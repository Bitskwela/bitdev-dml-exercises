# Property Testing

Odessa was staring at her screen, frustrated. "EJ, I wrote tests for specific inputs, but a user found a bug with a value I never thought to test. How do I test for _every_ possible input?"

EJ pulled up a chair. "You can't test every input manually. But you can define **properties**—rules that should _always_ be true—and let the testing framework try to break them."

## What is Property Testing?

"Traditional tests check specific examples," EJ explained. "Property tests check that certain properties hold for _any_ valid input."

```move
// Traditional test: Check specific values
#[test]
fun test_add_specific() {
    assert!(add(2, 3) == 5, 1);
    assert!(add(0, 0) == 0, 2);
    assert!(add(100, 200) == 300, 3);
}

// Property test: Check a property for any values
#[test]
fun test_add_commutative(a: u64, b: u64) {
    // Property: Addition is commutative (a + b == b + a)
    assert!(add(a, b) == add(b, a), 1);
}
```

## Invariants

"An **invariant** is a condition that must _always_ be true," EJ continued. "No matter what operations happen, the invariant holds."

Odessa nodded. "Like a bank balance never going negative?"

"Perfect example!" EJ said.

```move
module bank::account {
    struct Account has key {
        balance: u64,
    }

    // INVARIANT: Total deposits - Total withdrawals == Sum of all balances

    public fun withdraw(account: &mut Account, amount: u64) {
        // This maintains the invariant: balance >= 0
        assert!(account.balance >= amount, ERR_INSUFFICIENT_FUNDS);
        account.balance = account.balance - amount;
    }

    public fun deposit(account: &mut Account, amount: u64) {
        // This maintains the invariant: no overflow
        assert!(account.balance + amount >= account.balance, ERR_OVERFLOW);
        account.balance = account.balance + amount;
    }
}
```

## Common Properties to Test

EJ showed Odessa a list of common properties:

### 1. Preservation Properties

"After an operation, certain values should be preserved."

```move
#[test]
fun test_transfer_preserves_total(sender_initial: u64, amount: u64) {
    // Property: Total tokens before == Total tokens after transfer
    let receiver_initial = 0;

    // Assume valid transfer
    if (amount <= sender_initial) {
        transfer(sender, receiver, amount);

        let sender_final = balance(sender);
        let receiver_final = balance(receiver);

        // Total is preserved
        assert!(sender_initial + receiver_initial == sender_final + receiver_final, 1);
    }
}
```

### 2. Symmetry Properties

"Doing and undoing should return to the original state."

```move
#[test]
fun test_encode_decode_symmetry(original: vector<u8>) {
    // Property: decode(encode(x)) == x
    let encoded = encode(original);
    let decoded = decode(encoded);

    assert!(decoded == original, 1);
}
```

### 3. Idempotence Properties

"Doing something twice has the same effect as doing it once."

```move
#[test]
fun test_initialize_idempotent() {
    // Property: initialize() twice == initialize() once
    initialize();
    let state_after_first = get_state();

    initialize();
    let state_after_second = get_state();

    assert!(state_after_first == state_after_second, 1);
}
```

## Testing Invariants Across Operations

"The real power," EJ explained, "is testing that invariants hold _across sequences of operations_."

```move
#[test]
fun test_token_supply_invariant() {
    let initial_supply = total_supply();

    // Perform various operations
    mint(@0x1, 100);
    transfer(@0x1, @0x2, 30);
    burn(@0x2, 10);

    // Invariant: supply changes predictably
    // Started with initial_supply, minted 100, burned 10
    let expected_supply = initial_supply + 100 - 10;
    assert!(total_supply() == expected_supply, 1);
}
```

Odessa's eyes lit up. "So instead of testing 'does this specific thing work,' I'm testing 'does this rule always hold'?"

"Exactly," EJ smiled. "Properties capture the _essence_ of correctness. If your properties are right and they pass, you have much stronger guarantees than example-based tests alone."
