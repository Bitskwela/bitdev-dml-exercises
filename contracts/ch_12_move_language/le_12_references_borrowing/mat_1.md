# References and Borrowing

## Scene: Looking Without Taking

Det sets his coffee on the desk and turns to face Neri and Jaymart. The morning sun streams through the MoveStack office windows as the team gathers around the whiteboard.

"Yesterday we learned that values move," Det begins, drawing a box on the whiteboard labeled "Token". "When you pass a Token to a function, that function takes ownership. But what if you just want to _look_ at the token? Read its balance without taking it away?"

Neri nods slowly. "That's exactly the problem I hit yesterday. I wanted to check if a user had enough tokens before a transfer, but my check function kept consuming the token!"

"That's where references come in," Det draws an arrow from a new box pointing to the Token. "A reference is like looking at something through a window. You can see it, but you don't own it. The original owner keeps the value."

Jaymart leans forward. "So instead of passing the actual token, we pass a... view of it?"

"Exactly!" Det writes `&Token` on the board. "The ampersand means 'reference to'. When a function takes `&Token`, it _borrows_ the token temporarily. The caller still owns it. When the function ends, the borrow ends, and the caller can keep using their token."

"No more accidental consumption," Neri says, understanding dawning. "I can read data without destroying it."

"Think of it like lending someone your notebook," Jaymart adds, the analogy clicking. "They can read your notes, but you get it back when they're done."

Det nods approvingly. "Perfect analogy. And unlike ownership transfer, you can lend to multiple readers at once."

---

## Topics

### Immutable References: Reading Without Owning

An immutable reference (`&T`) lets you read a value without taking ownership:

```move
module movestack::reference_basics {
    struct Wallet has drop { balance: u64 }

    // This function BORROWS the wallet (doesn't take ownership)
    public fun check_balance(wallet: &Wallet): u64 {
        wallet.balance  // Read the balance
        // wallet still belongs to the caller!
    }

    public fun caller_example() {
        let my_wallet = Wallet { balance: 1000 };

        // Pass a REFERENCE using &
        let balance = check_balance(&my_wallet);

        // my_wallet is STILL valid! We only lent it temporarily.
        let balance_again = check_balance(&my_wallet);  // ✅ Works!

        // Can use as many times as needed
        assert!(balance == 1000, 0);
        assert!(balance_again == 1000, 1);
    }
}
```

The `&` operator creates a reference. The value doesn't move—it's borrowed temporarily.

### The Borrowing Rules

Move enforces strict rules about borrowing to prevent bugs:

**Rule 1: References cannot outlive their source**

```move
module movestack::borrow_rules {
    struct Data has drop { value: u64 }

    // ❌ This would be INVALID (if Move allowed it):
    // public fun bad_reference(): &Data {
    //     let local = Data { value: 10 };
    //     &local  // ERROR! local is destroyed, reference would dangle
    // }

    // ✅ This is VALID: reference comes from parameter
    public fun good_reference(data: &Data): u64 {
        data.value  // Reference valid because 'data' lives in caller
    }
}
```

**Rule 2: You can have multiple immutable references**

```move
module movestack::multiple_borrows {
    struct Data has drop { value: u64 }

    public fun multiple_readers(data: &Data): u64 {
        let ref1 = data;  // First borrow
        let ref2 = data;  // Second borrow (same data)

        ref1.value + ref2.value  // ✅ Both valid simultaneously!
    }
}
```

### Functions That Borrow vs Functions That Consume

Compare these two patterns:

```move
module movestack::borrow_vs_consume {
    struct Token has drop { amount: u64 }

    // Pattern A: CONSUMES the token (takes ownership)
    public fun spend_token(token: Token): u64 {
        let Token { amount } = token;
        // token is destroyed here
        amount
    }

    // Pattern B: BORROWS the token (reads only)
    public fun view_token(token: &Token): u64 {
        token.amount
        // token still exists in caller
    }

    public fun usage_comparison() {
        let token1 = Token { amount: 100 };
        let token2 = Token { amount: 200 };

        // Consuming pattern: token1 is gone after this
        let _amount1 = spend_token(token1);
        // let x = token1.amount;  // ❌ ERROR: token1 was consumed

        // Borrowing pattern: token2 survives
        let _amount2 = view_token(&token2);
        let _amount3 = view_token(&token2);  // ✅ Can borrow again!

        // Still need to handle token2 eventually
        let Token { amount: _ } = token2;
    }
}
```

