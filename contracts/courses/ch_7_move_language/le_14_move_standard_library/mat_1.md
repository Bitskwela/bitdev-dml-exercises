## Background Story

Mentor Kai meets Odessa in the Grand Library—an infinite repository where every spell ever written is cataloged. The shelves stretch endlessly, each containing modules used by developers across the entire Move ecosystem.

"Every language has a standard library," Kai explains, gesturing to the glowing shelves. "In Move, the standard library provides foundational data structures and utilities. These aren't blockchain-specific—they're universal tools for managing data, text, optionality, and debugging."

The mentor pulls several ancient tomes from the shelf.

"You've already used some of these: `vector` for dynamic arrays, `option` for optional values. But there's more—much more. String handling, mathematical operations, debugging utilities. These are the building blocks every Move developer relies on."

Kai opens one tome, revealing intricate patterns of code.

"The standard library is special because it's _battle-tested_. Thousands of developers have used these modules in production. Every function has been scrutinized, optimized, debugged. When you use `std::vector`, you're using code that's proven reliable across countless contracts."

The mentor's eyes glow with knowledge.

"Today, you'll master the standard library. You'll understand when to use each module, how they work internally, and why they're designed the way they are. By the end, you'll have a professional's command of the essential tools every Move developer must know."

The library brightens with anticipation.

"Let's begin with the fundamentals."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **std::vector - Dynamic Arrays**

Vectors are the primary collection type in Move. You've used them, but let's understand them deeply.

**What is a vector, really?**

