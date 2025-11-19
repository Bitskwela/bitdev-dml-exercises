## Background Story

Odessa stands before the Inner Sanctum—a restricted area where only trusted guild members may enter. At the entrance stands Keeper Aurelius, Guardian of Access, his form radiating layers of protective barriers.

"Not all code is public," Aurelius explains, his voice echoing with authority. "Some functions are internal infrastructure. Some modules are private implementation details. But sometimes, you need controlled access—a middle ground between public and private."

The keeper gestures, and architectural diagrams materialize in the air, showing intricate relationships between modules.

"In most languages, you have two levels: public (anyone can call) and private (only within the module). Move adds a third: friend. A friend module has special access—it can call functions that others cannot. This is how you build internal APIs."

Aurelius's eyes glow with intensity.

"Why does this matter? Imagine you're building a token system. You have a core Token module that manages balances. You need a Treasury module that can mint tokens, and a Vesting module that can lock them. But you don't want EVERYONE to call mint—only your trusted modules."

The keeper points to the sanctum's door.

"Friend declarations solve this. You explicitly name which modules can access privileged functions. It's like having a VIP list. Everyone else hits a wall. Only trusted modules get through."

Odessa sees the power in this pattern—controlled access without exposing everything publicly.

"Today, you master encapsulation. You'll learn to build module systems with clear boundaries. Internal APIs that only trusted code can reach. Public interfaces that everyone can use safely. By the end, you'll architect systems like a professional."

The sanctum doors begin to open.

"Enter. Learn the art of controlled access."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Module Imports and Using Other Modules**

Before we dive into friends, let's understand how modules interact in Move.

**What is a module in Move?**

A module is a collection of functions, structs, and constants. It's Move's unit of code organization.

```move
module spell_library::basic_module {
    public fun public_function(): u64 {
        42
    }

    fun internal_function(): u64 {
        100
    }
}
```

**Module naming:**

- Format: `address::module_name`
- Example: `spell_library::basic_module`
- `spell_library` is the address/package
- `basic_module` is the module name

**Using other modules:**

```move
module spell_library::calculator {
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    public fun multiply(a: u64, b: u64): u64 {
        a * b
    }
}

module spell_library::advanced_math {
    use spell_library::calculator;  // Import the module

    public fun compound(a: u64, b: u64): u64 {
        // Use functions from calculator module
        let sum = calculator::add(a, b);
        let product = calculator::multiply(sum, 2);
        product
    }
}
```

**Import styles:**

```move
// Style 1: Full path every time
use spell_library::calculator;
let result = calculator::add(1, 2);

// Style 2: Import specific functions
use spell_library::calculator::add;
let result = add(1, 2);

// Style 3: Import with alias
use spell_library::calculator as calc;
let result = calc::add(1, 2);

// Style 4: Import multiple items
use spell_library::calculator::{add, multiply};
let sum = add(1, 2);
let product = multiply(3, 4);
```

**What can be accessed from other modules?**

```move
module spell_library::access_demo {
    // ✅ PUBLIC: Anyone can call
    public fun anyone_can_call(): u64 { 1 }

    // ❌ PRIVATE: Only this module can call
    fun only_internal(): u64 { 2 }

    // ✅ PUBLIC for reading: Anyone can see, only module can modify
    public fun get_value(): u64 { only_internal() }
}

module spell_library::other_module {
    use spell_library::access_demo;

    public fun test_access() {
        // ✅ Can call public functions
        let x = access_demo::anyone_can_call();

        // ❌ CANNOT call private functions
        // let y = access_demo::only_internal();  // Compile error!
    }
}
```

**Why have private functions?**

1. **Encapsulation**: Hide implementation details
2. **Safety**: Prevent misuse of internal functions
3. **Flexibility**: Change internals without breaking external code

### 2️⃣ **Friend Declarations: Controlled Access**

Friend declarations create a middle tier between public and private.

**What is a friend?**

A friend is a module explicitly granted access to internal functions. It's like a VIP pass.

