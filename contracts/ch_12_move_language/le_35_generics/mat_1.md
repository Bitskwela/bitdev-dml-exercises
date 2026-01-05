# Material 1: Generics

## Opening Scene

The morning sun cast long shadows across the Aptos Research Institute's advanced laboratory. Det stood before a holographic display showing dozens of similar-looking data structures—each handling different types of assets but written with nearly identical logic.

"This is inefficient," Det muttered, scrolling through screens of redundant code. "We have separate vaults for coins, tokens, NFTs, credentials... but they all do the same thing."

Neri appeared beside her, carrying a steaming cup of tsokolate. "The pattern recognition protocols flagged it too. Seventeen different container implementations, all with the same store-and-retrieve logic."

"There has to be a better way." Det pulled up the Move documentation. "Generic programming. Write once, use for any type."

Neri's eyes lit up. "Type parameters! Instead of hardcoding the type, we make it a variable."

"Exactly." Det began sketching on her tablet. "One generic vault that works for Coin<APT>, NFT tokens, identity credentials—anything. The type becomes a parameter, not a constraint."

---

## Topics

### 1. Generic Functions

Generic functions allow you to write code that works with multiple types using type parameters:

```move
module examples::generic_functions {
    use std::vector;

    // Generic function with type parameter T
    public fun identity<T>(value: T): T {
        value
    }

    // Generic function that wraps any value in a vector
    public fun wrap_in_vector<T>(item: T): vector<T> {
        let v = vector::empty<T>();
        vector::push_back(&mut v, item);
        v
    }

    // Multiple type parameters
    public fun swap<A, B>(a: A, b: B): (B, A) {
        (b, a)
    }

    // Generic function with vector operations
    public fun first_element<T: copy>(vec: &vector<T>): T {
        *vector::borrow(vec, 0)
    }
}
```

Key points about generic functions:

- Type parameters are declared in angle brackets `<T>`
- Multiple type parameters separated by commas `<A, B, C>`
- Type parameters can have ability constraints `<T: copy>`
- The compiler infers types when possible

### 2. Type Parameters

Type parameters act as placeholders for concrete types:

```move
module examples::type_parameters {
    use std::vector;

    // T is a type parameter - a placeholder for any type
    public fun get_length<T>(vec: &vector<T>): u64 {
        vector::length(vec)
    }

    // Calling with different types:
    // get_length<u64>(&numbers)     -> T becomes u64
    // get_length<bool>(&flags)      -> T becomes bool
    // get_length<address>(&addrs)   -> T becomes address

    // Type parameters with meaningful names
    public fun transform<Input, Output>(
        _input: Input,
        default_output: Output
    ): Output {
        // In real code, you'd transform input to output
        default_output
    }

    // Phantom type parameters (unused in struct fields)
    // Used for type-level distinctions
    struct Marker<phantom T> has copy, drop, store {
        id: u64
    }
}
```

### 3. Generic Structs

Structs can also be parameterized with types:

```move
module examples::generic_structs {
    use std::vector;

    // Generic container struct
    struct Box<T> has copy, drop, store {
        value: T
    }

    // Generic pair struct with two type parameters
    struct Pair<A, B> has copy, drop, store {
        first: A,
        second: B
    }

    // Generic wrapper for optional values
    struct Optional<T> has copy, drop, store {
        value: vector<T>  // Empty = None, One element = Some
    }

    // Create a new box containing any value
    public fun new_box<T>(value: T): Box<T> {
        Box { value }
    }

    // Extract value from box
    public fun unbox<T>(box: Box<T>): T {
        let Box { value } = box;
        value
    }

    // Create a pair
    public fun make_pair<A, B>(first: A, second: B): Pair<A, B> {
        Pair { first, second }
    }

    // Create empty optional
    public fun none<T>(): Optional<T> {
        Optional { value: vector::empty<T>() }
    }

    // Create optional with value
    public fun some<T>(val: T): Optional<T> {
        let v = vector::empty<T>();
        vector::push_back(&mut v, val);
        Optional { value: v }
    }

    // Check if optional has value
    public fun is_some<T>(opt: &Optional<T>): bool {
        vector::length(&opt.value) > 0
    }
}
```

### 4. Practical Example: Generic Registry

```move
module examples::generic_registry {
    use std::vector;
    use std::signer;

    // Generic registry that can store any type
    struct Registry<T> has key {
        items: vector<T>,
        count: u64
    }

    // Initialize registry for a specific type
    public fun create_registry<T: store>(account: &signer) {
        move_to(account, Registry<T> {
            items: vector::empty<T>(),
            count: 0
        });
    }

    // Add item to registry
    public fun register<T: store>(
        account: &signer,
        item: T
    ) acquires Registry {
        let addr = signer::address_of(account);
        let registry = borrow_global_mut<Registry<T>>(addr);
        vector::push_back(&mut registry.items, item);
        registry.count = registry.count + 1;
    }

    // Get count of registered items
    public fun get_count<T: store>(addr: address): u64 acquires Registry {
        borrow_global<Registry<T>>(addr).count
    }
}
```

---

## Closing Scene

Hours later, Det pushed back from her workstation with a satisfied smile. The holographic display now showed a single, elegant generic vault implementation.

"One module," she announced. "Works for any asset type."

Neri examined the code, nodding appreciatively. "The Coin team can use it. The NFT team can use it. Even the identity credential system can use it."

"And when we need to add new functionality, we update one place instead of seventeen." Det saved the module. "Generic programming isn't just about writing less code—it's about writing code that adapts."

"Type parameters as variables," Neri summarized. "The type itself becomes flexible."

Det smiled. "Now let's see how we can add constraints to make sure these generics are used safely."

---

## Summary

- **Generic Functions**: Use `<T>` to create functions that work with any type
- **Type Parameters**: Placeholders that get replaced with concrete types at compile time
- **Generic Structs**: Structs parameterized by types, like `Box<T>` or `Pair<A, B>`
- **Multiple Parameters**: Functions and structs can have multiple type parameters
- **Type Inference**: The compiler often infers type parameters from context
- **Code Reuse**: Generics eliminate duplicate code for similar operations on different types