A vector is a growable array. Unlike fixed-size arrays (which Move doesn't have), vectors can expand and shrink dynamically.

```move
use std::vector;

public fun vector_basics() {
    // Create empty vector
    let mut vec = vector::empty<u64>();

    // Add elements (grows automatically)
    vector::push_back(&mut vec, 10);
    vector::push_back(&mut vec, 20);
    vector::push_back(&mut vec, 30);

    // Access elements
    let first = vector::borrow(&vec, 0);  // Returns &u64
    assert!(*first == 10, 1);

    // Mutate elements
    let first_mut = vector::borrow_mut(&mut vec, 0);
    *first_mut = 15;

    // Remove elements (shrinks automatically)
    let last = vector::pop_back(&mut vec);
    assert!(last == 30, 2);
}
```

**Core vector operations:**

| Operation   | Function                  | What it does                    | Time complexity |
| ----------- | ------------------------- | ------------------------------- | --------------- |
| Create      | `empty<T>()`              | New empty vector                | O(1)            |
| Add         | `push_back(&mut v, item)` | Append to end                   | O(1) amortized  |
| Remove      | `pop_back(&mut v)`        | Remove from end                 | O(1)            |
| Access      | `borrow(&v, i)`           | Get reference to element        | O(1)            |
| Mutate      | `borrow_mut(&mut v, i)`   | Get mutable reference           | O(1)            |
| Length      | `length(&v)`              | Get number of elements          | O(1)            |
| Check empty | `is_empty(&v)`            | True if length is 0             | O(1)            |
| Contains    | `contains(&v, &item)`     | Search for element              | O(n)            |
| Index of    | `index_of(&v, &item)`     | Find position of element        | O(n)            |
| Swap        | `swap(&mut v, i, j)`      | Exchange two elements           | O(1)            |
| Reverse     | `reverse(&mut v)`         | Reverse order in-place          | O(n)            |
| Append      | `append(&mut v1, v2)`     | Move all elements from v2 to v1 | O(n)            |

**Why borrow instead of direct access?**

```move
// ❌ Can't do this in Move
let element = vec[0];  // No indexing operator

// ✅ Must do this
let element_ref = vector::borrow(&vec, 0);
let element = *element_ref;
```

**Reason:** Move's ownership system requires explicit control. Borrowing makes ownership clear:

- `borrow` = immutable access (read-only)
- `borrow_mut` = mutable access (read-write)
- No ambiguity about who owns what

**Creating vectors with initial values:**

```move
// Literal syntax
let vec = vector[1u64, 2, 3, 4, 5];

// Programmatic creation
public fun create_range(n: u64): vector<u64> {
    let mut vec = vector::empty<u64>();
    let mut i = 0;

    while (i < n) {
        vector::push_back(&mut vec, i);
        i = i + 1;
    };

    vec
}
```

**Vector iteration patterns:**

```move
public fun sum_vector(vec: &vector<u64>): u64 {
    let mut total = 0;
    let mut i = 0;

    while (i < vector::length(vec)) {
        let value = *vector::borrow(vec, i);
        total = total + value;
        i = i + 1;
    };

    total
}

public fun find_max(vec: &vector<u64>): u64 {
    assert!(!vector::is_empty(vec), 1);

    let mut max = *vector::borrow(vec, 0);
    let mut i = 1;

    while (i < vector::length(vec)) {
        let current = *vector::borrow(vec, i);
        if (current > max) {
            max = current;
        };
        i = i + 1;
    };

    max
}
```

**Efficient removal patterns:**

```move
// ✅ Remove from end: O(1)
let last = vector::pop_back(&mut vec);

// ⚠️ Remove from middle: O(n) using swap_remove
public fun efficient_remove(vec: &mut vector<u64>, index: u64): u64 {
    let len = vector::length(vec);
    vector::swap(vec, index, len - 1);
    vector::pop_back(vec)
    // Order not preserved, but fast!
}

// ❌ Remove from middle preserving order: O(n)
public fun slow_remove(vec: &mut vector<u64>, index: u64): u64 {
    assert!(index < vector::length(vec), 1);

    let item = *vector::borrow(vec, index);
    let mut i = index;

    while (i < vector::length(vec) - 1) {
        let next = *vector::borrow(vec, i + 1);
        *vector::borrow_mut(vec, i) = next;
        i = i + 1;
    };

    vector::pop_back(vec);
    item
}
```

### 2️⃣ **std::string - Text Handling**

Strings in Move are UTF-8 encoded byte sequences with validation.

**What's the difference between vector<u8> and String?**

```move
use std::string::{Self, String};

// vector<u8>: Raw bytes, no validation
let bytes = b"hello";  // Type: vector<u8>

// String: Validated UTF-8
let text = string::utf8(b"hello");  // Type: String
```

**Why String type exists:**

1. **Validation**: Ensures bytes are valid UTF-8
2. **Safety**: Prevents invalid text from corrupting data
3. **Clarity**: Makes intent explicit (this is text, not arbitrary data)

**Creating strings:**

```move
public fun string_creation() {
    // From byte literal
    let s1 = string::utf8(b"Hello, Move!");

    // Empty string
    let s2 = string::empty();

    // From vector<u8>
    let bytes = vector[72u8, 101, 108, 108, 111];  // "Hello"
    let s3 = string::utf8(bytes);
}
```

**String operations:**

```move
use std::string::{Self, String};

public fun string_operations() {
    let mut text = string::utf8(b"Hello");

    // Length (in bytes, not characters!)
    let len = string::length(&text);
    assert!(len == 5, 1);

    // Append string
    let world = string::utf8(b" World");
    string::append(&mut text, world);

    // Check if empty
    let empty = string::empty();
    assert!(string::is_empty(&empty), 2);

    // Convert to bytes
    let bytes = string::bytes(&text);
    // bytes is &vector<u8>

    // Substring (careful: byte indices, not character indices!)
    let sub = string::sub_string(&text, 0, 5);
    assert!(sub == string::utf8(b"Hello"), 3);
}
```

**Important: UTF-8 and byte indexing**

```move
// ASCII works predictably
let ascii = string::utf8(b"hello");
let sub = string::sub_string(&ascii, 0, 2);  // "he"

// Unicode requires care
let unicode = string::utf8(b"hello 🌍");  // Earth emoji is 4 bytes!
// Be careful: character count ≠ byte count
```

**String comparison:**

```move
public fun string_comparison() {
    let s1 = string::utf8(b"apple");
    let s2 = string::utf8(b"banana");
    let s3 = string::utf8(b"apple");

    assert!(s1 == s3, 1);  // Equality works
    assert!(s1 != s2, 2);  // Inequality works
}
```

**Common patterns:**

```move
// Building strings dynamically
public fun build_string(): String {
    let mut result = string::utf8(b"Result: ");
    string::append(&mut result, string::utf8(b"Success"));
    result
}

// Validating string content
public fun validate_non_empty(text: &String) {
    assert!(!string::is_empty(text), 1);
}
```

### 3️⃣ **std::option - Optional Values**

Option represents a value that might or might not exist. This is Move's way of handling "nullable" values safely.

**What problem does Option solve?**

In many languages, you can have `null` or `undefined`:

```javascript
// JavaScript
let value = getValue(); // Might be undefined
if (value !== undefined) {
  use(value);
}
```

This causes errors when you forget to check. Move doesn't have `null`. Instead, it has `Option`:

```move
use std::option::{Self, Option};

// Option<T> is either:
// - Some(value): Contains a value of type T
// - None: Contains nothing

public fun option_basics() {
    // Create Some
    let has_value: Option<u64> = option::some(42);

    // Create None
    let no_value: Option<u64> = option::none();

    // Check if has value
    assert!(option::is_some(&has_value), 1);
    assert!(option::is_none(&no_value), 2);
}
```

**Why is this better than null?**

1. **Explicit**: You MUST handle both cases (Some and None)
2. **Safe**: Can't accidentally use a None value
3. **Clear**: Type system shows which values might be absent

**Working with Option:**

```move
public fun option_operations() {
    let opt = option::some(100u64);

    // Check before using
    if (option::is_some(&opt)) {
        let value = option::borrow(&opt);
        assert!(*value == 100, 1);
    };

    // Extract value (aborts if None!)
    let value = option::extract(&mut opt);
    assert!(value == 100, 2);
    assert!(option::is_none(&opt), 3);  // Now it's None

    // Fill None with value
    option::fill(&mut opt, 200);
    assert!(option::is_some(&opt), 4);
}
```

**Option API:**

| Function                | Purpose                  | Notes                       |
| ----------------------- | ------------------------ | --------------------------- |
| `some(value)`           | Create Option with value | Returns Option<T>           |
| `none()`                | Create empty Option      | Returns Option<T>           |
| `is_some(&opt)`         | Check if has value       | Returns bool                |
| `is_none(&opt)`         | Check if empty           | Returns bool                |
| `borrow(&opt)`          | Get reference to value   | Aborts if None              |
| `borrow_mut(&mut opt)`  | Get mutable reference    | Aborts if None              |
| `extract(&mut opt)`     | Take value out           | Aborts if None, leaves None |
| `fill(&mut opt, value)` | Put value in             | Aborts if already Some      |
| `swap(&mut opt, value)` | Replace value            | Returns old value if Some   |
| `destroy_none(opt)`     | Assert it's None         | Aborts if Some              |
| `destroy_some(opt)`     | Extract value            | Aborts if None              |

**Common patterns:**

```move
// Safe division (returns None if divide by zero)
public fun safe_divide(a: u64, b: u64): Option<u64> {
    if (b == 0) {
        option::none()
    } else {
        option::some(a / b)
    }
}

// Using the result
public fun use_division() {
    let result = safe_divide(100, 5);

    if (option::is_some(&result)) {
        let value = option::borrow(&result);
        println!("Result: {}", *value);
    } else {
        println!("Division failed");
    };
}

// Default value pattern
public fun get_or_default(opt: Option<u64>, default: u64): u64 {
    if (option::is_some(&opt)) {
        option::destroy_some(opt)
    } else {
        option::destroy_none(opt);
        default
    }
}
```

**Option in data structures:**

```move
struct User {
    name: String,
    email: Option<String>,  // Email is optional
    age: u64
}

public fun create_user(name: String, age: u64): User {
    User {
        name,
        email: option::none(),  // No email yet
        age
    }
}

public fun set_email(user: &mut User, email: String) {
    if (option::is_some(&user.email)) {
        // Replace existing email
        option::swap(&mut user.email, email);
    } else {
        // Add new email
        option::fill(&mut user.email, email);
    };
}
```

### 4️⃣ **std::math - Mathematical Utilities**

The math module provides common mathematical operations and constants.

**What's included:**

```move
use std::math;

public fun math_operations() {
    // Minimum and maximum
    let min = math::min(10u64, 20u64);
    assert!(min == 10, 1);

    let max = math::max(10u64, 20u64);
    assert!(max == 20, 2);

    // Absolute difference
    let diff = math::diff(10u64, 20u64);
    assert!(diff == 10, 3);  // Always positive

    // Power
    let squared = math::pow(5u64, 2u64);
    assert!(squared == 25, 4);

    // Square root (integer)
    let sqrt = math::sqrt(25u64);
    assert!(sqrt == 5, 5);
}
```

**Why use math module?**

1. **Clarity**: `math::min(a, b)` is clearer than `if (a < b) a else b`
2. **Optimization**: Library functions may be optimized
3. **Safety**: Functions handle edge cases correctly

**Common patterns:**

```move
// Clamping values to range
public fun clamp(value: u64, min: u64, max: u64): u64 {
    math::min(math::max(value, min), max)
}

// Safe subtraction (never underflows)
public fun safe_subtract(a: u64, b: u64): u64 {
    if (a > b) {
        a - b
    } else {
        0
    }
}

// Using diff for absolute difference
public fun calculate_change(old: u64, new: u64): u64 {
    math::diff(old, new)
}
```

**Integer overflow handling:**

```move
// Move aborts on overflow by default
public fun will_abort_on_overflow() {
    let max = 18446744073709551615u64;  // Max u64
    let result = max + 1;  // ❌ ABORTS
}

// Check before operation
public fun safe_add(a: u64, b: u64): Option<u64> {
    if (a > 18446744073709551615u64 - b) {
        option::none()  // Would overflow
    } else {
        option::some(a + b)
    }
}
```

### 5️⃣ **std::debug - Debugging Utilities**

Debug module provides tools for inspecting values during development.

**What is debug for?**

During testing and development, you need to see what's happening. The debug module lets you print values, inspect state, and trace execution.

```move
use std::debug;

public fun debug_examples() {
    let value = 42u64;

    // Print any value
    debug::print(&value);

    // Print string
    debug::print(&string::utf8(b"Debug message"));

    // Print complex structures
    let vec = vector[1u64, 2, 3];
    debug::print(&vec);
}
```

**Important: Debug is for development only**

```move
#[test]
fun test_with_debug() {
    let result = compute_something();
    debug::print(&result);  // ✅ OK in tests
    assert!(result == 100, 1);
}

public fun production_function() {
    let result = compute();
    debug::print(&result);  // ⚠️ Remove before deployment
}
```

**Why?**

- Debug output has cost on blockchain
- Production code should be clean
- Tests are the place for debugging

**Debug patterns:**

```move
#[test]
fun test_with_tracing() {
    debug::print(&string::utf8(b"Starting test"));

    let value = complex_computation();
    debug::print(&string::utf8(b"Computed value:"));
    debug::print(&value);

    assert!(value > 0, 1);
    debug::print(&string::utf8(b"Test passed"));
}
```

**Debugging vector contents:**

```move
#[test]
fun test_vector_transformation() {
    let original = vector[1u64, 2, 3, 4, 5];
    debug::print(&string::utf8(b"Original:"));
    debug::print(&original);

    let transformed = transform(original);
    debug::print(&string::utf8(b"Transformed:"));
    debug::print(&transformed);

    assert!(vector::length(&transformed) == 5, 1);
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Vector Mastery 📊

**Scenario:** Implement advanced vector operations for a score tracking system.

**Boilerplate Code:**

```move
module spell_library::score_tracker {
    use std::vector;

    public fun calculate_average(scores: &vector<u64>): u64 {
        // TODO: Calculate average of all scores
        assert!(!vector::is_empty(scores), 1);

        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(____)) {
            let score = *vector::borrow(scores, ____);
            total = total + ____;
            i = i + 1;
        };

        total / vector::length(scores)
    }

    public fun find_high_scores(scores: &vector<u64>, threshold: u64): vector<u64> {
        // TODO: Return vector of scores above threshold
        let mut high_scores = vector::empty<u64>();
        let mut i = 0;

        while (i < vector::length(scores)) {
            let score = *vector::borrow(____, i);
            if (score > ____) {
                vector::push_back(&mut high_scores, ____);
            };
            i = i + 1;
        };

        high_scores
    }

    public fun merge_sorted(v1: vector<u64>, v2: vector<u64>): vector<u64> {
        // TODO: Merge two sorted vectors into one sorted vector
        let mut result = vector::empty<u64>();

        vector::append(&mut result, ____);
        vector::append(&mut result, ____);

        // Simple approach: append and sort (Move has no built-in sort)
        // In production, implement proper merge
        result
    }

    #[test]
    fun test_average() {
        let scores = vector[80u64, 90, 70, 85];
        let avg = calculate_average(&scores);
        assert!(avg == ____, 1);  // (80+90+70+85)/4 = 81.25 → 81
    }

    #[test]
    fun test_high_scores() {
        let scores = vector[50u64, 75, 90, 60, 85];
        let high = find_high_scores(&scores, 70);

        assert!(vector::length(&high) == ____, 1);
        assert!(vector::contains(&high, &90), 2);
    }
}
```

**Your Task:**

1. Calculate vector average
2. Filter scores above threshold
3. Merge two vectors
4. Complete test assertions
5. Validate all operations

---

### Exercise 2: String and Option Handling 📝

**Scenario:** Build a user profile system with optional fields.

**Boilerplate Code:**

```move
module spell_library::user_profile {
    use std::string::{Self, String};
    use std::option::{Self, Option};

