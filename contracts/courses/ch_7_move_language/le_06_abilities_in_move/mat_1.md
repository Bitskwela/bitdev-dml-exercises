## Background Story

Odessa stands in the Chamber of Sigils, a circular room carved with four ancient symbols glowing on the walls. Master Cipher enters, holding four crystals that shimmer with different colors.

"These are the Four Sigils of Move," Cipher says, placing each crystal on its corresponding symbol. "Every type you create carries abilities—four ancient marks that determine what can be done with it."

The crystals begin to glow, revealing their properties:

"The first is **Copy**—data so abundant it multiplies without cost. The second is **Drop**—data so fleeting it vanishes when no longer needed. The third is **Store**—data so precious it persists in the global vault. And the fourth is **Key**—data so fundamental it can anchor other values."

Cipher turns to Odessa. "Most types have abilities—they're flexible. But some types have _no_ abilities. Those are **Resources**—the most sacred data in Move. Resources cannot be copied, cannot be dropped, cannot be stored carelessly. They are unique, linear, tracked to the atom."

"Today, you'll learn to wield these Four Sigils. By the end, you'll understand not just how to create types, but _why_ certain types have certain restrictions. This knowledge is the difference between code that works and code that is unbreakable."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **What Abilities Represent: Four Marks of Intent**

Abilities are annotations on types that declare what the compiler should allow:

```move
struct SpellBook has copy, drop, store {
    spells: u64  // Can be copied, dropped, stored
}

struct Wand has drop {
    power: u64  // Can be dropped, but NOT copied or stored
}

struct Grimoire {
    secrets: u64  // NO abilities—this is a RESOURCE!
}
```

**The Four Abilities:**

**`copy`**: The value can be implicitly copied

```move
struct HasCopy has copy { value: u64 }

let x = HasCopy { value: 10 };
let y = x;  // ✅ x is COPIED (x still exists!)
let z = x;  // ✅ Can copy again (x STILL exists!)
```

**`drop`**: The value can be silently discarded

```move
struct HasDrop has drop { value: u64 }

let x = HasDrop { value: 10 };
// end of scope—x is DROP-ed (disappears silently)
// ✅ No error, no requirement to use it
```

**`store`**: The value can be stored in persistent storage

```move
struct HasStore has store { value: u64 }
// Can be stored in global state (more on this later)
```

**`key`**: The value can be used as a key for storage (rarely used in basics)

```move
struct SpellID has key { id: u64 }
// Can be used to anchor data in global state
```

### 2️⃣ **Rules & Restrictions: The Compiler's Guards**

The compiler enforces strict rules about abilities:

**Rule 1: Copy prevents moves**

```move
struct NoCopy { value: u64 }

let x = NoCopy { value: 10 };
let y = x;    // MOVE (x no longer exists)
// println!("{}", x); // ❌ ERROR! x was moved
```

**Rule 2: Drop prevents "use it or error"**

```move
struct NoDrop { value: u64 }

let x = NoDrop { value: 10 };
// end of scope—ERROR! ❌ Must explicitly handle x
```

**Rule 3: Store prevents leaking into structs**

```move
struct OnlyLocal has store { value: u64 }
struct Container {
    data: OnlyLocal  // ❌ ERROR! OnlyLocal can't be stored
}
```

**Rule 4: Resources require explicit handling**

```move
struct Treasure {
    gold: u64  // No abilities = RESOURCE
}

let x = Treasure { gold: 100 };
// Must be explicitly destroyed, moved, or returned
// Can't accidentally drop it—compiler forces you to acknowledge it
```

### 3️⃣ **Designing Types with Intent: Every Ability Means Something**

When you add abilities to a struct, you're making a promise about how it should be used:

**Type design example:**

```move
// A small, immutable, reusable piece of data
struct PowerLevel has copy, drop, store {
    value: u8  // 0-100
}
// This can be used ANYWHERE—passed around freely

// A configuration that lives on-chain
struct SpellConfig has store {
    name: String,
    power: PowerLevel
}
// Can be stored but not copied (prevent duplicates)

// A unique spell instance (a resource!)
struct ActiveSpell {
    id: u64,
    owner: address,
    power: PowerLevel
}
// Cannot be copied (prevent duplication)
// Cannot be dropped (must be explicitly handled)
// Cannot be stored arbitrarily (must use storage functions)
```

### 4️⃣ **Resource vs Non-Resource Distinction: The Core Difference**

This is the most important distinction in Move:

**Non-Resources** (have at least one ability):

