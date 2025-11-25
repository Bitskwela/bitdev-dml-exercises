## Background Story

Odessa stands in the Testing Chamber—a vast hall where every spell must prove itself before entering the guild vault. At the center stands Master Veritas, the Guardian of Quality, her form shimmering with countless test cases running simultaneously.

"Every module you write will be used by others," Veritas says, her voice echoing with certainty. "How do you know your code works? How do you prove it handles edge cases? How do you ensure refactoring doesn't break existing functionality?"

The master gestures, and holographic test results fill the air—thousands of assertions, all passing in perfect harmony.

"In traditional development, testing is optional. Developers write code, ship it, and hope it works. When bugs appear in production, users suffer. Money is lost. Trust is broken."

Veritas's eyes glow with intensity.

"In Move, testing is not optional—it's discipline. Every function must be tested. Every edge case must be validated. Every invariant must be proven. The blockchain is unforgiving. There are no rollbacks. There are no patches. Code deployed is permanent."

She summons a glowing test suite before Odessa.

"Today, you learn the art of verification. You'll write tests that prove your code correct. You'll use assertions to validate behavior. You'll discover bugs before they reach production. By the time we're done, you won't just write code—you'll write _provably correct_ code."

The chamber brightens with the light of a thousand passing tests.

"Let's begin."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Native Move Testing Syntax**

Move has built-in testing support. You don't need external frameworks—testing is part of the language itself.

**What is a test in Move?**

A test is a function marked with `#[test]`. When you run tests, Move executes all functions with this attribute and reports which pass or fail.

```move
module spell_library::basic_tests {
    #[test]
    fun test_simple_addition() {
        let result = 2 + 2;
        assert!(result == 4, 1);
        // If we reach this point, test passed
    }

    #[test]
    fun test_another_case() {
        let x = 10;
        let y = 20;
        assert!(x < y, 2);
    }
}
```

**How tests work:**

1. Compiler finds all functions with `#[test]` attribute
2. Each test runs in isolation (independent execution)
3. If test completes without aborting → **PASS** ✅
4. If test aborts (assertion fails) → **FAIL** ❌

**Test isolation—why it matters:**

Each test runs independently. State from one test doesn't affect another. This means:

- Tests can run in any order
- Parallel execution is possible
- Failures don't cascade

```move
#[test]
fun test_isolated_1() {
    let mut x = 10;
    x = x + 5;
    assert!(x == 15, 1);
}

#[test]
fun test_isolated_2() {
    let mut x = 10;  // Same variable name, but different test—no conflict
    x = x * 2;
    assert!(x == 20, 2);
}
```

**The #[test_only] attribute:**

Sometimes you need helper code that's only used in tests. Mark it with `#[test_only]`:

```move
module spell_library::helpers {
    #[test_only]
    public fun create_test_spell(): u64 {
        // This function only exists during testing
        // Production code can't call it
        50
    }

    #[test]
    fun test_using_helper() {
        let power = create_test_spell();
        assert!(power == 50, 1);
    }
}
```

**Why use #[test_only]?**

- Keeps test code separate from production code
- Test helpers don't bloat production deployment
- Clear boundary between testing and production

**Test modules—organizing tests:**

You can create entire modules just for testing:

```move
module spell_library::spells {
    public fun calculate_damage(power: u64, level: u64): u64 {
        power * level
    }
}

#[test_only]
module spell_library::spells_tests {
    use spell_library::spells;

    #[test]
    fun test_damage_calculation() {
        let damage = spells::calculate_damage(10, 5);
        assert!(damage == 50, 1);
    }

    #[test]
    fun test_zero_power() {
        let damage = spells::calculate_damage(0, 100);
        assert!(damage == 0, 2);
    }
}
```

### 2️⃣ **Assertions: The Heart of Testing**

Assertions are how you verify behavior. If an assertion fails, the test fails.

**Basic assertion syntax:**

```move
assert!(condition, error_code);
```

If `condition` is false, test aborts with `error_code`.

**What makes a good assertion?**

