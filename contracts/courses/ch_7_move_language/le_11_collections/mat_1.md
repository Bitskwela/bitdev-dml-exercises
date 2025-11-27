## Background Story

Odessa enters the Grand Archive, a place where infinite knowledge is stored in crystalline vessels. Each vessel holds structured data—organized, indexed, and retrievable. But not all vessels are created equal.

An ancient librarian named Keeper Soreth approaches, her form composed of organized light.

"Many programmers treat collections as grab bags—throw data in, hope it's there later, suffer performance consequences. Here, we are precise about what we collect, how we store it, and what we promise the system."

Soreth gestures, and the archive reorganizes itself. Some vessels glow efficiently with organized data. Others flicker with poor design.

"Move gives you one primary collection: the vector. It's simple, safe, and powerful. But with power comes responsibility. A vector consumes heap space. A vector requires iteration to find elements. A vector forces you to choose: do you need ordered storage, or should you use something else?"

The librarian's eyes shine with purpose.

"Today, you'll master collections. You'll learn when to use them, when to avoid them, and how to use them safely. By day's end, you won't just write data structures—you'll architect them."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Vectors: Basics and Creation**

Vectors are ordered, dynamically-sized collections. Think of them like arrays that can grow or shrink as you need them. In Move, vectors are the primary collection type.

**What is a vector?**

A vector is a container that stores multiple values of the same type, one after another in order. When you create a vector with 3 elements, they have positions 0, 1, 2 (zero-indexed). You can add more elements, and the vector grows.

```move
use std::vector;

public fun create_vectors() {
    // Empty vector - start with nothing
    let mut spells: vector<u64> = vector::empty();
    // Now spells is an empty vector, ready to receive elements

    // Single element vector
    let spells2 = vector::singleton(100u64);
    // spells2 contains exactly one element: 100

    // Vector from literals (only in test contexts)
    #[test_only]
    let spells3 = vector[10u64, 20u64, 30u64];
    // spells3 contains three elements: 10, 20, 30
}
```

**Type safety - vectors are strongly typed:**

Every vector has a type: `vector<T>`. The `T` can be any type—u64, string, struct, etc. But once you create a `vector<u64>`, you can ONLY put u64s in it.

```move
let spells: vector<u64> = vector::empty();
// This vector is typed as "vector of u64"

let names: vector<std::string::String> = vector::empty();
// This vector is typed as "vector of String"

// ✅ Type is explicit
// ❌ Can't mix types: vector[10u64, "text", true]
// ❌ Can't add string to vector<u64>
```

**Vector ownership (vectors are owned, not borrowed):**

When you create a vector, YOU own it. A vector is a resource—if you move it, you lose ownership. If you pass it to a function, it gets consumed.

```move
let mut spells = vector::singleton(50u64);
// spells is owned by you

// Taking ownership and mutating
vector::push_back(&mut spells, 60u64);
// ✅ We pass &mut (borrowed for mutation), not the vector itself
// After push: spells still exists and you still own it

public fun process_and_consume(vec: vector<u64>) {
    // vec is owned by this function
    // It can read and modify vec
    // After this function, vec is destroyed
}

let spells = vector::singleton(50u64);
process_and_consume(spells);
// ❌ spells is gone—it was moved (consumed) into the function
// You can't use it anymore
```

**Vector in structs (storing vectors permanently):**

```move
struct Inventory {
    spells: vector<Spell>,  // The struct owns the vector
    potions: vector<Potion> // Different vector
}

public fun make_inventory(): Inventory {
    Inventory {
        spells: vector::empty(),
        potions: vector::empty()
    }
}

// Now the Inventory owns these vectors
// If you destroy the Inventory, the vectors are destroyed too
```

### 2️⃣ **Vector Operations: Safe Modification**

Vectors provide safe, well-defined operations for adding, removing, and accessing elements.

**Adding and removing elements:**

