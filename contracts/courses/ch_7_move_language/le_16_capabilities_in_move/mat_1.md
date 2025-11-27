## Background Story

Odessa enters the Hall of Authority—a vast chamber where permissions take physical form. At the center floats Master Certus, Guardian of Capabilities, surrounded by glowing tokens that represent different levels of power and access.

"In the traditional world," Certus begins, voice resonating with authority, "permissions are handled through external systems. A database tracks who can do what. An admin panel controls access. Users have roles stored separately from the code."

The master gestures, and the glowing tokens coalesce into distinct shapes.

"Move takes a radically different approach: **capabilities are objects**. A capability is a piece of data that proves you have permission. If you possess the `AdminCap` struct, you have admin rights. If you don't possess it, you don't. It's that simple—and that powerful."

Certus pulls down a capability, showing its structure.

"This isn't just clever design—it's revolutionary security. Capabilities can be transferred. They can be stored. They can be destroyed. They follow all of Move's ownership rules, which means the type system enforces permission logic. You can't fake a capability. You can't duplicate it. You can't access it without ownership."

The master's eyes glow with intensity.

"Today, you'll master the capability pattern. You'll learn how to design permission systems that are impossible to break, easy to reason about, and naturally composable. By the end, you won't just understand capabilities—you'll see how they transform blockchain security."

The hall illuminates with countless capability patterns.

"Let's begin."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Capability Basics: What Are Capabilities?**

A capability is a struct that represents permission. Possessing the struct means you have the permission.

**What problem do capabilities solve?**

Traditional permission systems:

```solidity
// Solidity: Permissions stored in mappings
mapping(address => bool) public admins;

function privilegedAction() public {
    require(admins[msg.sender], "Not admin");
    // Do privileged thing
}
```

Problems with this approach:

- Permissions are external to the action
- Can be complex to manage
- Checking requires storage lookup
- Revocation needs special logic

**Move's capability approach:**

```move
module spell_library::capability_basics {
    // The capability itself
    struct AdminCap has key, store {}

    // Privileged action requires the capability
    public fun privileged_action(_cap: &AdminCap) {
        // If caller has AdminCap, they can call this
        // Type system enforces this!
    }
}
```

**Why this is better:**

1. **Type-safe**: Can't call privileged functions without the right capability
2. **Explicit**: Function signature shows what permission is needed
3. **Transferable**: Capabilities can be given to others
4. **Composable**: Multiple capabilities can work together
5. **No storage lookups**: Possession is proof

**Basic capability pattern:**

```move
module spell_library::simple_cap {
    // Define the capability
    struct AdminCap has key, store {
        // Empty struct is fine—possession is what matters
    }

    struct Resource has key {
        value: u64
    }

    // Only way to get AdminCap
    public fun initialize_admin(): AdminCap {
        AdminCap {}
    }

    // Requires admin capability
    public fun admin_set_value(
        _cap: &AdminCap,  // Must provide admin capability
        resource: &mut Resource,
        new_value: u64
    ) {
        resource.value = new_value;
    }

    // No capability required—anyone can read
    public fun get_value(resource: &Resource): u64 {
        resource.value
    }
}
```

**How capabilities work:**

```move
public fun usage_example() {
    // Step 1: Get the capability (usually one-time initialization)
    let admin_cap = initialize_admin();

    // Step 2: Create resource
    let mut resource = Resource { value: 0 };

    // Step 3: Use capability to perform privileged action
    admin_set_value(&admin_cap, &mut resource, 100);
    // ✅ Works because we have admin_cap

    // Step 4: Try without capability
    // admin_set_value(???, &mut resource, 200);
    // ❌ Can't call—no admin_cap available!
}
```

**Capability with data:**

```move
struct AdminCap has key, store {
    admin_level: u64  // Different levels of admin
}

public fun create_admin(level: u64): AdminCap {
    assert!(level > 0 && level <= 10, 1);
    AdminCap { admin_level: level }
}

public fun admin_action(
    cap: &AdminCap,
    required_level: u64
) {
    assert!(cap.admin_level >= required_level, 100);
    // Perform action
}
```

### 2️⃣ **Permission Models: Designing Access Control**

