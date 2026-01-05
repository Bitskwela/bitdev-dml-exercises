# Reference Safety Rules

## Scene: The Guardian at the Gate

Odessa's fingers paused over the keyboard as a red squiggle appeared beneath her code. She smiled—a rare sight that made Neri lean in curiously.

"What is it?" Neri asked.

"The borrow checker just saved someone from a nasty bug," Odessa replied, pointing at the screen. "Look at this pull request. They tried to create two mutable references to the same data."

```move
let mut data = Resource { value: 100 };
let ref1 = &mut data;
let ref2 = &mut data;  // ERROR: Cannot borrow as mutable more than once
```

Neri frowned. "But why is that a problem? Can't you just... change it twice?"

Odessa turned to face her fully. "Imagine two chefs in a kitchen, both reaching for the same pot at the exact same moment. One wants to add salt, the other wants to add pepper. Neither knows what the other is doing. What ends up in the pot?"

"Chaos," Neri answered.

"Exactly. In programming, we call this a data race. Two pieces of code modifying the same memory location leads to unpredictable results—bugs that only appear sometimes, under specific timing conditions. They're nightmares to debug."

"So the compiler prevents this from ever happening?"

"The borrow checker enforces strict rules," Odessa confirmed. "You can have one mutable reference OR multiple immutable references, but never both. This isn't a limitation—it's a guarantee. If your code compiles, you're protected from an entire category of bugs."

Neri studied the error message again. "So every borrow error is actually the compiler preventing a potential disaster?"

"Think of it as a security guard checking references at the door," Odessa said. "Strict, but thorough. Nothing dangerous gets through."

---

## Topics

### The Borrow Checker

Move's borrow checker enforces reference safety at compile time by tracking every reference:

```move
module movestack::borrow_checker {
    struct Account has drop {
        balance: u64
    }

    public fun demonstrate_rules() {
        let mut account = Account { balance: 100 };

        // Rule 1: Multiple immutable borrows are OK
        let ref1 = &account;
        let ref2 = &account;
        let _sum = ref1.balance + ref2.balance;  // ✅ Both valid
        // Immutable borrows end here (last use)

        // Rule 2: One mutable borrow at a time
        let mut_ref = &mut account;
        mut_ref.balance = 200;
        // Mutable borrow ends here (last use)

        // Rule 3: Sequential borrows are safe
        let _val = (&account).balance;   // Immutable borrow ends immediately
        let mut_ref2 = &mut account;     // Fresh mutable borrow
        mut_ref2.balance = 300;
    }

    // This would NOT compile:
    // fun invalid_borrows() {
    //     let mut data = Account { balance: 50 };
    //     let ref1 = &mut data;
    //     let ref2 = &mut data;  // ❌ ERROR: second mutable borrow
    //     ref1.balance = 100;    // ref1 still in scope
    //     ref2.balance = 200;
    // }
}
```

**The borrow checker rules**:

1. **Exclusive mutable access**: Only one `&mut` reference at a time
2. **Shared immutable access**: Multiple `&` references allowed simultaneously
3. **No mixing**: Cannot have `&mut` and `&` to the same data at the same time
4. **Scope-based**: Borrows are valid until their last use

### Why No Multiple `&mut` References

Preventing multiple mutable references eliminates data races at compile time:

```move
module movestack::no_multiple_mut {
    struct Counter has drop {
        value: u64
    }

    // ❌ INVALID: This pattern causes data races
    // fun data_race_example() {
    //     let mut counter = Counter { value: 0 };
    //     let ref1 = &mut counter;
    //     let ref2 = &mut counter;
    //
    //     // Which modification wins? Undefined behavior!
    //     ref1.value = 10;
    //     ref2.value = 20;
    // }

    // ✅ VALID: Sequential modifications
    public fun sequential_modifications() {
        let mut counter = Counter { value: 0 };

        // First borrow, modify, borrow ends
        {
            let ref1 = &mut counter;
            ref1.value = 10;
        } // ref1 goes out of scope

        // Second borrow starts fresh
        {
            let ref2 = &mut counter;
            ref2.value = 20;
        }

        assert!(counter.value == 20, 0);
    }

    // ✅ VALID: Non-overlapping borrows
    public fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    public fun call_twice() {
        let mut counter = Counter { value: 0 };

        increment(&mut counter);  // Borrow starts and ends
        increment(&mut counter);  // New borrow starts

        assert!(counter.value == 2, 0);
    }
}
```

**Why this matters**:

- Concurrent modification leads to race conditions
- Without exclusivity, one write could overwrite another
- Move catches these bugs before they ever run

### Aliasing Prevention

Aliasing occurs when multiple references point to the same data. Uncontrolled aliasing is dangerous:

```move
module movestack::aliasing_prevention {
    struct Data has drop {
        value: u64
    }

    // ❌ PROBLEM: Mixing mutable and immutable references
    // fun mixing_references() {
    //     let mut data = Data { value: 100 };
    //     let immut_ref = &data;
    //     let mut_ref = &mut data;  // ERROR: can't borrow mutably
    //
    //     // immut_ref expects value to be 100
    //     // but mut_ref could change it!
    //     mut_ref.value = 200;
    //     assert!(immut_ref.value == 100, 0);  // Would fail!
    // }

    // ✅ SOLUTION: Complete immutable use before mutating
    public fun sequential_access() {
        let mut data = Data { value: 100 };

        // Immutable borrow - read and finish
        let cached_value = (&data).value;
        // Immutable borrow ends (last use)

        // Now safe to mutate
        let mut_ref = &mut data;
        mut_ref.value = 200;

        // cached_value still holds the old value (a copy)
        assert!(cached_value == 100, 0);
        assert!(data.value == 200, 1);
    }

    // ✅ SOLUTION: Use functions to create clear borrow boundaries
    public fun read_value(data: &Data): u64 {
        data.value
    }

    public fun set_value(data: &mut Data, new_val: u64) {
        data.value = new_val;
    }

    public fun function_boundaries() {
        let mut data = Data { value: 50 };

        let val = read_value(&data);  // Borrow, use, end
        set_value(&mut data, 100);    // New borrow

        assert!(val == 50, 0);
        assert!(data.value == 100, 1);
    }
}
```

