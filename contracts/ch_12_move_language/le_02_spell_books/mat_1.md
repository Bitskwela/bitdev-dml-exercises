# Modules and Scripts

![Cover](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_12/le_02/cover.png)

## Scene

Ronnie pulls up a whiteboard in the MoveStack team's conference room. "Before we write more code, we need to understand how Move organizes things," he says, drawing boxes and arrows.

Neri and Jaymart lean forward. "In Solidity, we have contracts," Neri offers. "Is it similar?"

"Similar concept, different execution," Ronnie explains. "Move uses **modules**—reusable containers of code that define types and functions. But here's the key difference: modules are published to addresses, and they stay there. No contract addresses that change. Just stable, versioned code."

Jaymart raises his hand. "And scripts?"

"Scripts are one-time transaction logic," Det chimes in from his desk. "Modules are your library. Scripts are how users call into that library. For MoveStack, we'll focus on modules—they're what we'll be building."

Ronnie taps the whiteboard. "Let's set up our first proper module structure. Once you understand this, everything else clicks into place."

---

## Topics

### Modules: The Building Blocks

> A module in Move is a container that groups related types, functions, and resources together, published at a specific blockchain address.

Think of modules like packages in other languages. They're the primary way to organize code in Move. Every piece of reusable logic you write will live inside a module.

```move
module movestack::user_registry {
    // All code lives inside the module
    // - Struct definitions
    // - Functions
    // - Constants
}
```

The module declaration has two parts:

- **Address** (`movestack`): Where the module is published. This is typically a named address configured in your `Move.toml`
- **Name** (`user_registry`): The module's identifier, using snake_case convention

### Use Statements: Importing Functionality

> Use statements bring external types and functions into scope, making them accessible within your module.

You'll rarely write everything from scratch. The standard library and other modules provide useful functionality:

```move
module movestack::payments {
    use std::vector;
    use std::option::{Self, Option};

    // Now we can use vector::empty(), option::some(), etc.
}
```

**Common import patterns:**

```move
// Import the module, access via module::function
use std::vector;
let v = vector::empty<u64>();

// Import specific items
use std::option::{some, none};
let x = some(42);

// Import module and items using Self
use std::option::{Self, Option};
let opt: Option<u64> = option::none();
```

### Public vs Private Functions

> Visibility modifiers control which functions can be called from outside the module.

Move gives you fine-grained control over what's exposed:

**Private functions** (default): Only callable within the same module

```move
fun internal_helper(): u64 {
    // This can only be called by other functions in this module
    42
}
```

**Public functions**: Callable by any other module

```move
public fun get_balance(addr: address): u64 {
    // Any module can call this
    100
}
```

**Public entry functions**: Can be called directly in transactions

```move
public entry fun transfer(from: &signer, to: address, amount: u64) {
    // Users can call this directly from their wallets
}
```

**Friend functions**: Only callable by designated friend modules

```move
public(friend) fun privileged_action() {
    // Only modules declared as friends can call this
}
```

### Module Address Configuration

> Named addresses let you write portable code that works across different deployments.

In your `Move.toml` file, you configure named addresses:

### 3️⃣ **Mutability Rules: Declaring Intentions**

By default, variables are **immutable**:

```move
let x = 10;
// x = 20;  // ❌ ERROR! x cannot change!
```

To make a variable changeable, use `mut`:

```move
let mut x = 10;
x = 20;  // ✅ OK! x is now 20
```

**Why is immutability the default?** Because it's safer! If most things don't change, bugs are less likely. When you write `mut`, you're saying "I know this will change, and I've thought about the consequences."

### 4️⃣ **Tuples: Bundling Values Together**

Sometimes you need to group values:

```move
let person = (42, true);           // A tuple of (u8, bool)
let coordinates = (100, 200, 300); // A tuple of three u64s
```

Unpack them to extract values:

```move
let (age, is_active) = person;
```

Or access by position:

```move
let first = person.0;   // Gets 42
let second = person.1;  // Gets true
```

### 5️⃣ **Literals & Type Inference: Move Reads Your Mind**

Move is smart about figuring out types from what you write:

```move
let x = 42;              // Move infers: u64 (default integer type)
let balance = 100u128;   // You explicitly say: u128
let flag = true;         // Move infers: bool
let hex_address = @0x1;  // Move infers: address
```

