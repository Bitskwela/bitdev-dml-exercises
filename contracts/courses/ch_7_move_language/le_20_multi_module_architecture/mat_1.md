## Background Story

Odessa enters the Cathedral of Modules—a vast architectural space where code structures rise like interconnected buildings. At its center stands Master Builder, architect of complex systems, surrounded by floating blueprints of multi-module projects.

"Welcome to architecture," the master begins, voice echoing through the space. "You've learned patterns. Now learn how to organize entire systems."

Builder gestures at the towering structures.

"A single module is like a single building. Simple. Manageable. But production systems aren't single modules—they're cities. Dozens of modules working together. Dependencies between them. Clear boundaries. Controlled interfaces."

The master pulls down a complex system diagram.

"Poor architecture leads to spaghetti code—everything depends on everything. Good architecture creates clean boundaries, minimal coupling, clear dependencies. Your code becomes maintainable, testable, and scalable."

Builder shows the principles:

- **Module boundaries**: Clear responsibilities
- **Dependency management**: Unidirectional flow
- **Interface design**: Minimal public surface
- **Cross-module communication**: Well-defined protocols
- **Shared resources**: Careful coordination

"Today, you'll master multi-module architecture. You'll learn how to organize large codebases, manage dependencies, design clean interfaces, and build systems that scale. By the end, you'll architect complex Move projects with confidence."

The cathedral resonates with structure.

"Let's build systems that last."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Module Organization and Boundaries**

Clear module boundaries create maintainable systems.

**What makes good module boundaries?**

**Single Responsibility Principle:**

Each module should do ONE thing well:

```move
// ❌ BAD: God module doing everything
module spell_library::everything {
    // Token logic
    public fun mint_token() { }

    // NFT logic
    public fun mint_nft() { }

    // Marketplace logic
    public fun create_listing() { }

    // Governance logic
    public fun vote() { }
}

// ✅ GOOD: Focused modules
module spell_library::token {
    public fun mint() { }
    public fun transfer() { }
}

module spell_library::nft {
    public fun mint() { }
    public fun transfer() { }
}

module spell_library::marketplace {
    public fun list() { }
    public fun buy() { }
}
```

**Real-world analogy:**

Modules are like departments in a company. Finance handles money, HR handles people, Engineering handles products. Each has clear responsibilities.

**Module organization patterns:**

**1. Layered architecture:**

```move
// Core layer (no dependencies)
module spell_library::types {
    struct Token has key { value: u64 }
    struct NFT has key { id: u64 }
}

// Business logic layer (depends on core)
module spell_library::token_logic {
    use spell_library::types::Token;

    public fun create_token(value: u64): Token {
        Token { value }
    }
}

// Application layer (depends on logic)
module spell_library::token_api {
    use spell_library::token_logic;

    public entry fun mint_for_user(user: &signer, value: u64) {
        let token = token_logic::create_token(value);
        move_to(user, token);
    }
}
```

**2. Feature-based organization:**

```move
// Each feature is a module
module spell_library::user_registration { }
module spell_library::user_profile { }
module spell_library::user_settings { }

module spell_library::content_creation { }
module spell_library::content_moderation { }
module spell_library::content_discovery { }
```

**3. Domain-driven design:**

```move
// Domain modules
module spell_library::auction_domain {
    struct Auction { }
    struct Bid { }
}

module spell_library::auction_commands {
    // User actions
    public fun place_bid() { }
    public fun cancel_bid() { }
}

module spell_library::auction_queries {
    // Read operations
    public fun get_auction() { }
    public fun list_bids() { }
}
```

**Module boundary guidelines:**

1. Each module has ONE clear purpose
2. Public functions are the module's interface
3. Internal functions stay private
4. Structs define the module's data
5. Dependencies flow in ONE direction

### 2️⃣ **Dependency Management**

Managing dependencies prevents circular references and complexity.

**Dependency rules:**

**Rule 1: Unidirectional dependencies**

```move
// ✅ GOOD: Clear dependency flow
module spell_library::core {
    struct Data { value: u64 }
}

module spell_library::logic {
    use spell_library::core;  // Depends on core

    public fun process(data: &core::Data) { }
}

module spell_library::api {
    use spell_library::logic;  // Depends on logic
    use spell_library::core;   // Can also depend on core

    public entry fun handle_request() {
        logic::process(&data);
    }
}

// Dependency flow: core ← logic ← api
```