1. **Specific**: Test one thing at a time
2. **Clear**: Error code tells you what failed
3. **Complete**: Cover all important cases

```move
#[test]
fun test_good_assertions() {
    let result = compute_something();

    // ✅ GOOD: Specific assertions
    assert!(result > 0, 1);        // Error 1: result should be positive
    assert!(result < 1000, 2);     // Error 2: result should be bounded
    assert!(result % 2 == 0, 3);   // Error 3: result should be even
}

#[test]
fun test_bad_assertions() {
    let result = compute_something();

    // ❌ BAD: Combined assertion
    assert!(result > 0 && result < 1000 && result % 2 == 0, 1);
    // If this fails, which condition failed? Can't tell!
}
```

**Testing expected failures:**

Sometimes you WANT a function to abort. Use `#[expected_failure]`:

```move
public fun divide(a: u64, b: u64): u64 {
    assert!(b != 0, 100);  // Must not divide by zero
    a / b
}

#[test]
#[expected_failure]
fun test_division_by_zero_fails() {
    divide(10, 0);  // Should abort with code 100
    // Test passes if function aborts
}

#[test]
#[expected_failure(abort_code = 100)]
fun test_specific_abort_code() {
    divide(10, 0);  // Must abort with EXACTLY code 100
}
```

**Why test failures?**

Negative tests validate error handling:

- Does code reject invalid input?
- Does code enforce invariants?
- Does code protect against edge cases?

**Assertion patterns:**

```move
#[test]
fun test_comprehensive() {
    // Pattern 1: Boundary testing
    assert!(function(0) == expected_zero_case, 1);
    assert!(function(1) == expected_min_case, 2);
    assert!(function(MAX_VALUE) == expected_max_case, 3);

    // Pattern 2: Invariant checking
    let result = complex_function();
    assert!(result.field1 <= result.field2, 4);  // Invariant maintained

    // Pattern 3: State validation
    let mut state = create_state();
    modify_state(&mut state);
    assert!(is_valid_state(&state), 5);
}
```

### 3️⃣ **Test Helpers: Building Test Infrastructure**

Test helpers are reusable functions that make tests cleaner and more maintainable.

**What are test helpers?**

Functions that:

- Set up common test scenarios
- Create test data
- Validate complex conditions
- Reduce code duplication

```move
#[test_only]
module spell_library::test_helpers {
    struct TestSpell {
        power: u64,
        level: u64
    }

    // Helper: Create test spell
    public fun create_test_spell(power: u64, level: u64): TestSpell {
        TestSpell { power, level }
    }

    // Helper: Validate spell invariants
    public fun assert_valid_spell(spell: &TestSpell) {
        assert!(spell.power > 0, 1);
        assert!(spell.power <= 100, 2);
        assert!(spell.level > 0, 3);
        assert!(spell.level <= 10, 4);
    }

    // Helper: Create pre-configured test data
    public fun create_weak_spell(): TestSpell {
        TestSpell { power: 10, level: 1 }
    }

    public fun create_strong_spell(): TestSpell {
        TestSpell { power: 90, level: 9 }
    }
}

// Using helpers in tests
#[test_only]
module spell_library::combat_tests {
    use spell_library::test_helpers;

    #[test]
    fun test_weak_spell() {
        let spell = test_helpers::create_weak_spell();
        test_helpers::assert_valid_spell(&spell);

        // Test specific behavior
        assert!(spell.power == 10, 1);
    }

    #[test]
    fun test_strong_spell() {
        let spell = test_helpers::create_strong_spell();
        test_helpers::assert_valid_spell(&spell);

        assert!(spell.power == 90, 1);
    }
}
```

**Helper pattern: Setup functions**

```move
#[test_only]
public fun setup_test_environment(): (u64, u64, u64) {
    let balance = 1000;
    let rate = 5;
    let time = 100;
    (balance, rate, time)
}

#[test]
fun test_with_setup() {
    let (balance, rate, time) = setup_test_environment();

    let interest = calculate_interest(balance, rate, time);
    assert!(interest == 500, 1);
}
```