### Nested References: Borrowing Fields

You can borrow individual fields of a struct through a reference:

```move
module movestack::nested_borrow {
    struct Player has drop {
        level: u64,
        health: u64
    }

    // Borrow the entire struct, access fields
    public fun get_level(player: &Player): u64 {
        player.level
    }

    // Access multiple fields through one reference
    public fun get_stats(player: &Player): (u64, u64) {
        (player.level, player.health)
    }

    // Can also borrow a field specifically
    public fun describe_player(player: &Player): u64 {
        let level_ref = &player.level;  // Reference to just the level
        *level_ref  // Dereference to get the value
    }
}
```

### Practical Patterns: When to Borrow

Use borrowing strategically in your code:

```move
module movestack::borrow_patterns {
    struct Account has drop {
        id: u64,
        balance: u64,
        active: bool
    }

    // Pattern 1: Read-only validation (borrow)
    public fun is_valid_account(account: &Account): bool {
        account.active && account.balance > 0
    }

    // Pattern 2: Comparison (borrow both)
    public fun has_more_balance(a: &Account, b: &Account): bool {
        a.balance > b.balance
    }

    // Pattern 3: Read before consume (borrow, then take ownership)
    public fun validate_and_close(account: Account): u64 {
        // First, validate by borrowing
        assert!(is_valid_account(&account), 0);

        // Then consume
        let Account { id: _, balance, active: _ } = account;
        balance
    }

    // Pattern 4: Multiple reads from same source
    public fun analyze_account(account: &Account): (bool, bool, bool) {
        let is_active = account.active;
        let has_balance = account.balance > 0;
        let is_premium = account.balance >= 1000;

        (is_active, has_balance, is_premium)
    }
}
```

---

## Closing Scene: Borrowing in Action

Later that afternoon, Jaymart shows Neri his refactored validation module.

"Check this out," Jaymart says, pulling up his code. "My `validate_transfer` function takes references to both the sender and recipient. It checks balances, verifies accounts are active, compares limits—all without consuming either account."

```move
public fun validate_transfer(
    sender: &Account,
    recipient: &Account,
    amount: u64
): bool {
    is_valid_account(sender) &&
    is_valid_account(recipient) &&
    sender.balance >= amount
}
```

Neri studies the code. "And after validation, the caller still has both accounts to actually perform the transfer."

"Exactly! The validation is pure—it just reads and returns a boolean. The actual transfer function takes ownership when it needs to modify state."

Det overhears and adds, "That's a key principle. Separate your reads from your writes. Borrow for validation and queries. Take ownership only when you need to mutate or consume."

"The compiler guides you toward better design," Neri realizes. "If a function only needs to read, it should only take a reference. The signature documents the intent."

---

## Summary

| Concept                 | Syntax      | Description                                        |
| ----------------------- | ----------- | -------------------------------------------------- |
| **Immutable Reference** | `&T`        | Borrows value for reading, original owner keeps it |
| **Create Reference**    | `&value`    | Creates a reference to a value                     |
| **Borrow Parameter**    | `fn(x: &T)` | Function borrows instead of consuming              |
| **Multiple Borrows**    | ✅ Allowed  | Can have many immutable references at once         |
| **Reference Lifetime**  | Scoped      | Reference valid only while source exists           |

**Key Principles**:

- **Borrow for reading**: When you only need to inspect data, use `&T`
- **Take ownership for modifying**: When data must change or be destroyed, take ownership
- **References are temporary**: They exist only for the duration of their scope
- **The compiler protects you**: Invalid borrows are caught at compile time

Next up: Mutable references (`&mut T`) for modifying borrowed values without taking ownership!
