## Scene

Morning sunlight streams through the floor-to-ceiling windows of MoveStack's conference room. Det stands at the whiteboard, markers in hand, while Neri and Jaymart settle into their seats with fresh coffee.

"Functions are the workhorses of Move," Det begins, drawing a simple diagram. "But they're not wild beasts like in some languages. Move functions are predictable, composable, and mathematically precise."

Jaymart raises his hand. "I've written functions in JavaScript before. What makes Move different?"

Neri chimes in. "In JS, a function can modify global state, throw random errors, behave differently each call. Move functions are like gears in a clock—call them the same way, get the same result."

Det nods approvingly. "Every transaction on the blockchain is a function call. If that function is unpredictable, the entire chain becomes unstable. That's why Move is strict about function signatures, visibility, and ownership."

He writes on the whiteboard: **public**, **fun**, **entry**, **parameters**, **return types**.

"Today we build MoveStack's calculator service," Det continues. "Public functions for external calls, private helpers for internal logic, entry points for user transactions. By the end, you'll understand why visibility layers matter and how to structure functions that can be called a million times and produce the same result every time."

Jaymart opens his IDE, eager to start. "Let's do this."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Function Signatures: The Blueprint**

A function signature tells us everything we need to know before we call it:

```move
public fun transfer_energy(
    from: &mut u64,     // Mutable reference to sender's energy
    to: &mut u64,       // Mutable reference to receiver's energy
    amount: u64         // Immutable amount to transfer
): bool {
    // Implementation
    true
}
```

**Breaking it down:**

- `public`: Visibility (who can call this?)
- `fun`: Keyword declaring a function
- `transfer_energy`: Function name
- `(from: &mut u64, to: &mut u64, amount: u64)`: Parameters with types
- `: bool`: Return type

**Key insights:**

- Parameters tell you what ownership the function needs
- `&mut` means "I will modify this"
- `&` means "I will read this"
- No `&` means "I will consume this (take ownership)"
- Return type tells you what value the function produces

### 2️⃣ **Parameters and Ownership**

Every parameter is a contract between caller and function:

**Pass by value (take ownership):**

```move
public fun consume_spell(spell: String) {
    // Function owns the spell
    // Spell is destroyed when function ends
}

let my_spell = utf8(b"Lightning");
consume_spell(my_spell);  // Ownership transfers
// my_spell is no longer valid
```

**Pass by immutable reference (borrow for reading):**

```move
public fun read_spell(spell: &String) {
    // Function can read spell but not modify it
    // Caller keeps ownership
}

let my_spell = utf8(b"Lightning");
read_spell(&my_spell);     // Borrow for reading
read_spell(&my_spell);     // Can borrow again!
// my_spell is still valid and unchanged
```

**Pass by mutable reference (borrow for modification):**

```move
public fun power_up_spell(spell: &mut String) {
    // Function can modify spell
    // Caller keeps ownership
}

let mut my_spell = utf8(b"Lightning");
power_up_spell(&mut my_spell);  // Borrow for modification
// my_spell is modified but still owned by us
```

### 3️⃣ **Return Values and Multiple Returns**

Functions produce outputs. Move makes this powerful:

**Single return:**

```move
public fun cast_and_consume(spell: String): bool {
    // Do something with spell
    true  // Return the result (no semicolon = return value)
}
```

**Multiple returns (using tuples):**

```move
public fun analyze_spell(spell: &String): (u64, bool, address) {
    let power = 100u64;
    let is_active = true;
    let caster = @0x1;
    (power, is_active, caster)  // Return tuple
}

// Caller unpacks the tuple:
let (p, active, c) = analyze_spell(&my_spell);
```

**No return (return unit `()`):**

```move
public fun print_info(spell: &String) {
    // Do something but return nothing
    // Implicitly returns ()
}
```

### 4️⃣ **Pure vs Impure Functions**

Move distinguishes between functions based on their side effects:

**Pure Functions** (no side effects, referentially transparent):