**Helper pattern: Assertion wrappers**

```move
#[test_only]
public fun assert_in_range(value: u64, min: u64, max: u64, error: u64) {
    assert!(value >= min, error);
    assert!(value <= max, error + 1);
}

#[test]
fun test_with_helper_assertion() {
    let result = compute_value();
    assert_in_range(result, 10, 100, 50);
    // Cleaner than two separate assertions
}
```

**Helper pattern: Mock data generators**

```move
#[test_only]
use std::vector;

#[test_only]
public fun create_test_vector_u64(size: u64): vector<u64> {
    let mut vec = vector::empty<u64>();
    let mut i = 0;

    while (i < size) {
        vector::push_back(&mut vec, i * 10);
        i = i + 1;
    };

    vec
}

#[test]
fun test_vector_operations() {
    let vec = create_test_vector_u64(5);
    // vec now contains [0, 10, 20, 30, 40]

    assert!(vector::length(&vec) == 5, 1);
    assert!(*vector::borrow(&vec, 2) == 20, 2);
}
```

### 4️⃣ **Property-Based Testing Introduction**

Property-based testing validates that certain properties ALWAYS hold, regardless of input.

**What is a property?**

A property is a statement that should be true for ALL valid inputs.

Example properties:

- Adding zero doesn't change a number: `x + 0 == x`
- Reversing a list twice gives original: `reverse(reverse(list)) == list`
- Multiplying by zero always gives zero: `x * 0 == 0`

**Traditional testing vs property-based testing:**

Traditional (example-based):

```move
#[test]
fun test_addition() {
    assert!(2 + 3 == 5, 1);
    assert!(10 + 20 == 30, 2);
    assert!(100 + 200 == 300, 3);
    // Tests specific cases
}
```

Property-based (conceptual):

```move
#[test]
fun test_addition_properties() {
    // Property 1: Commutative
    // For ALL x, y: x + y == y + x

    // Property 2: Identity
    // For ALL x: x + 0 == x

    // Property 3: Associative
    // For ALL x, y, z: (x + y) + z == x + (y + z)
}
```

**Implementing property tests in Move:**

Move doesn't have built-in property testing (like QuickCheck), but you can test properties manually:

```move
#[test]
fun test_commutative_property() {
    // Test property with multiple values
    let pairs = vector[
        (2u64, 3u64),
        (10u64, 20u64),
        (100u64, 200u64),
        (5u64, 15u64)
    ];

    let mut i = 0;
    while (i < vector::length(&pairs)) {
        let (a, b) = *vector::borrow(&pairs, i);
        assert!(add(a, b) == add(b, a), i);  // Commutative property
        i = i + 1;
    };
}

#[test]
fun test_identity_property() {
    let values = vector[0u64, 1, 10, 100, 1000];

    let mut i = 0;
    while (i < vector::length(&values)) {
        let x = *vector::borrow(&values, i);
        assert!(add(x, 0) == x, i);  // Identity property
        i = i + 1;
    };
}
```

**Property: Invariants must hold after operations**

```move
struct BankAccount {
    balance: u64,
    locked: u64  // Invariant: locked <= balance
}

#[test_only]
public fun check_invariant(account: &BankAccount): bool {
    account.locked <= account.balance
}

#[test]
fun test_withdraw_maintains_invariant() {
    let mut account = BankAccount { balance: 1000, locked: 200 };

    // Property: Invariant holds after withdrawal
    withdraw(&mut account, 100);
    assert!(check_invariant(&account), 1);

    withdraw(&mut account, 300);
    assert!(check_invariant(&account), 2);

    withdraw(&mut account, 400);
    assert!(check_invariant(&account), 3);
}
```

**Property: Round-trip transformations**

