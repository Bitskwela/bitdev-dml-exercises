## Scene

Mike bursts through the MoveStack office door, laptop in hand. As project manager, he's the bridge between clients and developers, and today he's carrying a fresh set of requirements.

"Big news, team," Mike announces, gathering Neri and Ronnie around the central table. "Client wants a full user profile system. Not just addresses—they want reputation scores, display names, verification status, the works."

Ronnie, the team's architect, pulls up a blank Move file. "Perfect timing. This is exactly what structs are for. We're not just storing random data—we're defining what a UserProfile _means_ in our system."

Neri nods, already thinking ahead. "So we bundle related data together. Name, reputation, verification—all in one typed container."

"Exactly," Ronnie says. "In other languages, you'd throw this in a hashmap and pray nobody mixes up the keys. Move is different. Every field is typed. Every struct knows exactly what it contains. The compiler enforces it."

Mike looks between them. "So if someone tries to pass a username where an address should be..."

"Compile-time error," Neri finishes. "The mistake never reaches production."

Ronnie draws a quick diagram on the whiteboard—boxes within boxes, fields connecting to fields. "Today we build MoveStack's UserProfile system. Nested structs, field access, destructuring. By the end, we'll have a real data model that can live on-chain forever."

"Let's architect this properly," Mike says, taking a seat to observe.

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Structs: Defining Your Domain**

A struct is a custom type that bundles related data together:

```move
struct Spell {
    name: String,
    power: u64,
    is_active: bool,
    caster: address
}
```

**Creating a struct instance:**

```move
let my_spell = Spell {
    name: utf8(b"Fireball"),
    power: 100,
    is_active: true,
    caster: @0x1
};
```

**Accessing fields:**

```move
println!("{}", my_spell.power);  // Access power
let caster_address = my_spell.caster;
```

**Modifying fields (must be mutable):**

```move
let mut spell = Spell { ... };
spell.power = 150;  // ✅ Can modify mutable struct
```

**Why structs matter:**

- Type-safe: compiler knows what fields exist
- Semantic clarity: "Spell" is more meaningful than a tuple
- Field names: no need to remember tuple order (0, 1, 2...)
- Bundling: related data is grouped together

### 2️⃣ **Struct Composition: Building Hierarchies**

Structs can contain other structs, creating complex hierarchies:

```move
struct Caster {
    name: String,
    level: u64,
    mana: u64
}

struct SpellRecord {
    spell: Spell,              // Struct within struct!
    caster_info: Caster,      // Another struct
    timestamp: u64,
    location: address
}
```

**Creating nested structures:**

```move
let caster = Caster {
    name: utf8(b"Odessa"),
    level: 10,
    mana: 500
};

let spell = Spell {
    name: utf8(b"Lightning"),
    power: 80,
    is_active: true,
    caster: @0x1
};

let record = SpellRecord {
    spell: spell,              // Use the struct we created
    caster_info: caster,      // Use the caster struct
    timestamp: 12345,
    location: @0x2
};
```

**Accessing nested fields:**

```move
let spell_power = record.spell.power;           // Two levels deep
let caster_level = record.caster_info.level;   // Nested access
```

**Why composition is powerful:**

- Mirrors real-world organization
- Each struct focuses on one thing
- Easy to modify one part without affecting others
- Clear ownership hierarchy

### 3️⃣ **Abilities: Controlling What You Can Do**

Structs can have **abilities** that determine what operations are allowed:

```move
// Copy ability: Can be implicitly copied
struct CopyableSpell has copy {
    power: u64
}

let spell1 = CopyableSpell { power: 100 };
let spell2 = spell1;  // ✅ Copied automatically
println!("{}, {}", spell1.power, spell2.power);  // Both exist!
```

```move
// Drop ability: Can be silently dropped (forgotten)
struct DropSpell has drop {
    name: String
}

let spell = DropSpell { name: utf8(b"Silence") };
// When scope ends, spell is automatically dropped (no error)
```

```move
// Store ability: Can be stored as a resource
struct StorableSpell has store {
    data: u64
}
// Can be stored in other structs or modules
```

**Important: Resources (no abilities)**

```move
struct SpellLibrary {  // No abilities!
    spells: vector<Spell>
}
// This is a RESOURCE (not copyable, not droppable)
// It must be explicitly handled
```

**Why abilities matter:**

- `copy`: Small, immutable data (like numbers, bools)
- `drop`: Data that can be safely forgotten
- `store`: Data that can be stored persistently
- No abilities: Resources (unique, valuable things that must be tracked)

