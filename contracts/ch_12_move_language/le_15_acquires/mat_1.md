# Acquires Annotation

## Scene: The Cryptic Compiler Error

Neri stares at her screen, frustration building. The code looks perfect—she's accessing a resource from global storage just like she's done a dozen times before. But the compiler refuses to cooperate.

"What is this error?" Neri mutters, pointing at the red text. "It says I'm missing an `acquires` annotation. I've never seen this before."

Det pulls up a chair, coffee in hand. "Ah, you've hit one of Move's safety mechanisms. Show me what you're doing."

Neri scrolls to her function:

```move
public fun get_balance(addr: address): u64 {
    let account = borrow_global<Account>(addr);
    account.balance
}
```

"See this?" Det taps the screen. "You're calling `borrow_global`. That means you're reaching into global storage to borrow a resource. Move needs you to declare that explicitly in your function signature."

"But why?" Neri asks. "The code clearly shows I'm borrowing it."

Det leans back thoughtfully. "Think about what happens if your function calls another function, and _that_ function also tries to borrow the same resource. You'd have two references to the same data—one might modify it while the other is reading. That's a recipe for bugs."

"So the annotation is about safety?"

"Exactly. By requiring `acquires`, Move can track which functions touch which resources. The compiler builds a complete picture of resource access across your entire call chain. If there's a conflict, it catches it at compile time—not at runtime when money is on the line."

Neri nods slowly. "So how do I fix this?"

Det smiles. "Just add `acquires Account` after your parameter list. Like a promise to the compiler—and to anyone reading your code—that this function accesses the Account resource."

---

## Topics

### What is the `acquires` Annotation?

When a function accesses global storage, it must declare which resource types it accesses using the `acquires` keyword:

```move
module movestack::storage_demo {
    struct UserProfile has key {
        name: vector<u8>,
        level: u64
    }

    // This function borrows UserProfile from global storage
    // The `acquires UserProfile` annotation is REQUIRED
    public fun get_level(addr: address): u64 acquires UserProfile {
        let profile = borrow_global<UserProfile>(addr);
        profile.level
    }
}
```

**Why is this required?**

- **Compile-time safety**: The compiler tracks all resource access
- **Prevents dangling references**: No double-borrows within a transaction
- **Code transparency**: Readers know exactly what resources a function touches

### When You Need `acquires`

You must add `acquires` when your function uses these global storage operations:

```move
module movestack::acquires_examples {
    struct Data has key {
        value: u64
    }

    // Using borrow_global - needs acquires
    public fun read_data(addr: address): u64 acquires Data {
        borrow_global<Data>(addr).value
    }

    // Using borrow_global_mut - needs acquires
    public fun update_data(addr: address, new_value: u64) acquires Data {
        let data = borrow_global_mut<Data>(addr);
        data.value = new_value;
    }

    // Using move_from - needs acquires
    public fun remove_data(addr: address): Data acquires Data {
        move_from<Data>(addr)
    }
}
```

**What does NOT require `acquires`:**

```move
module movestack::no_acquires {
    struct Data has key {
        value: u64
    }

    // move_to does NOT need acquires (adding to storage)
    public fun store_data(account: &signer, data: Data) {
        move_to(account, data);  // No acquires needed!
    }

    // exists does NOT need acquires (just checking existence)
    public fun has_data(addr: address): bool {
        exists<Data>(addr)  // No acquires needed!
    }
}
```

### The Propagation Rule: Acquires Travels Up

If function A calls function B, and B acquires a resource, then A must also declare that it acquires the resource. The annotation propagates up the call chain:

```move
module movestack::propagation {
    struct Config has key {
        value: u64
    }

    // Helper function acquires Config
    fun read_config_internal(addr: address): u64 acquires Config {
        borrow_global<Config>(addr).value
    }

    // Calling function MUST also declare acquires
    public fun get_config_doubled(addr: address): u64 acquires Config {
        let value = read_config_internal(addr);  // Calls a function that acquires
        value * 2
    }

    // ❌ WRONG: Missing acquires annotation
    // public fun get_config_wrong(addr: address): u64 {
    //     read_config_internal(addr)  // Compiler error!
    // }
}
```