Different permission models for different use cases.

**Model 1: Single admin capability**

Simple case: One admin controls everything.

```move
module spell_library::single_admin {
    struct AdminCap has key, store {}

    struct System has key {
        data: u64
    }

    // Initialize system and get admin capability
    public fun initialize(): (System, AdminCap) {
        (
            System { data: 0 },
            AdminCap {}
        )
    }

    // Only admin can modify
    public fun set_data(_cap: &AdminCap, system: &mut System, value: u64) {
        system.data = value;
    }
}
```

**Model 2: Multiple capability types**

Complex case: Different capabilities for different actions.

```move
module spell_library::multi_cap {
    // Different capabilities for different permissions
    struct AdminCap has key, store {}
    struct ModeratorCap has key, store {}
    struct ReaderCap has key, store {}

    struct System has key {
        sensitive_data: u64,
        public_data: u64
    }

    // Admin can do everything
    public fun admin_set_sensitive(
        _cap: &AdminCap,
        system: &mut System,
        value: u64
    ) {
        system.sensitive_data = value;
    }

    // Moderator has limited access
    public fun moderator_set_public(
        _cap: &ModeratorCap,
        system: &mut System,
        value: u64
    ) {
        system.public_data = value;
    }

    // Reader can only view
    public fun reader_view(
        _cap: &ReaderCap,
        system: &System
    ): (u64, u64) {
        (system.sensitive_data, system.public_data)
    }

    // Anyone can view public data
    public fun view_public(system: &System): u64 {
        system.public_data
    }
}
```

**Model 3: Hierarchical capabilities**

Admin creates lower-level capabilities:

```move
module spell_library::hierarchical {
    struct AdminCap has key, store {}
    struct OperatorCap has key, store {
        created_by: address  // Track who created this
    }

    // Admin creates operator capabilities
    public fun admin_create_operator(
        _admin: &AdminCap,
        operator_address: address
    ): OperatorCap {
        OperatorCap {
            created_by: operator_address
        }
    }

    // Admin can revoke (by destroying the capability)
    public fun admin_revoke_operator(
        _admin: &AdminCap,
        operator_cap: OperatorCap
    ) {
        let OperatorCap { created_by: _ } = operator_cap;
        // Capability destroyed—operator loses access
    }
}
```

**Model 4: Time-limited capabilities**

Capabilities that expire:

```move
module spell_library::time_limited {
    struct TemporaryCap has key, store {
        expires_at: u64  // Timestamp
    }

    public fun create_temporary(duration: u64): TemporaryCap {
        let current_time = get_current_time();
        TemporaryCap {
            expires_at: current_time + duration
        }
    }

    public fun use_temporary_cap(cap: &TemporaryCap) {
        let current_time = get_current_time();
        assert!(current_time < cap.expires_at, 100);
        // Use capability
    }

    fun get_current_time(): u64 {
        // In real code, use blockchain timestamp
        1000
    }
}
```

**Model 5: Quantity-limited capabilities**

Capabilities with usage limits:

```move
module spell_library::quantity_limited {
    struct LimitedCap has key, store {
        uses_remaining: u64
    }

    public fun create_limited(uses: u64): LimitedCap {
        assert!(uses > 0, 1);
        LimitedCap { uses_remaining: uses }
    }

    public fun use_limited_cap(cap: &mut LimitedCap) {
        assert!(cap.uses_remaining > 0, 100);
        cap.uses_remaining = cap.uses_remaining - 1;
        // Use capability
    }

    public fun remaining_uses(cap: &LimitedCap): u64 {
        cap.uses_remaining
    }
}
```

### 3️⃣ **Transferable Capabilities: Delegation and Ownership**

Capabilities can be transferred, enabling powerful delegation patterns.

**What does transferable mean?**

A capability with `store` ability can be:

- Given to another address
- Stored in another struct
- Moved between owners

```move
struct TransferableCap has key, store {
    // `store` ability makes this transferable
    power: u64
}
```

**Transfer pattern 1: Direct transfer**