```move
public fun add(a: u64, b: u64): u64 {
    a + b  // Always returns same result for same inputs
}
```

**Impure Functions** (have side effects, modify state):

```move
public fun cast_spell_on_target(
    caster: &mut Caster,      // Modifies caster's state
    target: &mut Target       // Modifies target's state
) {
    caster.energy = caster.energy - 10;
    target.health = target.health - 50;
}
```

**Why does this matter?**

- Pure functions are easier to test (no setup needed)
- Pure functions are easier to reason about (same input = same output)
- Impure functions are necessary but should be minimized
- Pure functions can be reordered and cached safely

### 5️⃣ **Visibility: Controlling Access**

Move has three visibility levels:

**`public`**: Anyone can call this function

```move
public fun public_spell() {
    // Can be called from anywhere
    // Including other modules, other chains
}
```

**`public(friend)`**: Only friend modules can call this

```move
public(friend) fun friend_only_spell() {
    // Can be called by modules listed in friends
    // Useful for internal APIs
}
```

**`private`** (no modifier): Only this module can call

```move
fun private_helper() {
    // Only visible within this module
    // Cannot be called from outside
}
```

**Example structure:**

```move
module my_module::spells {
    // Private helper (only internal use)
    fun validate_spell_data(data: &SpellData): bool {
        // Validation logic
        true
    }

    // Public API (anyone can use)
    public fun cast_spell(data: SpellData): bool {
        if (validate_spell_data(&data)) {
            // Cast it
            true
        } else {
            false
        }
    }
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Function Signatures & Parameters 🔱

**Scenario:** Create a spell transfer system. Odessa needs functions to transfer energy between casters.

**Boilerplate Code:**

```move
module spell_library::energy_transfer {

    // TODO: Write a function signature that:
    // - Takes a mutable reference to sender's energy (u64)
    // - Takes a mutable reference to receiver's energy (u64)
    // - Takes an immutable amount (u64)
    // - Returns whether transfer was successful (bool)
    public fun transfer_energy(____) {
        // Validation: sender must have enough energy
        if (sender_energy >= amount) {
            *sender_energy = *sender_energy - amount;
            *receiver_energy = *receiver_energy + amount;
            true
        } else {
            false
        }
    }

    public fun test_transfer() {
        let mut alice_energy = 100u64;
        let mut bob_energy = 50u64;

        // TODO: Call transfer_energy to transfer 20 energy from alice to bob
        let success = transfer_energy(____);

        assert!(success == true, 1);
        assert!(alice_energy == 80, 2);  // Alice has 80 left
        assert!(bob_energy == 70, 3);     // Bob has 70 now
    }
}
```

**Your Task:**

1. Complete the function signature with correct parameter types and names
2. Call the function with the correct borrowing syntax
3. Verify the assertions pass

---

### Exercise 2: Multiple Returns & Tuple Unpacking 📊

**Scenario:** Analyze a spell's properties and return multiple values.

**Boilerplate Code:**

```move
module spell_library::spell_analysis {

    public fun analyze_spell(power: u64) ____ {
        // TODO: Calculate three values:
        // 1. danger_level (u8): power / 10 (0-255 scale)
        // 2. is_dangerous (bool): power > 50
        // 3. cost (u64): power * 2

        let danger_level = (power / 10) as u8;
        let is_dangerous = power > 50;
        let cost = power * 2;

        ____  // TODO: Return all three values
    }

    public fun test_analyze() {
        let spell_power = 75u64;

        // TODO: Call analyze_spell and unpack the three return values
        let ____ = analyze_spell(spell_power);

        // TODO: Assert the values are correct
        // danger_level should be 7
        // is_dangerous should be true
        // cost should be 150
        assert!(danger_level == 7, 1);
        assert!(is_dangerous == true, 2);
        assert!(cost == 150, 3);
    }
}
```

**Your Task:**

1. Add return type annotation showing three returned values
2. Return the three values as a tuple
3. Unpack the tuple in the test function
4. Verify all assertions pass

---

### Exercise 3: Visibility and Pure Functions 🔮

**Scenario:** Build a spell library with public API and hidden helpers.

**Boilerplate Code:**

```move
module spell_library::spell_registry {