```move
#[test]
fun test_encode_decode_roundtrip() {
    let original = create_data(42);
    let encoded = encode(original);
    let decoded = decode(encoded);

    // Property: Decode(Encode(x)) == x
    assert!(decoded == original, 1);
}

#[test]
fun test_multiple_roundtrips() {
    let values = vector[0u64, 1, 10, 100, 1000];

    let mut i = 0;
    while (i < vector::length(&values)) {
        let val = *vector::borrow(&values, i);
        let data = create_data(val);
        let encoded = encode(data);
        let decoded = decode(encoded);

        assert!(decoded.value == val, i);
        i = i + 1;
    };
}
```

### 5️⃣ **Test Organization and Best Practices**

How you organize tests matters as much as what you test.

**Pattern 1: One test per behavior**

```move
// ✅ GOOD: Each test validates one behavior
#[test]
fun test_deposit_increases_balance() {
    let mut account = create_account(100);
    deposit(&mut account, 50);
    assert!(account.balance == 150, 1);
}

#[test]
fun test_withdraw_decreases_balance() {
    let mut account = create_account(100);
    withdraw(&mut account, 30);
    assert!(account.balance == 70, 1);
}

#[test]
fun test_withdraw_insufficient_funds_fails() {
    let mut account = create_account(100);
    // Should fail
}

// ❌ BAD: One test doing too much
#[test]
fun test_everything() {
    let mut account = create_account(100);
    deposit(&mut account, 50);
    assert!(account.balance == 150, 1);
    withdraw(&mut account, 30);
    assert!(account.balance == 120, 2);
    // If second assertion fails, we don't know which operation broke
}
```

**Pattern 2: Test naming conventions**

Use descriptive names that explain what's being tested:

```move
#[test]
fun test_transfer_with_sufficient_balance_succeeds() { }

#[test]
fun test_transfer_with_insufficient_balance_fails() { }

#[test]
fun test_transfer_to_self_is_noop() { }

#[test]
fun test_transfer_zero_amount_is_noop() { }
```

**Pattern 3: Arrange-Act-Assert structure**

```move
#[test]
fun test_structured() {
    // ARRANGE: Set up test data
    let mut account = create_account(1000);
    let amount = 300;

    // ACT: Perform the operation
    withdraw(&mut account, amount);

    // ASSERT: Verify the result
    assert!(account.balance == 700, 1);
}
```

**Pattern 4: Test edge cases**

```move
#[test]
fun test_empty_vector() {
    let vec = vector::empty<u64>();
    assert!(vector::length(&vec) == 0, 1);
}

#[test]
fun test_single_element_vector() {
    let mut vec = vector::empty<u64>();
    vector::push_back(&mut vec, 42);
    assert!(vector::length(&vec) == 1, 1);
}

#[test]
fun test_maximum_capacity() {
    // Test at boundary
}

#[test]
fun test_zero_values() {
    let result = compute(0, 0);
    // Validate zero handling
}
```

**Pattern 5: Test groups by feature**

```move
#[test_only]
module spell_library::transfer_tests {
    // All transfer-related tests
    #[test]
    fun test_transfer_basic() { }

    #[test]
    fun test_transfer_insufficient_funds() { }

    #[test]
    fun test_transfer_to_self() { }
}

#[test_only]
module spell_library::balance_tests {
    // All balance-related tests
    #[test]
    fun test_initial_balance() { }

    #[test]
    fun test_balance_after_deposit() { }
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Basic Test Suite 🧪

**Scenario:** Create a comprehensive test suite for a spell power calculator.

**Boilerplate Code:**

```move
module spell_library::power_calculator {
    const INVALID_LEVEL: u64 = 100;
    const OVERFLOW_ERROR: u64 = 101;

    public fun calculate_power(base: u64, level: u64): u64 {
        assert!(level > 0, INVALID_LEVEL);
        assert!(base * level > base, OVERFLOW_ERROR);
        base * level
    }

    public fun boost_power(power: u64, boost_percent: u64): u64 {
        assert!(boost_percent <= 100, 200);
        power + (power * boost_percent / 100)
    }
}

#[test_only]
module spell_library::power_calculator_tests {
    use spell_library::power_calculator;