    struct Profile {
        username: String,
        email: Option<String>,
        bio: Option<String>,
        age: u64
    }

    public fun create_profile(username: String, age: u64): Profile {
        // TODO: Create profile with required fields only
        Profile {
            username: ____,
            email: option::____(),
            bio: option::____(),
            age: ____
        }
    }

    public fun add_email(profile: &mut Profile, email: String) {
        // TODO: Add email to profile
        if (option::is_some(&profile.email)) {
            // Already has email, swap it
            option::____(&mut profile.email, ____);
        } else {
            // No email yet, fill it
            option::____(&mut profile.email, email);
        };
    }

    public fun get_email_or_default(profile: &Profile): String {
        // TODO: Return email if exists, otherwise return default
        if (option::is_some(&profile.____)) {
            let email_ref = option::borrow(&profile.email);
            ____
        } else {
            string::utf8(b"no-email@example.com")
        }
    }

    public fun has_complete_profile(profile: &Profile): bool {
        // TODO: Check if all optional fields are filled
        option::is_some(&profile.____) && option::is_some(&profile.____)
    }

    public fun build_display_name(profile: &Profile): String {
        // TODO: Build display name from username
        let mut display = string::utf8(b"User: ");
        string::append(&mut display, ____);
        display
    }

    #[test]
    fun test_profile_creation() {
        let profile = create_profile(
            string::utf8(b"alice"),
            25
        );

        assert!(option::is_none(&profile.email), 1);
        assert!(option::is_none(&profile.bio), 2);
    }