```move
module spell_library::core {
    // Declare trusted modules
    friend spell_library::treasury;
    friend spell_library::vesting;

    // This struct is NOT public
    struct InternalToken has store {
        amount: u64
    }

    // PUBLIC(friend): Only friends can call
    public(friend) fun mint(amount: u64): InternalToken {
        InternalToken { amount }
    }

    // REGULAR public: Anyone can call
    public fun get_amount(token: &InternalToken): u64 {
        token.amount
    }
}

// Friend module - CAN call mint
module spell_library::treasury {
    use spell_library::core;

    public fun create_tokens(amount: u64): core::InternalToken {
        // ✅ Allowed: treasury is a friend
        core::mint(amount)
    }
}

// Non-friend module - CANNOT call mint
module spell_library::external {
    use spell_library::core;

    public fun try_create(): core::InternalToken {
        // ❌ ERROR: external is not a friend
        // core::mint(100)  // Compile error!
    }
}
```

**Friend declaration syntax:**

```move
module address::my_module {
    friend address::friend_1;
    friend address::friend_2;
    friend address::friend_3;

    // Friend declarations must be at module level (top of module)
}
```

**Rules for friend declarations:**

1. **Must be at module top**: Before any code
2. **Must use full module path**: `address::module_name`
3. **One-way relationship**: If A declares B as friend, B still needs to import A to use it
4. **No circular friends**: A can friend B, B can friend C, but patterns should be carefully designed

**public(friend) functions:**

```move
module spell_library::token {
    friend spell_library::minter;

    struct Token has store {
        amount: u64
    }

    // ✅ Friends can call
    public(friend) fun create(amount: u64): Token {
        Token { amount }
    }

    // ❌ Only this module can call
    fun internal_validation(): bool {
        true
    }

    // ✅ Anyone can call
    public fun balance(token: &Token): u64 {
        token.amount
    }
}
```

**Access levels summary:**

| Visibility           | Who can call             | Use case                         |
| -------------------- | ------------------------ | -------------------------------- |
| `fun` (private)      | Only current module      | Internal implementation          |
| `public(friend) fun` | Friends + current module | Internal API for trusted modules |
| `public fun`         | Everyone                 | Public API                       |

### 3️⃣ **Encapsulation Patterns**

Encapsulation means hiding implementation details and exposing only what's necessary.

**Pattern 1: Internal state with public accessors**

```move
module spell_library::bank_account {
    struct Account has store {
        balance: u64,
        locked: u64  // Implementation detail
    }

    // Constructor (public)
    public fun create(initial: u64): Account {
        Account {
            balance: initial,
            locked: 0
        }
    }

    // Public accessor (read-only)
    public fun get_balance(account: &Account): u64 {
        account.balance
    }

    // Public accessor (read-only)
    public fun get_available(account: &Account): u64 {
        account.balance - account.locked
    }

    // Public mutator (controlled modification)
    public fun deposit(account: &mut Account, amount: u64) {
        account.balance = account.balance + amount;
    }

    // Private helper
    fun is_valid(account: &Account): bool {
        account.locked <= account.balance
    }
}
```

**Why this pattern?**

- Users can't directly modify `balance` or `locked`
- All changes go through controlled functions
- Invariants are maintained (`locked <= balance`)
- Implementation can change without breaking external code

**Pattern 2: Builder pattern with friends**

```move
module spell_library::token_core {
    friend spell_library::token_factory;

    struct Token has store {
        id: u64,
        amount: u64,
        metadata: vector<u8>
    }

    // Only friends can create tokens
    public(friend) fun create(id: u64, amount: u64, metadata: vector<u8>): Token {
        Token { id, amount, metadata }
    }

    // Anyone can read
    public fun get_amount(token: &Token): u64 {
        token.amount
    }
}

module spell_library::token_factory {
    use spell_library::token_core;

    // Public factory function
    public fun create_standard_token(amount: u64): token_core::Token {
        // Factory has special access to create
        token_core::create(
            generate_id(),
            amount,
            b"standard"
        )
    }

    fun generate_id(): u64 {
        // Internal ID generation logic
        12345
    }
}
```

**Pattern 3: Capability pattern**

```move
module spell_library::admin_system {
    // Capability proves you have permission
    struct AdminCap has key, store {}

    struct System has key {
        value: u64
    }

    // Only way to get AdminCap (restricted)
    public fun initialize_admin(): AdminCap {
        AdminCap {}
    }

    // Regular users can read
    public fun get_value(system: &System): u64 {
        system.value
    }

    // Only admin can modify (requires capability)
    public fun update_value(
        _cap: &AdminCap,  // Proves caller has admin rights
        system: &mut System,
        new_value: u64
    ) {
        system.value = new_value;
    }
}
```