**Rule 2: No circular dependencies**

```move
// ❌ BAD: Circular dependency
module spell_library::module_a {
    use spell_library::module_b;  // A depends on B
}

module spell_library::module_b {
    use spell_library::module_a;  // B depends on A
    // Circular! Won't compile!
}

// ✅ GOOD: Break circular dependency
module spell_library::shared {
    // Common types/functions
}

module spell_library::module_a {
    use spell_library::shared;
}

module spell_library::module_b {
    use spell_library::shared;
}
```

**Rule 3: Minimize dependencies**

```move
// ❌ BAD: Too many dependencies
module spell_library::feature {
    use spell_library::module1;
    use spell_library::module2;
    use spell_library::module3;
    use spell_library::module4;
    use spell_library::module5;
    // High coupling!
}

// ✅ GOOD: Minimal dependencies
module spell_library::feature {
    use spell_library::core;
    // Only depends on essential module
}
```

**Dependency injection pattern:**

```move
module spell_library::storage {
    // Generic storage, no specific dependencies
    struct Store<T: store> has key {
        items: vector<T>
    }

    public fun add<T: store>(store: &mut Store<T>, item: T) {
        vector::push_back(&mut store.items, item);
    }
}

module spell_library::my_feature {
    use spell_library::storage;

    struct MyData has store { value: u64 }

    // Uses generic storage, no tight coupling
    public fun store_data(store: &mut storage::Store<MyData>, data: MyData) {
        storage::add(store, data);
    }
}
```

**Dependency visualization:**

```
Core modules (no dependencies)
    ↓
Business logic (depends on core)
    ↓
Application layer (depends on logic)
    ↓
Entry points (depends on application)
```

### 3️⃣ **Interface Design and Public APIs**

Clean interfaces make modules usable and maintainable.

**Public interface principles:**

**1. Minimal public surface:**

```move
module spell_library::token {
    // Public interface (small, stable)
    public fun create(value: u64): Token { ... }
    public fun transfer(token: Token, to: address) { ... }
    public fun balance(token: &Token): u64 { ... }

    // Private implementation (can change freely)
    fun validate_amount(amount: u64): bool { ... }
    fun update_ledger(from: address, to: address, amount: u64) { ... }
    fun emit_event(event: Event) { ... }
}
```

**2. Clear naming conventions:**

```move
// Naming shows intent
public fun create_auction()  // Constructor
public fun place_bid()       // Action
public fun get_winner()      // Query
public fun is_active()       // Boolean query
public fun to_string()       // Conversion
```

**3. Consistent parameters:**

```move
// ✅ GOOD: Consistent parameter order
public fun transfer(from: &signer, to: address, amount: u64)
public fun approve(from: &signer, to: address, amount: u64)
public fun burn(from: &signer, amount: u64)

// ❌ BAD: Inconsistent order
public fun transfer(amount: u64, from: &signer, to: address)
public fun approve(to: address, from: &signer, amount: u64)
```

**4. Return value patterns:**

```move
// Return created resources
public fun create_token(value: u64): Token { ... }

// Return reference for queries
public fun get_balance(account: address): &u64 acquires Balance { ... }

// Return nothing for actions
public fun burn(token: Token) { ... }

// Return results for operations
public fun try_transfer(token: Token, to: address): bool { ... }
```

**5. Error handling:**

```move
// Clear error codes
const E_INSUFFICIENT_BALANCE: u64 = 100;
const E_UNAUTHORIZED: u64 = 101;
const E_INVALID_AMOUNT: u64 = 102;

public fun transfer(from: &signer, to: address, amount: u64) {
    assert!(get_balance(from) >= amount, E_INSUFFICIENT_BALANCE);
    assert!(amount > 0, E_INVALID_AMOUNT);
    // ...
}
```

**API design patterns:**

**Builder pattern:**

