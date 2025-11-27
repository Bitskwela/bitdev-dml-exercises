## Background Story

Odessa stands at the edge of the Abyss—a vast chasm where errors are born. At the precipice stands a sentinel named Guardian Errax, her form crackling with warning energy.

"Every program ever written has encountered failure," Errax says, her eyes scanning the darkness below. "The difference between amateurs and professionals is simple: amateurs hope their code works. Professionals assume it will fail, and they write code that fails _gracefully_."

The guardian gestures, and the abyss reveals images—systems crashing unexpectedly, resources lost, invariants violated.

"In other languages, programs stumble into undefined behavior. Here, in Move, we have no choice but to make decisions. When a spell can't be cast, what happens? When a resource doesn't exist, what happens? When math overflows, what happens? These are not philosophical questions—they are architectural requirements."

Errax's eyes shine with determination.

"Abort codes are not error handling—they are contracts. They tell the blockchain: if I abort with code 42, it means the world is inconsistent. This transaction is reverted. Everything is undone. No partial states. No corrupted data. Perfect safety."

The guardian steps closer.

"Today, you'll learn the most critical lesson: how to write code that _never_ enters an invalid state. By day's end, you won't just handle errors—you'll eliminate them."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Abort: The Ultimate Safety Mechanism**

Abort is how Move handles fatal errors. When you abort, the entire transaction stops and reverts. Everything that happened gets undone. This is the ONLY way to handle truly unrecoverable errors in blockchain code.

**What is abort?**

Abort means "stop right now and undo everything." On a blockchain, this is critical. You can't have:

- Partial transaction execution (some state changed, some didn't)
- Undefined behavior
- Corrupted state

Abort guarantees atomicity: either the entire transaction succeeds, or nothing changes.

```move
public fun cast_spell(power: u64) {
    assert!(power > 0, 1);  // Code 1: power must be positive
    // If assertion fails, transaction aborts with code 1
    // Everything reverts as if this transaction never happened

    // Code continues only if assertion passes
    println!("Casting spell with power {}", power);
}

// Abort codes are just numbers (typically 0-65535)
public fun validate_spell(power: u64): u64 {
    if (power == 0) {
        abort(0);  // Explicit abort with code 0
    };

    if (power > 1000) {
        abort(1);  // Explicit abort with code 1
    };

    power
}
```

**Abort codes are your documentation:**

Every abort code should have meaning. Code 0 means something different than code 1. Use constants to document what each code means:

```move
const SPELL_POWER_ZERO: u64 = 0;
const SPELL_POWER_TOO_HIGH: u64 = 1;
const INSUFFICIENT_BALANCE: u64 = 10;
const RESOURCE_NOT_FOUND: u64 = 20;
```

**Abort is atomic—no partial state:**

This is the critical feature. Look at this bank transfer:

```move
struct Bank {
    balance: u64
}

public fun transfer(
    from: &mut Bank,
    to: &mut Bank,
    amount: u64
) {
    assert!(from.balance >= amount, 100);  // Validate before transfer

    from.balance = from.balance - amount;
    to.balance = to.balance + amount;

    // If anything after validation fails, entire transfer reverts
    // from.balance is restored to original
    // to.balance is restored to original
    // No partial state!
}
```

What if the transfer failed after deducting from sender? Without atomicity:

- Sender loses money
- Receiver never gets it
- Money vanishes!

With abort/atomicity:

- Either BOTH changes happen
- Or NEITHER happens
- Never a partial state

**Abort prevents invalid state transitions:**

```move
struct Vault {
    total: u64,
    locked: u64  // Must always satisfy: locked <= total
}

public fun lock_portion(vault: &mut Vault, amount: u64) {
    // ✅ Check invariant BEFORE modification
    assert!(vault.locked + amount <= vault.total, 200);

    vault.locked = vault.locked + amount;

    // ✅ Invariant maintained: locked <= total after this line
}

public fun unlock_all(vault: &mut Vault) {
    vault.locked = 0;
    // ✅ Invariant still maintained
}

// If someone tries:
public fun bad_operation(vault: &mut Vault) {
    vault.locked = vault.total + 1000;
    // ❌ This would break the invariant!
    // But your lock_portion function prevents it
}
```

### 2️⃣ **Assert! Macro: Common Patterns**

Assert is the primary validation tool. It checks a condition, and if false, aborts with a code.

**What does assert! do?**

`assert!(condition, error_code)` means:

- If `condition` is true: continue normally
- If `condition` is false: abort with `error_code`

```move
public fun assert_examples(value: u64, name: vector<u8>) {
    // Basic assert: value must be positive
    assert!(value > 0, 1);

    // Bounds check: value must be less than 1000
    assert!(value < 1000, 2);

    // Modulo check: value must be even
    assert!(value % 2 == 0, 3);

    // Complex conditions: multiple things must be true
    assert!(
        value > 100 && name.length > 0,
        4  // Code 4: combined condition failed
    );
}
```

**Pattern 1: Validate all inputs first**

Put all input validation at the START of functions. This way, if anything is wrong, you abort immediately without changing state.

```move
public fun safe_operation(a: u64, b: u64): u64 {
    // FIRST: Input validation
    assert!(a > 0, 10);    // Input a must be positive
    assert!(b > 0, 11);    // Input b must be positive

    // SECOND: Overflow check
    assert!(a + b > a, 12);  // If a+b <= a, we overflowed

    // THIRD: Now it's safe to proceed
    a + b
}
```

**Why validate all inputs first?**

1. **Atomicity**: If validation fails, no state changed yet
2. **Clarity**: Reader knows exactly what the function requires
3. **Safety**: Prevents partial execution

**Pattern 2: Check preconditions on data**

Before using data, verify it's in a valid state:

```move
public fun remove_from_list(list: &mut vector<u64>, index: u64) {
    assert!(index < vector::length(list), 50);  // Bounds check

    let len = vector::length(list);
    vector::swap(list, index, len - 1);
    vector::pop_back(list);
}
```

**Pattern 3: Document abort codes**

Use named constants instead of magic numbers:

```move
module spell_library::error_codes {
    // Input validation errors (100-199)
    const INVALID_POWER: u64 = 101;
    const INVALID_NAME: u64 = 102;
    const OUT_OF_BOUNDS: u64 = 103;

    // State violations (200-299)
    const INSUFFICIENT_BALANCE: u64 = 201;
    const ALREADY_EXISTS: u64 = 202;
    const NOT_FOUND: u64 = 203;

    // Math errors (300-399)
    const OVERFLOW: u64 = 301;
    const UNDERFLOW: u64 = 302;
    const DIVISION_BY_ZERO: u64 = 303;

    public fun validate_spell(power: u64) {
        assert!(power > 0, INVALID_POWER);
        assert!(power < 10000, INVALID_POWER);
    }

    public fun withdraw(balance: &mut u64, amount: u64) {
        assert!(*balance >= amount, INSUFFICIENT_BALANCE);
        *balance = *balance - amount;
    }
}
```

### 3️⃣ **Common Error Patterns and Recovery**

Not all errors require abort. Sometimes you can recover gracefully.

**Pattern 1: Optional return instead of assert**

For non-critical errors, return an Option:

```move
use std::option::{self, Option};

public fun safe_divide(a: u64, b: u64): Option<u64> {
    if (b == 0) {
        option::none()  // Can't divide, return None
    } else {
        option::some(a / b)
    }
}

public fun use_optional() {
    let result = safe_divide(100, 0);

    if (option::is_none(&result)) {
        // Handle division by zero gracefully
        println!("Division failed");
        // Don't abort, just handle it
    } else {
        let value = option::unwrap(result);
        println!("Result: {}", value);
    };
}
```

**When to use Option:**

- When failure is expected/normal
- When you want to give caller a choice
- For recoverable errors

**When to abort:**

- When failure violates invariants
- When continuing would corrupt state
- For unrecoverable errors

**Pattern 2: Validate before consuming resources**

NEVER consume a resource and then validate:

```move
// ❌ WRONG: Consumes spells before validating
public fun cast_spell_bad(
    spells: &mut vector<Spell>,
    index: u64
): bool {
    let spell = vector::pop_back(spells);  // Oops!

    // Now validate—but it's too late!
    assert!(spell.power > 50, 1);  // If this fails, spell is lost!

    true
}

// ✅ CORRECT: Validate before consuming
public fun cast_spell_good(
    spells: &mut vector<Spell>,
    index: u64
): bool {
    // BEFORE consuming anything
    assert!(index < vector::length(spells), 100);

    // NOW consume
    let spell = vector::pop_back(spells);
    assert!(spell.power > 50, 101);

    true
}
```

**Pattern 3: Transaction-like semantics**

Group related operations so they either all succeed or all fail:

```move
public fun multi_step_operation(a: &mut u64, b: &mut u64) {
    // Step 1: Validate all preconditions
    assert!(*a > 0, 10);
    assert!(*b > 0, 11);
    assert!(*a > *b, 12);

    // Step 2: Perform all modifications
    *a = *a + 1;
    *b = *b - 1;

    // Result: Either both changed, or neither changed (abort reverted both)
}
```

**Pattern 4: Explicit error categorization**

Group related errors:

```move
public fun process_batch(items: &vector<u64>) {
    let mut i = 0;
    while (i < vector::length(items)) {
        let item = *vector::borrow(items, i);

        // Category 1: Invalid data
        if (item == 0) {
            abort(1000);  // Zero item not allowed
        };

        // Category 2: Overflow/underflow
        if (item > 1000000) {
            abort(1001);  // Item too large
        };

        i = i + 1;
    };
}
```

### 4️⃣ **Defensive Programming Strategies**

The best error is the one that never happens. Defensive programming prevents errors.

**Strategy 1: Invariant checks**

Define what must always be true:

```move
struct Account {
    balance: u64,
    holds: u64  // Amount held (should always be <= balance)
}

public fun check_invariants(account: &Account) {
    assert!(account.holds <= account.balance, 200);
}

// Always check invariants before returning
public fun withdraw(account: &mut Account, amount: u64) {
    assert!(amount <= account.balance - account.holds, 201);
    account.balance = account.balance - amount;
    check_invariants(account);  // Verify invariant still holds
}
```

**Strategy 2: Bounds checking everywhere**

Never assume index is valid:

```move
public fun safe_access(vec: &vector<u64>, index: u64): u64 {
    assert!(index < vector::length(vec), 300);
    *vector::borrow(vec, index)
}
```

**Strategy 3: Explicit type safety**

Create types that can't be invalid:

```move
struct SpellPower {
    value: u64  // Should always be 0-100
}

// Only way to create SpellPower is through this function
public fun create_spell_power(value: u64): SpellPower {
    assert!(value <= 100, 400);
    SpellPower { value }
}

// Now any function taking SpellPower knows it's valid
public fun use_spell(spell: SpellPower): u64 {
    // No need to validate again—SpellPower can't be invalid
    spell.value
}
```

**Strategy 4: Resource-based guarantees**

Use types to encode guarantees:

```move
struct ValidatedSpell {
    power: u64  // Guaranteed valid after construction
}

public fun validate_spell_create(power: u64): ValidatedSpell {
    assert!(power > 0 && power <= 100, 400);
    ValidatedSpell { power }
}

// Safe to use without rechecking
public fun process_valid(spell: ValidatedSpell) {
    println!("Power: {}", spell.power);  // Already validated!
}
```

### 5️⃣ **Error Boundaries: Structure Your Code**

Well-structured code has clear error boundaries—places where validation happens.

**Pattern: Layered boundaries**

```move
module spell_library::error_boundaries {
    public fun spell_registry_add(
        registry: &mut vector<u64>,
        power: u64
    ) {
        // BOUNDARY 1: Public interface validates everything
        assert!(power > 0, 1);
        assert!(power <= 1000, 2);
        assert!(vector::length(registry) < 1000, 3);

        internal_add(registry, power);
        // After this returns, caller knows addition succeeded
    }

    fun internal_add(registry: &mut vector<u64>, power: u64) {
        // INTERNAL: Trusts that boundary already validated
        // No validation here—caller already did it
        vector::push_back(registry, power);
    }

    public fun complex_operation(a: u64, b: u64): u64 {
        // BOUNDARY 1: Input validation
        assert!(a > 0 && b > 0, 10);

        let result = internal_compute(a, b);

        // BOUNDARY 2: Output validation
        assert!(result > a && result > b, 11);

        result
    }

    fun internal_compute(a: u64, b: u64): u64 {
        a + b
    }
}
```

**Pattern: Explicit error categories**

Organize code by responsibility:

```move
public fun operation_with_fallback(
    primary: u64,
    fallback: u64
) {
    // Try primary first
    if (primary > 0 && primary < 1000) {
        return primary;
    };

    // Fall back to secondary
    if (fallback > 0 && fallback < 1000) {
        return fallback;
    };

    // Both invalid—must abort
    abort(99);
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Validation and Assert Patterns 🛡️

**Scenario:** Build a validated spell system that can never enter invalid states.

**Boilerplate Code:**

```move
module spell_library::validation {
    const INVALID_POWER: u64 = 101;
    const INVALID_NAME: u64 = 102;
    const OVERFLOW: u64 = 201;

    struct Spell {
        name: vector<u8>,
        power: u64
    }

    public fun create_spell(name: vector<u8>, power: u64): Spell {
        // TODO: Validate name is not empty
        assert!(name.length > 0, ____);

        // TODO: Validate power is between 1 and 100
        assert!(power > ____ && power <= ____, INVALID_POWER);

        Spell { name, power }
    }

    public fun upgrade_spell(spell: &mut Spell, boost: u64) {
        // TODO: Check overflow
        assert!(spell.power + boost <= ____, OVERFLOW);

        spell.power = spell.power + boost;
    }

    public fun rename_spell(spell: &mut Spell, new_name: vector<u8>) {
        // TODO: Validate new_name not empty
        assert!(new_name.length > ____, INVALID_NAME);

        spell.name = new_name;
    }

    public fun test_validation() {
        let spell = create_spell(b"Fireball", 50);
        assert!(spell.power == 50, 1);

        let mut spell2 = create_spell(b"Icebolt", 40);
        upgrade_spell(&mut spell2, 30);
        assert!(spell2.power == 70, 2);
    }
}
```

**Your Task:**

1. Add name validation (non-empty)
2. Add power bounds (1-100)
3. Add overflow checking
4. Fill in error codes
5. Ensure all invariants are maintained

---

### Exercise 2: Complex Error Handling 🔍

**Scenario:** Implement a spell inventory system with defensive programming.

**Boilerplate Code:**

```move
module spell_library::defensive_inventory {
    use std::vector;

    const BOUNDS_ERROR: u64 = 300;
    const INVALID_AMOUNT: u64 = 301;

    struct Inventory {
        spells: vector<u64>,
        max_size: u64
    }

    public fun create_inventory(max: u64): Inventory {
        // TODO: Validate max > 0
        assert!(max > ____, INVALID_AMOUNT);

        Inventory {
            spells: vector::empty(),
            max_size: max
        }
    }

    public fun add_spell(inv: &mut Inventory, power: u64) {
        // TODO: Check length < max_size before adding
        assert!(vector::length(&inv.spells) < inv.max_size, ____);

        // TODO: Validate power before adding
        assert!(power > ____, INVALID_AMOUNT);

        vector::push_back(&mut inv.spells, power);
    }

    public fun remove_spell(inv: &mut Inventory, index: u64): u64 {
        // TODO: Bounds check
        assert!(index < vector::length(&inv.spells), ____);

        let len = vector::length(&inv.spells);
        vector::swap(&mut inv.spells, index, len - 1);
        vector::pop_back(&mut inv.spells)
    }

    public fun total_power(inv: &Inventory): u64 {
        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(&inv.spells)) {
            let power = *vector::borrow(&inv.spells, i);
            total = total + power;
            i = i + 1;
        };

        total
    }

    public fun test_defensive_inventory() {
        let mut inv = create_inventory(5);

        add_spell(&mut inv, 50);
        add_spell(&mut inv, 75);

        assert!(total_power(&inv) == 125, 1);

        let removed = remove_spell(&mut inv, 0);
        assert!(removed == 50, 2);
    }
}
```

**Your Task:**

1. Validate inventory max > 0
2. Check capacity before adding
3. Validate power values
4. Implement bounds checking
5. Ensure no invalid state possible

---

### Exercise 3: Error Boundaries and Recovery 🚧

**Scenario:** Build a multi-layered system with clear error boundaries.

**Boilerplate Code:**

```move
module spell_library::error_boundaries {
    use std::option::{self, Option};