```move
use std::vector;

public fun modify_vector(mut spells: vector<u64>) {
    // Add element to end
    vector::push_back(&mut spells, 50u64);
    // spells now has one element: [50]

    vector::push_back(&mut spells, 60u64);
    // spells now has two elements: [50, 60]

    // Check length
    let len = vector::length(&spells);
    assert!(len == 2, 1);
    // ✅ Length is 2

    // Remove from back (last element)
    let last = vector::pop_back(&mut spells);
    assert!(last == 60, 2);
    // ✅ last equals 60

    // Now length is 1
    assert!(vector::length(&spells) == 1, 3);
    // spells = [50]
}
```

**How push_back and pop_back work:**

```
Initial: [10, 20, 30]

push_back(&mut vec, 40):
Result: [10, 20, 30, 40]

pop_back(&mut vec):
Result: [10, 20, 30]
Returned: 40
```

**Accessing elements safely with borrowing:**

Move has no index operator like `vec[0]`. Instead, you use `borrow` and `borrow_mut` to safely get references:

```move
public fun borrow_operations(mut spells: vector<u64>) {
    vector::push_back(&mut spells, 50u64);
    vector::push_back(&mut spells, 60u64);
    // spells = [50, 60]

    // Immutable borrow - read only
    let first = vector::borrow(&spells, 0);
    // first is &u64 (reference)
    let value = *first;  // Dereference to copy value
    assert!(value == 50, 1);
    // ✅ We read the value

    // Mutable borrow - can modify
    let mut_first = vector::borrow_mut(&mut spells, 0);
    *mut_first = 100u64;  // Modify through reference
    // spells = [100, 60]

    assert!(*vector::borrow(&spells, 0) == 100, 2);
    // ✅ The modification worked
}
```

**Why borrow instead of direct indexing?**

Because indexing can fail (index out of bounds). By using borrow, you get a reference that's guaranteed to be valid. If the index is invalid, the function aborts safely.

**Iteration patterns (safe loop):**

```move
public fun sum_vector(spells: &vector<u64>): u64 {
    let mut sum = 0u64;
    let mut i = 0;

    while (i < vector::length(spells)) {
        // Get element at index i
        sum = sum + *vector::borrow(spells, i);
        i = i + 1;
    };

    sum
}

// Contains check
public fun contains(spells: &vector<u64>, target: u64): bool {
    let mut i = 0;
    while (i < vector::length(spells)) {
        if (*vector::borrow(spells, i) == target) {
            return true;
        };
        i = i + 1;
    };
    false
}
```

**Why loops instead of fancy iterators?**

Move wants to be explicit. No hidden magic. You see exactly what's happening: iterate from 0 to length, get each element, process it. This makes performance predictable.

### 3️⃣ **Swapping and Advanced Operations**

Move provides safe manipulation for more complex operations.

**Swap: Exchange two elements:**

```move
use std::vector;

public fun swap_elements(mut vec: vector<u64>) {
    vector::push_back(&mut vec, 10u64);
    vector::push_back(&mut vec, 20u64);
    // vec = [10, 20]

    // Swap positions 0 and 1
    vector::swap(&mut vec, 0, 1);

    assert!(*vector::borrow(&vec, 0) == 20, 1);
    assert!(*vector::borrow(&vec, 1) == 10, 2);
    // vec = [20, 10]
}
```

**Why swap is useful:**

Swap is the basis for efficient removal. Instead of shifting all elements after a deletion, you swap the element to remove with the last element, then pop:

```move
public fun remove_element(mut vec: vector<u64>, index: u64) {
    // vec = [10, 20, 30, 40]
    // Remove index 1 (value 20)

    let len = vector::length(&vec);

    if (index < len) {
        // Swap element at index with last element
        vector::swap(&mut vec, index, len - 1);
        // vec = [10, 40, 30, 20]

        // Remove last element
        vector::pop_back(&mut vec);
        // vec = [10, 40, 30]
    }
    // Result: 20 is removed, but order changed
}
```

**Append: Combine two vectors:**