    #[test]
    fun test_add_email() {
        let mut profile = create_profile(string::utf8(b"bob"), 30);
        add_email(&mut profile, string::utf8(b"bob@example.com"));

        assert!(option::is_some(&profile.email), 1);

        let email = option::borrow(&profile.email);
        assert!(*email == string::utf8(b"bob@example.com"), 2);
    }
}
```

**Your Task:**

1. Create profile with optional fields
2. Add email with proper Option handling
3. Get email with default fallback
4. Check profile completion
5. Build strings dynamically

---

### Exercise 3: Comprehensive Standard Library Usage 🔧

**Scenario:** Build a spell ranking system using multiple standard library modules.

**Boilerplate Code:**

```move
module spell_library::spell_ranking {
    use std::vector;
    use std::string::{Self, String};
    use std::option::{Self, Option};
    use std::math;

    struct Spell {
        name: String,
        power: u64,
        rank: Option<u64>
    }

    public fun create_spell(name: String, power: u64): Spell {
        // TODO: Create spell with optional rank
        Spell {
            name: ____,
            power: ____,
            rank: option::none()
        }
    }

    public fun calculate_rank(spells: &vector<Spell>, index: u64): u64 {
        // TODO: Calculate rank based on power relative to max
        let spell = vector::borrow(spells, index);
        let max_power = find_max_power(____);

        // Rank is percentage: (power / max_power) * 100
        (spell.power * 100) / max_power
    }