### 4️⃣ **Phantom Types: Type Safety Without Storage**

Phantom types are type parameters that don't actually store data—they're markers for safety:

```move
struct Treasury<CoinType> {
    amount: u64
}
// CoinType is a phantom—it's never stored
// But the type system knows this Treasury is for CoinType only!
```

**Why phantoms are useful:**

```move
// Without phantom types, you could mix up treasuries:
let apricot_treasury: Treasury = Treasury { amount: 100 };
let bitcoin_treasury: Treasury = Treasury { amount: 100 };
// Both are just "Treasury"—easy to confuse!

// With phantom types:
let apricot_treasury: Treasury<Apricot> = Treasury { amount: 100 };
let bitcoin_treasury: Treasury<Bitcoin> = Treasury { amount: 100 };
// Now the types are DIFFERENT—no mix-up possible!
```

**Real example:**

```move
struct Treasury<CoinType> {
    amount: u64
}

struct Apricot {}  // Empty marker type
struct Bitcoin {}  // Empty marker type

// These are INCOMPATIBLE types:
let apricot_account: Treasury<Apricot> = Treasury { amount: 100 };
let bitcoin_account: Treasury<Bitcoin> = Treasury { amount: 100 };

// You can't accidentally transfer apricot to bitcoin!
// The compiler prevents it.
```

### 5️⃣ **Mutability in Structs**

Struct mutability is all-or-nothing at the field level:

```move
struct SpellConfig {
    name: String,
    power: u64,
    caster: address
}

let mut config = SpellConfig { ... };
config.power = 200;  // ✅ Can modify any field

let config2 = SpellConfig { ... };  // Immutable
// config2.power = 300;  // ❌ ERROR! Not mutable
```

**Mutable references to structs:**

```move
public fun upgrade_spell(spell: &mut Spell, new_power: u64) {
    spell.power = new_power;  // Modify through reference
}

let mut my_spell = Spell { ... };
upgrade_spell(&mut my_spell, 150);
// my_spell is now upgraded
```

---

## 🎯 Activity / Exercises

### Exercise 1: Creating Basic Structs 🏰

**Scenario:** Odessa needs to create a data structure to represent a spell in the Guild's registry.

**Boilerplate Code:**

```move
module spell_library::spell_data {
    use std::string::String;

    // TODO: Define a Spell struct with:
    // - name: String
    // - power_level: u64 (0-100 scale)
    // - element: String (e.g., "Fire", "Ice")
    // - caster_address: address
    ____ Spell {
        ____
    }

    public fun create_spell(): Spell {
        Spell {
            name: std::string::utf8(b"Fireball"),
            power_level: 75,
            element: std::string::utf8(b"Fire"),
            caster_address: @0x1
        }
    }

    public fun test_spell_creation() {
        let spell = create_spell();

        // TODO: Assert the spell's properties
        assert!(spell.power_level == 75, 1);
        assert!(spell.caster_address == @0x1, 2);
    }
}
```

**Your Task:**

1. Define the `Spell` struct with all four fields
2. Ensure the `create_spell` function builds it correctly
3. Add assertions to verify each field

---

### Exercise 2: Struct Composition 🔗

**Scenario:** Build a SpellRecord that contains both spell data and caster information.

**Boilerplate Code:**

```move
module spell_library::spell_record {
    use std::string::String;

    struct Caster {
        name: String,
        level: u64
    }

    // TODO: Define a SpellRecord struct that contains:
    // - spell_name: String
    // - spell_power: u64
    // - caster: Caster (nested!)
    // - cast_timestamp: u64
    ____ SpellRecord {
        ____
    }

    public fun create_record(): SpellRecord {
        let caster = Caster {
            name: std::string::utf8(b"Odessa"),
            level: 15
        };

        SpellRecord {
            spell_name: std::string::utf8(b"Lightning"),
            spell_power: 90,
            caster: caster,
            cast_timestamp: 1000
        }
    }

    public fun test_composition() {
        let record = create_record();

        // TODO: Assert nested field access works
        assert!(record.spell_power == 90, 1);
        assert!(record.caster.level == 15, 2);  // Access nested field
        assert!(record.cast_timestamp == 1000, 3);
    }
}
```

**Your Task:**

1. Define the `SpellRecord` struct with a nested `Caster`
2. Create an instance and verify nested field access
3. Add assertions for all fields (including nested ones)

---

### Exercise 3: Abilities and Phantom Types 🔮

**Scenario:** Create a `Treasury` that can hold any coin type, and ensure type safety with phantom types.

**Boilerplate Code:**