```move
public fun combine_vectors(mut vec1: vector<u64>, vec2: vector<u64>) {
    vector::push_back(&mut vec1, 10u64);
    vector::push_back(&mut vec1, 20u64);
    // vec1 = [10, 20]

    let mut vec2 = vector::singleton(30u64);
    vector::push_back(&mut vec2, 40u64);
    // vec2 = [30, 40]

    // Append all of vec2 to vec1
    vector::append(&mut vec1, vec2);
    // vec1 = [10, 20, 30, 40]
    // vec2 is now empty (moved)
}
```

### 4️⃣ **Generic Collections and Type Safety**

Vectors are generic—they work with ANY type. This is powerful.

**Vector of structs:**

```move
struct Spell {
    power: u64
}

public fun spell_inventory() {
    // Vector of Spell structs
    let mut spells: vector<Spell> = vector::empty();

    vector::push_back(&mut spells, Spell { power: 50 });
    vector::push_back(&mut spells, Spell { power: 100 });

    let first = vector::borrow(&spells, 0);
    assert!(first.power == 50, 1);
}
```

**Generic functions (work with any type):**

```move
// This function works with ANY type T that is copy and drop
public fun find_value<T: copy + drop>(
    vec: &vector<T>,
    target: T
): u64 {
    let mut i = 0;

    while (i < vector::length(vec)) {
        if (*vector::borrow(vec, i) == target) {
            return i;  // Found at index i
        };
        i = i + 1;
    };

    vector::length(vec)  // Not found
}

// Use with u64
let numbers = vector[10u64, 20u64, 30u64];
let index = find_value(&numbers, 20u64);
// index = 1 ✓

// Use with boolean
let flags = vector[true, false, true];
let index = find_value(&flags, false);
// index = 1 ✓
```

**The `copy + drop` requirement:**

When you write `<T: copy + drop>`, you're saying "T must be copyable and droppable." This means:

- `copy`: Copying doesn't destroy the original (unlike moving)
- `drop`: Dropping doesn't require special cleanup

For basic types (u64, bool, address), this is automatic. For structs with resources, this might not apply.

### 5️⃣ **Anti-Patterns: When NOT to Use Collections**

Vectors are powerful, but they're not always the right choice. Understanding anti-patterns prevents bugs and performance issues.

**Anti-Pattern 1: Unbounded vector growth**

```move
// ❌ PROBLEM: What if all_items grows to 1 million elements?
struct BadRegistry {
    all_items: vector<Item>
    // No limit, could grow forever
}

// ✅ BETTER: Explicit limits
struct BoundedRegistry {
    items: vector<Item>,
    max_size: u64
}

public fun add_to_registry(registry: &mut BoundedRegistry, item: Item) {
    assert!(
        vector::length(&registry.items) < registry.max_size,
        ERROR_FULL
    );
    vector::push_back(&mut registry.items, item);
}
```

**Anti-Pattern 2: Linear search in huge collections**

```move
// ❌ PROBLEM: Searching 1M items one by one is slow
public fun find_expensive(registry: &vector<Item>, id: u64): Option<Item> {
    let mut i = 0;
    while (i < vector::length(&registry)) {
        if (registry[i].id == id) {
            return option::some(*vector::borrow(&registry, i));
        };
        i = i + 1;
    }
    // O(n) search! For 1M items, this is very slow
}

// ✅ BETTER: For on-chain storage, use TableStore or Table
// (More advanced topic for later lessons)
```

**Anti-Pattern 3: Unnecessary cloning**

```move
// ❌ PROBLEM: Copying huge vectors is wasteful
let vec1 = create_large_vector();
let vec2 = vec1;  // This should be a move, not copy
// (Actually Move prevents this with ownership, but be aware)

// ✅ BETTER: Use references
public fun process_items(items: &vector<Item>) {
    // Reference doesn't allocate new space
}
```

**Anti-Pattern 4: Destroying vectors implicitly**

```move
// ❌ PROBLEM: If vector contains resources, they're lost
public fun lose_resources(items: vector<Spell>) {
    // If Spell contains resources, and we just return without processing,
    // those resources are destroyed!
}

// ✅ BETTER: Explicitly handle all elements
public fn process_all_resources(items: vector<Spell>) {
    while (!vector::is_empty(&items)) {
        let spell = vector::pop_back(&mut items);
        // Process spell
    }
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Basic Vector Operations 📦

**Scenario:** Create a spell inventory system using vectors.

**Boilerplate Code:**

```move
module spell_library::vector_basics {
    use std::vector;