    fun find_max_power(spells: &vector<Spell>): u64 {
        // TODO: Find maximum power among all spells
        assert!(!vector::is_empty(____), 1);

        let mut max = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let spell = vector::borrow(spells, i);
            max = math::max(____, spell.power);
            i = i + 1;
        };

        max
    }

    public fun assign_ranks(spells: &mut vector<Spell>) {
        // TODO: Assign rank to each spell
        let mut i = 0;

        while (i < vector::length(____)) {
            let rank = calculate_rank(spells, i);
            let spell = vector::borrow_mut(spells, i);
            option::fill(&mut spell.rank, ____);
            i = i + 1;
        };
    }

    public fun get_rank_display(spell: &Spell): String {
        // TODO: Build display string for rank
        let mut display = string::utf8(b"");
        string::append(&mut display, ____);
        string::append(&mut display, string::utf8(b" - Power: "));

        if (option::is_some(&spell.rank)) {
            string::append(&mut display, string::utf8(b"Rank "));
            // Would need to convert rank to string (Move lacks this)
        } else {
            string::append(&mut display, string::utf8(b"Unranked"));
        };

        display
    }

    #[test]
    fun test_spell_creation() {
        let spell = create_spell(string::utf8(b"Fireball"), 50);
        assert!(spell.power == 50, 1);
        assert!(option::is_none(&spell.rank), 2);
    }

    #[test]
    fun test_max_power() {
        let spells = vector[
            create_spell(string::utf8(b"Weak"), 30),
            create_spell(string::utf8(b"Strong"), 90),
            create_spell(string::utf8(b"Medium"), 60)
        ];

        let max = find_max_power(&spells);
        assert!(max == ____, 1);
    }

    #[test]
    fun test_rank_calculation() {
        let spells = vector[
            create_spell(string::utf8(b"Spell1"), 50),
            create_spell(string::utf8(b"Spell2"), 100)
        ];

        let rank = calculate_rank(&spells, 0);
        assert!(rank == ____, 1);  // 50/100 * 100 = 50
    }
}
```

**Your Task:**

1. Create spells with optional ranks
2. Find maximum power using math::max
3. Calculate percentage-based ranks
4. Assign ranks to all spells
5. Build display strings

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::score_tracker {
    use std::vector;

    public fun calculate_average(scores: &vector<u64>): u64 {
        assert!(!vector::is_empty(scores), 1);

        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(scores)) {
            let score = *vector::borrow(scores, i);
            total = total + score;
            i = i + 1;
        };

        total / vector::length(scores)
    }

    public fun find_high_scores(scores: &vector<u64>, threshold: u64): vector<u64> {
        let mut high_scores = vector::empty<u64>();
        let mut i = 0;

        while (i < vector::length(scores)) {
            let score = *vector::borrow(scores, i);
            if (score > threshold) {
                vector::push_back(&mut high_scores, score);
            };
            i = i + 1;
        };

        high_scores
    }

    public fun merge_sorted(v1: vector<u64>, v2: vector<u64>): vector<u64> {
        let mut result = vector::empty<u64>();
        vector::append(&mut result, v1);
        vector::append(&mut result, v2);
        result
    }

    #[test]
    fun test_average() {
        let scores = vector[80u64, 90, 70, 85];
        let avg = calculate_average(&scores);
        assert!(avg == 81, 1);
    }

    #[test]
    fun test_high_scores() {
        let scores = vector[50u64, 75, 90, 60, 85];
        let high = find_high_scores(&scores, 70);

        assert!(vector::length(&high) == 3, 1);
        assert!(vector::contains(&high, &90), 2);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::user_profile {
    use std::string::{Self, String};
    use std::option::{Self, Option};

    struct Profile {
        username: String,
        email: Option<String>,
        bio: Option<String>,
        age: u64
    }

    public fun create_profile(username: String, age: u64): Profile {
        Profile {
            username,
            email: option::none(),
            bio: option::none(),
            age
        }
    }

    public fun add_email(profile: &mut Profile, email: String) {
        if (option::is_some(&profile.email)) {
            option::swap(&mut profile.email, email);
        } else {
            option::fill(&mut profile.email, email);
        };
    }

    public fun get_email_or_default(profile: &Profile): String {
        if (option::is_some(&profile.email)) {
            let email_ref = option::borrow(&profile.email);
            *email_ref
        } else {
            string::utf8(b"no-email@example.com")
        }
    }

    public fun has_complete_profile(profile: &Profile): bool {
        option::is_some(&profile.email) && option::is_some(&profile.bio)
    }

    public fun build_display_name(profile: &Profile): String {
        let mut display = string::utf8(b"User: ");
        string::append(&mut display, profile.username);
        display
    }

    #[test]
    fun test_profile_creation() {
        let profile = create_profile(string::utf8(b"alice"), 25);
        assert!(option::is_none(&profile.email), 1);
        assert!(option::is_none(&profile.bio), 2);
    }

    #[test]
    fun test_add_email() {
        let mut profile = create_profile(string::utf8(b"bob"), 30);
        add_email(&mut profile, string::utf8(b"bob@example.com"));

        assert!(option::is_some(&profile.email), 1);
        let email = option::borrow(&profile.email);
        assert!(*email == string::utf8(b"bob@example.com"), 2);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::spell_ranking {
    use std::vector;
    use std::string::{Self, String};
    use std::option::{Self, Option};
    use std::math;

    struct Spell {
        name: String,
        power: u64,
        rank: Option<u64>
    }

    public fun create_spell(name: String, power: u64): Spell {
        Spell {
            name,
            power,
            rank: option::none()
        }
    }

    public fun calculate_rank(spells: &vector<Spell>, index: u64): u64 {
        let spell = vector::borrow(spells, index);
        let max_power = find_max_power(spells);
        (spell.power * 100) / max_power
    }

    fun find_max_power(spells: &vector<Spell>): u64 {
        assert!(!vector::is_empty(spells), 1);

        let mut max = 0u64;
        let mut i = 0;

        while (i < vector::length(spells)) {
            let spell = vector::borrow(spells, i);
            max = math::max(max, spell.power);
            i = i + 1;
        };

        max
    }

    public fun assign_ranks(spells: &mut vector<Spell>) {
        let mut i = 0;

        while (i < vector::length(spells)) {
            let rank = calculate_rank(spells, i);
            let spell = vector::borrow_mut(spells, i);
            option::fill(&mut spell.rank, rank);
            i = i + 1;
        };
    }

    public fun get_rank_display(spell: &Spell): String {
        let mut display = string::utf8(b"");
        string::append(&mut display, spell.name);
        string::append(&mut display, string::utf8(b" - Power: "));

        if (option::is_some(&spell.rank)) {
            string::append(&mut display, string::utf8(b"Rank "));
        } else {
            string::append(&mut display, string::utf8(b"Unranked"));
        };

        display
    }

    #[test]
    fun test_spell_creation() {
        let spell = create_spell(string::utf8(b"Fireball"), 50);
        assert!(spell.power == 50, 1);
        assert!(option::is_none(&spell.rank), 2);
    }

    #[test]
    fun test_max_power() {
        let spells = vector[
            create_spell(string::utf8(b"Weak"), 30),
            create_spell(string::utf8(b"Strong"), 90),
            create_spell(string::utf8(b"Medium"), 60)
        ];

        let max = find_max_power(&spells);
        assert!(max == 90, 1);
    }

    #[test]
    fun test_rank_calculation() {
        let spells = vector[
            create_spell(string::utf8(b"Spell1"), 50),
            create_spell(string::utf8(b"Spell2"), 100)
        ];

        let rank = calculate_rank(&spells, 0);
        assert!(rank == 50, 1);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Vector Operations

**Average calculation uses accumulator pattern:**

```move
let mut total = 0;
// Accumulate all values
while (...) { total = total + score; }
// Divide by count
total / length
```

**Filtering builds new vector:**

```move
let mut result = empty();
// Add only items matching condition
if (item > threshold) { push_back(...); }
```

### Exercise 2 Explanation: Option Handling

**Option pattern for optional fields:**

```move
email: option::none()  // Initially no email
// Later fill it
option::fill(&mut profile.email, email);
```

**Default value pattern:**

```move
if (is_some(&opt)) { *borrow(&opt) }
else { default_value }
```

### Exercise 3 Explanation: Multi-Module Integration

**Combining vector + math + option + string:**

```move
// Vector iteration
while (i < length(vec)) { ... }
// Math operations
max = math::max(max, value);
// Option for optional data
rank: Option<u64>
// String building
string::append(&mut s, part);
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::stdlib_lesson_tests {
    use spell_library::score_tracker;
    use spell_library::user_profile;
    use spell_library::spell_ranking;
    use std::string;

    #[test]
    fun run_all_score_tests() {
        score_tracker::test_average();
        score_tracker::test_high_scores();
    }

    #[test]
    fun run_all_profile_tests() {
        user_profile::test_profile_creation();
        user_profile::test_add_email();
    }

    #[test]
    fun run_all_ranking_tests() {
        spell_ranking::test_spell_creation();
        spell_ranking::test_max_power();
        spell_ranking::test_rank_calculation();
    }
}
```

---

## 🌟 Closing Story

Mentor Kai closes the ancient tomes, satisfied with Odessa's progress. The Grand Library's shelves now feel familiar, no longer intimidating.

> "You've mastered the standard library," Kai says, pride evident in his voice. "These tools—vectors, strings, options, math, debug—are your foundation. Every Move developer uses them. Every production contract relies on them."

> "Remember what you've learned: Vectors for collections, with O(1) access and explicit borrowing. Strings for validated text, with UTF-8 safety. Options for nullable values, forcing you to handle both cases. Math for common operations, with clear intent. Debug for development visibility."

The mentor gestures to the infinite shelves.

> "These modules are battle-tested. Thousands of developers have used them. Bugs have been found and fixed. Performance has been optimized. When you use `std::vector`, you're using code that's proven reliable across the entire Move ecosystem."

Kai's form shimmers with knowledge.

> "But tools are only as good as their wielder. You now know WHAT each module does. The art is knowing WHEN to use each. That comes with practice, with building real systems, with making mistakes and learning from them."

The library begins to fade.

> "Your next lesson awaits: friend modules. You'll learn how Move enables controlled access between modules—how to build internal APIs while maintaining encapsulation. The standard library gave you tools. Friend modules will teach you architecture."

The mentor bows.

> "Go forth. Build with confidence. The standard library is your ally."

---

**Next Lesson:** Friend Modules - building internal APIs and controlled access patterns.