Type inference makes code readable, but explicit types prevent confusion:

```move
let x: u32 = 42;        // Clear: this is specifically u32
```

---

## 🎯 Activity / Exercises

### Exercise 1: Spell Book Inventory 📖

**Scenario:** You're building an inventory system for the Spell Library. You need to store basic information about a spell.

**Boilerplate Code:**

```move
module spell_library::spell_inventory {
    use std::vector;

    // TODO: Create a function that stores spell information
    public fun create_spell() {
        // Declare the spell's power level (0-100) using let
        let power_level = ____;

        // Declare if the spell is active (true/false)
        let is_active = ____;

        // Declare the caster's address (use @0x1 as example)
        let caster = ____;

        // Bundle them into a tuple
        let spell_data = (power_level, is_active, caster);
    }
}
```

**Your Task:**

1. Fill in the blanks with appropriate values
2. Specify explicit types for each variable
3. Make sure the tuple correctly combines all three pieces of information

---

### Exercise 2: Mutable Spell Counter ⚡

**Scenario:** Spells consume energy. Track how many times a spell has been cast, and it can increase.

**Boilerplate Code:**

```move
module spell_library::spell_counter {

    public fun track_spell_casts() {
        // TODO: Create a counter that tracks spell casts
        // It starts at 0 and will increase as spells are cast
        let ____ = 0u64;

        // Cast the spell once
        ____ = 1;

        // Cast the spell again
        ____ = 2;

        // Cast the spell a third time
        ____ = 3;
    }
}
```

**Your Task:**

1. Replace `____` with appropriate variable declarations
2. Decide: should this variable be mutable or immutable?
3. Add the `mut` keyword where needed

---

### Exercise 3: Address Validation & Type Conversion 🔐

**Scenario:** The Guild maintains a registry of authorized casters. You need to verify that addresses and user IDs are tracked correctly.

**Boilerplate Code:**

```move
module spell_library::caster_registry {

    public fun validate_caster() {
        // Create an 8-bit user ID
        let user_id: u8 = 42;

        // Create a 64-bit experience points counter
        let exp_points: u64 = 1000;

        // Bundle user_id and exp_points into a tuple
        let caster_stats = (user_id, exp_points);

        // TODO: Unpack the tuple to extract user_id and exp_points
        // Use destructuring: let (id, exp) = caster_stats;
        let ____ = caster_stats;

        // TODO: Create an immutable address for the caster's wallet
        let wallet_address: address = ____;
    }
}
```

**Your Task:**