    struct Spell {
        name: vector<u8>,
        power: u64
    }

    public fun create_inventory(): vector<Spell> {
        // TODO: Create empty vector
        let spells = ____;
        spells
    }

    public fun add_spell(
        inventory: &mut vector<Spell>,
        name: vector<u8>,
        power: u64
    ) {
        // TODO: Create spell and push to inventory
        let spell = Spell { name, power };
        ____
    }

    public fun get_spell_power(
        inventory: &vector<Spell>,
        index: u64
    ): u64 {
        // TODO: Borrow spell at index and return power
        let spell = ____;
        spell.power
    }

    public fun total_power(inventory: &vector<Spell>): u64 {
        // TODO: Sum all spell powers using while loop
        let mut total = 0u64;
        let mut i = 0;

        while (____) {
            total = total + ____.power;
            i = i + 1;
        };

        total
    }

    public fun test_inventory() {
        let mut inventory = create_inventory();

        add_spell(&mut inventory, b"Fireball", 100);
        add_spell(&mut inventory, b"Icebolt", 80);
        add_spell(&mut inventory, b"Lightning", 120);

        assert!(vector::length(&inventory) == 3, 1);
        assert!(get_spell_power(&inventory, 0) == 100, 2);
        assert!(total_power(&inventory) == 300, 3);
    }
}
```

**Your Task:**

1. Implement `create_inventory` with empty vector
2. Implement `add_spell` with push_back
3. Implement `get_spell_power` using borrow
4. Implement `total_power` with while loop
5. Verify inventory operations work correctly

---

### Exercise 2: Vector Modification and Swapping 🔄

**Scenario:** Manage spell inventory with advanced operations.

**Boilerplate Code:**

```move
module spell_library::vector_operations {
    use std::vector;

    public fun remove_weakest(spells: &mut vector<u64>) {
        // TODO: Find weakest spell and remove it
        if (vector::is_empty(spells)) {
            return;
        };

        let mut weakest_index = 0;
        let mut weakest_power = *vector::borrow(spells, 0);
        let mut i = 1;

        while (i < vector::length(spells)) {
            let current = *vector::borrow(spells, i);
            if (current < weakest_power) {
                weakest_power = current;
                weakest_index = i;
            };
            i = i + 1;
        };

        // Swap weakest to end and pop
        let len = vector::length(spells);
        vector::swap(spells, weakest_index, len - 1);
        vector::pop_back(spells);
    }

    public fun swap_strongest_first(spells: &mut vector<u64>) {
        // TODO: Move strongest spell to front
        if (vector::is_empty(spells)) {
            return;
        };

        let mut strongest_index = 0;
        let mut strongest_power = *vector::borrow(spells, 0);
        let mut i = 1;

        while (i < vector::length(spells)) {
            let current = *vector::borrow(spells, i);
            if (current > ____) {
                strongest_power = current;
                strongest_index = i;
            };
            i = i + 1;
        };

        // Swap to front
        if (strongest_index != 0) {
            vector::swap(spells, strongest_index, 0);
        }
    }

    public fun sum_top_n(spells: &vector<u64>, n: u64): u64 {
        // TODO: Sum the n strongest spells
        let mut copy = ____;  // Copy vector for sorting
        let mut i = 0;

        // Bubble sort (simple for learning)
        while (i < vector::length(&copy)) {
            swap_strongest_first(&mut copy);
            i = i + 1;
        };

        // Sum first n
        let mut sum = 0u64;
        let mut j = 0;
        while (j < n && j < vector::length(&copy)) {
            sum = sum + *vector::borrow(&copy, j);
            j = j + 1;
        };

        sum
    }