    #[test]
    fun test_basic_calculation() {
        // TODO: Test calculate_power(10, 5) == 50
        let result = power_calculator::calculate_power(____, ____);
        assert!(result == ____, 1);
    }

    #[test]
    fun test_boost_calculation() {
        // TODO: Test boost_power(100, 50) == 150
        let result = power_calculator::boost_power(____, ____);
        assert!(result == ____, 2);
    }

    #[test]
    #[expected_failure(abort_code = ____)]
    fun test_invalid_level_fails() {
        // TODO: Test that level 0 fails
        power_calculator::calculate_power(10, ____);
    }

    #[test]
    fun test_boost_at_max_percent() {
        // TODO: Test boost_power(100, 100) doubles value
        let result = power_calculator::boost_power(100, ____);
        assert!(result == ____, 4);
    }

    #[test]
    fun test_no_boost() {
        // TODO: Test boost_power(100, 0) returns same value
        let result = power_calculator::boost_power(____, 0);
        assert!(result == 100, 5);
    }
}
```

**Your Task:**

1. Complete basic calculation test
2. Complete boost calculation test
3. Fill in expected failure test
4. Test maximum boost percentage
5. Test zero boost (identity property)

---

### Exercise 2: Test Helpers and Organization 🏗️

**Scenario:** Build reusable test infrastructure for inventory testing.

**Boilerplate Code:**

```move
module spell_library::inventory {
    use std::vector;

    struct Inventory {
        items: vector<u64>,
        capacity: u64
    }

    public fun create(capacity: u64): Inventory {
        assert!(capacity > 0, 1);
        Inventory {
            items: vector::empty(),
            capacity
        }
    }

    public fun add_item(inv: &mut Inventory, item: u64) {
        assert!(vector::length(&inv.items) < inv.capacity, 2);
        vector::push_back(&mut inv.items, item);
    }

    public fun remove_item(inv: &mut Inventory, index: u64): u64 {
        assert!(index < vector::length(&inv.items), 3);
        let len = vector::length(&inv.items);
        vector::swap(&mut inv.items, index, len - 1);
        vector::pop_back(&mut inv.items)
    }

    public fun size(inv: &Inventory): u64 {
        vector::length(&inv.items)
    }
}

#[test_only]
module spell_library::inventory_test_helpers {
    use spell_library::inventory;
    use std::vector;

    // TODO: Create helper to set up test inventory with items
    public fun create_test_inventory(capacity: u64, items: vector<u64>): inventory::Inventory {
        let mut inv = inventory::create(capacity);

        let mut i = 0;
        while (i < vector::length(&items)) {
            let item = *vector::borrow(&items, i);
            inventory::add_item(&mut inv, item);
            i = i + 1;
        };

        inv
    }

    // TODO: Create helper to assert inventory state
    public fun assert_inventory_valid(inv: &inventory::Inventory, expected_size: u64) {
        assert!(inventory::size(inv) == expected_size, 100);
    }

    // TODO: Create pre-configured test data
    public fun create_empty_inventory(): inventory::Inventory {
        inventory::create(____)
    }

    public fun create_full_inventory(): inventory::Inventory {
        create_test_inventory(3, vector[10, 20, 30])
    }
}

#[test_only]
module spell_library::inventory_tests {
    use spell_library::inventory;
    use spell_library::inventory_test_helpers as helpers;

    #[test]
    fun test_using_helpers() {
        // TODO: Use helper to create inventory
        let inv = helpers::create_____();
        helpers::assert_inventory_valid(&inv, ____);
    }

    #[test]
    fun test_add_to_inventory() {
        // TODO: Create inventory using helper and add item
        let mut inv = helpers::create_empty_inventory();
        inventory::add_item(&mut inv, ____);
        helpers::assert_inventory_valid(&inv, ____);
    }