```move
module spell_library::config_builder {
    struct ConfigBuilder {
        name: String,
        value: u64,
        enabled: bool
    }

    public fun new(): ConfigBuilder {
        ConfigBuilder {
            name: string::utf8(b""),
            value: 0,
            enabled: false
        }
    }

    public fun with_name(builder: &mut ConfigBuilder, name: String) {
        builder.name = name;
    }

    public fun with_value(builder: &mut ConfigBuilder, value: u64) {
        builder.value = value;
    }

    public fun build(builder: ConfigBuilder): Config {
        // Validate and create Config
    }
}

// Usage:
let mut builder = config_builder::new();
config_builder::with_name(&mut builder, string::utf8(b"MyConfig"));
config_builder::with_value(&mut builder, 100);
let config = config_builder::build(builder);
```

**Facade pattern:**

```move
// Complex subsystems
module spell_library::validation { }
module spell_library::storage { }
module spell_library::notification { }

// Simple facade
module spell_library::user_service {
    use spell_library::{validation, storage, notification};

    // One simple function hides complexity
    public fun register_user(
        user: &signer,
        name: String
    ) {
        validation::validate_name(&name);
        storage::store_user(user, name);
        notification::send_welcome(user);
    }
}
```

### 4️⃣ **Cross-Module Communication**

Modules communicate through well-defined protocols.

**Communication patterns:**

**1. Direct function calls:**

```move
module spell_library::module_a {
    public fun function_a(): u64 {
        42
    }
}

module spell_library::module_b {
    use spell_library::module_a;

    public fun function_b(): u64 {
        module_a::function_a() + 10
    }
}
```

**2. Shared resources:**

```move
module spell_library::shared_state {
    struct SharedCounter has key {
        count: u64
    }

    public fun increment(counter: &mut SharedCounter) {
        counter.count = counter.count + 1;
    }

    public fun get_count(counter: &SharedCounter): u64 {
        counter.count
    }
}

module spell_library::module_a {
    use spell_library::shared_state;

    public fun do_action(counter: &mut shared_state::SharedCounter) {
        shared_state::increment(counter);
    }
}

module spell_library::module_b {
    use spell_library::shared_state;

    public fun do_other_action(counter: &mut shared_state::SharedCounter) {
        shared_state::increment(counter);
    }
}
```

**3. Event-based communication:**

```move
module spell_library::publisher {
    struct Event has copy, drop {
        data: u64
    }

    public fun publish_event(data: u64) {
        event::emit(Event { data });
    }
}

module spell_library::subscriber {
    // External systems listen for events
    // No direct coupling between modules
}
```

**4. Capability passing:**

```move
module spell_library::auth {
    struct AdminCap has key, store {}

    public fun create_admin_cap(): AdminCap {
        AdminCap {}
    }
}

module spell_library::operations {
    use spell_library::auth::AdminCap;

    public fun admin_operation(_cap: &AdminCap) {
        // Only callable with admin capability
    }
}
```

**5. Registry pattern:**

```move
module spell_library::service_registry {
    struct Registry has key {
        services: Table<String, address>
    }

    public fun register(registry: &mut Registry, name: String, addr: address) {
        table::add(&mut registry.services, name, addr);
    }

    public fun lookup(registry: &Registry, name: String): address {
        *table::borrow(&registry.services, name)
    }
}

// Other modules register and discover services
```

### 5️⃣ **Scaling Patterns and Best Practices**

Patterns for building large, maintainable systems.

**Pattern 1: Modular monolith**

Start simple, modularize as you grow:

```move
// Phase 1: Single module
module spell_library::app {
    // All functionality here
}

// Phase 2: Split by feature
module spell_library::users { }
module spell_library::content { }
module spell_library::marketplace { }

// Phase 3: Split by layer
module spell_library::user_domain { }
module spell_library::user_service { }
module spell_library::user_api { }
```

**Pattern 2: Core + extensions**

```move
// Core module (stable, minimal dependencies)
module spell_library::core {
    struct Token has key { value: u64 }

    public fun create(value: u64): Token {
        Token { value }
    }
}

// Extension modules (add features)
module spell_library::token_metadata {
    use spell_library::core::Token;

    struct Metadata has key {
        token: Token,
        name: String,
        description: String
    }
}

module spell_library::token_staking {
    use spell_library::core::Token;

    struct StakedToken has key {
        token: Token,
        staked_at: u64
    }
}
```

**Pattern 3: Versioned modules**