    public fun test_operations() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, 50u64);
        vector::push_back(&mut spells, 100u64);
        vector::push_back(&mut spells, 75u64);

        remove_weakest(&mut spells);
        assert!(vector::length(&spells) == 2, 1);

        let mut spells2 = vector::empty();
        vector::push_back(&mut spells2, 30u64);
        vector::push_back(&mut spells2, 90u64);
        vector::push_back(&mut spells2, 60u64);

        swap_strongest_first(&mut spells2);
        assert!(*vector::borrow(&spells2, 0) == 90, 2);
    }
}
```

**Your Task:**

1. Find and remove the weakest spell using swap/pop
2. Move strongest spell to front using swap
3. Sum the top n spells (after sorting concept)
4. Handle edge cases (empty vectors)

---

### Exercise 3: Generic Collections and Safety 🎯

**Scenario:** Build a generic collection handler that works with multiple types.

**Boilerplate Code:**

```move
module spell_library::generic_collections {
    use std::vector;
    use std::option::{self, Option};

    public fun find_value<T: drop + copy>(
        collection: &vector<T>,
        target: T
    ): Option<u64> {
        // TODO: Find index of target in collection
        let mut i = 0;

        while (i < vector::length(collection)) {
            if (*vector::borrow(collection, i) == target) {
                return option::some(i);
            };
            i = i + 1;
        };

        option::none()
    }

    public fun filter_and_collect<T: drop + copy>(
        source: &vector<T>,
        predicate: |&T| bool
    ): vector<T> {
        // TODO: Collect elements matching predicate
        let mut result = vector::empty();
        let mut i = 0;

        while (i < vector::length(source)) {
            let element = vector::borrow(source, i);
            if (predicate(element)) {
                vector::push_back(&mut result, *element);
            };
            i = i + 1;
        };

        result
    }

    public fun reverse_vector<T: drop + copy>(
        source: &vector<T>
    ): vector<T> {
        // TODO: Create reversed copy of vector
        let mut result = vector::empty();

        if (!vector::is_empty(source)) {
            let len = vector::length(source);
            let mut i = len;

            while (i > 0) {
                i = i - 1;
                vector::push_back(
                    &mut result,
                    *vector::borrow(source, i)
                );
            };
        };

        result
    }