### Borrow Checker Rules in Practice

Common scenarios and how the borrow checker handles them:

```move
module movestack::borrow_rules_practice {
    struct Wallet has drop {
        balance: u64,
        frozen: bool
    }

    // Rule: References cannot outlive their source
    // ❌ This would be invalid (if allowed):
    // fun dangling_reference(): &Wallet {
    //     let wallet = Wallet { balance: 100, frozen: false };
    //     &wallet  // ERROR: wallet is dropped, reference dangles
    // }

    // ✅ Return values, not references to locals
    public fun create_and_return(): Wallet {
        Wallet { balance: 100, frozen: false }
    }

    // Rule: Can't use reference after source is moved
    public fun no_use_after_move() {
        let wallet = Wallet { balance: 100, frozen: false };
        let _ref = &wallet;
        // If wallet moved here, _ref would be invalid
        // Compiler prevents this
    }

    // Rule: Nested borrows respect parent lifetime
    public fun nested_field_borrow(wallet: &Wallet): u64 {
        let balance_ref = &wallet.balance;  // Borrow field
        *balance_ref  // Valid while wallet reference lives
    }

    // Rule: Mutable borrows are exclusive
    public fun exclusive_access(wallet: &mut Wallet) {
        // While this function has &mut wallet,
        // nothing else can access wallet
        wallet.balance = wallet.balance + 100;
        wallet.frozen = false;
    }
}
```

### Restructuring for Borrow Safety

When code violates borrow rules, restructure to comply:

```move
module movestack::restructuring {
    struct State has drop {
        count: u64,
        total: u64
    }

    // ❌ PROBLEM: Need to read and write simultaneously
    // fun problematic_pattern() {
    //     let mut state = State { count: 5, total: 100 };
    //     let read_ref = &state;
    //     let write_ref = &mut state;  // ERROR!
    //     write_ref.total = read_ref.count * 20;
    // }

    // ✅ SOLUTION 1: Extract values first, then modify
    public fun extract_then_modify(state: &mut State) {
        let count = state.count;     // Read value
        let total = state.total;     // Read value
        // Now use only the mutable reference
        state.total = total + count;
    }

    // ✅ SOLUTION 2: Single mutable reference for everything
    public fun single_reference(state: &mut State) {
        state.total = state.total + state.count;
    }

    // ✅ SOLUTION 3: Separate into distinct function calls
    public fun get_count(state: &State): u64 {
        state.count
    }

    public fun update_total(state: &mut State, amount: u64) {
        state.total = state.total + amount;
    }

    public fun orchestrate() {
        let mut state = State { count: 5, total: 100 };

        let count = get_count(&state);  // Immutable borrow ends
        update_total(&mut state, count * 10);  // New mutable borrow

        assert!(state.total == 150, 0);
    }

    #[test]
    fun test_restructuring() {
        let mut state = State { count: 4, total: 80 };
        extract_then_modify(&mut state);
        assert!(state.total == 84, 0);
    }
}
```

**Restructuring strategies**:

1. **Extract values first**: Copy needed data before mutating
2. **Single reference**: Read and write through one `&mut`
3. **Function boundaries**: Use separate function calls
4. **Scope blocks**: End borrows explicitly with `{ }` blocks

---

## Closing Scene: Trust the Compiler

Neri sat back, a new appreciation forming. "So every time the borrow checker complains, it's actually preventing a bug I might not have caught until production?"

"Exactly," Odessa confirmed. "Data races are insidious. They might work correctly ninety-nine times, then fail catastrophically on the hundredth. The borrow checker eliminates that entire category of bugs."

"It felt restrictive at first," Neri admitted. "But now I see it's more like... guardrails."

"Guardrails that never get tired and never miss an issue," Odessa agreed. "The rules become second nature. You start designing your code to flow with them, and your designs end up cleaner."

Neri looked at the error message that had started their conversation. "So that pull request—"

"—would have caused race conditions in production. The borrow checker caught it in seconds. No debugging sessions, no mysterious intermittent failures."

"The compiler as the first line of defense," Neri mused.

Odessa nodded. "Every borrow error is a bug you'll never have to debug in production. That's not a restriction—that's a gift."

---

## Summary

| Rule                     | Description                        | Purpose                          |
| ------------------------ | ---------------------------------- | -------------------------------- |
| **One `&mut` at a time** | Only one mutable reference allowed | Prevents concurrent modification |
| **Multiple `&` allowed** | Many immutable references OK       | Enables safe parallel reads      |
| **No mixing**            | Can't have `&mut` and `&` together | Prevents read/write conflicts    |
| **Lifetime tracking**    | References can't outlive data      | Eliminates dangling pointers     |

**Key Principles**:

- **The borrow checker catches bugs at compile time**: No runtime overhead, no hidden failures
- **Sequential access is always safe**: Complete one borrow before starting another
- **Extract then modify**: Read values into locals before mutating the struct
- **Function boundaries end borrows**: Each function call creates a fresh borrow scope
- **Embrace the constraints**: Code that compiles is guaranteed free from data races

The strictness of Move's reference rules is a feature, not a bug. Every error the borrow checker catches is a production incident prevented.
