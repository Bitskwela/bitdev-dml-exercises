# Entry Functions

## Scene: The Transaction That Wouldn't Start

Loy slumps back in his chair, rubbing his temples. He's been trying to call his Move function from a wallet for the past hour, but nothing works. The function compiles fine, the logic is perfect—but the blockchain just won't accept it.

"Neri, I need help," Loy calls out. "I wrote this function to transfer tokens, but when I try to call it from my wallet, nothing happens. It's like the blockchain doesn't even see it."

Neri walks over, scanning Loy's screen. She spots the issue immediately.

"There it is," Neri points at the function signature. "You declared it as `public fun`. That makes it callable from other modules, but not directly from a transaction."

Loy frowns. "What's the difference? A function is a function, right?"

"Not in Move," Neri explains. "Think of it like the entrance to a building. A `public` function is like an internal door—other rooms can access it. But to let people in from the street, you need a front entrance. That's what `entry` functions are for."

"So `entry` is the front door?"

"Exactly. When someone submits a transaction to the blockchain, the runtime looks for functions marked with `entry`. Those are the only functions it can call directly. Everything else has to be reached through an entry point."

Loy nods, starting to understand. "So I just add `entry` to my function?"

"You can use `public entry` to make it both an entry point AND callable from other modules," Neri suggests. "That gives you maximum flexibility. But remember—entry functions have rules. They can't return values to the transaction caller, and their parameters must be types the transaction system understands."

Loy updates his function signature and resubmits. The transaction goes through instantly.

"The front door is open," Loy grins.

---

## Topics

### What are Entry Functions?

Entry functions are the gateway between external transactions and your Move module. They're the only functions that can be called directly when someone submits a transaction to the blockchain.

```move
module movestack::entry_demo {
    use std::signer;

    struct Counter has key {
        value: u64
    }

    // This is an ENTRY function - can be called directly from a transaction
    public entry fun initialize(account: &signer) {
        move_to(account, Counter { value: 0 });
    }

    // This is just a public function - NOT callable from transactions directly
    public fun get_value(addr: address): u64 acquires Counter {
        borrow_global<Counter>(addr).value
    }
}
```

**Key distinction:**

- `public fun` → Callable from other Move modules only
- `entry fun` → Callable from transactions only
- `public entry fun` → Callable from both transactions AND other modules

### The `entry` Modifier

The `entry` modifier marks a function as a transaction entry point:

```move
module movestack::token_ops {
    use std::signer;

    struct Balance has key {
        amount: u64
    }

    // Private entry - callable from transactions but NOT from other modules
    entry fun private_mint(account: &signer, amount: u64) {
        if (exists<Balance>(signer::address_of(account))) {
            let balance = borrow_global_mut<Balance>(signer::address_of(account));
            balance.amount = balance.amount + amount;
        } else {
            move_to(account, Balance { amount });
        }
    }

    // Public entry - callable from BOTH transactions AND other modules
    public entry fun transfer(from: &signer, to: address, amount: u64) acquires Balance {
        let from_addr = signer::address_of(from);
        let from_balance = borrow_global_mut<Balance>(from_addr);
        from_balance.amount = from_balance.amount - amount;

        let to_balance = borrow_global_mut<Balance>(to);
        to_balance.amount = to_balance.amount + amount;
    }
}
```

### Entry Function Rules

Entry functions have specific constraints:

```move
module movestack::entry_rules {
    use std::signer;

    struct Data has key {
        value: u64
    }

    // ✅ VALID: No return value
    public entry fun store_data(account: &signer, value: u64) {
        move_to(account, Data { value });
    }

    // ❌ INVALID: Entry functions cannot return values
    // public entry fun get_data(addr: address): u64 acquires Data {
    //     borrow_global<Data>(addr).value
    // }

    // ✅ VALID: Signer as first parameter
    public entry fun update_data(account: &signer, new_value: u64) acquires Data {
        let data = borrow_global_mut<Data>(signer::address_of(account));
        data.value = new_value;
    }

    // ✅ VALID: Primitive types as parameters
    public entry fun process(account: &signer, amount: u64, flag: bool) {
        // Process with primitives
    }
}
```

**Entry function constraints:**

1. **No return values**: Cannot return data to the transaction caller
2. **Allowed parameter types**: `&signer`, primitives (u8, u64, bool, address), vectors of primitives, String
3. **No generic type parameters** (in most cases)

### `public entry` vs `entry`

Choose the right visibility for your use case:

```move
module movestack::visibility_demo {
    use std::signer;

    struct Account has key {
        balance: u64
    }

    // Only callable from transactions - internal operation
    entry fun admin_reset(account: &signer) acquires Account {
        let acc = borrow_global_mut<Account>(signer::address_of(account));
        acc.balance = 0;
    }

    // Callable from transactions AND other modules - public API
    public entry fun deposit(account: &signer, amount: u64) acquires Account {
        let addr = signer::address_of(account);
        if (exists<Account>(addr)) {
            let acc = borrow_global_mut<Account>(addr);
            acc.balance = acc.balance + amount;
        } else {
            move_to(account, Account { balance: amount });
        }
    }

    // Helper that other modules can call
    public fun get_balance(addr: address): u64 acquires Account {
        if (exists<Account>(addr)) {
            borrow_global<Account>(addr).balance
        } else {
            0
        }
    }
}
```

---

## Closing Scene

Loy leans back, satisfied as he watches his transaction confirm on the explorer. "So the `entry` keyword is what connects the outside world to our module."

Neri nods. "Think of your module like a building. `public` functions are internal hallways between rooms. But `entry` functions are the doors to the outside. Without them, no one can get in."

"And `public entry` gives me both?"

"Right. It's a door that works from both inside and outside. Use it when you want maximum accessibility, but use plain `entry` when you want transactions-only access."

Loy saves his code. "Front doors and hallways. I'll remember that."

---

## Summary

- **Entry functions** are the only functions callable directly from blockchain transactions
- Use `entry fun` for transaction-only access (private entry point)
- Use `public entry fun` for both transaction and cross-module access
- Entry functions **cannot return values** to the transaction caller
- Entry functions accept specific parameter types: `&signer`, primitives, vectors, strings
- The `&signer` parameter represents the transaction sender and provides authorization
- Design entry functions as the public API of your module—the "front doors" for users