- Can be copied implicitly
- Can be dropped at scope end
- Can be mixed and matched freely
- Examples: numbers, bools, configs, small data

**Resources** (no abilities):

- Cannot be copied (exactly one owner at a time)
- Cannot be dropped (must be explicitly handled)
- Cannot vanish or multiply
- Examples: tokens, coins, NFTs, unique assets

**Why this matters for blockchain:**

```move
struct Token {  // RESOURCE
    amount: u64
}

// The compiler ensures:
// ✅ You cannot accidentally create two tokens from one
// ✅ You cannot accidentally delete a token
// ✅ Every token that exists is accounted for
// ✅ Total supply is guaranteed by the compiler
```

Compare to a language without resources:

```
// In other languages:
let coin = new Coin(100);
let coin2 = coin;  // ❌ Now you have TWO copies of 100!
// coin1.balance--;  // ❌ Easy to corrupt
delete coin1;  // ❌ Token vanishes without trace
// Total supply is broken and nobody knows
```

### 5️⃣ **Practical Ability Combinations**

Different combinations suit different purposes:

```move
// Pure data—no restrictions
struct Label has copy, drop, store {
    text: String
}

// Configuration—can't copy, but can be forgotten
struct Config has drop, store {
    version: u64
}

// Cached data—can copy, but can't store
struct Cache has copy, drop {
    result: u64
}

// Unique resource—maximum restrictions
struct NFT {
    id: u64,
    owner: address
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Understanding Ability Implications 🔮

**Scenario:** Odessa is designing different spell types and must choose appropriate abilities.

**Boilerplate Code:**

```move
module spell_library::spell_abilities {
    use std::string::String;

    // TODO: Design a SpellPower type
    // - It represents a number 0-100
    // - Should be copyable (often passed around)
    // - Should be droppable (temporary calculations)
    // - Should NOT be storable on-chain (only ephemeral)
    struct SpellPower ____ {
        value: u8
    }

    // TODO: Design a SpellTemplate type
    // - It's a configuration stored on-chain
    // - Should NOT be copyable (prevent duplicates)
    // - Should be droppable (can override config)
    // - Should be storable (lives on-chain)
    struct SpellTemplate ____ {
        name: String,
        base_power: u8
    }

    // TODO: Design an ActiveSpell type (RESOURCE)
    // - It's a unique spell currently active
    // - Should NOT be copyable (unique instance)
    // - Should NOT be droppable (must be consumed/tracked)
    // - Should NOT be storable in arbitrary places
    struct ActiveSpell ____ {
        id: u64,
        owner: address,
        power: u8
    }

    public fun test_abilities() {
        // SpellPower can be copied
        let power = SpellPower { value: 50 };
        let power2 = power;  // Should work
        assert!(power.value == 50, 1);
        assert!(power2.value == 50, 2);

        // ActiveSpell cannot be copied
        let spell = ActiveSpell { id: 1, owner: @0x1, power: 75 };
        // let spell2 = spell;  // ❌ Would be ERROR!
    }
}
```

**Your Task:**

1. Add the correct abilities (or no abilities) to each struct
2. Add `has copy, drop` to SpellPower
3. Add `has drop, store` to SpellTemplate
4. Add no abilities to ActiveSpell (making it a resource)
5. Verify the test passes

---

### Exercise 2: Copy vs Move Behavior 📖

**Scenario:** Demonstrate how abilities affect whether values copy or move.

**Boilerplate Code:**

```move
module spell_library::copy_vs_move {

    struct Copyable has copy, drop {
        value: u64
    }

    struct Moveable has drop {
        value: u64
    }

    public fun test_copy_behavior() {
        // TODO: Create a Copyable and assign it multiple times
        let x = Copyable { value: 100 };
        let y = ____;  // Assign x (should copy, not move)
        let z = ____;  // Assign x again (should work!)

        // All three should still have the value
        assert!(x.value == 100, 1);
        assert!(y.value == 100, 2);
        assert!(z.value == 100, 3);
    }

    public fun test_move_behavior() {
        // TODO: Create a Moveable and show it only moves once
        let m = Moveable { value: 200 };
        let m2 = ____;  // Assign m (m is MOVED)

        // TODO: Try to use m again—what happens?
        // Uncomment below to see the error:
        // let m3 = m;  // ❌ ERROR! m was already moved

        assert!(m2.value == 200, 1);
    }
}
```

**Your Task:**

1. Assign `x` to both `y` and `z` (should copy)
2. Assign `m` to `m2` (should move)
3. Explain why `x` can be used after assignment but `m` cannot

---

### Exercise 3: Resource Design 🏰

**Scenario:** Design a Treasure resource that cannot be duplicated or accidentally destroyed.

**Boilerplate Code:**

```move
module spell_library::treasure_resource {