**The chain continues through multiple levels:**

```move
module movestack::deep_chain {
    struct Resource has key {
        value: u64
    }

    // Level C: Actually accesses storage
    fun level_c(addr: address): u64 acquires Resource {
        borrow_global<Resource>(addr).value
    }

    // Level B: Calls C, must also have acquires
    fun level_b(addr: address): u64 acquires Resource {
        level_c(addr) + 1
    }

    // Level A: Calls B, must also have acquires
    public fun level_a(addr: address): u64 acquires Resource {
        level_b(addr) + 1
    }
}
```

### Multiple Resource Types

A function can acquire multiple resource types. List them all, separated by commas:

```move
module movestack::multi_acquire {
    struct UserData has key {
        name: vector<u8>
    }

    struct UserStats has key {
        points: u64
    }

    // Accessing multiple resources - list all of them
    public fun get_user_summary(addr: address): (vector<u8>, u64)
        acquires UserData, UserStats
    {
        let data = borrow_global<UserData>(addr);
        let stats = borrow_global<UserStats>(addr);
        (data.name, stats.points)
    }
}
```

### Common Patterns

**Pattern 1: Entry functions with acquires**

```move
public entry fun update_profile(
    account: &signer,
    new_name: vector<u8>
) acquires UserProfile {
    let addr = signer::address_of(account);
    let profile = borrow_global_mut<UserProfile>(addr);
    profile.name = new_name;
}
```

**Pattern 2: View functions with acquires**

```move
#[view]
public fun get_balance(addr: address): u64 acquires Balance {
    borrow_global<Balance>(addr).amount
}
```

**Pattern 3: Conditional access still needs acquires**

```move
// Even though we check exists first, we still need acquires
public fun safe_get_value(addr: address): u64 acquires Data {
    if (exists<Data>(addr)) {
        borrow_global<Data>(addr).value
    } else {
        0
    }
}
```

---

## Closing Scene: The Pattern Clicks

An hour later, Neri has refactored her entire module. She turns to show Det her work.

"I think I finally get it," Neri says. "Look—I traced through every function that touches global storage. The annotation creates this chain of documentation."

```move
public fun get_account_balance(addr: address): u64 acquires Account {
    let account = borrow_global<Account>(addr);
    account.balance
}

public fun validate_transfer(
    sender: address,
    recipient: address,
    amount: u64
): bool acquires Account {
    let sender_balance = get_account_balance(sender);
    sender_balance >= amount && exists<Account>(recipient)
}
```

Det nods approvingly. "See how the annotations flow? Anyone reading `validate_transfer` knows immediately that it accesses `Account` resources—even without looking at the implementation."

"It's like a contract," Neri realizes. "The function signature tells the whole story."

"Exactly. And the compiler enforces that contract. You can't lie about what you access—the compiler will catch you." Det finishes his coffee. "That's the Move philosophy. Make the important things explicit. Let the compiler verify your promises."

Neri saves her file, watching the green checkmarks appear. No more cryptic errors.

---

## Summary

| Concept               | Description                                                          |
| --------------------- | -------------------------------------------------------------------- |
| `acquires` annotation | Declares which resources a function accesses from global storage     |
| Required for          | `borrow_global`, `borrow_global_mut`, `move_from`                    |
| NOT required for      | `move_to`, `exists`                                                  |
| Propagation rule      | If A calls B, and B acquires R, then A must also acquire R           |
| Multiple resources    | List all: `acquires TypeA, TypeB, TypeC`                             |
| Purpose               | Compile-time safety, prevents dangling references, code transparency |

**Key Principles**:

- **Explicit is better than implicit**: Declare what resources you touch
- **Propagation ensures completeness**: The whole call chain must be annotated
- **The compiler enforces safety**: You cannot access storage without declaring it
- **Documentation built-in**: Function signatures reveal resource dependencies
