# Phantom Type Parameters

## Scene: The Token Mixing Problem

Ronnie gathers the team around the whiteboard, marker in hand. Today's architecture session is about to get interesting.

"I've been thinking about our token system," Ronnie begins, drawing a box labeled `Token`. "We have different currencies—gold, silver, gems. Right now, they're all just numbers. Nothing stops someone from accidentally adding gold to silver."

Neri frowns. "Can't we just use different struct types for each?"

"We could," Ronnie nods, "but then we'd duplicate all our logic. Transfer functions, balance checks, everything copied three times. That's a maintenance nightmare."

Dex leans forward. "This sounds like a job for phantom types."

"Phantom types?" Neri looks intrigued. "What's the phantom part mean?"

"Think of it like this," Dex explains. "A phantom is something you can see but can't touch. A phantom type parameter exists in the type signature, but doesn't appear in any of the struct's fields. It's there purely for the compiler to enforce type safety."

Ronnie draws a new diagram. "So the struct looks the same at runtime—just a number. But the compiler treats `Token<Gold>` and `Token<Silver>` as completely different types?"

"Exactly!" Dex confirms. "The phantom parameter is erased at runtime—it costs nothing in storage or gas. But the compiler enforces type safety. You literally cannot pass a gold token where a silver token is expected."

Neri picks up a marker. "Show me how it works."

---

## Topics

### What Are Phantom Types?

Phantom types are type parameters marked with the `phantom` keyword that don't appear in any struct field. They exist only for compile-time type checking:

```move
module movestack::phantom_intro {
    // Regular type parameter - must appear in a field
    struct Container<T> {
        value: T  // T appears here
    }

    // Phantom type parameter - doesn't appear in any field
    struct Token<phantom Currency> {
        amount: u64  // Currency doesn't appear anywhere!
    }
}
```

The `phantom` keyword tells the compiler: "This type parameter is for type safety only, not for data storage."

### Marker Structs: Type Tags

Phantom types work with "marker structs"—empty structs that serve as type tags:

```move
module movestack::markers {
    // Marker types - empty structs that serve as type tags
    struct Gold {}
    struct Silver {}
    struct Gem {}

    // Token is generic over any currency marker
    struct Token<phantom Currency> has store, drop, copy {
        amount: u64
    }

    // Create specific token types
    public fun create_gold(amount: u64): Token<Gold> {
        Token<Gold> { amount }
    }

    public fun create_silver(amount: u64): Token<Silver> {
        Token<Silver> { amount }
    }

    public fun create_gem(amount: u64): Token<Gem> {
        Token<Gem> { amount }
    }
}
```

At runtime, all three token types have the same structure—just a `u64`. But the compiler treats them as entirely different types.

### Type Safety Without Code Duplication

The power of phantom types: write generic code that the compiler enforces correctly.

**Without phantom types (bad):**

```move
// ❌ BAD: Duplicated structs and functions
struct GoldToken { amount: u64 }
struct SilverToken { amount: u64 }
struct GemToken { amount: u64 }

// Duplicate functions for each type!
fun transfer_gold(token: GoldToken, to: address) { /* ... */ }
fun transfer_silver(token: SilverToken, to: address) { /* ... */ }
fun transfer_gem(token: GemToken, to: address) { /* ... */ }
```

**With phantom types (good):**

```move
// ✅ GOOD: Single generic struct with phantom type
struct Token<phantom Currency> has store {
    amount: u64
}

// One function handles all token types!
fun transfer<Currency>(token: Token<Currency>, to: address) { /* ... */ }
```

### Compile-Time Type Safety

The compiler prevents mixing different phantom types:

```move
module movestack::type_safety {
    struct Gold {}
    struct Silver {}

    struct Token<phantom Currency> has drop {
        amount: u64
    }

    public fun add_tokens<Currency>(
        a: Token<Currency>,
        b: Token<Currency>
    ): Token<Currency> {
        Token { amount: a.amount + b.amount }
    }

    #[test]
    fun test_type_safety() {
        let gold1 = Token<Gold> { amount: 100 };
        let gold2 = Token<Gold> { amount: 50 };

        // ✅ Works: same type
        let combined = add_tokens(gold1, gold2);
        assert!(combined.amount == 150, 0);

        let silver = Token<Silver> { amount: 25 };

        // ❌ Compile error: Token<Gold> vs Token<Silver>
        // let mixed = add_tokens(combined, silver);
    }
}
```

### No Runtime Cost

Phantom parameters are erased at runtime. They affect only compile-time type checking:

```move
module movestack::no_cost {
    struct TypeA {}
    struct TypeB {}

    struct Wrapper<phantom T> has drop {
        value: u64
    }

    #[test]
    fun test_same_size() {
        let a = Wrapper<TypeA> { value: 100 };
        let b = Wrapper<TypeB> { value: 100 };

        // Both have exactly the same runtime representation
        // Just a u64 - the phantom type adds zero overhead
    }
}
```

### Phantom Types and Abilities

An important rule: phantom type parameters don't affect struct abilities.

