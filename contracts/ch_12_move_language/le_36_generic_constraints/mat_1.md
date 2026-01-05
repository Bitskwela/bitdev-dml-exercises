# Material 1: Generic Constraints

## Opening Scene

The debugging terminal in the Aptos Research Institute flickered with error messages. Det stared at the screen, her brow furrowed in concentration.

"The generic vault compiles fine," she said, "but when I try to store this custom token type, it fails."

Odessa rolled her chair over, her analytical mind already processing the error logs. "Show me the token struct."

Det pulled up the code. "Here. `struct SecretToken has drop { value: u64 }`. No `store` ability."

"Ah." Odessa nodded knowingly. "Your generic vault expects types that can be stored in global storage. But `SecretToken` can only be dropped—it can't persist."

"So the vault needs to enforce requirements on what types it accepts?"

"Exactly. Generic constraints." Odessa began typing. "You can require that type parameters have specific abilities. `<T: store>` means only types with the `store` ability can be used."

Det's eyes widened. "So we can make our generics type-safe at compile time."

"Not just type-safe—ability-safe. The compiler becomes your guardian, preventing misuse before code ever runs."

---

## Topics

### 1. Ability Constraints on Generics

Generic type parameters can require specific abilities:

```move
module examples::ability_constraints {
    use std::vector;

    // T must have 'copy' ability
    public fun duplicate<T: copy>(value: T): (T, T) {
        (copy value, value)
    }

    // T must have 'drop' ability
    public fun discard<T: drop>(_value: T) {
        // value is automatically dropped
    }

    // T must have 'store' ability (for persistence)
    struct StorageBox<T: store> has key, store {
        contents: T
    }

    // T must have 'key' ability
    public fun check_exists<T: key>(addr: address): bool {
        exists<T>(addr)
    }

    // Without constraints, limited operations available
    public fun identity<T>(value: T): T {
        value  // Can only move, not copy or drop
    }
}
```

### 2. The `copy` Constraint

Requires the type to be copyable:

```move
module examples::copy_constraint {
    use std::vector;

    // Can duplicate values of type T
    public fun make_copies<T: copy>(original: T, count: u64): vector<T> {
        let copies = vector::empty<T>();
        let i = 0;
        while (i < count) {
            vector::push_back(&mut copies, copy original);
            i = i + 1;
        };
        // Original is still valid here
        vector::push_back(&mut copies, original);
        copies
    }

    // First element without consuming vector
    public fun peek_first<T: copy>(vec: &vector<T>): T {
        *vector::borrow(vec, 0)  // Dereference requires copy
    }

    // Structs with copy constraint
    struct Duplicator<T: copy> has copy, drop {
        value: T
    }

    public fun duplicate_in_struct<T: copy>(val: T): Duplicator<T> {
        Duplicator { value: val }
    }
}
```

### 3. The `drop` Constraint

Requires the type to be droppable:

```move
module examples::drop_constraint {

    // Can safely ignore the value
    public fun use_or_discard<T: drop>(value: T, use_it: bool): u64 {
        if (use_it) {
            // Would need to do something with value
            0
        } else {
            // value is dropped here - requires drop ability
            1
        }
    }

    // Replace value, dropping the old one
    struct Replaceable<T: drop> has drop {
        current: T
    }

    public fun replace<T: drop>(container: &mut Replaceable<T>, new_value: T) {
        container.current = new_value;  // Old value is dropped
    }

    // Conditional return - might drop the value
    public fun filter<T: drop>(value: T, keep: bool): vector<T> {
        let result = vector[];
        if (keep) {
            vector::push_back(&mut result, value);
        };
        // If not kept, value is dropped
        result
    }
}
```

### 4. The `store` Constraint

Requires the type to be storable in global storage:

```move
module examples::store_constraint {
    use std::signer;

    // Resource that stores any storable type
    struct Vault<T: store> has key {
        contents: T,
        owner: address
    }

    // Only types with 'store' can be vaulted
    public fun create_vault<T: store>(
        account: &signer,
        item: T
    ) {
        let owner = signer::address_of(account);
        move_to(account, Vault<T> {
            contents: item,
            owner
        });
    }

    // Nested storage - inner type must have store
    struct NestedVault<T: store> has key, store {
        inner: Vault<T>  // Vault itself needs store for this
    }

    // Vector of storable items
    struct Collection<T: store> has key {
        items: vector<T>  // vector<T> has store if T has store
    }
}
```

### 5. The `key` Constraint

Requires the type to be a resource (top-level storage):

```move
module examples::key_constraint {
    use std::signer;

    // Check if any resource type exists
    public fun resource_exists<T: key>(addr: address): bool {
        exists<T>(addr)
    }

    // Generic resource management
    public fun remove_resource<T: key>(account: &signer): T acquires T {
        let addr = signer::address_of(account);
        move_from<T>(addr)
    }

    // Transfer resource between accounts
    public fun transfer_resource<T: key + store>(
        from: &signer,
        to: address
    ) acquires T {
        let resource = move_from<T>(signer::address_of(from));
        // Would need destination signer to move_to
        // This is simplified example
        abort 0
    }
}
```

### 6. Combining Multiple Constraints

Type parameters can require multiple abilities:

```move
module examples::combined_constraints {
    use std::vector;
    use std::signer;

    // T must have both copy and drop
    public fun copy_and_discard<T: copy + drop>(value: T): T {
        let copy1 = copy value;
        let _copy2 = copy value;  // This will be dropped
        copy1
    }

    // T must have copy, drop, and store
    struct FlexibleContainer<T: copy + drop + store> has key, copy, drop, store {
        items: vector<T>,
        default: T
    }

    public fun create_flexible<T: copy + drop + store>(
        account: &signer,
        default: T
    ) {
        move_to(account, FlexibleContainer<T> {
            items: vector::empty(),
            default
        });
    }

    // Get default value (needs copy)
    public fun get_default<T: copy + drop + store>(
        addr: address
    ): T acquires FlexibleContainer {
        let container = borrow_global<FlexibleContainer<T>>(addr);
        container.default  // Implicit copy
    }

    // All four abilities
    public fun full_flexibility<T: copy + drop + store + key>(
        _value: T
    ): bool {
        // Can do anything with T
        true
    }
}
```

---

## Closing Scene

Det leaned back, the error messages now replaced with successful compilation logs. "So by adding `<T: store>` to my vault, the compiler catches invalid types before deployment."

"Precisely." Odessa highlighted the constraint syntax. "Think of ability constraints as contracts. You're telling the compiler—and other developers—exactly what guarantees you need from a type."

"And if someone tries to store a non-storable type?"

"Compile-time error. Clear, immediate, and informative." Odessa smiled. "The Move type system is designed to catch these issues early. Generic constraints are part of that safety net."

Det saved her work. "So `copy` for duplicating, `drop` for discarding, `store` for persistence, and `key` for resources."

"And you can combine them as needed. `<T: copy + drop + store>` gives you maximum flexibility—types you can copy, discard, and store."

"The compiler as guardian," Det repeated. "I like that."

---

## Summary

- **Ability Constraints**: Restrict generic types using `<T: ability>`
- **`copy` Constraint**: Type must be copyable—allows duplication
- **`drop` Constraint**: Type must be droppable—allows discarding
- **`store` Constraint**: Type must be storable—allows persistence in global storage
- **`key` Constraint**: Type must be a resource—allows top-level storage operations
- **Combined Constraints**: Use `+` to require multiple abilities: `<T: copy + drop + store>`
- **Compile-Time Safety**: Constraints are checked at compile time, preventing runtime errors
