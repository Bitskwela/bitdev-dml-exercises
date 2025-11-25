## Background Story

Odessa stands in the Labyrinth of Choices, a vast structure with infinite corridors branching and reconverging. Each path represents a different control flow decision. At the center, a great guardian named Arceus watches over the paths.

"Most programmers treat control flow like a wild river," Arceus says, his form shifting between the branching paths. "They flow where they will, sometimes reaching the destination, sometimes getting lost. Here, control flow is architecture—every branch is known, every loop has guaranteed termination, every decision is predictable."

Arceus gestures, and the corridors light up with flowing light—each representing a different control path.

"In Move, your `if` statements respect ownership. Your `while` loops cannot corrupt state. Your breaks and continues are safe. Every path through your code is mathematically proven to be sound. The compiler won't let you create an impossible situation—a path where a resource is used twice, or a path where it vanishes."

"Today, you'll learn to architect control flow that is not just functional, but _provably correct_. By day's end, you'll write code that branches safely, loops reliably, and completes predictably."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **If-Else: Safe Branching with Ownership**

Control flow is about making decisions: "If this is true, do that. Otherwise, do this." Move's if-else statements are different from other languages because they must respect ownership rules across ALL branches.

**What does "all branches must handle values the same way" mean?**

Imagine you have an `if` statement that consumes (moves) a value in one branch but not the other. Now you have a problem: in one case, the value is gone. In the other case, it still exists. Your code becomes unpredictable. Move prevents this by requiring ALL branches to handle values consistently.

Here's why this matters. Imagine two paths through your code:

- Path A (if condition true): move the spell, consume it
- Path B (if condition false): keep the spell

After the if-else ends, does the spell still exist? The compiler doesn't know! This uncertainty is exactly what Move prevents.

```move
public fun authorize_spell(power: u64): bool {
    // Simple if-else: returns a bool in all branches
    if (power < 50) {
        true   // Branch 1: returns bool
    } else {
        false  // Branch 2: also returns bool
    }
    // ✅ Both branches return the same type (bool)
}

// ✅ Works: all branches return u64
public fun calculate_cost(power: u64): u64 {
    if (power > 100) {
        power * 2      // Branch 1: multiply power by 2
    } else {
        power          // Branch 2: just return power as-is
    }
    // ✅ Both branches return u64
}
```

**Ownership through branches (the hard part):**

Here's where beginners struggle. Let's look at both wrong and right ways:

```move
struct Spell {
    power: u64
}

// ❌ WRONG: Branches handle ownership differently
public fun process_spell(spell: Spell): u64 {
    if (spell.power > 50) {
        spell.power   // Branch 1: uses (moves) spell
    } else {
        0             // Branch 2: doesn't touch spell
    }
    // ❌ ERROR! One path consumes spell, other doesn't
    // After the if-else, compiler doesn't know: does spell still exist?
}

// ✅ CORRECT: All paths handle spell consistently
public fun process_spell(spell: Spell): u64 {
    // Extract the value BEFORE the if-else
    let value = spell.power;

    if (value > 50) {
        value   // Branch 1: returns value
    } else {
        0       // Branch 2: returns constant
    }
    // ✅ Both branches work with extracted value
    // spell is consumed before the if-else, consistently
}
```

**The compiler's guarantee:**

Move's compiler proves that at every point in your code, every variable is in a well-defined state:

```move
let mut x = 10u64;

if (true) {
    x = 20;
} else {
    x = 30;
};

println!("{}", x);  // ✅ x definitely has a value (20 or 30, not undefined)
```

**Real blockchain example:**

Imagine you're building spell inventory code:

```move
public fun cast_if_powerful(spell: Spell, target: u64): u64 {
    // You MUST handle spell in all branches consistently
    let power = spell.power;

    if (power >= target) {
        // Spell is powerful enough - consume it
        execute_spell(spell);
        1000  // Return success code
    } else {
        // Spell too weak - still need to handle it
        let _unused = spell;  // Consume it anyway
        0     // Return failure code
    }
}
```