1. Unpack the tuple correctly (destructure it)
2. Fill in a valid address for the wallet (use `@0x2` or `@0xCAFE`)
3. Verify all type declarations match the values

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::spell_inventory {
    use std::vector;

    public fun create_spell() {
        // Declare the spell's power level (0-100) using u8
        let power_level: u8 = 75;

        // Declare if the spell is active (true/false)
        let is_active: bool = true;

        // Declare the caster's address
        let caster: address = @0x1;

        // Bundle them into a tuple
        let spell_data: (u8, bool, address) = (power_level, is_active, caster);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::spell_counter {

    public fun track_spell_casts() {
        // Create a mutable counter (will change as spells are cast)
        let mut cast_count: u64 = 0;

        // Cast the spell once
        cast_count = 1;

        // Cast the spell again
        cast_count = 2;

        // Cast the spell a third time
        cast_count = 3;
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::caster_registry {

    public fun validate_caster() {
        // Create an 8-bit user ID
        let user_id: u8 = 42;

        // Create a 64-bit experience points counter
        let exp_points: u64 = 1000;

        // Bundle user_id and exp_points into a tuple
        let caster_stats = (user_id, exp_points);

        // Unpack the tuple to extract values
        let (id, exp) = caster_stats;

        // Create an immutable address for the caster's wallet
        let wallet_address: address = @0xCAFE;
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Type Safety in Action

**Why `u8` for power_level?**

- Power levels are 0-100, well within u8's range (0-255)
- Using smaller types saves memory on the blockchain (matters for gas costs!)

**Why `bool` for is_active?**

- Only two states: casting or not casting
- Bool is the perfect fit

**Why `address`?**

- Represents a wallet/account on the blockchain
- Move enforces that addresses are exactly the right format

**The Tuple:**

- Grouping related data together keeps code organized
- You can pass this single tuple around instead of three separate variables

### Exercise 2 Explanation: Mutability = Intentional Change

**Why `mut`?**

- The variable starts at 0 and changes to 1, 2, 3
- Without `mut`, the compiler would reject `cast_count = 1`
- By writing `mut`, you're telling Move: "I know this changes, I've planned for it"

**Why `u64` instead of `u8`?**

- A spell could be cast thousands of times
- `u8` maxes out at 255, so `u64` (0 to 18 quintillion) is safer
- This is defensive programming: "future-proof your code"

### Exercise 3 Explanation: Destructuring & Addresses

**Unpacking (Destructuring):**

```move
let (id, exp) = caster_stats;
```

- This extracts the first value (42) into `id`
- Extracts the second value (1000) into `exp`
- Now you can use `id` and `exp` separately

**Address Literal:**

- `@0xCAFE` is hexadecimal notation (0-9, A-F)
- Move automatically converts it to an address type
- It's a fixed 32-byte identifier

---

## 🧪 Unit Tests

Here's a test file to validate all your solutions:

```move
#[test_only]
module spell_library::spell_inventory_tests {
    use spell_library::spell_inventory;
    use spell_library::spell_counter;
    use spell_library::caster_registry;

    #[test]
    fun test_spell_inventory_types() {
        // This test ensures Exercise 1 compiles and runs without errors
        spell_inventory::create_spell();
        // If we reach here, types were correct!
    }

    #[test]
    fun test_spell_counter_mutability() {
        // This test ensures Exercise 2 compiles and mutability works
        spell_counter::track_spell_casts();
        // If we reach here, mutability was correct!
    }

    #[test]
    fun test_caster_registry_unpacking() {
        // This test ensures Exercise 3 compiles and unpacking works
        caster_registry::validate_caster();
        // If we reach here, tuple unpacking was correct!
    }

    // Advanced Test: Verify type constraints
    #[test]
    fun test_advanced_type_constraints() {
        // u8 can only hold 0-255
        let small_number: u8 = 255;
        assert!(small_number == 255, 1);

        // u64 can hold much larger numbers
        let large_number: u64 = 18446744073709551615; // u64 max
        assert!(large_number > 0, 2);

        // Booleans are exactly true or false
        let active: bool = true;
        assert!(active, 3);

        // Addresses work as identifiers
        let contract: address = @0x1;
        let user: address = @0x2;
        assert!(contract != user, 4);
    }

    // Destructuring Test
    #[test]
    fun test_tuple_destructuring() {
        let spell_data = (100u8, true, @0xFEED);
        let (power, active, caster) = spell_data;

        assert!(power == 100, 1);
        assert!(active == true, 2);
        assert!(caster == @0xFEED, 3);
    }
}
```

### Running the Tests

To validate your solutions:

```bash
# In your Move project directory
move test

# Or for verbose output
move test -- --verbose
```

**What to look for:**

- ✅ All tests pass (green checkmarks)
- ❌ If a test fails, read the error—it tells you exactly what's wrong
- 📊 Test output shows which assertions passed

---

## 🌟 Closing Story

Odessa completes her final spell. Master Cipher reviews her work:

> "Three spells, three lessons," Cipher nods approvingly. "You've learned that Move doesn't restrict you—it _protects_ you. Every type you declare, every `mut` keyword you write, every tuple you pack—these aren't limitations. They're guardrails on a mountain road."

> "In other lands, developers spend weeks hunting bugs that Move would catch in seconds. Your tests pass, not because you got lucky, but because the compiler _forced_ you to think clearly."

Odessa holds the glowing crystal again. It feels different now—powerful, purposeful.

> "Tomorrow, we venture deeper," Cipher says, gesturing toward a door etched with strange symbols. "You'll learn about **Functions and Scopes**—how to build larger spells. But the foundation you've built today? That's your real power."

> "Now rest. You've earned it."

---

**Next Lesson Preview:** 🔮 _Functions & Scopes: Building Larger Spells_

- Learn to write reusable functions
- Understand scope and variable lifetime
- Master parameters and return values
- Build your first library spell

_Are you ready to continue, young caster?_