```move
module spell_library::direct_transfer {
    struct OwnerCap has key, store {}

    // Transfer capability to another address
    public fun transfer_ownership(cap: OwnerCap, new_owner: address) {
        // In real Move, would use transfer or move_to
        // This gives ownership to new_owner
    }
}
```

**Transfer pattern 2: Delegation with returned capability**

Temporarily delegate, then return:

```move
module spell_library::delegation {
    struct AdminCap has key, store {}

    public fun delegate_action<T>(
        cap: AdminCap,
        action: |AdminCap| -> (AdminCap, T)
    ): (AdminCap, T) {
        // Call action with capability
        let (returned_cap, result) = action(cap);
        (returned_cap, result)
    }
}
```

**Transfer pattern 3: Capability marketplace**

Trade capabilities:

```move
module spell_library::cap_marketplace {
    use std::vector;

    struct Marketplace has key {
        listings: vector<Listing>
    }

    struct Listing has store {
        cap_holder: address,
        price: u64
    }

    struct TradableCap has key, store {
        power: u64
    }

    public fun list_capability(
        _cap: &TradableCap,
        marketplace: &mut Marketplace,
        seller: address,
        price: u64
    ) {
        let listing = Listing {
            cap_holder: seller,
            price
        };
        vector::push_back(&mut marketplace.listings, listing);
    }

    // Buy capability (would involve actual transfer in production)
    public fun buy_capability(
        marketplace: &mut Marketplace,
        index: u64,
        payment: u64
    ): address {
        let listing = vector::swap_remove(&mut marketplace.listings, index);
        assert!(payment >= listing.price, 100);
        listing.cap_holder
    }
}
```

**Delegated capabilities with constraints:**

```move
module spell_library::constrained_delegation {
    struct MasterCap has key, store {}

    struct DelegatedCap has key, store {
        max_amount: u64,
        delegated_from: address
    }

    // Master creates constrained delegation
    public fun create_delegate(
        _master: &MasterCap,
        delegator: address,
        max_amount: u64
    ): DelegatedCap {
        DelegatedCap {
            max_amount,
            delegated_from: delegator
        }
    }

    // Delegate can only use up to max_amount
    public fun delegate_action(
        cap: &DelegatedCap,
        amount: u64
    ) {
        assert!(amount <= cap.max_amount, 100);
        // Perform constrained action
    }
}
```

### 4️⃣ **Capability Composition: Combining Permissions**

Multiple capabilities can work together for complex permission models.

**Pattern 1: AND composition (require multiple capabilities)**

```move
module spell_library::and_composition {
    struct AdminCap has key, store {}
    struct AuditorCap has key, store {}

    // Requires BOTH capabilities
    public fun sensitive_action(
        _admin: &AdminCap,
        _auditor: &AuditorCap,
        amount: u64
    ) {
        // Can only call if you have both AdminCap AND AuditorCap
        // Implements two-person rule
    }
}
```

**Pattern 2: OR composition (accept any of several capabilities)**

```move
module spell_library::or_composition {
    struct AdminCap has key, store {}
    struct OwnerCap has key, store {}

    // Accept either capability
    public fun privileged_action_admin(
        _cap: &AdminCap
    ) {
        internal_privileged_action()
    }

    public fun privileged_action_owner(
        _cap: &OwnerCap
    ) {
        internal_privileged_action()
    }

    fun internal_privileged_action() {
        // Actual privileged logic
    }
}
```

**Pattern 3: Capability aggregation**

Combine multiple capabilities into one:

```move
module spell_library::aggregation {
    struct ReadCap has store {}
    struct WriteCap has store {}
    struct DeleteCap has store {}

    struct SuperCap has key, store {
        read: ReadCap,
        write: WriteCap,
        delete: DeleteCap
    }

    public fun create_super_cap(): SuperCap {
        SuperCap {
            read: ReadCap {},
            write: WriteCap {},
            delete: DeleteCap {}
        }
    }

    // Can use individual capabilities
    public fun read_action(cap: &SuperCap) {
        // Use cap.read
    }

    public fun write_action(cap: &SuperCap) {
        // Use cap.write
    }

    public fun delete_action(cap: &SuperCap) {
        // Use cap.delete
    }
}
```

**Pattern 4: Capability inheritance**