    const INPUT_ERROR: u64 = 400;
    const STATE_ERROR: u64 = 401;

    struct BoundedValue {
        value: u64,
        min: u64,
        max: u64
    }

    // Public boundary: full validation
    public fun create_bounded(value: u64, min: u64, max: u64): BoundedValue {
        // TODO: Validate all preconditions
        assert!(min < ____, INPUT_ERROR);
        assert!(value >= min && value <= max, INPUT_ERROR);

        BoundedValue { value, min, max }
    }

    // Internal: trusts validation already done
    fun internal_update(bounded: &mut BoundedValue, new_val: u64) {
        bounded.value = new_val;
    }

    // Public update: re-validates at boundary
    public fun update_bounded(bounded: &mut BoundedValue, new_val: u64) {
        // TODO: Check bounds before internal update
        assert!(new_val >= bounded.min && new_val <= ____, STATE_ERROR);

        internal_update(bounded, new_val);
    }

    public fun safe_add(
        a: &BoundedValue,
        b: &BoundedValue
    ): Option<u64> {
        // TODO: Check for overflow before adding
        if (a.value > 1000000 - b.value) {
            return option::none();
        };

        let sum = a.value + b.value;
        option::some(sum)
    }

    public fun test_boundaries() {
        let bounded = create_bounded(50, 0, 100);
        assert!(bounded.value == 50, 1);

        let mut bounded2 = create_bounded(75, 0, 100);
        update_bounded(&mut bounded2, 80);
        assert!(bounded2.value == 80, 2);

        let result = safe_add(&bounded, &bounded2);
        assert!(option::is_some(&result), 3);
    }
}
```

**Your Task:**

1. Implement public boundary with full validation
2. Implement internal functions trusting validation
3. Add overflow detection
4. Create clear error boundaries
5. Provide fallback options where appropriate

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::validation {
    const INVALID_POWER: u64 = 101;
    const INVALID_NAME: u64 = 102;
    const OVERFLOW: u64 = 201;

    struct Spell {
        name: vector<u8>,
        power: u64
    }

    public fun create_spell(name: vector<u8>, power: u64): Spell {
        assert!(name.length > 0, INVALID_NAME);
        assert!(power > 0 && power <= 100, INVALID_POWER);

        Spell { name, power }
    }

    public fun upgrade_spell(spell: &mut Spell, boost: u64) {
        assert!(spell.power + boost <= 100, OVERFLOW);
        spell.power = spell.power + boost;
    }

    public fun rename_spell(spell: &mut Spell, new_name: vector<u8>) {
        assert!(new_name.length > 0, INVALID_NAME);
        spell.name = new_name;
    }

    public fun test_validation() {
        let spell = create_spell(b"Fireball", 50);
        assert!(spell.power == 50, 1);

        let mut spell2 = create_spell(b"Icebolt", 40);
        upgrade_spell(&mut spell2, 30);
        assert!(spell2.power == 70, 2);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::defensive_inventory {
    use std::vector;

    const BOUNDS_ERROR: u64 = 300;
    const INVALID_AMOUNT: u64 = 301;

    struct Inventory {
        spells: vector<u64>,
        max_size: u64
    }

    public fun create_inventory(max: u64): Inventory {
        assert!(max > 0, INVALID_AMOUNT);

        Inventory {
            spells: vector::empty(),
            max_size: max
        }
    }

    public fun add_spell(inv: &mut Inventory, power: u64) {
        assert!(vector::length(&inv.spells) < inv.max_size, BOUNDS_ERROR);
        assert!(power > 0, INVALID_AMOUNT);

        vector::push_back(&mut inv.spells, power);
    }

    public fun remove_spell(inv: &mut Inventory, index: u64): u64 {
        assert!(index < vector::length(&inv.spells), BOUNDS_ERROR);

        let len = vector::length(&inv.spells);
        vector::swap(&mut inv.spells, index, len - 1);
        vector::pop_back(&mut inv.spells)
    }

    public fun total_power(inv: &Inventory): u64 {
        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(&inv.spells)) {
            let power = *vector::borrow(&inv.spells, i);
            total = total + power;
            i = i + 1;
        };

        total
    }

    public fun test_defensive_inventory() {
        let mut inv = create_inventory(5);

        add_spell(&mut inv, 50);
        add_spell(&mut inv, 75);

        assert!(total_power(&inv) == 125, 1);

        let removed = remove_spell(&mut inv, 0);
        assert!(removed == 50, 2);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::error_boundaries {
    use std::option::{self, Option};

    const INPUT_ERROR: u64 = 400;
    const STATE_ERROR: u64 = 401;

    struct BoundedValue {
        value: u64,
        min: u64,
        max: u64
    }

    public fun create_bounded(value: u64, min: u64, max: u64): BoundedValue {
        assert!(min < max, INPUT_ERROR);
        assert!(value >= min && value <= max, INPUT_ERROR);

        BoundedValue { value, min, max }
    }

    fun internal_update(bounded: &mut BoundedValue, new_val: u64) {
        bounded.value = new_val;
    }

    public fun update_bounded(bounded: &mut BoundedValue, new_val: u64) {
        assert!(new_val >= bounded.min && new_val <= bounded.max, STATE_ERROR);
        internal_update(bounded, new_val);
    }

    public fun safe_add(
        a: &BoundedValue,
        b: &BoundedValue
    ): Option<u64> {
        if (a.value > 1000000 - b.value) {
            return option::none();
        };

        let sum = a.value + b.value;
        option::some(sum)
    }

    public fun test_boundaries() {
        let bounded = create_bounded(50, 0, 100);
        assert!(bounded.value == 50, 1);

        let mut bounded2 = create_bounded(75, 0, 100);
        update_bounded(&mut bounded2, 80);
        assert!(bounded2.value == 80, 2);

        let result = safe_add(&bounded, &bounded2);
        assert!(option::is_some(&result), 3);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Validation

**Invariants prevented at creation:**

```move
assert!(power > 0 && power <= 100, error_code);
// Spell can NEVER be created with invalid power
// Once created, it's guaranteed valid
```

**Update guards invariants:**

```move
assert!(spell.power + boost <= 100, OVERFLOW);
// Can't upgrade to invalid state
// Invariant is maintained
```

### Exercise 2 Explanation: Defensive Programming

**Precondition checks before state modification:**

```move
assert!(capacity_check, error);  // Validate FIRST
vector::push_back(...);           // Then modify
// If check fails, nothing changes
```

**All errors have explicit codes:**

- 300: Bounds violations
- 301: Invalid values
- 302: Insufficient state

### Exercise 3 Explanation: Boundaries

**Public functions validate everything:**

```move
public fun create_bounded(...) {
    assert!(...);  // Full validation
}
```

**Internal functions trust callers:**

```move
fun internal_update(...) {
    // No validation—boundary already validated
}
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::error_handling_tests {
    use spell_library::validation;
    use spell_library::defensive_inventory;
    use spell_library::error_boundaries;
    use std::option;

    #[test]
    fun test_spell_validation() {
        validation::test_validation();
    }

    #[test]
    fun test_inventory_operations() {
        defensive_inventory::test_defensive_inventory();
    }

    #[test]
    fun test_error_boundaries() {
        error_boundaries::test_boundaries();
    }

    #[test]
    #[expected_failure]
    fun test_invalid_spell_power() {
        validation::create_spell(b"Bad", 0);  // Power 0 should fail
    }

    #[test]
    #[expected_failure]
    fun test_empty_spell_name() {
        validation::create_spell(b"", 50);  // Empty name should fail
    }

    #[test]
    #[expected_failure]
    fun test_overflow_protection() {
        let mut spell = validation::create_spell(b"Test", 100);
        validation::upgrade_spell(&mut spell, 1);  // Should overflow
    }

    #[test]
    #[expected_failure]
    fun test_capacity_exceeded() {
        let mut inv = defensive_inventory::create_inventory(1);
        defensive_inventory::add_spell(&mut inv, 50);
        defensive_inventory::add_spell(&mut inv, 50);  // Should exceed capacity
    }

    #[test]
    #[expected_failure]
    fun test_bounds_check_on_remove() {
        let mut inv = defensive_inventory::create_inventory(5);
        defensive_inventory::remove_spell(&mut inv, 0);  // Empty inventory
    }

    #[test]
    fun test_safe_add_handles_overflow() {
        let a = error_boundaries::create_bounded(1000000, 0, 1000000);
        let b = error_boundaries::create_bounded(1000000, 0, 1000000);

        let result = error_boundaries::safe_add(&a, &b);
        assert!(option::is_none(&result), 1);  // Overflow detected
    }

    #[test]
    fun test_error_recovery() {
        let a = error_boundaries::create_bounded(10, 0, 100);
        let b = error_boundaries::create_bounded(20, 0, 100);

        let result = error_boundaries::safe_add(&a, &b);
        assert!(option::is_some(&result), 1);  // No overflow
    }
}
```

---

## 🌟 Closing Story

Guardian Errax stands with Odessa at the edge of the Abyss, watching as it grows quiet. The errors that once plagued the realm have been systematized, documented, defended against.

> "You've reached mastery," Errax says, her warning energy now calm and purposeful. "You understand that errors are not exceptions—they are normal. Every program fails. The question is: does it fail gracefully, or does it leave the world corrupted?"

> "You write code that never enters invalid states. Your assertions are explicit. Your boundaries are clear. Your invariants are maintained. When something goes wrong, the entire transaction reverts—perfectly, completely, atomically."

The guardian gestures to the now-calm abyss.

> "In other languages, developers pray their code works. Here, you _know_ it will work, or it will fail cleanly. There is no middle ground. There is no undefined behavior. There is only certainty."

Errax's form begins to shimmer with approval.

> "You've journeyed from simple primitives through ownership, functions, data structures, resources, storage, references, control flow, collections, and now error handling. You understand Move deeply. You understand how to build systems that are not just functional, but provably correct and perfectly safe."

The entire realm suddenly crystallizes into perfect order—every contract secure, every transaction atomic, every invariant maintained.

> "But knowledge alone is not mastery. True mastery comes from building. Take these lessons and create something real. Build contracts that matter. Build systems that don't just work, but that change the world. The path is yours now."

The guardian bows slightly.

> "Go. Build. Trust your training. The blockchain awaits your creations."

---

**🎓 Epilogue: Your Move Journey Complete**

You have completed the foundational curriculum:

1. **Spell Books** (Primitives & Variables) - Understanding data
2. **Every Variable Matters** (Ownership) - Understanding control
3. **Functions Deep Dive** - Understanding behavior
4. **Data Modelling** (Structs) - Understanding organization
5. **Abilities in Move** - Understanding type safety
6. **Resource-Oriented Programming** - Understanding value
7. **Global Storage Model** - Understanding persistence
8. **References and Borrowing** - Understanding access
9. **Safe Control Flow** - Understanding branching
10. **Collections** - Understanding scale
11. **Error Handling and Aborts** - Understanding safety

**What's Next?**

- Build production contracts
- Explore advanced patterns (generics, upgradability, complex storage)
- Contribute to the Move ecosystem
- Help others learn

_You are no longer a student. You are a Move developer._

_The blockchain awaits your creations._
