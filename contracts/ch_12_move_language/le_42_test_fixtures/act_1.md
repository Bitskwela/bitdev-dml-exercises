# Activity 1: Create Test Fixtures for a Wallet Module

## Context

EJ challenged Jaymart: "Let's put your new knowledge to work. Build a wallet module with proper test fixtures."

"Bet," Jaymart replied. "No more copy-paste chaos."

---

## Task

Create a `Wallet` module with:

1. A `Wallet` struct with `owner` (address) and `coins` (u64)
2. Functions to `add_coins` and `spend_coins`
3. **Test fixtures** using `#[test_only]`:
   - `setup_wallet(owner: address): Wallet` - creates wallet with 0 coins
   - `setup_wallet_with_coins(owner: address, amount: u64): Wallet` - creates wallet with specified coins
   - `get_coins(wallet: &Wallet): u64` - returns coin count for assertions
4. At least **two tests** using your fixtures

---

## Starter Code

```move
module fixtures::wallet {
    // TODO: Define the Wallet struct with 'owner' (address) and 'coins' (u64)
    // It should have the 'drop' ability

    // TODO: Implement add_coins function
    // Takes mutable reference to Wallet and amount to add

    // TODO: Implement spend_coins function
    // Takes mutable reference to Wallet and amount to spend
    // Should abort if insufficient coins (abort code: 1)

    // ========== TEST FIXTURES ==========

    // TODO: Create setup_wallet fixture with #[test_only]

    // TODO: Create setup_wallet_with_coins fixture with #[test_only]

    // TODO: Create get_coins helper with #[test_only]

    // ========== TESTS ==========

    // TODO: Write test_add_coins using fixtures

    // TODO: Write test_spend_coins using fixtures
}
```

---

## Requirements

- Use `#[test_only]` for all fixture functions
- Tests must use fixtures (no direct struct creation in tests)
- `spend_coins` must abort with code `1` if spending more than available

---

## Hints

<details>
<summary>Hint 1: Struct definition</summary>

```move
struct Wallet has drop {
    owner: address,
    coins: u64
}
```

</details>

<details>
<summary>Hint 2: Test-only attribute</summary>

```move
#[test_only]
public fun setup_wallet(owner: address): Wallet {
    // Create and return wallet
}
```

</details>

<details>
<summary>Hint 3: Using fixtures in tests</summary>

```move
#[test]
fun test_add_coins() {
    let mut wallet = setup_wallet(@0x1);
    add_coins(&mut wallet, 100);
    assert!(get_coins(&wallet) == 100, 0);
}
```

</details>
