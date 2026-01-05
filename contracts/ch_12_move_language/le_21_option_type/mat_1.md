# Option Type in Move

## Opening Scene

Joas was pacing around the barangay tech hub, his notebook filled with scribbled diagrams and crossed-out solutions. He slumped into a chair next to Neri, who was reviewing some module documentation.

"Ate Neri, I'm stuck," Joas admitted, frustration evident in his voice. "I'm building a beneficiary lookup system, but what do I return when someone searches for a record that doesn't exist?"

Neri looked up from her screen. "What are you returning now?"

"Zero," Joas replied sheepishly. "But that's a problem because zero could be a valid ID. I tried returning a special 'not found' number like 999999, but that feels hacky."

Neri smiled knowingly. "You've stumbled onto one of programming's classic problems—representing the absence of a value. Move has an elegant solution for this: the Option type."

Joas leaned in, intrigued. "Tell me more."

---

## Topics

### Understanding Option

"Option is a type that represents a value that might or might not exist," Neri began. "It has two variants: `Some` when a value is present, and `None` when it's absent."

```move
module registry::lookup {
    use std::option::{Self, Option};

    struct Beneficiary has copy, drop {
        id: u64,
        name: vector<u8>,
    }

    public fun find_by_id(
        records: &vector<Beneficiary>,
        target_id: u64
    ): Option<u64> {
        let i = 0;
        let len = vector::length(records);

        while (i < len) {
            let record = vector::borrow(records, i);
            if (record.id == target_id) {
                return option::some(i)  // Found: return Some with the index
            };
            i = i + 1;
        };

        option::none()  // Not found: return None
    }
}
```

Joas studied the code carefully. "So instead of returning a magic number, we return `None` to explicitly say 'nothing was found'?"

"Exactly," Neri confirmed. "The caller knows to check for `None` before trying to use the value. No more guessing if zero means 'not found' or 'found at index zero'."

### Creating Options

"Let's look at the different ways to create Option values," Neri continued.

```move
module option_demo::creation {
    use std::option::{Self, Option};

    public fun create_some_value(): Option<u64> {
        option::some(42)  // Contains the value 42
    }

    public fun create_empty(): Option<u64> {
        option::none()  // Contains no value
    }

    public fun conditional_value(condition: bool): Option<u64> {
        if (condition) {
            option::some(100)
        } else {
            option::none()
        }
    }
}
```

### Checking and Extracting Values

"Before using an Option's value, you need to check if it contains something," Neri explained.

```move
module option_demo::extraction {
    use std::option::{Self, Option};

    public fun is_present(opt: &Option<u64>): bool {
        option::is_some(opt)  // Returns true if contains a value
    }

    public fun is_absent(opt: &Option<u64>): bool {
        option::is_none(opt)  // Returns true if empty
    }

    public fun safe_extract(opt: Option<u64>): u64 {
        if (option::is_some(&opt)) {
            option::extract(&mut opt)  // Extract and return the value
        } else {
            0  // Default value when empty
        }
    }

    public fun extract_or_default(opt: Option<u64>, default: u64): u64 {
        if (option::is_some(&opt)) {
            option::extract(&mut opt)
        } else {
            default
        }
    }
}
```

Joas nodded. "So we always check with `is_some` or `is_none` before extracting?"

"Right! Trying to extract from a `None` will abort the transaction," Neri warned.

### Option Utilities

"The standard library provides several helpful utilities for working with Options," Neri continued.

```move
module beneficiary::processor {
    use std::option::{Self, Option};

    public fun get_or_abort(opt: Option<u64>): u64 {
        // Extracts value or aborts if None
        option::extract(&mut opt)
    }

    public fun get_with_default(opt: Option<u64>, default: u64): u64 {
        // Returns contained value or the default
        option::get_with_default(&opt, default)
    }

    public fun destroy_or_get_default(opt: Option<u64>, default: u64): u64 {
        // Destroys the option and returns value or default
        option::destroy_with_default(opt, default)
    }

    public fun swap_value(opt: &mut Option<u64>, new_value: u64): Option<u64> {
        // Swaps the contained value, returns old value
        option::swap(opt, new_value)
    }

    public fun fill_if_empty(opt: &mut Option<u64>, value: u64) {
        // Only fills if currently None
        if (option::is_none(opt)) {
            option::fill(opt, value);
        };
    }
}
```

### Pattern Matching with Option

"One of the most elegant ways to handle Options is with pattern matching," Neri showed.

