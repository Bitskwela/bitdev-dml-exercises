````markdown
# Activity: Building a Type-Safe Data Registry

## Objective

Create a Move module that demonstrates different primitive types, variable declarations, and safe type conversions to build a flexible data registry for MoveStack.

## Scenario

Jaymart looks up from his screen, slightly overwhelmed. "There are so many integer types in Move—u8, u16, u64... When do I use each one?"

Neri pulls her chair over. "Great question. I struggled with that too at first. The key is understanding what each type can hold and choosing the smallest one that fits your needs."

Det joins the conversation, coffee in hand. "Think of it like choosing containers. You wouldn't use a shipping container to carry a lunchbox, right? Same principle—u8 for small counts, u64 for token amounts, u256 for cryptographic values."

"Let's build something practical," Neri suggests. "A data registry that uses different types appropriately. You'll see exactly when each type matters."

## Starter Code

```move
module movestack::type_registry {
    // ============================================
    // TYPE DEMONSTRATIONS
    // ============================================

    // TODO: Create a public function called 'demonstrate_integers'
    // Declare variables of types: u8, u16, u32, u64, u128, u256
    // Assign appropriate values showing each type's range
    // Return the u64 value for testing

    // TODO: Create a public function called 'demonstrate_bool_and_address'
    // Declare a boolean variable set to true
    // Declare an address variable using @0x1 syntax
    // Return the boolean value

    // TODO: Create a public function called 'safe_type_conversion'
    // Take a u8 parameter
    // Safely convert it to u64 using the 'as' keyword
    // Return the u64 result

    // ============================================
    // PRACTICAL APPLICATION
    // ============================================

    // TODO: Create a public function called 'create_user_age'
    // Take a u8 parameter for age (ages fit in 0-255)
    // Return true if age is between 18 and 120 (valid adult)

    // TODO: Create a public function called 'calculate_total_tokens'
    // Take two u64 parameters: balance and bonus
    // Return their sum as u64
    // (In production, you'd check for overflow)
}
```

## Tasks

1. **Demonstrate integer types**

   - Declare variables of each integer type: u8, u16, u32, u64, u128, u256
   - Assign values that showcase each type's typical use case
   - Return the u64 value for verification

2. **Work with bool and address**

   - Create a boolean variable with value `true`
   - Create an address variable using the `@0x1` literal syntax
   - Return the boolean for testing

3. **Implement safe type conversion**
   - Take a `u8` input parameter
   - Convert it safely to `u64` using the `as` keyword
   - This demonstrates upcasting (smaller to larger type)

## Expected Behavior

After completing this activity:

- `demonstrate_integers()` returns a u64 value you assigned
- `demonstrate_bool_and_address()` returns `true`
- `safe_type_conversion(255)` returns `255` as u64
- `create_user_age(25)` returns `true` (valid adult age)
- `create_user_age(10)` returns `false` (not adult)
- `calculate_total_tokens(100, 50)` returns `150`

## Hints

<details>
<summary>Hint 1: Integer type declarations</summary>

Each integer type has a specific size and range:

```move
let small: u8 = 255;           // 0 to 255
let medium: u16 = 65535;       // 0 to 65,535
let standard: u32 = 1000000;   // 0 to ~4 billion
let large: u64 = 1000000000;   // Most common for tokens
let huge: u128 = 1000000000000000;  // For very large values
let massive: u256 = 1;         // For cryptographic values
```

</details>

<details>
<summary>Hint 2: Boolean and address syntax</summary>

Booleans and addresses are straightforward:

```move
let is_active: bool = true;
let admin_address: address = @0x1;
```

</details>

<details>
<summary>Hint 3: Type conversion with 'as'</summary>

Use `as` to convert between integer types (upcast only is safe):

```move
public fun safe_type_conversion(value: u8): u64 {
    (value as u64)
}
```

</details>

<details>
<summary>Hint 4: Boolean logic for age validation</summary>

Use comparison operators and logical AND:

```move
public fun create_user_age(age: u8): bool {
    age >= 18 && age <= 120
}
```

</details>
````