### 2️⃣ **While Loops: Bounded Iteration**

While loops let you repeat code while a condition is true. The key thing about Move is that loops must have an obvious termination point—Move won't let you create infinite loops (which would freeze the blockchain).

**Why have a termination condition?**

In traditional programming, programmers sometimes accidentally create infinite loops (`while (true) { }`). On a blockchain, this is catastrophic—the validator would compute forever and never finish the block. Move prevents this by requiring a clear exit condition.

**Basic while loop (countdown):**

```move
// Countdown example
public fun countdown(mut n: u64) {
    // Start with n = 5, for example
    while (n > 0) {
        println!("{}", n);  // Print 5, 4, 3, 2, 1
        n = n - 1;          // Decrease n each iteration
    }
    // Loop ends when n reaches 0
    // When n = 0, the condition n > 0 is false, so we exit
}
```

**Loop with accumulation (sum all elements):**

```move
// Accumulate (sum) all elements in a vector
public fun accumulate(values: &vector<u64>): u64 {
    let mut sum = 0u64;     // Start with sum = 0
    let mut i = 0;          // Start with index = 0

    while (i < vector::length(values)) {
        // Get value at index i and add to sum
        sum = sum + *vector::borrow(values, i);
        // Move to next index
        i = i + 1;
    }

    // Loop ends when i >= length of vector
    sum
}
```

**How does this work step by step?**

If values = [10, 20, 30]:

- i=0: i < 3 is true, sum = 0 + 10 = 10, then i = 1
- i=1: i < 3 is true, sum = 10 + 20 = 30, then i = 2
- i=2: i < 3 is true, sum = 30 + 30 = 60, then i = 3
- i=3: i < 3 is FALSE, loop exits
- Return 60 ✓

**Critical: Move doesn't have traditional for loops**

Many languages have `for (let i = 0; i < 10; i++)`. Move doesn't have this syntax. Why? Because Move wants to make sure:

1. The loop variable is explicit (you see `let mut i`)
2. The termination condition is obvious (`i < length`)
3. The increment is explicit (`i = i + 1`)

So Move requires you to write:

```move
let mut i = 0;
while (i < 10) {
    println!("{}", i);
    i = i + 1;
}
```

This is verbose, but it's CLEAR. No hidden magic. You can always predict when the loop ends.

**Loop with resources (consuming from vector):**

```move
public fun process_spells(mut spells: vector<Spell>) {
    while (!vector::is_empty(&spells)) {
        let spell = vector::pop_back(&mut spells);
        // Process spell
        execute_spell(spell);
        // spell is consumed here
    }
    // After loop: all spells have been processed
    // spells is now empty
}
```

### 3️⃣ **Break and Continue: Safe Loop Control**

Sometimes you need to exit a loop early or skip to the next iteration. Move provides `break` and `continue` for this.

**BREAK: Exit loop immediately**

`break` stops the loop right now and continues execution after the loop:

```move
public fun find_powerful_spell(spells: &vector<Spell>): u64 {
    let mut i = 0;

    while (i < vector::length(spells)) {
        let spell = vector::borrow(spells, i);

        if (spell.power > 100) {
            break;  // Exit loop immediately when we find a powerful spell
        };
        i = i + 1;
    };

    // After break or normal loop end, i contains the index
    i
}
```

**When should you use break?**

Use `break` when you're searching for something and found it. No point continuing the loop.

```move
public fun contains_power(spells: &vector<u64>, target: u64): bool {
    let mut i = 0;

    while (i < vector::length(spells)) {
        if (*vector::borrow(spells, i) == target) {
            break;  // Found it! Exit immediately
        };
        i = i + 1;
    };

    // After break, i is at the found position
    i < vector::length(spells)  // If i < length, we found it (broke), otherwise loop ended normally
}
```

**CONTINUE: Skip to next iteration**

`continue` stops the current iteration and jumps to the next one (checking the loop condition):