Higher-level capabilities include lower-level ones:

```move
module spell_library::inheritance {
    struct UserCap has store {
        user_id: address
    }

    struct ModeratorCap has store {
        user: UserCap,
        moderator_level: u64
    }

    struct AdminCap has key, store {
        moderator: ModeratorCap
    }

    // Admin can do anything moderator can do
    public fun admin_moderate(admin: &AdminCap) {
        let moderator_ref = &admin.moderator;
        // Use moderator capabilities
    }

    // Admin can do anything user can do
    public fun admin_as_user(admin: &AdminCap) {
        let user_ref = &admin.moderator.user;
        // Use user capabilities
    }
}
```

### 5️⃣ **Advanced Capability Patterns**

Professional patterns for production systems.

**Pattern 1: Witness pattern with capabilities**

One-time initialization proof:

```move
module spell_library::witness_cap {
    struct WITNESS has drop {}

    struct ProtectedCap has key, store {}

    // Can only be called once (witness can only be created once)
    public fun initialize(_witness: WITNESS): ProtectedCap {
        ProtectedCap {}
    }
}
```

**Pattern 2: Hot potato pattern**

Capability must be consumed:

```move
module spell_library::hot_potato {
    struct MustUse {
        // No abilities—can't drop, can't store
        value: u64
    }

    public fun create_must_use(): MustUse {
        MustUse { value: 42 }
    }

    // Must call this to consume MustUse
    public fun consume(potato: MustUse): u64 {
        let MustUse { value } = potato;
        value
    }

    // Example forcing pattern
    public fun operation(): u64 {
        let potato = create_must_use();
        // Must consume before returning
        consume(potato)
    }
}
```

**Pattern 3: Capability registry**

Central registry of all capabilities:

```move
module spell_library::cap_registry {
    use std::vector;

    struct Registry has key {
        admins: vector<address>,
        moderators: vector<address>
    }

    struct AdminCap has key, store {
        holder: address
    }

    public fun register_admin(
        registry: &mut Registry,
        admin: address
    ) {
        vector::push_back(&mut registry.admins, admin);
    }

    public fun verify_admin(
        registry: &Registry,
        cap: &AdminCap
    ): bool {
        vector::contains(&registry.admins, &cap.holder)
    }
}
```

**Pattern 4: Revocable capabilities**

Capabilities that can be checked against a revocation list:

```move
module spell_library::revocable {
    use std::vector;

    struct RevocableCap has key, store {
        id: u64,
        holder: address
    }

    struct RevocationList has key {
        revoked_ids: vector<u64>
    }

    public fun create_revocable(id: u64, holder: address): RevocableCap {
        RevocableCap { id, holder }
    }

    public fun revoke(
        list: &mut RevocationList,
        cap_id: u64
    ) {
        vector::push_back(&mut list.revoked_ids, cap_id);
    }

    public fun verify_not_revoked(
        list: &RevocationList,
        cap: &RevocableCap
    ): bool {
        !vector::contains(&list.revoked_ids, &cap.id)
    }

    public fun use_revocable_cap(
        list: &RevocationList,
        cap: &RevocableCap
    ) {
        assert!(verify_not_revoked(list, cap), 100);
        // Use capability
    }
}
```

**Pattern 5: Tiered capability system**

Different tiers unlock different features:

```move
module spell_library::tiered {
    struct Tier1Cap has key, store {}
    struct Tier2Cap has key, store {
        tier1: Tier1Cap
    }
    struct Tier3Cap has key, store {
        tier2: Tier2Cap
    }

    public fun upgrade_to_tier2(tier1: Tier1Cap): Tier2Cap {
        Tier2Cap { tier1 }
    }

    public fun upgrade_to_tier3(tier2: Tier2Cap): Tier3Cap {
        Tier3Cap { tier2 }
    }

    // Tier 3 can do anything tier 1 can do
    public fun use_as_tier1(tier3: &Tier3Cap) {
        let tier1_ref = &tier3.tier2.tier1;
        // Use tier1 capabilities
    }
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Basic Capability System 🔑

**Scenario:** Build a document management system with admin and editor capabilities.

**Boilerplate Code:**

```move
module spell_library::document_system {
    use std::string::{Self, String};

