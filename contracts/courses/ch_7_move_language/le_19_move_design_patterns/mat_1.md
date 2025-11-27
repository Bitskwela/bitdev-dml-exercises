## Background Story

Odessa enters the Hall of Mastery—a grand chamber where the greatest Move patterns shimmer in crystalline perfection. At its center stands Master Architect, surrounded by floating code patterns that have proven themselves across countless production systems.

"Welcome to the patterns that define professional Move development," the master begins, voice resonating with authority. "Every language has its idioms, its proven solutions, its elegant approaches. Move is no different."

The architect gestures, and five patterns materialize:

- **Witness**: Proof of authority through one-time tokens
- **Hot Potato**: Forced handling through undropped types
- **Capability**: Permission objects for access control
- **Singleton**: Ensuring exactly one instance exists
- **Registry**: Global directories for discovery

"These aren't just clever tricks," Master Architect continues. "These are battle-tested patterns used in production Move contracts worth millions. They solve real problems: authentication, authorization, resource management, state coordination."

The master pulls down the witness pattern, showing its elegance.

"The witness pattern proves you have authority to perform an action. You create a struct that can only be instantiated in your module, pass it as proof, and it gets consumed. Simple, elegant, secure."

The patterns glow with knowledge.

"Today, you'll master these five foundational patterns and several advanced ones. You'll learn when to use each, how to implement them correctly, and how to combine them for powerful effects. By the end, you'll recognize these patterns in the wild and use them in your own contracts."

The hall brightens with possibility.

"Let's begin with the patterns that make Move code elegant and secure."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **The Witness Pattern: Proof of Authority**

The witness pattern uses a one-time token to prove module authority.

**What problem does it solve?**

How do you prove that only your module can perform an action?

```move
// Problem: Anyone can call this!
public fun create_special_token(): Token {
    Token { value: 1000 }
}
```

**Solution: Witness pattern**

```move
module spell_library::witness_example {
    // Only this module can create MyWitness
    struct MyWitness has drop {}

    struct Token has key {
        value: u64
    }

    // Public function, but requires witness!
    public fun create_token(_witness: MyWitness): Token {
        Token { value: 1000 }
    }

    // Only this module can call create_token
    fun init() {
        let witness = MyWitness {};
        let token = create_token(witness);
        // ...
    }
}
```

**Why this works:**

1. `MyWitness` has no `store` or `key` ability
2. Only functions in `spell_library::witness_example` can create `MyWitness`
3. External modules can call `create_token`, but can't pass a witness
4. Witness is consumed (dropped) after use

**Real-world analogy:**

Witness is like a backstage pass that only the venue can issue. You need the pass to get backstage, but only the venue staff can create passes.

**Witness pattern variations:**

**1. One-time witness (OTW):**

```move
module spell_library::one_time {
    // By convention: module name in CAPS
    struct ONE_TIME has drop {}

    // Called only once at module publish
    fun init(witness: ONE_TIME) {
        // Use witness to initialize
        setup_registry(witness);
    }
}
```

**2. Phantom witness:**

```move
struct Witness<phantom T> has drop {}

public fun create_with_witness<T>(
    _witness: Witness<T>
): Registry<T> {
    Registry { items: vector::empty() }
}

// Only module defining MyType can create Registry<MyType>
```

**3. Witness for type registration:**

```move
struct TypeRegistry has key {
    types: vector<String>
}

public fun register_type<T>(
    registry: &mut TypeRegistry,
    _witness: T  // T must be from your module
) {
    // Register type T
    let type_name = type_name::get<T>();
    vector::push_back(&mut registry.types, type_name);
}
```

**When to use witness pattern:**

- Proving module authority
- One-time initialization
- Type registration
- Privileged operations that should only be callable by specific modules

### 2️⃣ **The Hot Potato Pattern: Forced Handling**

Hot potato uses structs without abilities to force proper handling.

**What problem does it solve?**

How do you ensure a value is properly handled and can't be ignored?

```move
// Problem: Return value can be ignored
public fun start_process(): Token {
    Token { value: 100 }
}

// Token could be lost!
start_process();  // Returned value ignored
```

**Solution: Hot potato (no abilities)**