    #[test]
    fun test_remove_from_inventory() {
        // TODO: Use full inventory helper
        let mut inv = helpers::create_full_inventory();
        let removed = inventory::remove_item(&mut inv, 0);

        assert!(removed == ____, 1);
        helpers::assert_inventory_valid(&inv, ____);
    }
}
```

**Your Task:**

1. Complete test helper functions
2. Create pre-configured test data helpers
3. Use helpers in tests
4. Validate inventory state with helpers
5. Test all inventory operations

---

### Exercise 3: Property-Based Testing 🔬

**Scenario:** Validate mathematical properties of a calculation system.

**Boilerplate Code:**

```move
module spell_library::calculator {
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    public fun multiply(a: u64, b: u64): u64 {
        a * b
    }

    public fun power_of_two(n: u64): u64 {
        if (n == 0) { 1 }
        else { 2 * power_of_two(n - 1) }
    }
}

#[test_only]
module spell_library::calculator_property_tests {
    use spell_library::calculator;
    use std::vector;

    #[test]
    fun test_addition_commutative() {
        // Property: a + b == b + a
        let pairs = vector[
            (2u64, 3u64),
            (10u64, 20u64),
            (100u64, 5u64)
        ];

        let mut i = 0;
        while (i < vector::length(&pairs)) {
            let (a, b) = *vector::borrow(&pairs, i);

            // TODO: Assert commutative property
            assert!(
                calculator::add(a, b) == calculator::add(____, ____),
                i
            );

            i = i + 1;
        };
    }

    #[test]
    fun test_addition_identity() {
        // Property: x + 0 == x
        let values = vector[0u64, 1, 10, 100];

        let mut i = 0;
        while (i < vector::length(&values)) {
            let x = *vector::borrow(&values, i);

            // TODO: Assert identity property
            assert!(calculator::add(x, ____) == ____, i);

            i = i + 1;
        };
    }

    #[test]
    fun test_multiplication_by_zero() {
        // Property: x * 0 == 0
        let values = vector[0u64, 1, 10, 100, 1000];

        let mut i = 0;
        while (i < vector::length(&values)) {
            let x = *vector::borrow(&values, i);

            // TODO: Assert zero property
            assert!(calculator::multiply(x, 0) == ____, i);

            i = i + 1;
        };
    }