    // TODO: Define Treasure as a RESOURCE
    // - Must have an ID (u64)
    // - Must have an amount (u64)
    // - Must have an owner (address)
    // - NO abilities (making it a resource)
    struct Treasure ____ {
        id: u64,
        amount: u64,
        owner: address
    }

    public fun create_treasure(id: u64, amount: u64, owner: address): Treasure {
        Treasure { id, amount, owner }
    }

    public fun consume_treasure(treasure: Treasure): u64 {
        // Extract the amount from the treasure (consuming it)
        treasure.amount
    }

    public fun test_resource_safety() {
        let treasure = create_treasure(1, 1000, @0x1);

        // TODO: Call consume_treasure and get the amount
        let amount = consume_treasure(____);

        // verify the amount
        assert!(amount == 1000, 1);

        // TODO: Try to use treasure again—what happens?
        // Uncomment below to see the error:
        // let amount2 = consume_treasure(treasure);  // ❌ ERROR! treasure already moved
    }
}
```

**Your Task:**

1. Define `Treasure` as a resource (no abilities)
2. Call `consume_treasure` to move the treasure
3. Explain why you cannot use `treasure` after it's consumed

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::spell_abilities {
    use std::string::String;

    struct SpellPower has copy, drop {
        value: u8
    }

    struct SpellTemplate has drop, store {
        name: String,
        base_power: u8
    }

    struct ActiveSpell {
        id: u64,
        owner: address,
        power: u8
    }

    public fun test_abilities() {
        // SpellPower can be copied
        let power = SpellPower { value: 50 };
        let power2 = power;  // ✅ Copied!
        assert!(power.value == 50, 1);
        assert!(power2.value == 50, 2);

        // ActiveSpell is a resource
        let spell = ActiveSpell { id: 1, owner: @0x1, power: 75 };
        // Cannot copy it
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::copy_vs_move {

    struct Copyable has copy, drop {
        value: u64
    }

    struct Moveable has drop {
        value: u64
    }

    public fun test_copy_behavior() {
        // Create a Copyable and assign it multiple times
        let x = Copyable { value: 100 };
        let y = x;  // ✅ Copied (x still exists)
        let z = x;  // ✅ Copied again! (x STILL exists)

        // All three have the value
        assert!(x.value == 100, 1);
        assert!(y.value == 100, 2);
        assert!(z.value == 100, 3);
    }

    public fun test_move_behavior() {
        // Create a Moveable and show it only moves once
        let m = Moveable { value: 200 };
        let m2 = m;  // ❌ MOVED (m no longer exists)

        // Cannot use m again
        assert!(m2.value == 200, 1);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::treasure_resource {

    struct Treasure {
        id: u64,
        amount: u64,
        owner: address
    }

    public fun create_treasure(id: u64, amount: u64, owner: address): Treasure {
        Treasure { id, amount, owner }
    }

    public fun consume_treasure(treasure: Treasure): u64 {
        // Extract the amount (treasure is moved/consumed)
        treasure.amount
    }

    public fun test_resource_safety() {
        let treasure = create_treasure(1, 1000, @0x1);

        // Call consume_treasure
        let amount = consume_treasure(treasure);

        // Verify the amount
        assert!(amount == 1000, 1);

        // treasure is now gone—it was moved into consume_treasure
        // Compiler ensures we can't use it again
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Ability Selection

**SpellPower with `copy, drop`:**

- `copy`: Power levels are small (u8), safe to duplicate
- `drop`: Temporary calculations can be forgotten at scope end
- This is pure data—no restrictions needed

**SpellTemplate with `drop, store`:**

- `drop`: Old configs can be discarded when overwritten
- `store`: Needs to persist on-chain
- No `copy`: Prevents accidental template duplication

**ActiveSpell with no abilities (RESOURCE):**

- No `copy`: Each spell instance is unique—can't duplicate
- No `drop`: Must be explicitly consumed or transferred—can't disappear
- No `store`: Must use special functions to store (prevents arbitrary placement)

### Exercise 2 Explanation: Copy vs Move

**Copyable behavior:**

```move
let x = Copyable { ... };
let y = x;  // ✅ COPY (x still available)
let z = x;  // ✅ COPY again! (x still available)
// All three exist simultaneously
```

**Moveable behavior:**

```move
let m = Moveable { ... };
let m2 = m;  // MOVE (m is transferred)
// m no longer exists—it was moved to m2
// println!("{}", m);  // ❌ ERROR!
```

**The key difference:**

- `copy` ability = permission to implicitly copy
- No `copy` ability = must move (transfer ownership)

### Exercise 3 Explanation: Resources

**Why Treasure is a resource:**

- Resources have NO abilities
- Cannot copy (prevents duplication of treasure)
- Cannot drop (prevents accidentally forgetting treasure)
- Must be explicitly handled (compiler forces safety)

**The consume_treasure function:**

```move
public fun consume_treasure(treasure: Treasure): u64 {
    // Takes ownership of treasure
    // Returns the amount
    // treasure is moved into the function and destroyed
    treasure.amount
}
```

**Compiler guarantee:**

- Every treasure that exists must be explicitly accounted for
- No treasure can be lost or duplicated
- Perfect for managing assets on-chain!

---

## 🧪 Unit Tests

Here's a comprehensive test file:

```move
#[test_only]
module spell_library::ability_tests {
    use spell_library::spell_abilities;
    use spell_library::copy_vs_move;
    use spell_library::treasure_resource;