**Why capabilities?**

- Explicit permission model
- Transferable (can give AdminCap to someone else)
- Checkable (easy to verify who has permissions)
- Composable (can combine multiple capabilities)

### 4️⃣ **Internal APIs: Building Module Systems**

Internal APIs are functions designed for use by other modules in your system, not end users.

**What is an internal API?**

Functions that:

- Are not meant for direct user calls
- Provide building blocks for higher-level features
- Maintain system invariants
- Are trusted by specific modules

**Example: Multi-tier architecture**

```move
// Layer 1: Core (lowest level)
module spell_library::core {
    friend spell_library::logic;

    struct Resource has store {
        value: u64
    }

    // Internal API: Only logic layer can create
    public(friend) fun create_resource(value: u64): Resource {
        assert!(value > 0, 1);
        Resource { value }
    }

    // Internal API: Only logic layer can destroy
    public(friend) fun destroy_resource(resource: Resource): u64 {
        let Resource { value } = resource;
        value
    }
}

// Layer 2: Logic (middle level)
module spell_library::logic {
    friend spell_library::api;
    use spell_library::core;

    // Internal API: Only api layer can call
    public(friend) fun process(amount: u64): u64 {
        let resource = core::create_resource(amount);
        let value = core::destroy_resource(resource);
        value * 2
    }
}

// Layer 3: API (public level)
module spell_library::api {
    use spell_library::logic;

    // Public API: Anyone can call
    public fun double_value(amount: u64): u64 {
        logic::process(amount)
    }
}
```

**Why multiple layers?**

1. **Separation of concerns**: Each layer has specific responsibility
2. **Maintainability**: Change internals without breaking public API
3. **Security**: Limit what users can directly access
4. **Testing**: Test each layer independently

**Pattern: Registry with controlled access**

```move
module spell_library::registry_core {
    friend spell_library::registry_admin;

    use std::vector;

    struct Registry has key {
        items: vector<u64>
    }

    // Only admin module can add
    public(friend) fun add_item(registry: &mut Registry, item: u64) {
        vector::push_back(&mut registry.items, item);
    }

    // Only admin module can remove
    public(friend) fun remove_item(registry: &mut Registry, index: u64): u64 {
        let len = vector::length(&registry.items);
        vector::swap(&mut registry.items, index, len - 1);
        vector::pop_back(&mut registry.items)
    }

    // Anyone can read
    public fun get_items(registry: &Registry): &vector<u64> {
        &registry.items
    }
}

module spell_library::registry_admin {
    use spell_library::registry_core;

    struct AdminCap has key, store {}

    // Admin functions require capability
    public fun admin_add(
        _cap: &AdminCap,
        registry: &mut registry_core::Registry,
        item: u64
    ) {
        registry_core::add_item(registry, item);
    }

    public fun admin_remove(
        _cap: &AdminCap,
        registry: &mut registry_core::Registry,
        index: u64
    ): u64 {
        registry_core::remove_item(registry, index)
    }
}
```

### 5️⃣ **Best Practices for Module Architecture**

How to structure modules for maintainability and security.

**Principle 1: Minimize public surface**

```move
// ❌ BAD: Everything public
module spell_library::bad_module {
    public fun internal_helper1(): u64 { 1 }
    public fun internal_helper2(): u64 { 2 }
    public fun internal_helper3(): u64 { 3 }
    public fun main_function(): u64 {
        internal_helper1() + internal_helper2() + internal_helper3()
    }
}

// ✅ GOOD: Only necessary functions public
module spell_library::good_module {
    fun internal_helper1(): u64 { 1 }
    fun internal_helper2(): u64 { 2 }
    fun internal_helper3(): u64 { 3 }

    public fun main_function(): u64 {
        internal_helper1() + internal_helper2() + internal_helper3()
    }
}
```

**Principle 2: Use friends for trusted modules only**

