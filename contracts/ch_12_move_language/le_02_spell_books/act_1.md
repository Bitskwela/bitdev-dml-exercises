# Activity: Building Your First Spell Book Module

## Objective

Create a properly structured Move module that demonstrates module declaration, imports, and the difference between public and private functions.

## Scenario

Ronnie has called the team together in the MoveStack workspace. "Before we build anything complex," he says, spreading architectural diagrams across the table, "we need to understand how Move organizes code. Think of modules as spell books—each one contains related incantations, but they have rules about what's visible to the outside world."

Jaymart leans in, curious. "So it's like how some spells in a book are meant to be shared, while others are secret techniques?"

"Exactly," Neri nods, pulling up her editor. "Public functions are the spells anyone can invoke. Private functions are our internal helpers—they do the work, but outsiders can't call them directly."

Ronnie points to the screen. "Let's build our first spell book module. We'll need a proper address, some imports, and a mix of public and private functions to see how visibility works."

## Starter Code

```move
module movestack::spell_book {
    // TODO: Import the vector module from std
    // Hint: use std::vector;

    // ============================================
    // PRIVATE HELPER FUNCTIONS
    // ============================================

    // TODO: Create a private helper function called 'calculate_power'
    // It should take two u64 parameters: base_power and multiplier
    // Return their product (base_power * multiplier)
    // Remember: functions without 'public' are private by default

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    // TODO: Create a public function called 'create_spell'
    // It should take a u64 parameter: base_power
    // Call the private 'calculate_power' function with base_power and 2
    // Return the result

    // TODO: Create a public function called 'get_spell_list'
    // It should create an empty vector of u64
    // Add three values to it: 10, 20, 30
    // Return the vector
}
```

## Tasks

1. **Add the import statement**

   - Import `std::vector` at the top of the module
   - This gives you access to vector operations like `push_back` and `empty`

2. **Create the private helper function**

   - Define a function `calculate_power` that takes `base_power: u64` and `multiplier: u64`
   - Return the product of these two values
   - Do NOT add `public` keyword—this keeps it private to the module

3. **Create the public functions**
   - Define `public fun create_spell(base_power: u64): u64` that calls `calculate_power`
   - Define `public fun get_spell_list(): vector<u64>` that returns a vector with values 10, 20, 30

## Expected Behavior

After completing this activity:

- The module compiles successfully with proper address and structure
- `create_spell(50)` returns `100` (50 × 2)
- `get_spell_list()` returns a vector containing `[10, 20, 30]`
- External code can call `create_spell` and `get_spell_list`
- External code CANNOT call `calculate_power` directly (it's private)

## Hints

<details>
<summary>Hint 1: Import syntax</summary>

To import a module from the standard library:

```move
use std::vector;
```

This lets you call `vector::empty()`, `vector::push_back()`, etc.

</details>

<details>
<summary>Hint 2: Private function syntax</summary>

Functions without the `public` keyword are private:

```move
fun calculate_power(base_power: u64, multiplier: u64): u64 {
    base_power * multiplier
}
```

Only other functions within `spell_book` can call this.

</details>

<details>
<summary>Hint 3: Working with vectors</summary>

To create and populate a vector:

```move
let mut spells = vector::empty<u64>();
vector::push_back(&mut spells, 10);
vector::push_back(&mut spells, 20);
vector::push_back(&mut spells, 30);
spells  // Return the vector
```

</details>

<details>
<summary>Hint 4: Public function calling private function</summary>

Public functions can freely call private helper functions:

```move
public fun create_spell(base_power: u64): u64 {
    calculate_power(base_power, 2)
}
```

</details>