```move
module relief::claim_processor {
    use std::option::{Self, Option};

    const E_NOT_FOUND: u64 = 1;
    const E_ALREADY_CLAIMED: u64 = 2;

    struct ClaimRecord has copy, drop {
        beneficiary_id: u64,
        amount: u64,
        claimed: bool,
    }

    public fun find_claim(
        records: &vector<ClaimRecord>,
        beneficiary_id: u64
    ): Option<ClaimRecord> {
        let i = 0;
        let len = vector::length(records);

        while (i < len) {
            let record = *vector::borrow(records, i);
            if (record.beneficiary_id == beneficiary_id) {
                return option::some(record)
            };
            i = i + 1;
        };

        option::none()
    }

    public fun process_claim(
        records: &vector<ClaimRecord>,
        beneficiary_id: u64
    ): u64 {
        let maybe_claim = find_claim(records, beneficiary_id);

        // Check if we found a claim
        if (option::is_none(&maybe_claim)) {
            abort E_NOT_FOUND
        };

        let claim = option::extract(&mut maybe_claim);

        // Check claim status
        if (claim.claimed) {
            abort E_ALREADY_CLAIMED
        };

        claim.amount
    }
}
```

### Real-World Option Patterns

"Let me show you some common patterns you'll use in real applications," Neri said.

```move
module barangay::registry {
    use std::option::{Self, Option};

    struct Resident has copy, drop, store {
        id: u64,
        age: u64,
        is_senior: bool,
    }

    // Find the first senior citizen in a list
    public fun find_first_senior(
        residents: &vector<Resident>
    ): Option<Resident> {
        let i = 0;
        let len = vector::length(residents);

        while (i < len) {
            let resident = *vector::borrow(residents, i);
            if (resident.is_senior) {
                return option::some(resident)
            };
            i = i + 1;
        };

        option::none()
    }

    // Get maximum age, returns None if list is empty
    public fun find_max_age(residents: &vector<Resident>): Option<u64> {
        let len = vector::length(residents);

        if (len == 0) {
            return option::none()
        };

        let max = 0;
        let i = 0;

        while (i < len) {
            let resident = vector::borrow(residents, i);
            if (resident.age > max) {
                max = resident.age;
            };
            i = i + 1;
        };

        option::some(max)
    }

    // Safe lookup with fallback
    public fun get_resident_age_or_zero(
        residents: &vector<Resident>,
        target_id: u64
    ): u64 {
        let i = 0;
        let len = vector::length(residents);

        while (i < len) {
            let resident = vector::borrow(residents, i);
            if (resident.id == target_id) {
                return resident.age
            };
            i = i + 1;
        };

        0  // Default when not found
    }
}
```

---

## Closing Scene

Joas rewrote his lookup function, replacing the awkward magic numbers with clean Option returns. He tested various scenarios—finding existing records, searching for missing ones, handling edge cases.

"This is so much better," Joas said, admiring his refactored code. "The function signature now tells me exactly what to expect. 'Returns Option<Beneficiary>' makes it obvious the search might fail."

"That's the power of expressive types," Neri replied. "The type system itself documents your code's behavior. Anyone reading `Option<u64>` knows to handle the 'not found' case."

Joas saved his work and stretched. "No more wondering if zero is a real value or a sentinel. No more magic numbers."

"And the compiler helps you too," Neri added. "If you try to use an Option value without checking it first, Move's type system will catch the mistake."

"So Option makes my code safer and clearer at the same time," Joas concluded.

Neri nodded with satisfaction. "Now you're writing Move code that's honest about uncertainty. That's a sign of a thoughtful developer."

---

## Summary

### Option Basics

- `Option<T>` represents a value of type T that may or may not exist
- Use `option::some(value)` to create an Option containing a value
- Use `option::none()` to create an empty Option

### Checking Options

- `option::is_some(&opt)` returns true if the Option contains a value
- `option::is_none(&opt)` returns true if the Option is empty
- Always check before extracting to avoid aborting

### Extracting Values

- `option::extract(&mut opt)` removes and returns the value (aborts if None)
- `option::get_with_default(&opt, default)` returns value or default (keeps Option)
- `option::destroy_with_default(opt, default)` consumes Option, returns value or default

### Common Patterns

- Return `Option` from search functions instead of magic sentinel values
- Use `is_none` checks followed by `abort` for required values
- Provide `get_with_default` style wrappers for convenience

### Best Practices

- Prefer Option over sentinel values (like -1 or 0) for "not found" cases
- Use descriptive variable names like `maybe_record` or `opt_value`
- Handle the None case explicitly to make code intentions clear
- Import with `use std::option::{Self, Option}` for convenient access