```move
// ✅ GOOD: Clear trust relationships
module spell_library::token {
    friend spell_library::minter;  // Only minter can create
    friend spell_library::burner;  // Only burner can destroy

    public(friend) fun create(): Token { ... }
    public(friend) fun destroy(t: Token) { ... }
}
```

**Principle 3: Separate concerns**

```move
// Core data structures
module spell_library::types {
    struct Token has store { amount: u64 }
    public fun create(amount: u64): Token { Token { amount } }
}

// Business logic
module spell_library::operations {
    use spell_library::types;
    public fun transfer(from: &mut types::Token, to: &mut types::Token, amount: u64) {
        // Transfer logic
    }
}

// Public API
module spell_library::api {
    use spell_library::operations;
    public fun safe_transfer(...) {
        // Validation + operations::transfer
    }
}
```

**Principle 4: Document friend relationships**

```move
/// Core token module.
///
/// Friends:
/// - spell_library::minter: Can create new tokens
/// - spell_library::burner: Can destroy tokens
/// - spell_library::admin: Can modify metadata
module spell_library::token {
    friend spell_library::minter;
    friend spell_library::burner;
    friend spell_library::admin;

    // ... implementation
}
```

**Principle 5: Validate at boundaries**

```move
module spell_library::core {
    friend spell_library::trusted;

    // Friend function still validates!
    public(friend) fun create(amount: u64): Token {
        assert!(amount > 0, 1);  // Don't trust friends blindly
        assert!(amount < MAX, 2);
        Token { amount }
    }
}
```

**Why validate even for friends?**

- Friends might have bugs
- Validation documents requirements
- Prevents future mistakes
- Maintains invariants

---

## 🎯 Activity / Exercises

### Exercise 1: Basic Module Structure 🏗️

**Scenario:** Build a counter system with controlled increment access.

**Boilerplate Code:**

```move
module spell_library::counter_core {
    // TODO: Declare counter_admin as friend
    friend spell_library::counter_____;

    struct Counter has store {
        value: u64
    }

    public fun create(): Counter {
        Counter { value: 0 }
    }

    // TODO: Make this friend-only
    public(____) fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    // Anyone can read
    public fun get_value(counter: &Counter): u64 {
        counter.____
    }
}

module spell_library::counter_admin {
    use spell_library::counter_core;

    struct AdminCap has store {}

    public fun create_admin(): AdminCap {
        AdminCap {}
    }

    // Admin function using friend access
    public fun admin_increment(
        _cap: &AdminCap,
        counter: &mut counter_core::Counter
    ) {
        // TODO: Call friend function
        counter_core::____(counter);
    }
}

#[test_only]
module spell_library::counter_tests {
    use spell_library::counter_core;
    use spell_library::counter_admin;

    #[test]
    fun test_counter_creation() {
        let counter = counter_core::create();
        assert!(counter_core::get_value(&counter) == ____, 1);
    }

    #[test]
    fun test_admin_increment() {
        let mut counter = counter_core::create();
        let admin = counter_admin::create_admin();

        counter_admin::admin_increment(&admin, &mut counter);

        assert!(counter_core::get_value(&counter) == ____, 1);
    }
}
```

**Your Task:**

1. Declare friend relationship
2. Make increment friend-only
3. Implement admin increment
4. Complete test assertions
5. Verify access control works

---

### Exercise 2: Multi-Layer Architecture 🏛️

**Scenario:** Build a token system with core, logic, and API layers.

**Boilerplate Code:**