```move
module spell_library::hot_potato {
    // NO abilities! Can't be dropped, stored, or copied
    struct Request {
        id: u64,
        data: vector<u8>
    }

    // Creates hot potato
    public fun create_request(id: u64, data: vector<u8>): Request {
        Request { id, data }
    }

    // Must be consumed!
    public fun complete_request(request: Request): u64 {
        let Request { id, data: _ } = request;
        id
    }
}

// Usage:
let request = create_request(1, b"data");
// MUST call complete_request or code won't compile!
complete_request(request);
```

**Why this works:**

1. `Request` has no `drop` ability → can't be ignored
2. `Request` has no `store` ability → can't be stored
3. `Request` has no `copy` ability → can't be duplicated
4. Compiler forces you to destructure it

**Real-world analogy:**

Hot potato is like a literal hot potato—you can't just hold it, you must pass it along or handle it immediately.

**Hot potato pattern variations:**

**1. Flash loan pattern:**

```move
struct FlashLoan {
    amount: u64,
    fee: u64
}

public fun borrow(amount: u64): FlashLoan {
    // Give tokens
    FlashLoan { amount, fee: amount / 100 }
}

public fun repay(loan: FlashLoan, payment: Coin) {
    let FlashLoan { amount, fee } = loan;
    assert!(coin::value(&payment) >= amount + fee, 100);
    // Accept repayment
}

// Must repay in same transaction!
let loan = borrow(1000);
// ... use borrowed funds ...
repay(loan, payment);  // MUST repay!
```

**2. Approval flow:**

```move
struct Approval {
    approver: address,
    action: u8
}

public fun request_approval(action: u8): Approval {
    Approval {
        approver: @0x0,  // Placeholder
        action
    }
}

public fun approve(approval: Approval, approver: &signer): ApprovedAction {
    let Approval { approver: _, action } = approval;
    ApprovedAction {
        approver: signer::address_of(approver),
        action
    }
}
```

**3. Multi-step process:**

```move
struct Step1 { data: u64 }
struct Step2 { data: u64, timestamp: u64 }
struct Step3 { data: u64, timestamp: u64, signature: vector<u8> }

public fun start(): Step1 {
    Step1 { data: 0 }
}

public fun process_step1(step: Step1): Step2 {
    let Step1 { data } = step;
    Step2 { data: data + 1, timestamp: get_timestamp() }
}

public fun process_step2(step: Step2, sig: vector<u8>): Step3 {
    let Step2 { data, timestamp } = step;
    Step3 { data, timestamp, signature: sig }
}

public fun finalize(step: Step3) {
    let Step3 { data: _, timestamp: _, signature: _ } = step;
    // Complete!
}
```

**When to use hot potato:**

- Enforcing multi-step workflows
- Flash loans
- Request-response patterns
- Ensuring cleanup happens

### 3️⃣ **The Capability Pattern: Permission Objects**

Capabilities are objects that represent permissions.

**What problem does it solve?**

How do you represent and transfer permissions in a type-safe way?

```move
// Problem: Permission checks are fragile
public fun admin_action(caller: address) {
    assert!(caller == ADMIN, 100);  // Hardcoded!
}
```

**Solution: Capability objects**

```move
module spell_library::capabilities {
    struct AdminCap has key, store {}

    struct ModeratorCap has key, store {}

    // Issue capabilities
    public fun create_admin_cap(): AdminCap {
        AdminCap {}
    }

    // Require capability
    public fun admin_action(_cap: &AdminCap, target: &mut Resource) {
        // If you have AdminCap, you can act
        target.value = 999;
    }

    // Transfer capability
    public fun transfer_admin(cap: AdminCap, to: address) {
        transfer::transfer(cap, to);
    }
}
```

**Why this works:**

1. Capability is an object you must possess
2. Type system enforces you have the right capability
3. Capabilities can be transferred, delegated, or revoked
4. No hardcoded addresses

**Real-world analogy:**

Capabilities are like physical keys. To open a door, you need the key. Keys can be given to others or taken back.

**Capability pattern variations:**

**1. Hierarchical capabilities:**