    // TODO: Define AdminCap
    struct AdminCap has ____, ____ {}

    // TODO: Define EditorCap
    struct EditorCap has key, store {}

    struct Document has key {
        content: String,
        author: address
    }

    // Initialize system and return admin capability
    public fun initialize(): AdminCap {
        // TODO: Create and return AdminCap
        AdminCap {}
    }

    // Admin creates editor capabilities
    public fun create_editor(
        _admin: &____,
        editor_address: address
    ): EditorCap {
        // TODO: Create EditorCap
        EditorCap {}
    }

    // Create document (anyone can create)
    public fun create_document(author: address, content: String): Document {
        Document {
            content: ____,
            author: ____
        }
    }

    // Edit document (requires EditorCap or AdminCap)
    public fun edit_as_editor(
        _cap: &EditorCap,
        doc: &mut Document,
        new_content: String
    ) {
        // TODO: Update document content
        doc.content = ____;
    }

    public fun edit_as_admin(
        _cap: &____,
        doc: &mut Document,
        new_content: String
    ) {
        // TODO: Update document content
        doc.____ = new_content;
    }

    // Anyone can read
    public fun read_document(doc: &Document): String {
        doc.____
    }
}

#[test_only]
module spell_library::document_tests {
    use spell_library::document_system;
    use std::string;

    #[test]
    fun test_admin_creation() {
        let admin = document_system::initialize();
        // Admin created successfully
    }

    #[test]
    fun test_editor_creation() {
        let admin = document_system::initialize();
        let editor = document_system::create_editor(&admin, @0x123);
        // Editor created successfully
    }

    #[test]
    fun test_document_editing() {
        let admin = document_system::initialize();
        let editor = document_system::create_editor(&admin, @0x123);

        let mut doc = document_system::create_document(
            @0x456,
            string::utf8(b"Original content")
        );

        document_system::edit_as_editor(
            &editor,
            &mut doc,
            string::utf8(b"Edited content")
        );

        let content = document_system::read_document(&doc);
        assert!(content == string::utf8(b"Edited content"), 1);
    }
}
```

**Your Task:**

1. Define AdminCap and EditorCap with correct abilities
2. Implement capability creation
3. Implement edit functions with capability checks
4. Complete document operations
5. Verify capability-based access control

---

### Exercise 2: Hierarchical Permission System 🏛️

**Scenario:** Build a multi-tier permission system with delegation.

**Boilerplate Code:**

```move
module spell_library::hierarchy {
    use std::vector;

    struct MasterCap has key, store {}

    struct ManagerCap has key, store {
        created_by: address,
        team_size: u64
    }

    struct WorkerCap has key, store {
        manager: address
    }

    struct Vault has key {
        balance: u64,
        authorized_managers: vector<address>
    }

    // Initialize with master capability
    public fun initialize(): (Vault, MasterCap) {
        (
            Vault {
                balance: 0,
                authorized_managers: vector::empty()
            },
            MasterCap {}
        )
    }

    // Master creates managers
    public fun create_manager(
        _master: &____,
        vault: &mut Vault,
        manager_address: address,
        team_size: u64
    ): ManagerCap {
        // TODO: Add manager to authorized list
        vector::push_back(&mut vault.____, manager_address);

        // TODO: Create and return ManagerCap
        ManagerCap {
            created_by: ____,
            team_size: ____
        }
    }

    // Manager creates workers
    public fun create_worker(
        manager: &ManagerCap,
        worker_address: address
    ): WorkerCap {
        // TODO: Create WorkerCap
        WorkerCap {
            manager: manager.____
        }
    }

    // Master can add funds
    public fun master_add_funds(
        _cap: &MasterCap,
        vault: &mut Vault,
        amount: u64
    ) {
        vault.____ = vault.balance + amount;
    }

    // Manager can withdraw (limited by team_size)
    public fun manager_withdraw(
        cap: &ManagerCap,
        vault: &mut Vault,
        amount: u64
    ) {
        // TODO: Check manager is authorized
        assert!(vector::contains(&vault.authorized_managers, &cap.____), 100);

        // TODO: Check amount <= team_size * 100
        assert!(amount <= cap.____ * 100, 101);

        vault.balance = vault.balance - amount;
    }