```move
// Layer 1: Core
module spell_library::token_core {
    // TODO: Declare logic layer as friend
    friend spell_library::token_____;

    struct Token has store {
        amount: u64
    }

    // TODO: Friend-only creation
    public(friend) fun mint(amount: u64): Token {
        assert!(amount > 0, 1);
        Token { amount: ____ }
    }

    // TODO: Friend-only destruction
    public(friend) fun burn(token: Token): u64 {
        let Token { amount } = token;
        amount
    }

    // Public read
    public fun balance(token: &Token): u64 {
        token.____
    }
}

// Layer 2: Logic
module spell_library::token_logic {
    // TODO: Declare API layer as friend
    friend spell_library::token_____;

    use spell_library::token_core;

    // TODO: Friend-only transfer
    public(____) fun transfer(
        from: Token,
        to: &mut Token,
        amount: u64
    ): Token {
        // Get balances
        let from_balance = token_core::burn(from);
        let to_balance = token_core::burn(*to);

        // Validate
        assert!(from_balance >= amount, 100);

        // Create new tokens
        *to = token_core::mint(to_balance + amount);
        token_core::mint(from_balance - amount)
    }
}

// Layer 3: Public API
module spell_library::token_api {
    use spell_library::token_core;
    use spell_library::token_logic;

    // Public function using internal layers
    public fun create_token(amount: u64): token_core::Token {
        // TODO: Use core to mint
        token_core::____(amount)
    }

    public fun safe_transfer(
        from: token_core::Token,
        to: &mut token_core::Token,
        amount: u64
    ): token_core::Token {
        // TODO: Use logic to transfer
        token_logic::____(from, to, amount)
    }
}

#[test_only]
module spell_library::token_tests {
    use spell_library::token_api;
    use spell_library::token_core;

    #[test]
    fun test_token_creation() {
        let token = token_api::create_token(100);
        assert!(token_core::balance(&token) == ____, 1);
    }

    #[test]
    fun test_transfer() {
        let token1 = token_api::create_token(100);
        let mut token2 = token_api::create_token(50);

        let token1 = token_api::safe_transfer(token1, &mut token2, 30);

        assert!(token_core::balance(&token1) == ____, 1);
        assert!(token_core::balance(&token2) == ____, 2);
    }
}
```

**Your Task:**

1. Set up friend relationships across layers
2. Implement friend-only functions
3. Build public API using internal layers
4. Complete transfer logic
5. Verify layered architecture

---

### Exercise 3: Capability-Based Access Control 🔐

**Scenario:** Build a registry system with capability-based permissions.

**Boilerplate Code:**

```move
module spell_library::registry {
    use std::vector;

    struct Registry has key {
        items: vector<u64>
    }

    // Capabilities
    struct AdminCap has key, store {}
    struct ReaderCap has key, store {}

    // Initialize with admin capability
    public fun initialize(): (Registry, AdminCap) {
        (
            Registry { items: vector::empty() },
            AdminCap {}
        )
    }

    // Create reader capability
    public fun create_reader(_admin: &AdminCap): ReaderCap {
        ReaderCap {}
    }

    // Admin can add (requires AdminCap)
    public fun add_item(
        _cap: &____,
        registry: &mut Registry,
        item: u64
    ) {
        vector::push_back(&mut registry.items, item);
    }

    // Admin can remove (requires AdminCap)
    public fun remove_item(
        _cap: &AdminCap,
        registry: &mut Registry,
        index: u64
    ): u64 {
        let len = vector::length(&registry.items);
        vector::swap(&mut registry.items, index, len - 1);
        vector::pop_back(&mut registry.items)
    }

    // Reader can view (requires ReaderCap)
    public fun view_items(
        _cap: &____,
        registry: &Registry
    ): u64 {
        vector::length(&registry.____)
    }

    // Public: anyone can check size
    public fun size(registry: &Registry): u64 {
        vector::length(&registry.items)
    }
}

#[test_only]
module spell_library::registry_tests {
    use spell_library::registry;

    #[test]
    fun test_registry_initialization() {
        let (registry, admin) = registry::initialize();
        assert!(registry::size(&registry) == ____, 1);
    }

    #[test]
    fun test_admin_operations() {
        let (mut registry, admin) = registry::initialize();

        registry::add_item(&admin, &mut registry, 100);
        registry::add_item(&admin, &mut registry, 200);

        assert!(registry::size(&registry) == ____, 1);

        let removed = registry::remove_item(&admin, &mut registry, 0);
        assert!(removed == ____, 2);
    }

    #[test]
    fun test_reader_capability() {
        let (mut registry, admin) = registry::initialize();
        let reader = registry::create_reader(&admin);

        registry::add_item(&admin, &mut registry, 42);

        let count = registry::view_items(&reader, &registry);
        assert!(count == ____, 1);
    }
}
```

**Your Task:**

1. Complete capability parameters
2. Implement add/remove with admin checks
3. Implement view with reader checks
4. Test capability-based access
5. Verify permission model

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::counter_core {
    friend spell_library::counter_admin;

    struct Counter has store {
        value: u64
    }

    public fun create(): Counter {
        Counter { value: 0 }
    }

    public(friend) fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    public fun get_value(counter: &Counter): u64 {
        counter.value
    }
}