```move
struct MasterCap has key, store {
    id: u64
}

struct ManagerCap has key, store {
    master_id: u64,
    permissions: u64
}

struct WorkerCap has key, store {
    manager_id: u64,
    tasks: vector<u8>
}
```

**2. Time-limited capabilities:**

```move
struct TimedCap has key, store {
    expiry: u64
}

public fun use_timed_cap(cap: &TimedCap) {
    assert!(get_timestamp() < cap.expiry, 100);
    // Capability still valid
}
```

**3. Delegated capabilities:**

```move
struct DelegatedCap has key, store {
    original_owner: address,
    delegatee: address,
    permissions: u64
}

public fun delegate(
    cap: &AdminCap,
    to: address,
    permissions: u64
): DelegatedCap {
    DelegatedCap {
        original_owner: get_cap_owner(cap),
        delegatee: to,
        permissions
    }
}
```

**4. Consumable capabilities:**

```move
struct UsageCap has key, store {
    uses_remaining: u64
}

public fun use_cap(cap: &mut UsageCap) {
    assert!(cap.uses_remaining > 0, 100);
    cap.uses_remaining = cap.uses_remaining - 1;
}
```

**When to use capability pattern:**

- Access control
- Permission delegation
- Role-based systems
- Transferable authority

### 4️⃣ **The Singleton Pattern: One Instance Only**

Singleton ensures exactly one instance of a resource exists.

**What problem does it solve?**

How do you ensure only one global instance exists?

```move
// Problem: Multiple instances could be created
public fun create_config(): Config {
    Config { setting: 100 }
}

// Could create many configs!
let config1 = create_config();
let config2 = create_config();
```

**Solution: Singleton pattern**

```move
module spell_library::singleton {
    struct Config has key {
        setting: u64
    }

    // One-time initialization
    public fun init(account: &signer) {
        // Will fail if already exists!
        move_to(account, Config { setting: 100 });
    }

    // Access singleton
    public fun get_config(): &Config acquires Config {
        borrow_global<Config>(@admin_address)
    }

    // Modify singleton
    public fun update_config(
        _cap: &AdminCap,
        new_setting: u64
    ) acquires Config {
        let config = borrow_global_mut<Config>(@admin_address);
        config.setting = new_setting;
    }
}
```

**Why this works:**

1. `move_to` fails if resource already exists
2. Only one address can store the singleton
3. Global access via `borrow_global`

**Real-world analogy:**

Singleton is like a country's constitution—there's exactly one, everyone refers to it, and changing it requires special authority.

**Singleton pattern variations:**

**1. Lazy singleton:**

```move
struct Registry has key {
    items: vector<Item>
}

public fun get_or_create_registry(
    account: &signer
): &Registry acquires Registry {
    let addr = signer::address_of(account);

    if (!exists<Registry>(addr)) {
        move_to(account, Registry {
            items: vector::empty()
        });
    };

    borrow_global<Registry>(addr)
}
```

**2. Module-level singleton:**

```move
struct ModuleData has key {
    initialized: bool,
    data: u64
}

fun init(account: &signer) {
    move_to(account, ModuleData {
        initialized: true,
        data: 0
    });
}
```

**3. Singleton with witness:**

```move
struct ONE_TIME has drop {}

struct GlobalRegistry has key {
    items: Table<u64, Item>
}

public fun initialize(
    witness: ONE_TIME,
    account: &signer
) {
    move_to(account, GlobalRegistry {
        items: table::new()
    });
}
```

**When to use singleton:**

- Global configuration
- Module-level state
- Shared registries
- System-wide resources

### 5️⃣ **The Registry Pattern: Global Discovery**

Registry provides global directory for looking up resources.

**What problem does it solve?**

How do users discover resources or services?

```move
// Problem: How to find other users' resources?
// Each resource is at a different address!
```

**Solution: Registry pattern**