    // Worker can view balance
    public fun worker_view_balance(
        _cap: &WorkerCap,
        vault: &Vault
    ): u64 {
        vault.____
    }
}

#[test_only]
module spell_library::hierarchy_tests {
    use spell_library::hierarchy;

    #[test]
    fun test_hierarchy() {
        let (mut vault, master) = hierarchy::initialize();

        // Master adds funds
        hierarchy::master_add_funds(&master, &mut vault, 1000);

        // Master creates manager
        let manager = hierarchy::create_manager(
            &master,
            &mut vault,
            @0x123,
            5  // Team size 5
        );

        // Manager creates worker
        let worker = hierarchy::create_worker(&manager, @0x456);

        // Worker views balance
        let balance = hierarchy::worker_view_balance(&worker, &vault);
        assert!(balance == ____, 1);

        // Manager withdraws
        hierarchy::manager_withdraw(&manager, &mut vault, 400);
        // 400 <= 5 * 100, so should work

        let new_balance = hierarchy::worker_view_balance(&worker, &vault);
        assert!(new_balance == ____, 2);
    }
}
```

**Your Task:**

1. Complete manager creation and authorization
2. Implement worker capability creation
3. Add manager withdrawal with constraints
4. Implement balance viewing
5. Test hierarchical permissions

---

### Exercise 3: Advanced Capability Patterns 🔐

**Scenario:** Build a time-limited and usage-limited capability system.

**Boilerplate Code:**

```move
module spell_library::advanced_caps {
    struct TimeLimitedCap has key, store {
        expires_at: u64,
        owner: address
    }

    struct UsageLimitedCap has key, store {
        uses_remaining: u64,
        max_amount_per_use: u64
    }

    struct Resource has key {
        value: u64
    }

    // Create time-limited capability
    public fun create_time_limited(
        owner: address,
        duration: u64
    ): TimeLimitedCap {
        let current_time = 1000u64;  // Mock timestamp
        TimeLimitedCap {
            expires_at: current_time + ____,
            owner: ____
        }
    }

    // Create usage-limited capability
    public fun create_usage_limited(
        uses: u64,
        max_per_use: u64
    ): UsageLimitedCap {
        assert!(uses > ____, 1);
        UsageLimitedCap {
            uses_remaining: ____,
            max_amount_per_use: ____
        }
    }

    // Use time-limited capability
    public fun use_time_limited(
        cap: &TimeLimitedCap,
        resource: &mut Resource,
        amount: u64
    ) {
        let current_time = 1000u64;  // Mock timestamp

        // TODO: Check not expired
        assert!(current_time < cap.____, 100);

        resource.value = resource.value + amount;
    }

    // Use usage-limited capability
    public fun use_usage_limited(
        cap: &mut UsageLimitedCap,
        resource: &mut Resource,
        amount: u64
    ) {
        // TODO: Check uses remaining
        assert!(cap.____ > 0, 101);

        // TODO: Check amount limit
        assert!(amount <= cap.____, 102);

        // TODO: Decrement uses
        cap.uses_remaining = cap.____ - 1;

        resource.value = resource.value + amount;
    }

    public fun get_remaining_uses(cap: &UsageLimitedCap): u64 {
        cap.____
    }

    public fun is_expired(cap: &TimeLimitedCap, current_time: u64): bool {
        current_time >= cap.____
    }
}

#[test_only]
module spell_library::advanced_tests {
    use spell_library::advanced_caps;

    #[test]
    fun test_time_limited() {
        let cap = advanced_caps::create_time_limited(@0x123, 500);
        let mut resource = advanced_caps::Resource { value: 0 };

        advanced_caps::use_time_limited(&cap, &mut resource, 100);
        assert!(resource.value == ____, 1);
    }

    #[test]
    fun test_usage_limited() {
        let mut cap = advanced_caps::create_usage_limited(3, 50);
        let mut resource = advanced_caps::Resource { value: 0 };

        advanced_caps::use_usage_limited(&mut cap, &mut resource, 30);
        assert!(advanced_caps::get_remaining_uses(&cap) == ____, 1);

        advanced_caps::use_usage_limited(&mut cap, &mut resource, 40);
        assert!(advanced_caps::get_remaining_uses(&cap) == ____, 2);
    }