```move
module spell_library::token_v1 {
    struct Token has key { value: u64 }
}

module spell_library::token_v2 {
    struct Token has key {
        value: u64,
        decimals: u8  // New field
    }

    // Migration function
    public fun migrate_from_v1(old_token: token_v1::Token): Token {
        let token_v1::Token { value } = old_token;
        Token { value, decimals: 8 }
    }
}
```

**Pattern 4: Feature flags**

```move
module spell_library::features {
    struct FeatureFlags has key {
        experimental_enabled: bool,
        new_auction_enabled: bool
    }

    public fun is_enabled(flags: &FeatureFlags, feature: u8): bool {
        // Check if feature is enabled
        true
    }
}

module spell_library::auction {
    use spell_library::features;

    public fun create_auction(flags: &features::FeatureFlags) {
        if (features::is_enabled(flags, NEW_AUCTION)) {
            // New implementation
        } else {
            // Old implementation
        }
    }
}
```

**Best practices:**

1. **Start simple**: Don't over-architect early
2. **Refactor as you grow**: Split modules when they get large
3. **Document interfaces**: Clear comments on public functions
4. **Version carefully**: Consider migration paths
5. **Test boundaries**: Test module interactions
6. **Monitor dependencies**: Keep dependency graph clean

---

## 🎯 Activity / Exercises

### Exercise 1: Layered Architecture 🏗️

**Scenario:** Build a token system with clear layers.

**Boilerplate Code:**

```move
// Layer 1: Core types (no dependencies)
module spell_library::token_types {
    struct Token has store {
        value: u64,
        owner: address
    }

    public fun new_token(owner: address, value: u64): Token {
        Token { owner, value: ____ }
    }

    public fun value(token: &Token): u64 {
        token.____
    }

    public fun owner(token: &Token): address {
        token.____
    }
}

// Layer 2: Business logic (depends on types)
module spell_library::token_logic {
    use spell_library::token_types::{Self, Token};

    public fun transfer(
        token: Token,
        new_owner: address
    ): Token {
        let old_owner = token_types::owner(&token);
        let value = token_types::____(&token);

        // Destroy old token
        let Token { value: _, owner: _ } = token;

        // Create new token
        token_types::____(____, value)
    }

    public fun split(
        token: Token,
        amount: u64
    ): (Token, Token) {
        let owner = token_types::owner(&token);
        let total = token_types::value(&token);

        assert!(total >= ____, 100);

        let remaining = total - ____;

        // Destroy original
        let Token { value: _, owner: _ } = token;

        (
            token_types::new_token(owner, ____),
            token_types::new_token(owner, ____)
        )
    }
}

// Layer 3: API (depends on logic)
module spell_library::token_api {
    use spell_library::token_logic;
    use spell_library::token_types;

    struct TokenStore has key {
        token: token_types::Token
    }

    public entry fun mint(account: &signer, value: u64) {
        let addr = signer::address_of(____);
        let token = token_types::____(____, value);

        move_to(account, TokenStore { token });
    }

    public entry fun transfer_to(
        from: &signer,
        to: address
    ) acquires TokenStore {
        let addr = signer::address_of(from);
        let TokenStore { token } = move_from<____>(addr);

        let transferred = token_logic::____(____, to);

        move_to(/* TODO: need signer for to address */, TokenStore { token: transferred });
    }
}
```

**Your Task:**

1. Complete core types layer
2. Implement business logic layer using types
3. Build API layer using logic
4. Maintain unidirectional dependencies

---

### Exercise 2: Module Communication 📡

**Scenario:** Build modules that communicate through shared resources.

**Boilerplate Code:**

```move
// Shared counter module
module spell_library::counter {
    struct Counter has key {
        value: u64
    }

    public fun create(account: &signer) {
        move_to(account, Counter { value: ____ });
    }

    public fun increment(counter: &mut Counter) {
        counter.____ = counter.value + 1;
    }

    public fun get_value(counter: &Counter): u64 {
        counter.____
    }
}

// Module A uses counter
module spell_library::service_a {
    use spell_library::____::Counter;

    public fun perform_action(
        counter: &mut ____
    ) {
        // Do work

        // Increment shared counter
        counter::____(____)
    }
}

// Module B also uses counter
module spell_library::service_b {
    use spell_library::counter::{Self, ____};

    public fun perform_other_action(
        counter: &mut Counter
    ) {
        // Do different work

        // Also increment counter
        counter::increment(____)
    }
}

#[test_only]
module spell_library::communication_tests {
    use spell_library::{counter, service_a, service_b};

    #[test]
    fun test_shared_communication() {
        let account = @0x123;
        counter::create(&account);

        let mut shared_counter = /* get counter */;

        service_a::perform_action(&mut ____);
        service_b::perform_other_action(&mut shared_counter);

        assert!(counter::get_value(&shared_counter) == ____, 1);
    }
}
```

