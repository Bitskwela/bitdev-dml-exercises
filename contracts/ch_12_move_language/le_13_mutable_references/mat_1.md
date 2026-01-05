# Mutable References

## Scene: Permission to Modify

Ronnie spread his hands across the desk in frustration, staring at the terminal. "I can read the data through an immutable reference, but I can't change it. What if I need to update a struct field without consuming the entire thing?"

Det leaned against the whiteboard, marker in hand. "That's exactly what mutable references solve. Instead of `&T` for reading, you use `&mut T` for writing. You're still borrowing—not taking ownership—but now you have permission to modify."

"So I can change the original value through the reference?" Ronnie asked, sitting up straighter.

"Exactly," Neri confirmed, pulling up a code example. "Think of it like this: an immutable reference is like viewing a shared document in read-only mode. A mutable reference is like having exclusive edit access. You can make changes, but only one person can edit at a time."

Det drew two boxes on the whiteboard. "The `&mut` syntax creates an exclusive mutable reference. While that reference exists, nothing else can access the original value—not even for reading. This exclusivity prevents data races."

Ronnie nodded slowly. "So if I pass `&mut counter` to a function, that function can modify the counter, and when it returns, I'll see the updated value?"

"Precisely," Det said. "The borrow is temporary. The function modifies the value through the reference, then the borrow ends, and you continue with the modified data. No ownership transfer needed."

"This is going to clean up so much of my code," Ronnie said, already reimagining his implementations.

---

## Topics

### Mutable Reference Syntax

Mutable references use `&mut` to allow modification of borrowed values:

```move
module movestack::mutable_refs {
    struct Counter has drop {
        value: u64
    }

    // Takes a mutable reference - can modify the original
    public fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    public fun example() {
        // Declare as mutable with 'let mut'
        let mut counter = Counter { value: 0 };

        // Create mutable reference with &mut
        increment(&mut counter);
        assert!(counter.value == 1, 0);

        // Can borrow again after previous borrow ends
        increment(&mut counter);
        assert!(counter.value == 2, 1);
    }
}
```

Key syntax points:

- Declare mutable variables with `let mut`
- Create mutable references with `&mut value`
- Function parameters use `param: &mut Type`
- Access and modify fields directly through the reference

### Modifying Struct Fields

Mutable references allow direct field modification:

```move
module movestack::field_modification {
    struct Player has drop {
        health: u64,
        level: u64,
        experience: u64
    }

    // Modify a single field
    public fun heal(player: &mut Player, amount: u64) {
        player.health = player.health + amount;
    }

    // Modify multiple fields
    public fun level_up(player: &mut Player) {
        player.level = player.level + 1;
        player.experience = 0;  // Reset experience on level up
    }

    // Conditional modification
    public fun take_damage(player: &mut Player, damage: u64) {
        if (damage >= player.health) {
            player.health = 0;
        } else {
            player.health = player.health - damage;
        };
    }

    // Read and modify pattern
    public fun gain_experience(player: &mut Player, exp: u64) {
        let new_exp = player.experience + exp;
        player.experience = new_exp;

        // Check for level up threshold
        if (new_exp >= 100) {
            level_up(player);
        };
    }

    #[test]
    fun test_field_modification() {
        let mut player = Player {
            health: 100,
            level: 1,
            experience: 0
        };

        heal(&mut player, 20);
        assert!(player.health == 120, 0);

        take_damage(&mut player, 50);
        assert!(player.health == 70, 1);

        gain_experience(&mut player, 100);
        assert!(player.level == 2, 2);
        assert!(player.experience == 0, 3);
    }
}
```

### Update Patterns

Common patterns for updating values through mutable references:

```move
module movestack::update_patterns {
    struct Wallet has drop {
        balance: u64
    }

    struct Account has drop {
        owner: address,
        wallet: Wallet,
        active: bool
    }

    // Pattern 1: Simple field update
    public fun set_balance(wallet: &mut Wallet, new_balance: u64) {
        wallet.balance = new_balance;
    }

    // Pattern 2: Arithmetic update
    public fun add_funds(wallet: &mut Wallet, amount: u64) {
        wallet.balance = wallet.balance + amount;
    }

    // Pattern 3: Conditional update with return
    public fun withdraw(wallet: &mut Wallet, amount: u64): bool {
        if (wallet.balance >= amount) {
            wallet.balance = wallet.balance - amount;
            true
        } else {
            false
        }
    }

    // Pattern 4: Nested struct modification
    public fun deposit_to_account(account: &mut Account, amount: u64) {
        // Access nested field mutably
        account.wallet.balance = account.wallet.balance + amount;
    }

    // Pattern 5: Passing nested mutable reference
    public fun process_account_wallet(account: &mut Account, amount: u64) {
        // Create mutable reference to nested struct
        add_funds(&mut account.wallet, amount);
    }

    // Pattern 6: Toggle boolean state
    public fun toggle_active(account: &mut Account) {
        account.active = !account.active;
    }

    // Pattern 7: Swap between two mutable references
    public fun transfer(from: &mut Wallet, to: &mut Wallet, amount: u64) {
        assert!(from.balance >= amount, 0);
        from.balance = from.balance - amount;
        to.balance = to.balance + amount;
    }

    #[test]
    fun test_update_patterns() {
        let mut wallet1 = Wallet { balance: 100 };
        let mut wallet2 = Wallet { balance: 50 };

        add_funds(&mut wallet1, 25);
        assert!(wallet1.balance == 125, 0);

        let success = withdraw(&mut wallet1, 30);
        assert!(success && wallet1.balance == 95, 1);

        transfer(&mut wallet1, &mut wallet2, 45);
        assert!(wallet1.balance == 50, 2);
        assert!(wallet2.balance == 95, 3);
    }
}
```

### Mutable References vs Ownership

Choose the right approach based on what the function needs:

```move
module movestack::mut_vs_ownership {
    struct Token has drop {
        id: u64,
        value: u64
    }

    // Takes ownership - consumes the token completely
    public fun burn_token(token: Token): u64 {
        let Token { id: _, value } = token;
        // token is destroyed here
        value
    }

    // Mutable reference - modifies without consuming
    public fun set_value(token: &mut Token, new_value: u64) {
        token.value = new_value;
        // token still exists in caller
    }

    // Immutable reference - read only
    public fun get_value(token: &Token): u64 {
        token.value
        // token unchanged
    }

    public fun demonstrate_differences() {
        let mut token = Token { id: 1, value: 100 };

        // Read without affecting ownership
        let val = get_value(&token);
        assert!(val == 100, 0);

        // Modify without taking ownership
        set_value(&mut token, 200);
        assert!(token.value == 200, 1);

        // Can still use the token
        let val2 = get_value(&token);
        assert!(val2 == 200, 2);

        // Now consume it - ownership transfers
        let final_value = burn_token(token);
        assert!(final_value == 200, 3);

        // token no longer exists - it was consumed
    }
}
```

**Guidelines**:

| Use This        | When You Need To                         |
| --------------- | ---------------------------------------- |
| `&T`            | Read data without modification           |
| `&mut T`        | Modify data and return it to caller      |
| `T` (ownership) | Consume, destroy, or transform the value |

---

## Closing Scene: Patterns in Practice

Later that afternoon, Ronnie demonstrated his refactored code to Neri and Det.

"Look at this inventory system," Ronnie said, pulling up his module. "Each item can be upgraded without moving it around."

```move
public fun upgrade_item(item: &mut Item) {
    item.level = item.level + 1;
    item.power = item.power * 2;
}
```

Neri examined the code. "Clean. The caller keeps ownership of the item, and you just bump its stats through the reference."

"And check out this transfer function," Ronnie continued. "It takes mutable references to both wallets and moves funds between them."

```move
public fun transfer(from: &mut Wallet, to: &mut Wallet, amount: u64) {
    from.balance = from.balance - amount;
    to.balance = to.balance + amount;
}
```

Det nodded approvingly. "You're modifying two separate values through their references. Neither gets consumed, so the caller still controls both wallets after the transfer."

"The pattern is so much cleaner than what I was doing before," Ronnie admitted. "No more destructuring and reconstructing just to change one field."

"That's the power of mutable references," Neri said. "In-place modification with clear ownership semantics."

---

## Summary

| Concept               | Syntax            | Description                                 |
| --------------------- | ----------------- | ------------------------------------------- |
| **Mutable Reference** | `&mut T`          | Borrows value with permission to modify     |
| **Create Mut Ref**    | `&mut value`      | Creates a mutable reference                 |
| **Mut Parameter**     | `fn(x: &mut T)`   | Function can modify the borrowed value      |
| **Field Access**      | `ref.field = val` | Direct field modification through reference |
| **Nested Access**     | `&mut s.field`    | Create mutable reference to nested field    |

**Key Principles**:

- **Mutable references allow in-place modification**: Change values without ownership transfer
- **Exclusivity is enforced**: Only one mutable reference at a time
- **Borrows are temporary**: Reference ends when last used or scope ends
- **Choose the right tool**: Use `&T` for reading, `&mut T` for modifying, `T` for consuming

Next up: Reference safety rules that prevent data races and ensure program correctness!