```move
module spell_library::registry {
    use std::table::{Self, Table};

    struct Registry has key {
        items: Table<address, ItemInfo>
    }

    struct ItemInfo has store {
        name: String,
        value: u64,
        active: bool
    }

    public fun create_registry(account: &signer) {
        move_to(account, Registry {
            items: table::new()
        });
    }

    public fun register(
        registry: &mut Registry,
        owner: address,
        name: String,
        value: u64
    ) {
        table::add(&mut registry.items, owner, ItemInfo {
            name,
            value,
            active: true
        });
    }

    public fun lookup(
        registry: &Registry,
        owner: address
    ): &ItemInfo {
        table::borrow(&registry.items, owner)
    }

    public fun get_all_addresses(
        registry: &Registry
    ): vector<address> {
        // Return all registered addresses
        vector::empty()  // Simplified
    }
}
```

**Why this works:**

1. Central registry at known address
2. Maps addresses to information
3. Anyone can query the registry
4. Enables discovery

**Real-world analogy:**

Registry is like a phone book or DNS—a central place to look up where things are.

**Registry pattern variations:**

**1. Typed registry:**

```move
struct TypedRegistry<T: store> has key {
    items: Table<address, T>
}

public fun register<T: store>(
    registry: &mut TypedRegistry<T>,
    owner: address,
    item: T
) {
    table::add(&mut registry.items, owner, item);
}
```

**2. Multi-index registry:**

```move
struct MultiRegistry has key {
    by_address: Table<address, ItemInfo>,
    by_name: Table<String, address>,
    by_type: Table<u8, vector<address>>
}
```

**3. Paginated registry:**

```move
public fun get_page(
    registry: &Registry,
    page: u64,
    page_size: u64
): vector<address> {
    // Return page of addresses
}
```

**4. Filtered registry:**

```move
public fun find_active(
    registry: &Registry
): vector<address> {
    // Return only active items
}
```

**When to use registry:**

- Service discovery
- User directories
- Resource listings
- Global marketplaces

---

## 🎯 Activity / Exercises

### Exercise 1: Witness Pattern 🎫

**Scenario:** Build a token system with witness-protected minting.

**Boilerplate Code:**

```move
module spell_library::token_witness {
    // TODO: Define witness struct (only this module can create)
    struct MintWitness has ____ {}

    struct Token has key, store {
        value: u64,
        minted_by: address
    }

    struct MintCap has key, store {
        total_minted: u64
    }

    // TODO: Public function requiring witness
    public fun mint_token(
        _witness: ____,
        minter: address,
        amount: u64
    ): Token {
        Token {
            value: ____,
            minted_by: ____
        }
    }

    // Only this module can mint (has access to witness)
    public fun authorized_mint(
        cap: &mut MintCap,
        minter: address,
        amount: u64
    ): Token {
        cap.total_minted = cap.____ + amount;

        // TODO: Create witness and mint
        let witness = ____{};
        mint_token(____, minter, amount)
    }

    public fun create_mint_cap(): MintCap {
        MintCap { total_minted: 0 }
    }

    public fun value(token: &Token): u64 {
        token.____
    }
}

#[test_only]
module spell_library::token_witness_tests {
    use spell_library::token_witness;

    #[test]
    fun test_authorized_mint() {
        let mut cap = token_witness::create_mint_cap();
        let token = token_witness::authorized_mint(&mut cap, @0x123, 100);

        assert!(token_witness::value(&token) == ____, 1);
    }
}
```

**Your Task:**

1. Define MintWitness with drop ability
2. Complete mint_token requiring witness
3. Create witness in authorized_mint
4. Verify only module can create witness

---

### Exercise 2: Hot Potato Pattern 🥔

**Scenario:** Build a flash loan system using hot potato.

**Boilerplate Code:**