**Your Task:**

1. Complete shared counter module
2. Implement service modules using counter
3. Verify modules communicate through shared resource
4. Test cross-module interaction

---

### Exercise 3: Clean Interface Design 🎨

**Scenario:** Design a clean public API for a marketplace.

**Boilerplate Code:**

```move
module spell_library::marketplace {
    use std::string::String;

    struct Listing has store {
        seller: address,
        item_id: u64,
        price: u64,
        active: bool
    }

    struct Marketplace has key {
        listings: vector<Listing>,
        next_id: u64
    }

    // Error codes
    const E_NOT_FOUND: u64 = 100;
    const E_NOT_ACTIVE: u64 = 101;
    const E_INSUFFICIENT_PAYMENT: u64 = 102;

    // Public API: Create marketplace
    public fun create(account: &signer) {
        move_to(account, Marketplace {
            listings: vector::____(),
            next_id: 0
        });
    }

    // Public API: Create listing
    public fun create_listing(
        marketplace: &mut Marketplace,
        seller: address,
        item_id: u64,
        price: u64
    ): u64 {
        let listing_id = marketplace.____;
        marketplace.next_id = marketplace.next_id + 1;

        vector::push_back(&mut marketplace.____, Listing {
            seller: ____,
            item_id: ____,
            price: ____,
            active: true
        });

        listing_id
    }

    // Public API: Get listing
    public fun get_listing(
        marketplace: &Marketplace,
        listing_id: u64
    ): &Listing {
        assert!(listing_id < vector::length(&marketplace.____), ____);
        vector::borrow(&marketplace.listings, ____)
    }

    // Public API: Buy item
    public fun buy(
        marketplace: &mut Marketplace,
        listing_id: u64,
        payment: u64
    ) {
        let listing = vector::borrow_mut(&mut marketplace.____, listing_id);

        assert!(listing.____, E_NOT_ACTIVE);
        assert!(payment >= listing.____, E_INSUFFICIENT_PAYMENT);

        listing.active = ____;
    }

    // Public API: Query functions
    public fun is_active(listing: &Listing): bool {
        listing.____
    }

    public fun get_price(listing: &Listing): u64 {
        listing.____
    }

    public fun get_seller(listing: &Listing): address {
        listing.____
    }

    // Private helper (not public)
    fun find_listing(marketplace: &Marketplace, id: u64): Option<&Listing> {
        // Internal implementation
        option::none()
    }
}
```

**Your Task:**

1. Complete public API functions
2. Use clear error codes
3. Implement query functions
4. Keep helpers private

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::token_types {
    struct Token has store {
        value: u64,
        owner: address
    }

    public fun new_token(owner: address, value: u64): Token {
        Token { owner, value }
    }

    public fun value(token: &Token): u64 {
        token.value
    }

    public fun owner(token: &Token): address {
        token.owner
    }
}

module spell_library::token_logic {
    use spell_library::token_types::{Self, Token};

    public fun transfer(token: Token, new_owner: address): Token {
        let value = token_types::value(&token);
        let Token { value: _, owner: _ } = token;
        token_types::new_token(new_owner, value)
    }