    #[test]
    fun test_power_of_two_doubles() {
        // Property: 2^(n+1) == 2 * 2^n
        let mut n = 0;

        while (n < 10) {
            let current = calculator::power_of_two(n);
            let next = calculator::power_of_two(n + 1);

            // TODO: Assert doubling property
            assert!(next == ____ * current, n);

            n = n + 1;
        };
    }
}
```

**Your Task:**

1. Test commutative property of addition
2. Test identity property (adding zero)
3. Test multiplication by zero
4. Test power-of-two doubling property
5. Validate properties across multiple inputs

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::power_calculator {
    const INVALID_LEVEL: u64 = 100;
    const OVERFLOW_ERROR: u64 = 101;

    public fun calculate_power(base: u64, level: u64): u64 {
        assert!(level > 0, INVALID_LEVEL);
        assert!(base * level > base, OVERFLOW_ERROR);
        base * level
    }

    public fun boost_power(power: u64, boost_percent: u64): u64 {
        assert!(boost_percent <= 100, 200);
        power + (power * boost_percent / 100)
    }
}

#[test_only]
module spell_library::power_calculator_tests {
    use spell_library::power_calculator;

    #[test]
    fun test_basic_calculation() {
        let result = power_calculator::calculate_power(10, 5);
        assert!(result == 50, 1);
    }

    #[test]
    fun test_boost_calculation() {
        let result = power_calculator::boost_power(100, 50);
        assert!(result == 150, 2);
    }

    #[test]
    #[expected_failure(abort_code = 100)]
    fun test_invalid_level_fails() {
        power_calculator::calculate_power(10, 0);
    }

    #[test]
    fun test_boost_at_max_percent() {
        let result = power_calculator::boost_power(100, 100);
        assert!(result == 200, 4);
    }

    #[test]
    fun test_no_boost() {
        let result = power_calculator::boost_power(100, 0);
        assert!(result == 100, 5);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::inventory {
    use std::vector;

    struct Inventory {
        items: vector<u64>,
        capacity: u64
    }

    public fun create(capacity: u64): Inventory {
        assert!(capacity > 0, 1);
        Inventory {
            items: vector::empty(),
            capacity
        }
    }

    public fun add_item(inv: &mut Inventory, item: u64) {
        assert!(vector::length(&inv.items) < inv.capacity, 2);
        vector::push_back(&mut inv.items, item);
    }

    public fun remove_item(inv: &mut Inventory, index: u64): u64 {
        assert!(index < vector::length(&inv.items), 3);
        let len = vector::length(&inv.items);
        vector::swap(&mut inv.items, index, len - 1);
        vector::pop_back(&mut inv.items)
    }

    public fun size(inv: &Inventory): u64 {
        vector::length(&inv.items)
    }
}

#[test_only]
module spell_library::inventory_test_helpers {
    use spell_library::inventory;
    use std::vector;

    public fun create_test_inventory(capacity: u64, items: vector<u64>): inventory::Inventory {
        let mut inv = inventory::create(capacity);

        let mut i = 0;
        while (i < vector::length(&items)) {
            let item = *vector::borrow(&items, i);
            inventory::add_item(&mut inv, item);
            i = i + 1;
        };

        inv
    }

    public fun assert_inventory_valid(inv: &inventory::Inventory, expected_size: u64) {
        assert!(inventory::size(inv) == expected_size, 100);
    }

    public fun create_empty_inventory(): inventory::Inventory {
        inventory::create(10)
    }

    public fun create_full_inventory(): inventory::Inventory {
        create_test_inventory(3, vector[10, 20, 30])
    }
}

#[test_only]
module spell_library::inventory_tests {
    use spell_library::inventory;
    use spell_library::inventory_test_helpers as helpers;

    #[test]
    fun test_using_helpers() {
        let inv = helpers::create_empty_inventory();
        helpers::assert_inventory_valid(&inv, 0);
    }

    #[test]
    fun test_add_to_inventory() {
        let mut inv = helpers::create_empty_inventory();
        inventory::add_item(&mut inv, 42);
        helpers::assert_inventory_valid(&inv, 1);
    }

    #[test]
    fun test_remove_from_inventory() {
        let mut inv = helpers::create_full_inventory();
        let removed = inventory::remove_item(&mut inv, 0);

        assert!(removed == 10, 1);
        helpers::assert_inventory_valid(&inv, 2);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::calculator {
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    public fun multiply(a: u64, b: u64): u64 {
        a * b
    }

    public fun power_of_two(n: u64): u64 {
        if (n == 0) { 1 }
        else { 2 * power_of_two(n - 1) }
    }
}

#[test_only]
module spell_library::calculator_property_tests {
    use spell_library::calculator;
    use std::vector;

    #[test]
    fun test_addition_commutative() {
        let pairs = vector[
            (2u64, 3u64),
            (10u64, 20u64),
            (100u64, 5u64)
        ];

        let mut i = 0;
        while (i < vector::length(&pairs)) {
            let (a, b) = *vector::borrow(&pairs, i);
            assert!(
                calculator::add(a, b) == calculator::add(b, a),
                i
            );
            i = i + 1;
        };
    }

    #[test]
    fun test_addition_identity() {
        let values = vector[0u64, 1, 10, 100];

        let mut i = 0;
        while (i < vector::length(&values)) {
            let x = *vector::borrow(&values, i);
            assert!(calculator::add(x, 0) == x, i);
            i = i + 1;
        };
    }

    #[test]
    fun test_multiplication_by_zero() {
        let values = vector[0u64, 1, 10, 100, 1000];

        let mut i = 0;
        while (i < vector::length(&values)) {
            let x = *vector::borrow(&values, i);
            assert!(calculator::multiply(x, 0) == 0, i);
            i = i + 1;
        };
    }

    #[test]
    fun test_power_of_two_doubles() {
        let mut n = 0;

        while (n < 10) {
            let current = calculator::power_of_two(n);
            let next = calculator::power_of_two(n + 1);
            assert!(next == 2 * current, n);
            n = n + 1;
        };
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Basic Testing

**Test structure follows arrange-act-assert:**

```move
let result = power_calculator::calculate_power(10, 5);  // ACT
assert!(result == 50, 1);                                // ASSERT
```

**Expected failure tests validate error handling:**

```move
#[expected_failure(abort_code = 100)]
// Test EXPECTS function to abort with code 100
```

**Edge cases include identity operations:**

```move
boost_power(100, 0) == 100  // Zero boost returns original
```

### Exercise 2 Explanation: Test Helpers

**Helpers eliminate duplication:**

```move
// Instead of repeating setup in every test:
let mut inv = create(10);
add_item(&mut inv, 10);
add_item(&mut inv, 20);