```move
module spell_library::treasury {

    // Empty marker types for different coin types
    struct FireCoin {}
    struct IceCoin {}

    // TODO: Define a Treasury struct:
    // - It should have a phantom type parameter <CoinType>
    // - It should store amount: u64
    // - It should have abilities: copy, drop
    ____ Treasury<CoinType: drop> ____ {
        amount: u64
    }

    public fun create_fire_treasury(amount: u64): Treasury<FireCoin> {
        Treasury { amount }
    }

    public fun create_ice_treasury(amount: u64): Treasury<IceCoin> {
        Treasury { amount }
    }

    public fun test_phantom_safety() {
        let fire_treasury = create_fire_treasury(1000);
        let ice_treasury = create_ice_treasury(500);

        // These should be different types, so we can't mix them
        // fire_treasury and ice_treasury are INCOMPATIBLE
        assert!(fire_treasury.amount == 1000, 1);
        assert!(ice_treasury.amount == 500, 2);
    }
}
```

**Your Task:**

1. Define `Treasury<CoinType>` with phantom type and abilities
2. Create instances for different coin types
3. Verify that the type system keeps them separate (the compiler should prevent mixing)

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::spell_data {
    use std::string::String;

    struct Spell {
        name: String,
        power_level: u64,
        element: String,
        caster_address: address
    }

    public fun create_spell(): Spell {
        Spell {
            name: std::string::utf8(b"Fireball"),
            power_level: 75,
            element: std::string::utf8(b"Fire"),
            caster_address: @0x1
        }
    }

    public fun test_spell_creation() {
        let spell = create_spell();

        // Assert the spell's properties
        assert!(spell.power_level == 75, 1);
        assert!(spell.caster_address == @0x1, 2);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::spell_record {
    use std::string::String;

    struct Caster {
        name: String,
        level: u64
    }

    struct SpellRecord {
        spell_name: String,
        spell_power: u64,
        caster: Caster,
        cast_timestamp: u64
    }

    public fun create_record(): SpellRecord {
        let caster = Caster {
            name: std::string::utf8(b"Odessa"),
            level: 15
        };

        SpellRecord {
            spell_name: std::string::utf8(b"Lightning"),
            spell_power: 90,
            caster: caster,
            cast_timestamp: 1000
        }
    }

    public fun test_composition() {
        let record = create_record();

        // Assert nested field access works
        assert!(record.spell_power == 90, 1);
        assert!(record.caster.level == 15, 2);  // Access nested field
        assert!(record.cast_timestamp == 1000, 3);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::treasury {

    // Empty marker types for different coin types
    struct FireCoin {}
    struct IceCoin {}

    // Treasury struct with phantom type and abilities
    struct Treasury<CoinType: drop> has copy, drop {
        amount: u64
    }

    public fun create_fire_treasury(amount: u64): Treasury<FireCoin> {
        Treasury { amount }
    }

    public fun create_ice_treasury(amount: u64): Treasury<IceCoin> {
        Treasury { amount }
    }

    public fun test_phantom_safety() {
        let fire_treasury = create_fire_treasury(1000);
        let ice_treasury = create_ice_treasury(500);

        // These are different types—compiler prevents mixing!
        assert!(fire_treasury.amount == 1000, 1);
        assert!(ice_treasury.amount == 500, 2);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Basic Struct Definition

**Why we need structs:**

- Group related data together (spell's properties go together)
- Type safety: compiler knows what fields exist
- Documentation: struct name tells us what data represents

**The struct definition:**

```move
struct Spell {
    name: String,           // Who cast it (or what is its name)
    power_level: u64,       // How strong (0-100)
    element: String,        // What type (Fire, Ice, etc.)
    caster_address: address // Who cast it
}
```

**Creating instances:**

- Use `Spell { field1: value1, field2: value2, ... }` syntax
- All fields must be provided
- Types must match exactly

### Exercise 2 Explanation: Composition and Nesting

**Why composition is powerful:**

- Each struct has a single responsibility (Caster = caster info, SpellRecord = full record)
- Easy to reuse Caster in multiple places
- Clear hierarchical organization

**Accessing nested fields:**

```move
record.caster.level  // Two accesses: first get .caster, then get .level
```

**Benefits:**

- No need for flattening (all fields at top level)
- Changes to Caster structure don't break SpellRecord access
- Mirrors real-world relationships

### Exercise 3 Explanation: Phantom Types

**Why phantom types?**

```move
// Without phantom:
struct Treasury { amount: u64 }
let treasury1: Treasury = Treasury { amount: 100 };
let treasury2: Treasury = Treasury { amount: 100 };
// Both are "Treasury"—compiler doesn't know the difference!

// With phantom:
struct Treasury<CoinType: drop> has copy, drop { amount: u64 }
let treasury1: Treasury<FireCoin> = Treasury { amount: 100 };
let treasury2: Treasury<IceCoin> = Treasury { amount: 100 };
// DIFFERENT types—compiler prevents mixing!
```

**The `drop` constraint on `CoinType`:**

- Phantom types must have `drop` to keep the treasury `drop`-able
- Ensures the marker type doesn't prevent cleanup

**The abilities:**

- `copy`: Small, safe to copy
- `drop`: Can be forgotten (scope ends)
- Together: easy to use, no resource management headaches

---

## 🧪 Unit Tests

Here's a comprehensive test file:

```move
#[test_only]
module spell_library::data_structure_tests {
    use spell_library::spell_data;
    use spell_library::spell_record;
    use spell_library::treasury;

    #[test]
    fun test_spell_creation() {
        spell_data::test_spell_creation();
    }

    #[test]
    fun test_spell_modification() {
        let mut spell = spell_data::create_spell();
        spell.power_level = 100;
        assert!(spell.power_level == 100, 1);
    }

    #[test]
    fun test_spell_record_composition() {
        spell_record::test_composition();
    }

    #[test]
    fun test_nested_access_chain() {
        let record = spell_record::create_record();

        // Deep access
        let caster_name_exists = true;  // Just verify we can access
        assert!(caster_name_exists, 1);

        // Multiple nested accesses
        assert!(record.caster.level == 15, 2);
        assert!(record.spell_power == 90, 3);
    }

    #[test]
    fun test_treasury_type_safety() {
        treasury::test_phantom_safety();
    }

    #[test]
    fun test_treasury_copyability() {
        let fire1 = treasury::create_fire_treasury(1000);
        let fire2 = fire1;  // ✅ Can copy because we added 'copy' ability

        // Both should exist and be identical
        assert!(fire1.amount == fire2.amount, 1);
    }

    #[test]
    fun test_multiple_treasuries() {
        // Create treasuries of different coin types
        let fire = treasury::create_fire_treasury(500);
        let ice = treasury::create_ice_treasury(300);

        // Type system ensures they're different
        // (compiler prevents mixing them)
        assert!(fire.amount == 500, 1);
        assert!(ice.amount == 300, 2);
    }

    #[test]
    fun test_data_integrity() {
        // Create a record and verify all data is preserved
        let record = spell_record::create_record();

        assert!(record.spell_power == 90, 1);
        assert!(record.cast_timestamp == 1000, 2);
        assert!(record.caster.level == 15, 3);
    }
}
```

### Running the Tests

```bash
move test
move test -- --verbose
move test spell_library::data_structure_tests
```

---

## 🌟 Closing Story

Odessa stands at the crystal desk, surrounded by her completed data structures. Master Architect Nyx approaches, examining each one carefully.

> "You've built your first domain," Nyx says, nodding with approval. "These structs—they're not just containers. They're _blueprints_ for how the Guild will organize its knowledge forever."

Odessa looks at the intricate structures she's created, each piece fitting perfectly into the whole.

> "The beauty of Move," Nyx continues, "is that once you define a struct, the blockchain never forgets it. Every spell record you create will have the exact same shape, the exact same fields. No confusion, no corruption. The data you store today will be readable, trustworthy, and uncorrupted ten years from now."

> "This is power beyond magic. This is the power to organize reality itself."

Nyx gestures toward the temple's entrance, where the sun is setting over the city.

> "You've now learned the foundations of Move: primitives and variables, ownership and references, functions and their purity, and finally, how to structure data. You can build spells now. Real spells. Systems that matter."

> "But your true journey is just beginning. Next, you'll learn how to make these systems _interactive_—how to write modules that work together, how to handle errors, how to build tests that verify correctness. The path to mastery is long, but you have the foundation."

> "Rest well tonight. Tomorrow, we bridge the gap between theory and reality."

---

**Congratulations, Young Caster!** 🎉

You've completed the foundations of Move:

- ✅ Primitive Types & Mutability
- ✅ Ownership & Scope
- ✅ Functions & Visibility
- ✅ Data Structures & Composition

**Next Chapter:** 📚 _Advanced Topics_

- Error Handling & Assertions
- Module Organization & Dependencies
- Events and On-Chain Data
- Writing Comprehensive Tests
- Building Production-Ready Smart Contracts

_The Guild awaits your next chapter. Are you ready to continue?_