    public fun split(token: Token, amount: u64): (Token, Token) {
        let owner = token_types::owner(&token);
        let total = token_types::value(&token);
        assert!(total >= amount, 100);

        let remaining = total - amount;
        let Token { value: _, owner: _ } = token;

        (
            token_types::new_token(owner, amount),
            token_types::new_token(owner, remaining)
        )
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::counter {
    struct Counter has key {
        value: u64
    }

    public fun create(account: &signer) {
        move_to(account, Counter { value: 0 });
    }

    public fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    public fun get_value(counter: &Counter): u64 {
        counter.value
    }
}

module spell_library::service_a {
    use spell_library::counter::{Self, Counter};

    public fun perform_action(counter: &mut Counter) {
        counter::increment(counter);
    }
}

module spell_library::service_b {
    use spell_library::counter::{Self, Counter};

    public fun perform_other_action(counter: &mut Counter) {
        counter::increment(counter);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::marketplace {
    use std::string::String;

    struct Listing has store {
        seller: address,
        item_id: u64,
        price: u64,
        active: bool
    }

    struct Marketplace has key {
        listings: vector<Listing>,
        next_id: u64
    }

    const E_NOT_FOUND: u64 = 100;
    const E_NOT_ACTIVE: u64 = 101;
    const E_INSUFFICIENT_PAYMENT: u64 = 102;

    public fun create(account: &signer) {
        move_to(account, Marketplace {
            listings: vector::empty(),
            next_id: 0
        });
    }

    public fun create_listing(
        marketplace: &mut Marketplace,
        seller: address,
        item_id: u64,
        price: u64
    ): u64 {
        let listing_id = marketplace.next_id;
        marketplace.next_id = marketplace.next_id + 1;

        vector::push_back(&mut marketplace.listings, Listing {
            seller,
            item_id,
            price,
            active: true
        });

        listing_id
    }

    public fun get_listing(
        marketplace: &Marketplace,
        listing_id: u64
    ): &Listing {
        assert!(listing_id < vector::length(&marketplace.listings), E_NOT_FOUND);
        vector::borrow(&marketplace.listings, listing_id)
    }

    public fun buy(
        marketplace: &mut Marketplace,
        listing_id: u64,
        payment: u64
    ) {
        let listing = vector::borrow_mut(&mut marketplace.listings, listing_id);

        assert!(listing.active, E_NOT_ACTIVE);
        assert!(payment >= listing.price, E_INSUFFICIENT_PAYMENT);

        listing.active = false;
    }

    public fun is_active(listing: &Listing): bool {
        listing.active
    }

    public fun get_price(listing: &Listing): u64 {
        listing.price
    }

    public fun get_seller(listing: &Listing): address {
        listing.seller
    }

    fun find_listing(marketplace: &Marketplace, id: u64): Option<&Listing> {
        option::none()
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1: Layered Architecture

**Dependency flow:**

```
token_types (core)
    ↓
token_logic (uses types)
    ↓
token_api (uses logic)
```

**Each layer builds on previous, no reverse dependencies.**

### Exercise 2: Module Communication

**Shared resource pattern:**

```move
// Both modules operate on same Counter
service_a::perform_action(&mut counter);
service_b::perform_other_action(&mut counter);
```

**Decoupled but coordinated through shared state.**

### Exercise 3: Clean Interface

**Public API principles:**

```move
// Clear function names
public fun create_listing(...)
public fun get_listing(...)
public fun buy(...)

// Clear error codes
const E_NOT_ACTIVE: u64 = 101;

// Private helpers
fun find_listing(...)  // Not public
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::architecture_tests {
    #[test]
    fun test_layered_architecture() {
        // Test layer interactions
    }

    #[test]
    fun test_module_communication() {
        // Test cross-module coordination
    }

    #[test]
    fun test_public_api() {
        // Test interface design
    }
}
```

---

## 🌟 Closing Story

Master Builder stands with Odessa in the Cathedral of Modules, surrounded by the architecture of complex systems.

> "You've mastered multi-module architecture," Builder says with pride. "Your code is now organized, maintainable, and scalable. Clear boundaries. Unidirectional dependencies. Clean interfaces. Cross-module communication through well-defined protocols."

> "This is how production systems are built. Not as monoliths, but as coordinated modules. Each with clear responsibilities. Each with minimal dependencies. Each with a clean public API."

The architect gestures at the towering structures.

> "Remember: start simple, refactor as you grow. Keep dependencies unidirectional. Design clear interfaces. Make modules communicate through shared resources, capabilities, or events. Build systems that can evolve."

Builder's form radiates structure.

> "Your next lesson: state machines. You'll learn how to model complex state transitions, validate state changes, and build systems with clear state management. Architecture taught you organization. State machines will teach you flow control."

The cathedral fades into ordered light.

> "Go. Build structured systems. Maintain clean boundaries. Trust the architecture."

---

**Next Lesson:** State Machines - modeling state transitions and flow control.