```move
module movestack::phantom_abilities {
    // Non-copyable marker
    struct RareGem {}  // No 'copy' ability!

    // Token can still have 'copy' because Currency is phantom
    struct Token<phantom Currency> has copy, drop, store {
        amount: u64
    }

    #[test]
    fun test_phantom_abilities() {
        let gem = Token<RareGem> { amount: 1 };
        let gem_copy = gem;  // ✅ Works despite RareGem not being copyable!
        assert!(gem_copy.amount == 1, 0);
    }
}
```

**Contrast with regular type parameters:**

```move
module movestack::regular_abilities {
    struct NoCopy {}  // No 'copy' ability

    // Regular type parameter - abilities are affected
    struct Box<T> has drop {
        value: T
    }

    // Box<NoCopy> cannot have 'copy' because T appears in the field
    // and T doesn't have 'copy'
}
```

### Real-World Pattern: Typed IDs

Phantom types are perfect for creating type-safe identifiers:

```move
module movestack::typed_ids {
    // Marker types for different ID domains
    struct UserId {}
    struct OrderId {}
    struct ProductId {}

    // Generic typed ID - phantom ensures type safety
    struct TypedId<phantom Domain> has copy, drop, store {
        value: u64
    }

    // Create domain-specific IDs
    public fun new_user_id(value: u64): TypedId<UserId> {
        TypedId { value }
    }

    public fun new_order_id(value: u64): TypedId<OrderId> {
        TypedId { value }
    }

    // Function that only accepts user IDs
    public fun get_user_name(_id: TypedId<UserId>): vector<u8> {
        // Only TypedId<UserId> can be passed here
        // TypedId<OrderId> would be a compile error!
        b"User Name"
    }
}
```

### Phantom Types with Global Storage

Phantom types work seamlessly with resources. Each phantom type creates a separate storage slot:

```move
module movestack::phantom_storage {
    use std::signer;

    struct Gold {}
    struct Silver {}

    // Balance stored per currency type
    struct Balance<phantom Currency> has key {
        amount: u64
    }

    // Each phantom type creates a separate storage slot
    public fun deposit<Currency>(
        account: &signer,
        amount: u64
    ) acquires Balance {
        let addr = signer::address_of(account);

        if (exists<Balance<Currency>>(addr)) {
            let balance = borrow_global_mut<Balance<Currency>>(addr);
            balance.amount = balance.amount + amount;
        } else {
            move_to(account, Balance<Currency> { amount });
        }
    }

    // User can have both Balance<Gold> AND Balance<Silver>
    // They're different types, so different storage slots!
}
```

### Advanced Pattern: Capability Tokens

Phantom types enable the "capability pattern" for access control:

```move
module movestack::capabilities {
    // Permission markers
    struct ReadPermission {}
    struct WritePermission {}
    struct AdminPermission {}

    // Capability token - grants specific permissions
    struct Capability<phantom Permission> has store, drop {
        owner: address
    }

    // Only someone with WritePermission can call this
    public fun write_data(
        _cap: &Capability<WritePermission>,
        _data: u64
    ) {
        // The capability proves the caller has write permission
        // No runtime check needed - it's enforced by the type system!
    }

    // Only admin can create capabilities
    public fun grant_write(
        _admin_cap: &Capability<AdminPermission>,
        to: address
    ): Capability<WritePermission> {
        Capability { owner: to }
    }
}
```

---

## Closing Scene: Type Safety Wins

An hour later, Neri has implemented the new token system. She pulls up her code for Ronnie and Dex to review.

"Check this out," Neri says proudly. "One `Token` struct, three currency types. All the transfer logic is generic."

```move
struct Token<phantom Currency> has store, drop, copy {
    amount: u64
}

public fun transfer<Currency>(
    token: Token<Currency>,
    _to: address
): Token<Currency> {
    // Works for any currency type!
    token
}
```

Dex nods approvingly. "Try adding gold and silver together."

Neri types the code and the compiler immediately flags it red:

```move
// let gold = create_gold(100);
// let silver = create_silver(50);
// let mixed = add_tokens(gold, silver);  // ❌ Type mismatch!
```

"Beautiful," Ronnie grins. "The compiler catches it before anyone can make that mistake in production."

"And the best part?" Dex adds. "Zero runtime overhead. The phantom type exists only in the compiler's mind. At runtime, it's all just numbers—but numbers that can never be confused."

Neri saves the file. "Type-level programming without the cost. I could get used to this."

---

## Summary

| Concept       | Description                                                        |
| ------------- | ------------------------------------------------------------------ |
| Phantom type  | Type parameter marked with `phantom` that doesn't appear in fields |
| Marker struct | Empty struct used as a type tag (e.g., `struct Gold {}`)           |
| Purpose       | Compile-time type safety without runtime overhead                  |
| Abilities     | Phantom parameters don't affect struct abilities                   |
| Use cases     | Token types, typed IDs, capability patterns, domain separation     |
| Syntax        | `struct MyStruct<phantom T> { ... }`                               |

**Key Principles**:

- **Type safety at zero cost**: Phantom types are erased at runtime
- **One implementation, many types**: Generic code with compile-time differentiation
- **Marker structs as tags**: Empty structs serve as type-level labels
- **Abilities unaffected**: A `struct<phantom T>` doesn't inherit T's ability restrictions
- **Perfect for tokens and IDs**: Prevent mixing incompatible types at compile time