```move
module spell_library::flash_loan {
    struct FlashLoan {  // TODO: No abilities!
        amount: u64,
        fee: u64,
        loan_id: u64
    }

    struct Pool has key {
        balance: u64,
        total_loaned: u64
    }

    public fun create_pool(account: &signer) {
        move_to(account, Pool {
            balance: 0,
            total_loaned: 0
        });
    }

    public fun borrow(
        pool: &mut Pool,
        amount: u64
    ): FlashLoan acquires Pool {
        assert!(pool.balance >= ____, 100);

        pool.balance = pool.____ - amount;
        pool.total_loaned = pool.total_loaned + amount;

        // TODO: Return hot potato
        FlashLoan {
            amount: ____,
            fee: amount / 100,  // 1% fee
            loan_id: pool.____
        }
    }

    public fun repay(
        pool: &mut Pool,
        loan: ____,  // TODO: Hot potato parameter
        repayment: u64
    ) {
        let FlashLoan { amount, fee, loan_id: _ } = ____;

        assert!(repayment >= amount + ____, 101);

        pool.balance = pool.balance + ____;
        pool.total_loaned = pool.total_loaned - amount;
    }
}

#[test_only]
module spell_library::flash_loan_tests {
    use spell_library::flash_loan;

    #[test]
    fun test_flash_loan() {
        let account = @0x123;
        flash_loan::create_pool(&account);

        let mut pool = /* get pool */;

        // Borrow
        let loan = flash_loan::borrow(&mut pool, 1000);

        // TODO: Must repay! Can't ignore hot potato
        flash_loan::repay(&mut pool, ____, 1010);
    }
}
```

**Your Task:**

1. Define FlashLoan with NO abilities
2. Implement borrow creating hot potato
3. Implement repay consuming hot potato
4. Verify loan must be repaid

---

### Exercise 3: Capability + Registry Pattern 🔑

**Scenario:** Build a service registry with capability-based registration.

**Boilerplate Code:**

```move
module spell_library::service_registry {
    use std::string::String;
    use std::table::{Self, Table};

    struct RegistrarCap has key, store {}

    struct ServiceInfo has store {
        name: String,
        owner: address,
        active: bool
    }

    struct Registry has key {
        services: Table<address, ____>
    }

    public fun create_registry(account: &signer): RegistrarCap {
        move_to(account, Registry {
            services: table::____()
        });

        RegistrarCap {}
    }

    public fun register_service(
        _cap: &____,  // TODO: Require capability
        registry: &mut Registry,
        owner: address,
        name: String
    ) {
        table::add(&mut registry.____, owner, ServiceInfo {
            name: ____,
            owner: ____,
            active: true
        });
    }

    public fun lookup_service(
        registry: &Registry,
        owner: address
    ): &ServiceInfo {
        table::borrow(&registry.____, ____)
    }

    public fun deactivate_service(
        _cap: &RegistrarCap,
        registry: &mut Registry,
        owner: address
    ) {
        let service = table::borrow_mut(&mut registry.services, owner);
        service.____ = false;
    }
}

#[test_only]
module spell_library::service_registry_tests {
    use spell_library::service_registry;
    use std::string;

    #[test]
    fun test_registry() {
        let account = @0x123;
        let cap = service_registry::create_registry(&account);

        let mut registry = /* get registry */;

        service_registry::register_service(
            &____,
            &mut registry,
            @0x456,
            string::utf8(b"MyService")
        );

        let service = service_registry::lookup_service(&registry, @0x456);
        assert!(service.active == ____, 1);
    }
}
```

**Your Task:**