    // TODO: Create a PRIVATE helper function that validates spell names
    // Name: validate_name
    // Parameter: name (u64 - length)
    // Returns: bool (true if 1-50 characters)
    ____ fun validate_name(name_length: u64): bool {
        name_length > 0 && name_length <= 50
    }

    // TODO: Create a PUBLIC function that registers a spell
    // Name: register_spell
    // Parameter: name_length (u64)
    // Returns: bool (success status)
    ____ fun register_spell(name_length: u64): bool {
        if (validate_name(name_length)) {
            // Registration logic
            true
        } else {
            false
        }
    }

    public fun test_registration() {
        // This should succeed (valid name length)
        let result1 = register_spell(10);
        assert!(result1 == true, 1);

        // This should fail (name too long)
        let result2 = register_spell(100);
        assert!(result2 == false, 2);

        // This should fail (name too short)
        let result3 = register_spell(0);
        assert!(result3 == false, 3);
    }
}
```

**Your Task:**

1. Add `fun` or `public fun` to `validate_name` (it should be private)
2. Add `public fun` to `register_spell` (it should be public)
3. Verify that the test correctly validates spell registration

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::energy_transfer {

    public fun transfer_energy(
        sender_energy: &mut u64,
        receiver_energy: &mut u64,
        amount: u64
    ): bool {
        // Validation: sender must have enough energy
        if (sender_energy >= amount) {
            *sender_energy = *sender_energy - amount;
            *receiver_energy = *receiver_energy + amount;
            true
        } else {
            false
        }
    }

    public fun test_transfer() {
        let mut alice_energy = 100u64;
        let mut bob_energy = 50u64;

        // Transfer 20 energy from alice to bob
        let success = transfer_energy(&mut alice_energy, &mut bob_energy, 20);

        assert!(success == true, 1);
        assert!(alice_energy == 80, 2);  // Alice has 80 left
        assert!(bob_energy == 70, 3);     // Bob has 70 now
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::spell_analysis {

    public fun analyze_spell(power: u64): (u8, bool, u64) {
        // Calculate three values:
        let danger_level = (power / 10) as u8;
        let is_dangerous = power > 50;
        let cost = power * 2;

        (danger_level, is_dangerous, cost)
    }

    public fun test_analyze() {
        let spell_power = 75u64;

        // Call analyze_spell and unpack the three return values
        let (danger_level, is_dangerous, cost) = analyze_spell(spell_power);

        // Assert the values are correct
        assert!(danger_level == 7, 1);
        assert!(is_dangerous == true, 2);
        assert!(cost == 150, 3);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::spell_registry {

    // Private helper function
    fun validate_name(name_length: u64): bool {
        name_length > 0 && name_length <= 50
    }

    // Public registration function
    public fun register_spell(name_length: u64): bool {
        if (validate_name(name_length)) {
            // Registration logic
            true
        } else {
            false
        }
    }

    public fun test_registration() {
        // This should succeed (valid name length)
        let result1 = register_spell(10);
        assert!(result1 == true, 1);

        // This should fail (name too long)
        let result2 = register_spell(100);
        assert!(result2 == false, 2);

        // This should fail (name too short)
        let result3 = register_spell(0);
        assert!(result3 == false, 3);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Parameters and Mutable References

**Why `&mut` for sender and receiver?**

- Both must be modified (decrease/increase)
- `&mut` allows modification while keeping caller's ownership
- Caller can see the changes afterward

**Why immutable `amount`?**

- Amount is just information—doesn't need to be modified
- Pass by value is fine (it's just a u64)
- Actually, we could also use `&u64`, but `amount` is small enough to copy

**The assertion chain:**

- Success validates the transfer happened
- `alice_energy == 80` confirms sender was deducted
- `bob_energy == 70` confirms receiver was credited

### Exercise 2 Explanation: Multiple Returns

**Why tuple return `(u8, bool, u64)`?**

- Move allows returning multiple values as a tuple
- Caller can unpack them into separate variables
- Type-safe: each value has explicit type

**The casting `as u8`:**

- `power / 10` produces a u64
- We need a u8 (smaller type)
- `as` explicitly converts (safe because 0-255 range)

**Unpacking in the test:**

```move
let (danger_level, is_dangerous, cost) = analyze_spell(spell_power);
```

- This destructures the tuple
- Each variable gets one element
- Must match the order and types from the function

### Exercise 3 Explanation: Visibility

**Why `validate_name` is private:**

- It's a helper—internal validation logic
- Callers shouldn't depend on this detail
- Implementation can change without breaking external API

**Why `register_spell` is public:**

- It's the main API users call
- Exposes the intended interface
- Hides complexity of validation

**The test validates all edge cases:**

- Valid name (10 chars): passes
- Too long (100 chars): fails
- Too short (0 chars): fails

This ensures the validation works for all scenarios.

---

## 🧪 Unit Tests

Here's a comprehensive test file:

```move
#[test_only]
module spell_library::function_tests {
    use spell_library::energy_transfer;
    use spell_library::spell_analysis;
    use spell_library::spell_registry;