```move
public fun print_low_power(spells: &vector<u64>) {
    let mut i = 0;

    while (i < vector::length(spells)) {
        let power = *vector::borrow(spells, i);

        if (power > 50) {
            i = i + 1;
            continue;  // Skip this spell, go to next iteration
        };

        // Only reaches here for low-power spells
        println!("{}", power);
        i = i + 1;
    }
}
```

**When should you use continue?**

Use `continue` when you want to skip certain elements but keep processing others.

```move
public fun process_non_fire_spells(spells: &vector<Spell>) {
    let mut i = 0;

    while (i < vector::length(spells)) {
        let spell = vector::borrow(spells, i);

        // Skip all fire spells
        if (spell.element == FIRE) {
            i = i + 1;
            continue;  // Go to next spell
        };

        // Process non-fire spells
        cast_spell(spell);
        i = i + 1;
    }
}
```

**Break with return value:**

You can break and immediately return a value:

```move
public fun search(target: u64): bool {
    let mut i = 0;
    let found = loop {
        if (i >= 10) break false;      // Return false if we reach 10
        if (i == target) break true;   // Return true if we find target
        i = i + 1;
    };
    found
}
```

### 4️⃣ **Loop: Infinite Loop with Explicit Exit**

The `loop` keyword creates an infinite loop that MUST explicitly exit with `break`. This is different from `while`.

**Basic loop structure:**

```move
public fun interactive_spell_casting() {
    loop {
        let action = get_user_action();  // Get user input

        if (action == CAST) {
            cast_spell();
            // Continue looping
        } else if (action == EXIT) {
            break;  // Must explicitly break to exit
        }
        // If neither condition, loop continues
    }
}
```

**Why use loop instead of while?**

`loop` says "run until I explicitly tell you to stop." `while` says "run while this condition is true." Use `loop` when:

1. You have multiple different exit conditions
2. You want to emphasize that exit is explicit
3. You'll definitely exit with a break somewhere

**Loop that returns a value:**

```move
public fun find_in_list(list: &vector<u64>, target: u64): u64 {
    loop {
        // Loop logic...
        if (found) {
            break value;  // Break with return value
        }
    }
}
```

**Loop without break is a compile error:**

```move
loop {
    println!("Forever!");
    // ❌ ERROR! Loop must have explicit break
    // This prevents accidental infinite loops
}
```

### 5️⃣ **Conditional Logic: If Expression vs Statement**

Move's if can be both an expression (returns a value) and a statement (does something). This is important for understanding how to structure code.

**If as an expression (returns a value):**

```move
// If returns a value directly
let result = if (power > 50) { "strong" } else { "weak" };

// If returns different types (must be same type)
let cost = if (is_rush_order) {
    100u64  // Cost for rush
} else {
    50u64   // Cost for normal
};
```

**If as a statement (does something):**

```move
if (power > 100) {
    println!("Powerful!");
} else if (power > 50) {
    println!("Moderate");
} else {
    println!("Weak");
}
```

**Nested if statements:**

```move
if (spell.active) {
    if (spell.power > 80) {
        println!("Strong active spell");
    } else {
        println!("Weak active spell");
    }
} else {
    println!("Spell is inactive");
}
```

**Combining conditions:**

```move
if (power > 50 && active && cost < 100) {
    // Multiple conditions with AND
    execute_spell();
}

if (power > 100 || special || emergency) {
    // Multiple conditions with OR
    execute_spell();
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Safe Branching with Ownership 🔀

**Scenario:** Build a spell evaluation system that safely handles different spell types through branching.

**Boilerplate Code:**

```move
module spell_library::safe_branching {
    use std::string::String;

    struct Spell {
        power: u64,
        element: u8  // 0=Fire, 1=Ice, 2=Lightning
    }

    public fun evaluate_spell(spell: Spell): String {
        // TODO: Branch based on power, all paths must handle spell
        let result = if (spell.power > 80) {
            std::string::utf8(b"Powerful")
        } else if (spell.power > 50) {
            std::string::utf8(b"Moderate")
        } else {
            std::string::utf8(b"Weak")
        };

        result
    }