    #[test]
    #[expected_failure]
    fun test_usage_limit_exceeded() {
        let mut cap = advanced_caps::create_usage_limited(1, 50);
        let mut resource = advanced_caps::Resource { value: 0 };

        // First use succeeds
        advanced_caps::use_usage_limited(&mut cap, &mut resource, 30);

        // Second use should fail
        advanced_caps::use_usage_limited(&mut cap, &mut resource, 30);
    }
}
```

**Your Task:**

1. Implement time-limited capability creation
2. Implement usage-limited capability creation
3. Add expiration checking
4. Add usage limit checking and decrementing
5. Test both capability types

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::document_system {
    use std::string::{Self, String};

    struct AdminCap has key, store {}
    struct EditorCap has key, store {}

    struct Document has key {
        content: String,
        author: address
    }

    public fun initialize(): AdminCap {
        AdminCap {}
    }

    public fun create_editor(
        _admin: &AdminCap,
        editor_address: address
    ): EditorCap {
        EditorCap {}
    }

    public fun create_document(author: address, content: String): Document {
        Document { content, author }
    }

    public fun edit_as_editor(
        _cap: &EditorCap,
        doc: &mut Document,
        new_content: String
    ) {
        doc.content = new_content;
    }

    public fun edit_as_admin(
        _cap: &AdminCap,
        doc: &mut Document,
        new_content: String
    ) {
        doc.content = new_content;
    }

    public fun read_document(doc: &Document): String {
        doc.content
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::hierarchy {
    use std::vector;

    struct MasterCap has key, store {}
    struct ManagerCap has key, store {
        created_by: address,
        team_size: u64
    }
    struct WorkerCap has key, store {
        manager: address
    }

    struct Vault has key {
        balance: u64,
        authorized_managers: vector<address>
    }

    public fun initialize(): (Vault, MasterCap) {
        (
            Vault {
                balance: 0,
                authorized_managers: vector::empty()
            },
            MasterCap {}
        )
    }

    public fun create_manager(
        _master: &MasterCap,
        vault: &mut Vault,
        manager_address: address,
        team_size: u64
    ): ManagerCap {
        vector::push_back(&mut vault.authorized_managers, manager_address);
        ManagerCap {
            created_by: manager_address,
            team_size
        }
    }

    public fun create_worker(
        manager: &ManagerCap,
        worker_address: address
    ): WorkerCap {
        WorkerCap {
            manager: manager.created_by
        }
    }

    public fun master_add_funds(
        _cap: &MasterCap,
        vault: &mut Vault,
        amount: u64
    ) {
        vault.balance = vault.balance + amount;
    }

    public fun manager_withdraw(
        cap: &ManagerCap,
        vault: &mut Vault,
        amount: u64
    ) {
        assert!(vector::contains(&vault.authorized_managers, &cap.created_by), 100);
        assert!(amount <= cap.team_size * 100, 101);
        vault.balance = vault.balance - amount;
    }

    public fun worker_view_balance(
        _cap: &WorkerCap,
        vault: &Vault
    ): u64 {
        vault.balance
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::advanced_caps {
    struct TimeLimitedCap has key, store {
        expires_at: u64,
        owner: address
    }

    struct UsageLimitedCap has key, store {
        uses_remaining: u64,
        max_amount_per_use: u64
    }

    struct Resource has key {
        value: u64
    }

    public fun create_time_limited(
        owner: address,
        duration: u64
    ): TimeLimitedCap {
        let current_time = 1000u64;
        TimeLimitedCap {
            expires_at: current_time + duration,
            owner
        }
    }

    public fun create_usage_limited(
        uses: u64,
        max_per_use: u64
    ): UsageLimitedCap {
        assert!(uses > 0, 1);
        UsageLimitedCap {
            uses_remaining: uses,
            max_amount_per_use: max_per_use
        }
    }

    public fun use_time_limited(
        cap: &TimeLimitedCap,
        resource: &mut Resource,
        amount: u64
    ) {
        let current_time = 1000u64;
        assert!(current_time < cap.expires_at, 100);
        resource.value = resource.value + amount;
    }

    public fun use_usage_limited(
        cap: &mut UsageLimitedCap,
        resource: &mut Resource,
        amount: u64
    ) {
        assert!(cap.uses_remaining > 0, 101);
        assert!(amount <= cap.max_amount_per_use, 102);
        cap.uses_remaining = cap.uses_remaining - 1;
        resource.value = resource.value + amount;
    }

    public fun get_remaining_uses(cap: &UsageLimitedCap): u64 {
        cap.uses_remaining
    }

    public fun is_expired(cap: &TimeLimitedCap, current_time: u64): bool {
        current_time >= cap.expires_at
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Basic Capabilities

**Capabilities as permission proof:**

```move
struct AdminCap has key, store {}
// Possession = permission
// No AdminCap = no admin rights
```

**Type-safe access control:**

```move
public fun edit_as_admin(_cap: &AdminCap, ...)
// Function signature REQUIRES AdminCap
// Can't call without it!
```

### Exercise 2 Explanation: Hierarchy

**Hierarchical delegation:**

```move
Master → Manager → Worker
// Each level can create next level
// Each level has constrained permissions
```

**Manager constraints:**

```move
assert!(amount <= cap.team_size * 100, 101);
// Manager's power limited by team_size
// Encoded in capability itself
```

### Exercise 3 Explanation: Advanced Patterns

**Time-limited capabilities:**

```move
assert!(current_time < cap.expires_at, 100);
// Capability becomes invalid after expiration
// Automatic time-based revocation
```

**Usage-limited capabilities:**

```move
cap.uses_remaining = cap.uses_remaining - 1;
// Capability depletes with use
// Eventually becomes unusable
```

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::capability_lesson_tests {
    use spell_library::document_tests;
    use spell_library::hierarchy_tests;
    use spell_library::advanced_tests;

    #[test]
    fun run_all_document_tests() {
        document_tests::test_admin_creation();
        document_tests::test_editor_creation();
        document_tests::test_document_editing();
    }

    #[test]
    fun run_all_hierarchy_tests() {
        hierarchy_tests::test_hierarchy();
    }

    #[test]
    fun run_all_advanced_tests() {
        advanced_tests::test_time_limited();
        advanced_tests::test_usage_limited();
    }

    #[test]
    #[expected_failure]
    fun verify_usage_limit() {
        advanced_tests::test_usage_limit_exceeded();
    }
}
```