// Use helper once:
let inv = create_test_inventory(10, vector[10, 20]);
```

**Validation helpers centralize invariant checks:**

```move
public fun assert_inventory_valid(inv: &Inventory, expected_size: u64) {
    assert!(size(inv) == expected_size, 100);
    // Could add more invariant checks here
}
```

### Exercise 3 Explanation: Property Testing

**Properties are universally true statements:**

```move
// Commutative: Order doesn't matter
a + b == b + a

// Identity: Adding zero doesn't change value
x + 0 == x

// Zero: Multiplying by zero always gives zero
x * 0 == 0
```

**Test multiple inputs to validate properties:**

```move
let pairs = vector[(2, 3), (10, 20), (100, 5)];
// If property holds for all pairs, it's validated
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::testing_lesson_tests {
    use spell_library::power_calculator_tests;
    use spell_library::inventory_tests;
    use spell_library::calculator_property_tests;

    #[test]
    fun run_all_power_calculator_tests() {
        power_calculator_tests::test_basic_calculation();
        power_calculator_tests::test_boost_calculation();
        power_calculator_tests::test_boost_at_max_percent();
        power_calculator_tests::test_no_boost();
    }

    #[test]
    fun run_all_inventory_tests() {
        inventory_tests::test_using_helpers();
        inventory_tests::test_add_to_inventory();
        inventory_tests::test_remove_from_inventory();
    }

    #[test]
    fun run_all_property_tests() {
        calculator_property_tests::test_addition_commutative();
        calculator_property_tests::test_addition_identity();
        calculator_property_tests::test_multiplication_by_zero();
        calculator_property_tests::test_power_of_two_doubles();
    }

    #[test]
    #[expected_failure]
    fun verify_failure_tests_work() {
        power_calculator_tests::test_invalid_level_fails();
    }
}
```

---

## 🌟 Closing Story

Master Veritas stands beside Odessa in the Testing Chamber, now filled with the glow of thousands of passing tests. Each assertion green, each property validated, each edge case covered.

> "You understand now," Veritas says, her voice warm with approval. "Testing is not a chore—it's proof. Every test you write is a guarantee to future developers, to users, to yourself. It says: 'This code works. I've proven it.'"

> "When you deploy to the blockchain, there are no second chances. No debugging in production. No hotfixes. The code you ship is permanent. Testing is how you sleep at night knowing your contracts won't drain user funds or violate invariants."

The master gestures to the test suites floating in the air.

> "Look at what you've built: Unit tests that validate individual functions. Integration tests that prove components work together. Property tests that validate mathematical truths. Helpers that make testing maintainable. This is professional-grade infrastructure."

Veritas's form shimmers with satisfaction.

> "Remember these principles: Test one thing at a time. Use descriptive names. Cover edge cases. Validate properties. Build helpers to reduce duplication. Organize tests by feature. Test both success and failure paths."

The chamber's light intensifies.

> "You've mastered the art of verification. Your code is no longer just functional—it's _provably_ correct. You've earned the title of Professional Move Developer."

The guardian bows.

> "Now go. Write code that's tested. Ship contracts that work. Build systems that last. The blockchain awaits your guaranteed-correct creations."

---

**Next Lesson:** Move Standard Library - exploring the tools available to all Move developers.