    public fun element_name(spell: &Spell): String {
        // TODO: Return element name based on spell.element
        // Use if-else to branch
        if (spell.element == 0) {
            std::string::utf8(b"Fire")
        } else if (spell.element == 1) {
            ____
        } else {
            std::string::utf8(b"Lightning")
        }
    }

    public fun test_branching() {
        let spell1 = Spell { power: 90, element: 0 };
        let result1 = evaluate_spell(spell1);
        assert!(result1 == std::string::utf8(b"Powerful"), 1);

        let spell2 = Spell { power: 60, element: 1 };
        let result2 = evaluate_spell(spell2);
        assert!(result2 == std::string::utf8(b"Moderate"), 2);

        let elem = element_name(&spell2);
        assert!(elem == std::string::utf8(b"Ice"), 3);
    }
}
```

**Your Task:**

1. Complete the if-else chain in `evaluate_spell`
2. Fill in the missing branch in `element_name`
3. Verify that all branches return consistent types
4. Ensure ownership is handled correctly

---

### Exercise 2: While Loops and Safe Iteration 🔄

**Scenario:** Process collections safely using while loops.

**Boilerplate Code:**

```move
module spell_library::loop_patterns {
    use std::vector;

    public fun sum_powers(spells: &vector<u64>): u64 {
        // TODO: Implement sum using while loop
        let mut total = 0u64;
        let mut i = 0;

        while (i < ____) {  // Condition: i < length
            let power = *vector::borrow(spells, ____);
            total = total + power;
            i = i + 1;
        };

        total
    }

    public fun count_powerful(spells: &vector<u64>, threshold: u64): u64 {
        // TODO: Count how many spells exceed threshold
        let mut count = 0u64;
        let mut i = 0;

        while (____) {
            let power = *vector::borrow(spells, i);
            if (power > threshold) {
                count = count + 1;
            };
            i = i + 1;
        };

        count
    }

    public fun find_index(spells: &vector<u64>, target: u64): u64 {
        // TODO: Find index of target value using while loop with break
        let mut i = 0;

        while (____) {
            if (*vector::borrow(spells, i) == target) {
                break;  // Exit when found
            };
            i = i + 1;
        };

        i
    }

    public fun test_loops() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, 50u64);
        vector::push_back(&mut spells, 80u64);
        vector::push_back(&mut spells, 60u64);
        vector::push_back(&mut spells, 90u64);

        let total = sum_powers(&spells);
        assert!(total == 280, 1);

        let powerful = count_powerful(&spells, 70);
        assert!(powerful == 2, 2);

        let index = find_index(&spells, 80);
        assert!(index == 1, 3);
    }
}
```

**Your Task:**

1. Complete `sum_powers` to sum all vector elements
2. Implement `count_powerful` to count elements above threshold
3. Use `break` safely in `find_index`
4. Verify loop termination conditions

---

### Exercise 3: Complex Control Flow 🌀

**Scenario:** Implement a spell processor with multiple branching paths and loops.

**Boilerplate Code:**

```move
module spell_library::complex_control {
    use std::vector;

    struct Spell {
        power: u64,
        element: u8
    }

    public fun process_spells(spells: &vector<Spell>): u64 {
        // TODO: Calculate total power with conditions
        // Skip Fire spells (element = 0)
        // Double power for Lightning spells (element = 2)

        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let spell = vector::borrow(spells, i);

            if (spell.element == 0) {
                i = i + 1;
                continue;  // Skip fire spells
            };

            if (spell.element == 2) {
                total = total + spell.power * 2;
            } else {
                total = total + spell.power;
            };

            i = i + 1;
        };