---

## 🌟 Closing Story

Master Certus stands with Odessa in the Hall of Authority, now fully illuminated. The capability patterns glow with perfect clarity—each permission model, each delegation strategy, each composition pattern understood completely.

> "You've mastered capabilities," Certus says, voice filled with satisfaction. "You understand that permissions are not external checks—they are objects. Possessing a capability proves you have permission. The type system enforces this. You can't fake it. You can't bypass it."

> "This is revolutionary security. In traditional systems, permission checks can be forgotten. Bugs can allow unauthorized access. In Move, if a function requires AdminCap, you MUST have AdminCap. The compiler enforces it. The runtime enforces it. There's no way around it."

The master gestures to the glowing patterns.

> "You've learned single capabilities, multiple capability types, hierarchical systems, transferable capabilities, composition patterns, time limits, usage limits, witness patterns, hot potato patterns, and revocation strategies. You can now design permission systems that are impossible to break."

Certus's form radiates authority.

> "Remember: capabilities are transferable, composable, and type-safe. Use them for admin rights, for delegation, for marketplace trading, for anything requiring permissions. They're your most powerful security tool."

The hall begins to transform, showing new patterns.

> "Your next lesson: event-driven architecture. You'll learn how to emit events, how to track changes, how to build systems that respond to state transitions. Capabilities gave you security. Events will give you observability."

The guardian bows.

> "Go. Build secure systems. Use capabilities. Trust the type system. The blockchain rewards those who design security correctly."

---

**Next Lesson:** Event-Driven Architecture - building observable, reactive systems in Move.