    #[test]
    fun test_spell_abilities() {
        spell_abilities::test_abilities();
    }

    #[test]
    fun test_spell_power_multiple_copies() {
        // Verify copy works multiple times
        let power = spell_abilities::SpellPower { value: 75 };
        let p1 = power;
        let p2 = power;
        let p3 = power;
        assert!(power.value == 75, 1);
        assert!(p1.value == 75, 2);
    }

    #[test]
    fun test_copy_vs_move_copy() {
        copy_vs_move::test_copy_behavior();
    }

    #[test]
    fun test_copy_vs_move_move() {
        copy_vs_move::test_move_behavior();
    }

    #[test]
    fun test_treasure_creation() {
        let treasure = treasure_resource::create_treasure(1, 500, @0x1);
        // Verify it was created (even though we can't copy it)
        assert!(treasure_resource::consume_treasure(treasure) == 500, 1);
    }

    #[test]
    fun test_multiple_treasures() {
        // Create multiple treasures
        let t1 = treasure_resource::create_treasure(1, 100, @0x1);
        let t2 = treasure_resource::create_treasure(2, 200, @0x2);
        let t3 = treasure_resource::create_treasure(3, 300, @0x3);

        // Each one must be explicitly consumed
        let a1 = treasure_resource::consume_treasure(t1);
        let a2 = treasure_resource::consume_treasure(t2);
        let a3 = treasure_resource::consume_treasure(t3);

        assert!(a1 == 100, 1);
        assert!(a2 == 200, 2);
        assert!(a3 == 300, 3);
    }

    #[test]
    fun test_ability_guarantees() {
        // Copyable can be copied
        let copy = spell_abilities::SpellPower { value: 50 };
        let _ = copy;
        let _ = copy;  // ✅ Works!

        // Treasure cannot be copied
        let t = treasure_resource::create_treasure(1, 100, @0x1);
        // let t2 = t;  // ❌ Would error
        let _ = treasure_resource::consume_treasure(t);  // ✅ Must move it
    }
}
```

### Running the Tests

```bash
move test
move test -- --verbose
```

---

## 🌟 Closing Story

Master Cipher watches as Odessa completes her final test with the Four Sigils. The crystals on the walls begin to glow in harmony.

> "You now understand the secret that guards the blockchain," Cipher says, his voice echoing through the chamber. "Every type carries intent. Every ability—or the absence of it—tells the compiler what is safe to do."

> "In other lands, programmers trust humans to remember rules. 'Don't copy this token!' they write in comments. 'Don't forget to destroy this!' But humans forget. And when they forget, assets disappear or multiply, and the chain breaks."

> "Here, the compiler never forgets. The compiler enforces every sigil. The compiler ensures that resources cannot be copied, cannot be lost, cannot vanish into the void. This is why Move is unbreakable."

Odessa looks at the glowing crystals, now seeing them not as restrictions, but as promises—promises that her code will be safe.

> "Next, you'll learn something deeper still. You'll learn that Move is not just about safety—it's about rights. Resources are not just data; they represent ownership, transfer, and value. Tomorrow, we begin the final foundation: Resource-Oriented Programming."

---

**Next Lesson Preview:** 💎 _Resource-Oriented Programming: The Linear Type System_

- Understanding resources as first-class citizens
- Resource invariants and constraints
- Preventing double-spend and duplication
- Linear type system guarantees
- Building trustless financial systems

_The path to mastery deepens. Are you ready?_