        total
    }

    public fun classify_inventory(spells: &vector<Spell>): (u64, u64, u64) {
        // TODO: Classify spells by element
        // Return (fire_count, ice_count, lightning_count)

        let mut fire = 0u64;
        let mut ice = 0u64;
        let mut lightning = 0u64;
        let mut i = 0;

        while (____) {
            let spell = vector::borrow(spells, i);

            if (____) {
                fire = fire + 1;
            } else if (spell.element == 1) {
                ice = ice + 1;
            } else {
                lightning = lightning + 1;
            };

            i = i + 1;
        };

        (fire, ice, lightning)
    }

    public fun test_complex_control() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, Spell { power: 50, element: 0 });  // Fire
        vector::push_back(&mut spells, Spell { power: 60, element: 1 });  // Ice
        vector::push_back(&mut spells, Spell { power: 40, element: 2 });  // Lightning

        let total = process_spells(&spells);
        // Fire skipped, Ice 60, Lightning 80 (40*2)
        assert!(total == 140, 1);

        let (fire, ice, lightning) = classify_inventory(&spells);
        assert!(fire == 1, 2);
        assert!(ice == 1, 3);
        assert!(lightning == 1, 4);
    }
}
```

**Your Task:**

1. Implement spell processing with skip logic (continue)
2. Classify spells into three categories
3. Handle multiple branches correctly
4. Verify results for all paths

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::safe_branching {
    use std::string::String;

    struct Spell {
        power: u64,
        element: u8
    }

    public fun evaluate_spell(spell: Spell): String {
        let result = if (spell.power > 80) {
            std::string::utf8(b"Powerful")
        } else if (spell.power > 50) {
            std::string::utf8(b"Moderate")
        } else {
            std::string::utf8(b"Weak")
        };

        result
    }

    public fun element_name(spell: &Spell): String {
        if (spell.element == 0) {
            std::string::utf8(b"Fire")
        } else if (spell.element == 1) {
            std::string::utf8(b"Ice")
        } else {
            std::string::utf8(b"Lightning")
        }
    }

    public fun test_branching() {
        let spell1 = Spell { power: 90, element: 0 };
        let result1 = evaluate_spell(spell1);
        assert!(result1 == std::string::utf8(b"Powerful"), 1);

        let spell2 = Spell { power: 60, element: 1 };
        let result2 = evaluate_spell(spell2);
        assert!(result2 == std::string::utf8(b"Moderate"), 2);

        let elem = element_name(&spell2);
        assert!(elem == std::string::utf8(b"Ice"), 3);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::loop_patterns {
    use std::vector;

    public fun sum_powers(spells: &vector<u64>): u64 {
        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let power = *vector::borrow(spells, i);
            total = total + power;
            i = i + 1;
        };

        total
    }

    public fun count_powerful(spells: &vector<u64>, threshold: u64): u64 {
        let mut count = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let power = *vector::borrow(spells, i);
            if (power > threshold) {
                count = count + 1;
            };
            i = i + 1;
        };

        count
    }

    public fun find_index(spells: &vector<u64>, target: u64): u64 {
        let mut i = 0;

        while (i < vector::length(spells)) {
            if (*vector::borrow(spells, i) == target) {
                break;
            };
            i = i + 1;
        };

        i
    }

    public fun test_loops() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, 50u64);
        vector::push_back(&mut spells, 80u64);
        vector::push_back(&mut spells, 60u64);
        vector::push_back(&mut spells, 90u64);

        let total = sum_powers(&spells);
        assert!(total == 280, 1);

        let powerful = count_powerful(&spells, 70);
        assert!(powerful == 2, 2);

        let index = find_index(&spells, 80);
        assert!(index == 1, 3);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::complex_control {
    use std::vector;

    struct Spell {
        power: u64,
        element: u8
    }

    public fun process_spells(spells: &vector<Spell>): u64 {
        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let spell = vector::borrow(spells, i);

            if (spell.element == 0) {
                i = i + 1;
                continue;
            };

            if (spell.element == 2) {
                total = total + spell.power * 2;
            } else {
                total = total + spell.power;
            };

            i = i + 1;
        };

        total
    }

    public fun classify_inventory(spells: &vector<Spell>): (u64, u64, u64) {
        let mut fire = 0u64;
        let mut ice = 0u64;
        let mut lightning = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let spell = vector::borrow(spells, i);

            if (spell.element == 0) {
                fire = fire + 1;
            } else if (spell.element == 1) {
                ice = ice + 1;
            } else {
                lightning = lightning + 1;
            };

            i = i + 1;
        };

        (fire, ice, lightning)
    }

    public fun test_complex_control() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, Spell { power: 50, element: 0 });
        vector::push_back(&mut spells, Spell { power: 60, element: 1 });
        vector::push_back(&mut spells, Spell { power: 40, element: 2 });

        let total = process_spells(&spells);
        assert!(total == 140, 1);

        let (fire, ice, lightning) = classify_inventory(&spells);
        assert!(fire == 1, 2);
        assert!(ice == 1, 3);
        assert!(lightning == 1, 4);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Safe Branching

**All branches must return same type:**

```move
if (condition) {
    utf8(b"Text")  // Returns String
} else {
    utf8(b"Other")  // Also returns String
}
// Result is always String ✅
```

**Ownership is consistent:**

- Spell is consumed by extracting its power field before the if
- No branch tries to move it multiple times

### Exercise 2 Explanation: While Loops

**Standard loop pattern:**

```move
let mut i = 0;
while (i < vector::length(...)) {
    // Process element at index i
    i = i + 1;  // MUST increment to move forward
};
// When i >= length, loop exits
```

**Break exits immediately:**

```move
while (...) {
    if (condition) {
        break;  // Exit loop right now
    }
}
// Execution continues after the loop
```

### Exercise 3 Explanation: Complex Control

**Continue skips current iteration:**

```move
if (element == 0) {
    i = i + 1;
    continue;  // Jump to next iteration
}
// Code after continue is skipped
```

**Multiple branches handled safely:**

- Fire path (element=0): skip with continue
- Lightning path (element=2): double power
- Other paths: add normally
- All paths maintain consistent state

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::control_flow_tests {
    use spell_library::safe_branching;
    use spell_library::loop_patterns;
    use spell_library::complex_control;
    use std::vector;

    #[test]
    fun test_safe_branching() {
        safe_branching::test_branching();
    }

    #[test]
    fun test_while_loops() {
        loop_patterns::test_loops();
    }

    #[test]
    fun test_complex_control() {
        complex_control::test_complex_control();
    }

    #[test]
    fun test_empty_vector_handling() {
        let empty = vector::empty();
        let sum = loop_patterns::sum_powers(&empty);
        assert!(sum == 0, 1);
    }

    #[test]
    fun test_single_element() {
        let mut vec = vector::empty();
        vector::push_back(&mut vec, 42u64);
        let sum = loop_patterns::sum_powers(&vec);
        assert!(sum == 42, 1);
    }

    #[test]
    fun test_nested_conditions() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, complex_control::Spell { power: 100, element: 2 });
        let total = complex_control::process_spells(&spells);
        assert!(total == 200, 1);  // Lightning doubled
    }
}
```

---

## 🌟 Closing Story

Arceus watches as Odessa navigates the labyrinth perfectly, every branch taken safely, every loop terminating correctly, every path proven sound.

> "You've learned the architecture of control flow," Arceus says, his form stabilizing into a single, confident shape. "Every `if` you write will type-check across branches. Every `while` you write will respect ownership. Every `break` you write will exit safely."

> "In other languages, control flow is chaos masquerading as order. Functions return at unpredictable times, loops forget to terminate, branches leave resources in undefined states. Here, control flow is predictable, provable, and perfect."

The labyrinth glows with ordered light—every corridor now visible and accounted for.

> "You're nearing mastery. But there are still collections to organize, errors to handle, and systems to build. Next, we must teach you how to organize data—how to use vectors and tables to build scalable storage."

> "The path is clear. Are you ready to continue?"

---

**Next Lesson Preview:** 📦 _Collections: Organizing Data Safely_

- Master vectors and their operations
- Safe iteration without indexing vulnerabilities
- Generic collections for flexible storage
- When and why NOT to use collections
- Building efficient data structures

_Organization is the next frontier. Are you ready?_