    #[test]
    fun test_energy_transfer_success() {
        energy_transfer::test_transfer();
    }

    #[test]
    fun test_energy_transfer_insufficient() {
        let mut alice = 10u64;
        let mut bob = 100u64;

        let success = energy_transfer::transfer_energy(&mut alice, &mut bob, 20);
        assert!(success == false, 1);  // Transfer failed
        assert!(alice == 10, 2);       // Alice unchanged
        assert!(bob == 100, 3);        // Bob unchanged
    }

    #[test]
    fun test_spell_analysis() {
        spell_analysis::test_analyze();
    }

    #[test]
    fun test_spell_analysis_low_power() {
        let (danger, is_dangerous, cost) = spell_analysis::analyze_spell(30);
        assert!(danger == 3, 1);
        assert!(is_dangerous == false, 2);
        assert!(cost == 60, 3);
    }

    #[test]
    fun test_spell_registration() {
        spell_registry::test_registration();
    }

    #[test]
    fun test_boundary_cases() {
        // Edge case: minimum valid length
        let result1 = spell_registry::register_spell(1);
        assert!(result1 == true, 1);

        // Edge case: maximum valid length
        let result2 = spell_registry::register_spell(50);
        assert!(result2 == true, 2);

        // Edge case: just over maximum
        let result3 = spell_registry::register_spell(51);
        assert!(result3 == false, 3);
    }

    #[test]
    fun test_pure_function_consistency() {
        // Pure functions always return same result for same input
        let result1 = spell_analysis::analyze_spell(100);
        let result2 = spell_analysis::analyze_spell(100);

        assert!(result1 == result2, 1);  // Identical!
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

Kai watches as Odessa completes her final function. "Look at this," Kai says, studying her code. "You've written three functions, and each one is like a perfectly cut gemstone. Each has a clear purpose. Each knows exactly what it owns and what it borrows. Each is predictable."

> "This is the difference between programming in most languages and programming in Move. In other lands, functions are murky—side effects hiding everywhere, state corruption possible. Here, each function is transparent. Its intent is written in its signature."

Odessa smiles, seeing her code in a new light.

> "Tomorrow, we tackle the ultimate challenge: complex data structures. You'll learn to compose types, to build things within things, to create data hierarchies. Your spells will gain sophistication—and so will your power."

> "But remember: every function you write from this day forward is a promise. A promise that it does what its signature says, nothing more, nothing less. The compiler will hold you to that promise. And you'll be stronger for it."

---

**Next Lesson Preview:** 🏰 _Data Modelling: Building Complex Spells_

- Master struct declarations and fields
- Learn data composition
- Understand phantom types
- Build nested data structures
- Create efficient spell registries and databases

_The architecture of data awaits. Are you ready to build?_