    public fun test_generics() {
        // Test with u64
        let numbers = vector[10u64, 20u64, 30u64];
        let found = find_value(&numbers, 20u64);
        assert!(option::is_some(&found), 1);

        // Test with boolean predicate
        let large = filter_and_collect(&numbers, |x| { *x > 15 });
        assert!(vector::length(&large) == 2, 2);

        // Test reverse
        let reversed = reverse_vector(&numbers);
        assert!(*vector::borrow(&reversed, 0) == 30, 3);
    }
}
```

**Your Task:**

1. Implement generic `find_value` for any copyable type
2. Implement `filter_and_collect` with closure predicates
3. Implement `reverse_vector` safely
4. Verify generics work across different types

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::vector_basics {
    use std::vector;

    struct Spell {
        name: vector<u8>,
        power: u64
    }

    public fun create_inventory(): vector<Spell> {
        vector::empty()
    }

    public fun add_spell(
        inventory: &mut vector<Spell>,
        name: vector<u8>,
        power: u64
    ) {
        let spell = Spell { name, power };
        vector::push_back(inventory, spell);
    }

    public fun get_spell_power(
        inventory: &vector<Spell>,
        index: u64
    ): u64 {
        let spell = vector::borrow(inventory, index);
        spell.power
    }

    public fun total_power(inventory: &vector<Spell>): u64 {
        let mut total = 0u64;
        let mut i = 0;

        while (i < vector::length(inventory)) {
            total = total + vector::borrow(inventory, i).power;
            i = i + 1;
        };

        total
    }

    public fun test_inventory() {
        let mut inventory = create_inventory();

        add_spell(&mut inventory, b"Fireball", 100);
        add_spell(&mut inventory, b"Icebolt", 80);
        add_spell(&mut inventory, b"Lightning", 120);

        assert!(vector::length(&inventory) == 3, 1);
        assert!(get_spell_power(&inventory, 0) == 100, 2);
        assert!(total_power(&inventory) == 300, 3);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::vector_operations {
    use std::vector;

    public fun remove_weakest(spells: &mut vector<u64>) {
        if (vector::is_empty(spells)) {
            return;
        };

        let mut weakest_index = 0;
        let mut weakest_power = *vector::borrow(spells, 0);
        let mut i = 1;

        while (i < vector::length(spells)) {
            let current = *vector::borrow(spells, i);
            if (current < weakest_power) {
                weakest_power = current;
                weakest_index = i;
            };
            i = i + 1;
        };

        let len = vector::length(spells);
        vector::swap(spells, weakest_index, len - 1);
        vector::pop_back(spells);
    }

    public fun swap_strongest_first(spells: &mut vector<u64>) {
        if (vector::is_empty(spells)) {
            return;
        };

        let mut strongest_index = 0;
        let mut strongest_power = *vector::borrow(spells, 0);
        let mut i = 1;

        while (i < vector::length(spells)) {
            let current = *vector::borrow(spells, i);
            if (current > strongest_power) {
                strongest_power = current;
                strongest_index = i;
            };
            i = i + 1;
        };

        if (strongest_index != 0) {
            vector::swap(spells, strongest_index, 0);
        }
    }

    public fun sum_top_n(spells: &vector<u64>, n: u64): u64 {
        let mut copy = *spells;

        let mut i = 0;
        while (i < vector::length(&copy)) {
            swap_strongest_first(&mut copy);
            i = i + 1;
        };

        let mut sum = 0u64;
        let mut j = 0;
        while (j < n && j < vector::length(&copy)) {
            sum = sum + *vector::borrow(&copy, j);
            j = j + 1;
        };

        sum
    }

    public fun test_operations() {
        let mut spells = vector::empty();
        vector::push_back(&mut spells, 50u64);
        vector::push_back(&mut spells, 100u64);
        vector::push_back(&mut spells, 75u64);

        remove_weakest(&mut spells);
        assert!(vector::length(&spells) == 2, 1);

        let mut spells2 = vector::empty();
        vector::push_back(&mut spells2, 30u64);
        vector::push_back(&mut spells2, 90u64);
        vector::push_back(&mut spells2, 60u64);

        swap_strongest_first(&mut spells2);
        assert!(*vector::borrow(&spells2, 0) == 90, 2);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::generic_collections {
    use std::vector;
    use std::option::{self, Option};

    public fun find_value<T: drop + copy>(
        collection: &vector<T>,
        target: T
    ): Option<u64> {
        let mut i = 0;

        while (i < vector::length(collection)) {
            if (*vector::borrow(collection, i) == target) {
                return option::some(i);
            };
            i = i + 1;
        };

        option::none()
    }

    public fun filter_and_collect<T: drop + copy>(
        source: &vector<T>,
        predicate: |&T| bool
    ): vector<T> {
        let mut result = vector::empty();
        let mut i = 0;

        while (i < vector::length(source)) {
            let element = vector::borrow(source, i);
            if (predicate(element)) {
                vector::push_back(&mut result, *element);
            };
            i = i + 1;
        };

        result
    }

    public fun reverse_vector<T: drop + copy>(
        source: &vector<T>
    ): vector<T> {
        let mut result = vector::empty();

        if (!vector::is_empty(source)) {
            let len = vector::length(source);
            let mut i = len;

            while (i > 0) {
                i = i - 1;
                vector::push_back(
                    &mut result,
                    *vector::borrow(source, i)
                );
            };
        };

        result
    }

    public fun test_generics() {
        let numbers = vector[10u64, 20u64, 30u64];
        let found = find_value(&numbers, 20u64);
        assert!(option::is_some(&found), 1);

        let large = filter_and_collect(&numbers, |x| { *x > 15 });
        assert!(vector::length(&large) == 2, 2);

        let reversed = reverse_vector(&numbers);
        assert!(*vector::borrow(&reversed, 0) == 30, 3);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Basic Operations

**Vector initialization:**

```move
let spells: vector<Spell> = vector::empty();  // Type-explicit empty
```

**Push maintains ownership:**

```move
vector::push_back(&mut inventory, spell);  // Spell moves into vector
// spell is now owned by inventory
```

**Borrowing to read:**

```move
let spell = vector::borrow(inventory, i);  // Reference, not copy
spell.power  // Access through reference
```

### Exercise 2 Explanation: Modification

**Finding min/max with single pass:**

```move
while (i < length) {
    if (element < weakest) {
        weakest = element;
        index = i;
    };
    i = i + 1;
}
// O(n) to find, efficient single pass
```

**Swap and pop pattern:**

```move
vector::swap(vec, index, len - 1);  // Move target to end
vector::pop_back(vec);               // Remove from end
// Efficient removal without preserving order
```

### Exercise 3 Explanation: Generics

**Type parameters with bounds:**

```move
<T: drop + copy>  // T must be copyable
// Ensures we can read without moving
```

**Closures as predicates:**

```move
filter_and_collect(&vec, |x| { *x > threshold })
// Flexible filtering logic
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::collection_tests {
    use spell_library::vector_basics;
    use spell_library::vector_operations;
    use spell_library::generic_collections;
    use std::vector;
    use std::option;

    #[test]
    fun test_basic_operations() {
        vector_basics::test_inventory();
    }

    #[test]
    fun test_vector_modification() {
        vector_operations::test_operations();
    }

    #[test]
    fun test_generic_operations() {
        generic_collections::test_generics();
    }

    #[test]
    fun test_empty_vector_safety() {
        let empty: vector<u64> = vector::empty();
        assert!(vector::is_empty(&empty), 1);
        assert!(vector::length(&empty) == 0, 2);
    }

    #[test]
    fun test_vector_append() {
        let mut vec1 = vector::empty();
        vector::push_back(&mut vec1, 1u64);

        let mut vec2 = vector::empty();
        vector::push_back(&mut vec2, 2u64);

        vector::append(&mut vec1, vec2);
        assert!(vector::length(&vec1) == 2, 1);
    }

    #[test]
    fun test_vector_contains_pattern() {
        let mut vec = vector::empty();
        vector::push_back(&mut vec, 10u64);
        vector::push_back(&mut vec, 20u64);

        let found = generic_collections::find_value(&vec, 20u64);
        assert!(option::is_some(&found), 1);

        let not_found = generic_collections::find_value(&vec, 99u64);
        assert!(option::is_none(&not_found), 2);
    }

    #[test]
    fun test_vector_reverse_preserves_length() {
        let original = vector[1u64, 2u64, 3u64, 4u64, 5u64];
        let reversed = generic_collections::reverse_vector(&original);

        assert!(vector::length(&reversed) == vector::length(&original), 1);
        assert!(*vector::borrow(&reversed, 0) == 5, 2);
        assert!(*vector::borrow(&reversed, 4) == 1, 3);
    }
}
```

---

## 🌟 Closing Story

Keeper Soreth smiles as Odessa expertly organizes the crystalline vessels, each collection precisely sized, each operation intentional, each pattern proven safe.

> "You understand now," Soreth says, the archive glowing with orderly light. "Collections are powerful precisely because they are constrained. A vector promises O(1) access but O(n) search. It consumes heap but ensures type safety. It allows growth but demands responsibility."

> "Many programmers stumble here, creating vectors that grow unbounded, searching linearly through millions of elements, cloning collections carelessly. You won't make these mistakes. You understand the cost of your choices."

The librarian gestures to the final chamber in the archive.

> "But even the most perfect collection can encounter problems. What happens when an operation fails? What if a spell can't be cast? What if a resource doesn't exist? These are not suggestions for handling failure—they are absolute requirements. Next, we must teach you how to write code that fails gracefully, that handles the impossible."

> "Error handling is not optional. It is the final frontier of robust programming."

The archive shimmers, ready for the ultimate lesson.

---

**Next Lesson Preview:** 🚫 _Error Handling and Aborts: The Ultimate Safety Net_

- Abort codes and assertions
- Common error patterns and recovery
- Defensive programming strategies
- Error boundaries and propagation
- Building systems that never crash unexpectedly

_The path to mastery is clear. Are you ready to handle the errors you'll inevitably face?_