1. Define RegistrarCap capability
2. Require capability for registration
3. Implement lookup in registry
4. Protect deactivation with capability

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::token_witness {
    struct MintWitness has drop {}

    struct Token has key, store {
        value: u64,
        minted_by: address
    }

    struct MintCap has key, store {
        total_minted: u64
    }

    public fun mint_token(
        _witness: MintWitness,
        minter: address,
        amount: u64
    ): Token {
        Token {
            value: amount,
            minted_by: minter
        }
    }

    public fun authorized_mint(
        cap: &mut MintCap,
        minter: address,
        amount: u64
    ): Token {
        cap.total_minted = cap.total_minted + amount;

        let witness = MintWitness {};
        mint_token(witness, minter, amount)
    }

    public fun create_mint_cap(): MintCap {
        MintCap { total_minted: 0 }
    }

    public fun value(token: &Token): u64 {
        token.value
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::flash_loan {
    struct FlashLoan {
        amount: u64,
        fee: u64,
        loan_id: u64
    }

    struct Pool has key {
        balance: u64,
        total_loaned: u64
    }

    public fun create_pool(account: &signer) {
        move_to(account, Pool {
            balance: 0,
            total_loaned: 0
        });
    }

    public fun borrow(
        pool: &mut Pool,
        amount: u64
    ): FlashLoan {
        assert!(pool.balance >= amount, 100);

        pool.balance = pool.balance - amount;
        pool.total_loaned = pool.total_loaned + amount;

        FlashLoan {
            amount,
            fee: amount / 100,
            loan_id: pool.total_loaned
        }
    }

    public fun repay(
        pool: &mut Pool,
        loan: FlashLoan,
        repayment: u64
    ) {
        let FlashLoan { amount, fee, loan_id: _ } = loan;

        assert!(repayment >= amount + fee, 101);

        pool.balance = pool.balance + repayment;
        pool.total_loaned = pool.total_loaned - amount;
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::service_registry {
    use std::string::String;
    use std::table::{Self, Table};

    struct RegistrarCap has key, store {}

    struct ServiceInfo has store {
        name: String,
        owner: address,
        active: bool
    }

    struct Registry has key {
        services: Table<address, ServiceInfo>
    }

    public fun create_registry(account: &signer): RegistrarCap {
        move_to(account, Registry {
            services: table::new()
        });

        RegistrarCap {}
    }

    public fun register_service(
        _cap: &RegistrarCap,
        registry: &mut Registry,
        owner: address,
        name: String
    ) {
        table::add(&mut registry.services, owner, ServiceInfo {
            name,
            owner,
            active: true
        });
    }

    public fun lookup_service(
        registry: &Registry,
        owner: address
    ): &ServiceInfo {
        table::borrow(&registry.services, owner)
    }

    public fun deactivate_service(
        _cap: &RegistrarCap,
        registry: &mut Registry,
        owner: address
    ) {
        let service = table::borrow_mut(&mut registry.services, owner);
        service.active = false;
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Witness Pattern

**Witness proves authority:**

```move
struct MintWitness has drop {}
// Only this module can create this
```

**Public but protected:**

```move
public fun mint_token(_witness: MintWitness, ...)
// Anyone can call, but only we have witness
```

### Exercise 2 Explanation: Hot Potato

**No abilities = must handle:**

```move
struct FlashLoan { ... }  // No drop!
// Compiler forces you to destructure
```

**Enforced repayment:**

```move
let loan = borrow(...);
// Must call repay(loan) or code won't compile
```

### Exercise 3 Explanation: Patterns Combined

**Capability protects actions:**

```move
public fun register_service(_cap: &RegistrarCap, ...)
// Need capability to register
```

**Registry enables discovery:**

```move
public fun lookup_service(registry: &Registry, owner: address)
// Anyone can lookup, only cap holders can modify
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::pattern_tests {
    use spell_library::token_witness_tests;
    use spell_library::flash_loan_tests;
    use spell_library::service_registry_tests;

    #[test]
    fun run_witness_tests() {
        token_witness_tests::test_authorized_mint();
    }

    #[test]
    fun run_flash_loan_tests() {
        flash_loan_tests::test_flash_loan();
    }

    #[test]
    fun run_registry_tests() {
        service_registry_tests::test_registry();
    }
}
```

---

## 🌟 Closing Story

Master Architect stands with Odessa in the Hall of Mastery, surrounded by the crystalline patterns that define professional Move development.

> "You've mastered the fundamental patterns," the architect says with satisfaction. "Witness proves authority. Hot potato enforces handling. Capabilities represent permissions. Singletons ensure uniqueness. Registries enable discovery."

> "These aren't just patterns—they're the vocabulary of professional Move code. When you see a witness, you know it's about authority. When you see a hot potato, you know it's about enforcement. When you see capabilities, you know it's about permissions."

The master gestures to the patterns.

> "Remember: patterns aren't about being clever. They're about solving common problems in proven ways. Use witness for authority, hot potato for enforcement, capabilities for permissions, singletons for global state, registries for discovery."

The architect's form radiates knowledge.

> "Your next lesson: multi-module architecture. You'll learn how to organize large codebases, manage dependencies, design module boundaries, and build scalable systems. Patterns taught you solutions. Architecture will teach you organization."

The hall fades into structured light.

> "Go. Use these patterns. Build secure systems. Trust the designs that have proven themselves."

---

**Next Lesson:** Multi-Module Architecture - organizing large codebases and managing dependencies.
