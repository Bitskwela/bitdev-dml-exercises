# Mat 1: Phantom Parameters

## Scene

The research facility's holographic displays flickered with complex type diagrams as Ronnie paced around the central console. "Dex, we've got a problem. The token registry needs to distinguish between different token types at compile time, but we can't afford any runtime overhead."

Dex pulled up a schematic showing memory allocations. "Every byte counts in this system. If we add type parameters that carry actual data, the gas costs will spike."

"There has to be a way to mark types for the compiler's benefit without affecting runtime," Ronnie muttered, scrolling through documentation. His eyes lit up. "Phantom parameters. They exist purely at the type level—zero runtime cost."

Dex leaned in. "So the type system knows the difference, but the blockchain doesn't pay for it?"

"Exactly. The `phantom` keyword tells Move that a type parameter is only used for type checking. It's never stored or used in any field."

---

## Topics

### 1. The `phantom` Keyword

When a type parameter is marked as `phantom`, it means the parameter is only used at the type level and has no runtime representation:

```move
module examples::tokens {
    /// A phantom type parameter - USD is never stored
    struct Token<phantom Currency> has store {
        value: u64
    }

    /// Currency marker types - empty structs
    struct USD {}
    struct PHP {}
    struct EUR {}
}
```

The `Currency` parameter distinguishes token types at compile time, but `Token<USD>` and `Token<PHP>` have identical runtime representations—just a `u64`.

### 2. Type-Level Markers

Phantom types enable compile-time distinctions without runtime cost:

```move
module examples::markers {
    /// State markers - no fields needed
    struct Locked {}
    struct Unlocked {}

    /// Resource with phantom state
    struct Safe<phantom State> has key {
        contents: u64
    }

    /// Only works with Unlocked safes
    public fun withdraw(safe: &mut Safe<Unlocked>): u64 {
        let amount = safe.contents;
        safe.contents = 0;
        amount
    }

    /// Transform Unlocked to Locked
    public fun lock(safe: Safe<Unlocked>): Safe<Locked> {
        Safe<Locked> { contents: safe.contents }
    }
}
```

The compiler prevents calling `withdraw` on a `Safe<Locked>`—no runtime checks needed.

### 3. Zero Runtime Cost

Phantom parameters provide type safety without any storage or gas overhead:

```move
module examples::zero_cost {
    struct Meters {}
    struct Feet {}

    /// Distance stores only u64, but type system knows the unit
    struct Distance<phantom Unit> has copy, drop {
        value: u64
    }

    /// Create distances with explicit units
    public fun meters(value: u64): Distance<Meters> {
        Distance { value }
    }

    public fun feet(value: u64): Distance<Feet> {
        Distance { value }
    }

    /// Can only add same units - compiler enforced
    public fun add<Unit>(a: Distance<Unit>, b: Distance<Unit>): Distance<Unit> {
        Distance { value: a.value + b.value }
    }

    // This would fail: add(meters(100), feet(50))
}
```

---

## Closing Scene

Ronnie deployed the updated token registry. The type system now distinguished between dozens of currency types, but the on-chain storage remained minimal.

"Look at these gas costs," Dex said approvingly. "Same as before we added multi-currency support."

"Phantom parameters give us the best of both worlds," Ronnie replied. "The compiler catches type mismatches before deployment, and the blockchain never knows the difference."

Dex nodded. "Type-level programming that pays for itself."

---

## Summary

- The `phantom` keyword marks type parameters used only at the type level
- Phantom types have zero runtime representation—no storage or gas cost
- Marker types (empty structs) work with phantom parameters for state machines
- The compiler enforces phantom type constraints, preventing mismatched operations
- Use phantom parameters when you need compile-time distinctions without runtime overhead