module spell_library::counter_admin {
    use spell_library::counter_core;

    struct AdminCap has store {}

    public fun create_admin(): AdminCap {
        AdminCap {}
    }

    public fun admin_increment(
        _cap: &AdminCap,
        counter: &mut counter_core::Counter
    ) {
        counter_core::increment(counter);
    }
}

#[test_only]
module spell_library::counter_tests {
    use spell_library::counter_core;
    use spell_library::counter_admin;

    #[test]
    fun test_counter_creation() {
        let counter = counter_core::create();
        assert!(counter_core::get_value(&counter) == 0, 1);
    }

    #[test]
    fun test_admin_increment() {
        let mut counter = counter_core::create();
        let admin = counter_admin::create_admin();

        counter_admin::admin_increment(&admin, &mut counter);

        assert!(counter_core::get_value(&counter) == 1, 1);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::token_core {
    friend spell_library::token_logic;

    struct Token has store {
        amount: u64
    }

    public(friend) fun mint(amount: u64): Token {
        assert!(amount > 0, 1);
        Token { amount }
    }

    public(friend) fun burn(token: Token): u64 {
        let Token { amount } = token;
        amount
    }

    public fun balance(token: &Token): u64 {
        token.amount
    }
}

module spell_library::token_logic {
    friend spell_library::token_api;
    use spell_library::token_core;

    public(friend) fun transfer(
        from: token_core::Token,
        to: &mut token_core::Token,
        amount: u64
    ): token_core::Token {
        let from_balance = token_core::burn(from);
        let to_balance = token_core::burn(*to);

        assert!(from_balance >= amount, 100);

        *to = token_core::mint(to_balance + amount);
        token_core::mint(from_balance - amount)
    }
}

module spell_library::token_api {
    use spell_library::token_core;
    use spell_library::token_logic;

    public fun create_token(amount: u64): token_core::Token {
        token_core::mint(amount)
    }

    public fun safe_transfer(
        from: token_core::Token,
        to: &mut token_core::Token,
        amount: u64
    ): token_core::Token {
        token_logic::transfer(from, to, amount)
    }
}

#[test_only]
module spell_library::token_tests {
    use spell_library::token_api;
    use spell_library::token_core;

    #[test]
    fun test_token_creation() {
        let token = token_api::create_token(100);
        assert!(token_core::balance(&token) == 100, 1);
    }

    #[test]
    fun test_transfer() {
        let token1 = token_api::create_token(100);
        let mut token2 = token_api::create_token(50);

        let token1 = token_api::safe_transfer(token1, &mut token2, 30);

        assert!(token_core::balance(&token1) == 70, 1);
        assert!(token_core::balance(&token2) == 80, 2);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::registry {
    use std::vector;

    struct Registry has key {
        items: vector<u64>
    }

    struct AdminCap has key, store {}
    struct ReaderCap has key, store {}

    public fun initialize(): (Registry, AdminCap) {
        (
            Registry { items: vector::empty() },
            AdminCap {}
        )
    }

    public fun create_reader(_admin: &AdminCap): ReaderCap {
        ReaderCap {}
    }

    public fun add_item(
        _cap: &AdminCap,
        registry: &mut Registry,
        item: u64
    ) {
        vector::push_back(&mut registry.items, item);
    }

    public fun remove_item(
        _cap: &AdminCap,
        registry: &mut Registry,
        index: u64
    ): u64 {
        let len = vector::length(&registry.items);
        vector::swap(&mut registry.items, index, len - 1);
        vector::pop_back(&mut registry.items)
    }

    public fun view_items(
        _cap: &ReaderCap,
        registry: &Registry
    ): u64 {
        vector::length(&registry.items)
    }

    public fun size(registry: &Registry): u64 {
        vector::length(&registry.items)
    }
}

#[test_only]
module spell_library::registry_tests {
    use spell_library::registry;

    #[test]
    fun test_registry_initialization() {
        let (registry, admin) = registry::initialize();
        assert!(registry::size(&registry) == 0, 1);
    }

    #[test]
    fun test_admin_operations() {
        let (mut registry, admin) = registry::initialize();

        registry::add_item(&admin, &mut registry, 100);
        registry::add_item(&admin, &mut registry, 200);

        assert!(registry::size(&registry) == 2, 1);

        let removed = registry::remove_item(&admin, &mut registry, 0);
        assert!(removed == 100, 2);
    }

    #[test]
    fun test_reader_capability() {
        let (mut registry, admin) = registry::initialize();
        let reader = registry::create_reader(&admin);

        registry::add_item(&admin, &mut registry, 42);

        let count = registry::view_items(&reader, &registry);
        assert!(count == 1, 1);
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Friend Access

**Friend declaration establishes trust:**

```move
friend spell_library::counter_admin;
// Only counter_admin can call public(friend) functions
```

**public(friend) creates middle tier:**

```move
public(friend) fun increment(...)
// Not fully public, not fully private
// Only friends can call
```

### Exercise 2 Explanation: Layered Architecture

**Three-layer structure:**

```move
Core (friend logic) → Logic (friend api) → API (public)
// Each layer trusts the next
// Users only see API layer
```

**Benefits:**

- Clear separation of concerns
- Easy to change internals
- Security through layers

### Exercise 3 Explanation: Capabilities

**Capabilities prove permission:**

```move
public fun add_item(_cap: &AdminCap, ...)
// Must have AdminCap to call
// No cap = can't call
```

**Why this works:**

- Capabilities are unforgeable (can't create without permission)
- Transferable (can give to others)
- Checkable (function signature shows requirements)

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::friend_modules_lesson_tests {
    use spell_library::counter_tests;
    use spell_library::token_tests;
    use spell_library::registry_tests;

    #[test]
    fun run_all_counter_tests() {
        counter_tests::test_counter_creation();
        counter_tests::test_admin_increment();
    }

    #[test]
    fun run_all_token_tests() {
        token_tests::test_token_creation();
        token_tests::test_transfer();
    }

    #[test]
    fun run_all_registry_tests() {
        registry_tests::test_registry_initialization();
        registry_tests::test_admin_operations();
        registry_tests::test_reader_capability();
    }
}
```

---

## 🌟 Closing Story

Keeper Aurelius stands with Odessa at the entrance of the Inner Sanctum, now fully accessible. The architectural diagrams glow with clarity—every module, every relationship, every access pattern perfectly understood.

> "You've mastered encapsulation," Aurelius says, satisfaction evident in his voice. "You understand that not all code is equal. Some functions are public APIs—gateways for everyone. Some are private internals—implementation details. And some are friend functions—internal APIs for trusted modules."

> "This is professional software architecture. You don't just write code that works—you write code that's organized, maintainable, and secure. Your modules have clear boundaries. Your access patterns are explicit. Your trust relationships are documented."

The keeper gestures to the sanctum's interior, now open.

> "Remember these patterns: Use `public(friend)` for internal APIs. Minimize your public surface. Separate concerns across layers. Use capabilities for permission checks. Validate even for friends. Document your trust relationships."

Aurelius's form glows with approval.

> "You've completed the foundational curriculum. You understand primitives, ownership, functions, structs, abilities, resources, storage, references, control flow, collections, error handling, testing, standard library, and module architecture. You are no longer a student—you are a Move developer."

The guardian bows deeply.

> "The path ahead is yours to forge. Build tokens. Create DAOs. Implement DeFi protocols. Design NFT systems. The blockchain is your canvas. Your skills are your brush. Paint something that matters."

The Inner Sanctum shines with infinite possibility.

> "Go. Build. Transform the world."

---

**🎓 Move Language Foundations: Complete**

You have mastered:

1. Primitives and Variables
2. Ownership and Move Semantics
3. Functions
4. Structs and Data Modeling
5. Abilities
6. Resource-Oriented Programming
7. Global Storage
8. References and Borrowing
9. Safe Control Flow
10. Collections (Vectors)
11. Error Handling and Aborts
12. Unit Testing
13. Standard Library
14. Friend Modules and Encapsulation

**What's Next?**

- Advanced patterns (generics, upgradability)
- Production contract development
- Integration with blockchain platforms
- Contributing to the Move ecosystem

_You are now a professional Move developer._

_The blockchain awaits your innovations._
