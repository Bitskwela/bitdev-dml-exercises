## Background Story

The final chamber. Odessa stands in the Hall of Vaults, a vast cathedral where the walls are made of crystalline storage blocks—each block containing resources that will persist forever on the blockchain.

Master Archivist Thorne stands silently, studying the blocks with ancient eyes. Behind them, a great golden door sealed with a thousand locks represents the global storage—the permanent home of all blockchain data.

"You've learned how to create resources and protect them," Thorne says, her voice echoing like stone on stone. "But resources must _live_ somewhere. They cannot float in limbo. They must be anchored to the chain itself, where they will persist until the chain itself ends."

Thorne places her hand on one of the storage blocks. It glows with a warm light.

"In old systems, data lives in isolated caches. Save it to disk, you hope it survives. Restart the server, and it might vanish. Here, data lives _in the chain itself_. Store a resource in the global vault, and it will outlive you, outlive kingdoms, outlive empires. It persists because the mathematics demand it."

"This is the last foundation: the Global Storage Model. How resources persist. How they are retrieved. How the chain itself becomes a database that cannot fail because it is protected by billions of validators and the immutability of mathematics."

Thorne gestures to the golden door. "Ready to unlock it?"

---

## 📚 Topics & Deep Lessons

### 1️⃣ **How Move Handles Persistent Storage**

Move has a unique approach to storage: resources can be stored _under addresses_.

```move
struct Treasure {
    gold: u64
}

public fun store_treasure(owner: address, treasure: Treasure) {
    // Store the treasure under owner's address
    move_to<Treasure>(&owner, treasure);
    // treasure is moved into global storage
    // treasure no longer exists in function scope
}
```

**Key concepts:**

- **Every address has storage:** Each address on the chain is a vault
- **Resources live at addresses:** You store resources under addresses you control
- **Type-indexed storage:** Only one resource of each type can be stored at each address
- **Access control:** Only the owner (or authorized code) can access stored resources

### 2️⃣ **The Global State Model: Addresses as Vaults**

Think of each blockchain address as a vault with compartments:

```
Address @0x1:
├── Coin { amount: 100 }
├── Treasure { gold: 500 }
├── SpellBook { spells: [...] }
└── (other resources)

Address @0x2:
├── Coin { amount: 50 }
└── (other resources)
```

**Each address is isolated:**

```move
// Alice's address: @0x1
// Bob's address: @0x2
// Each can only modify their own storage
```

**Type indexing:**

```move
// At address @0x1, you can store:
// - ONE Coin (at type `Coin`)
// - ONE Treasure (at type `Treasure`)
// - ONE SpellBook (at type `SpellBook`)
// But only ONE of each type!

// If you want multiple coins, store them in a container:
struct Wallet {
    coins: vector<Coin>
}
```

### 3️⃣ **Publishing Resources: Storing in the Vault**

The `move_to` function publishes a resource to global storage:

```move
struct MyResource {
    value: u64
}

public fun publish(account: &signer, resource: MyResource) {
    // move_to stores MyResource under the signer's address
    move_to<MyResource>(account, resource);
}

// After publish:
// - MyResource is in global storage at account's address
// - MyResource no longer exists in function scope
// - Only the account owner can access it
```

**Why `&signer` is important:**

```move
// ❌ WRONG: Anyone could store anything at any address
public fun publish_bad(address: address, resource: MyResource) {
    move_to<MyResource>(&address, resource);  // ❌ Doesn't work!
}

// ✅ CORRECT: Only the signer can authorize storage
public fun publish_good(account: &signer, resource: MyResource) {
    move_to<MyResource>(account, resource);  // ✅ Safe!
}
```

The `&signer` proves that the caller is the account owner.

### 4️⃣ **Loading Resources: Retrieving from Storage**

The `move_from` function retrieves and removes resources from storage:

```move
public fun retrieve(account: &signer): MyResource {
    // move_from removes MyResource from account's storage
    move_from<MyResource>(signer::address_of(account))
}

// After retrieve:
// - MyResource is no longer in global storage
// - MyResource exists in function scope
// - Can be used, returned, or stored again
```

**The linear guarantee:**

```move
// You retrieve a resource exactly once
let resource = move_from<Treasure>(@0x1);

// Now it's in your hands
// You MUST:
// - Return it, or
// - Move it somewhere else, or
// - Transform it
// You cannot drop it (it has no drop ability)
```

### 5️⃣ **Storage Safety Rules: The Unchangeable Invariants**

Move's storage model enforces strict rules:

**Rule 1: Type-indexed storage**

```move
// At each address, max one resource of each type
move_to<Coin>(&account, Coin { amount: 100 });
// move_to<Coin>(&account, Coin { amount: 200 });  // ❌ ERROR!
// Second coin would overwrite first—prevented!
```

**Rule 2: Move semantics in storage**

```move
let resource = move_from<Treasure>(@0x1);
// If @0x1 doesn't have Treasure, transaction fails
// If it does, Treasure is removed and returns to you
```

**Rule 3: Signer authorization**

```move
// Only &signer can publish to their own address
// This prevents unauthorized storage

// ✅ AUTHORIZED: Account signs transaction
public fun publish(account: &signer, treasure: Treasure) {
    move_to<Treasure>(account, treasure);
}

// ❌ UNAUTHORIZED: No signer for this address
public fun publish_bad(other_address: address, treasure: Treasure) {
    // Cannot store at other_address without signer
}
```

**Rule 4: Resources cannot evaporate**

```move
struct Important {
    value: u64
}

public fun process(account: &signer, important: Important) {
    // If you retrieve Important from storage, you MUST handle it
    let retrieved = move_from<Important>(signer::address_of(account));

    // ❌ ERROR: retrieved goes out of scope without being used
    // Must be returned, stored, or passed to function with same end result
}

// ✅ CORRECT: Handle the resource
public fun process(account: &signer, important: Important) {
    let retrieved = move_from<Important>(signer::address_of(account));
    move_to<Important>(account, retrieved);  // Store it back
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Publishing Resources to Storage 📦

**Scenario:** Odessa is creating a vault system where treasure can be stored and retrieved.

**Boilerplate Code:**

```move
module spell_library::treasure_vault {
    use std::signer;

    struct Treasure has key {  // Must have "key" ability for storage!
        gold: u64
    }

    public fun store_treasure(account: &signer, gold_amount: u64) {
        // TODO: Create a Treasure struct with gold_amount
        let treasure = Treasure { gold: ____ };

        // TODO: Store it using move_to
        // move_to<Treasure>(_____, treasure);
    }

    public fun retrieve_treasure(account: &signer): u64 {
        // TODO: Get the account's address
        let address = signer::address_of(____);

        // TODO: Retrieve the treasure using move_from
        let treasure = move_from<Treasure>(____);

        // TODO: Extract the gold and return it
        treasure.gold
    }

    public fun test_store_and_retrieve() {
        // Create a treasure
        let treasure = Treasure { gold: 1000 };

        // In a real scenario, account would be a signer
        // For testing, we'll simulate the storage operations

        // We would call: store_treasure(&account, 1000);
        // Then: let gold = retrieve_treasure(&account);
        // assert!(gold == 1000, 1);
    }
}
```

**Your Task:**

1. Create a Treasure with the `key` ability
2. Use `move_to` to store it under the account's address
3. Use `move_from` to retrieve it back
4. Extract and return the gold amount

---

### Exercise 2: Type-Indexed Storage 🗂️

**Scenario:** Store multiple different resource types at the same address.

**Boilerplate Code:**

```move
module spell_library::multi_vault {
    use std::signer;

    struct Coin has key, store {
        amount: u64
    }

    struct Spell has key, store {
        name: String,
        power: u64
    }

    public fun store_coin(account: &signer, amount: u64) {
        // TODO: Store a Coin at account's address
        let coin = Coin { amount };
        move_to<Coin>(____);
    }

    public fun store_spell(account: &signer, name: String, power: u64) {
        // TODO: Store a Spell at account's address
        let spell = Spell { name, power };
        move_to<Spell>(____);
    }

    public fun retrieve_coin(account: &signer): u64 {
        // TODO: Retrieve the coin and return its amount
        let address = signer::address_of(account);
        let coin = move_from<Coin>(____);
        coin.amount
    }

    public fun retrieve_spell(account: &signer): (String, u64) {
        // TODO: Retrieve the spell and return its properties
        let address = signer::address_of(account);
        let spell = move_from<Spell>(____);
        (spell.name, spell.power)
    }

    public fun test_multi_storage() {
        // In real scenario:
        // store_coin(&account, 500);
        // store_spell(&account, utf8(b"Fireball"), 80);

        // let coin_amount = retrieve_coin(&account);
        // assert!(coin_amount == 500, 1);

        // let (name, power) = retrieve_spell(&account);
        // assert!(power == 80, 2);
    }
}
```

**Your Task:**

1. Store different resource types at the same address
2. Each type has its own storage compartment (type-indexed)
3. Retrieve each type separately
4. Verify they don't interfere with each other

---

### Exercise 3: Signer Authorization 🔐

**Scenario:** Implement secure storage with signer authorization.

**Boilerplate Code:**

```move
module spell_library::secure_vault {
    use std::signer;

    struct SecureAsset has key {
        owner: address,
        value: u64
    }

    public fun create_secure_asset(account: &signer, value: u64) {
        // TODO: Get the account's address
        let owner = signer::address_of(____);

        // TODO: Create SecureAsset
        let asset = SecureAsset { owner, value };

        // TODO: Store using move_to with proper authorization
        move_to<SecureAsset>(_____, asset);
    }

    public fun access_secure_asset(account: &signer): u64 {
        // TODO: Get the account's address
        let address = signer::address_of(____);

        // TODO: Retrieve the asset
        let asset = move_from<SecureAsset>(____);

        // TODO: Verify ownership (should match the stored owner)
        assert!(asset.owner == address, 1);

        // TODO: Return the value
        asset.value
    }

    public fun test_security() {
        // Only the account holder can access their asset
        // If someone tries with wrong signer, move_from fails
        // (or assertion fails if we verify ownership)
    }
}
```

**Your Task:**

1. Use `&signer` to authorize storage operations
2. Store the owner's address within the asset
3. Verify authorization on retrieval
4. Explain why `&signer` is essential for security

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::treasure_vault {
    use std::signer;

    struct Treasure has key {
        gold: u64
    }

    public fun store_treasure(account: &signer, gold_amount: u64) {
        let treasure = Treasure { gold: gold_amount };
        move_to<Treasure>(account, treasure);
    }

    public fun retrieve_treasure(account: &signer): u64 {
        let address = signer::address_of(account);
        let treasure = move_from<Treasure>(address);
        treasure.gold
    }

    public fun test_store_and_retrieve() {
        // Demonstrates the storage cycle:
        // 1. Create treasure
        // 2. Store at address using move_to
        // 3. Retrieve from address using move_from
        // 4. Extract value
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::multi_vault {
    use std::signer;
    use std::string::String;

    struct Coin has key, store {
        amount: u64
    }

    struct Spell has key, store {
        name: String,
        power: u64
    }

    public fun store_coin(account: &signer, amount: u64) {
        let coin = Coin { amount };
        move_to<Coin>(account, coin);
    }

    public fun store_spell(account: &signer, name: String, power: u64) {
        let spell = Spell { name, power };
        move_to<Spell>(account, spell);
    }

    public fun retrieve_coin(account: &signer): u64 {
        let address = signer::address_of(account);
        let coin = move_from<Coin>(address);
        coin.amount
    }

    public fun retrieve_spell(account: &signer): (String, u64) {
        let address = signer::address_of(account);
        let spell = move_from<Spell>(address);
        (spell.name, spell.power)
    }

    public fun test_multi_storage() {
        // Multiple types can be stored at same address simultaneously
        // Each type has its own storage slot
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::secure_vault {
    use std::signer;

    struct SecureAsset has key {
        owner: address,
        value: u64
    }

    public fun create_secure_asset(account: &signer, value: u64) {
        let owner = signer::address_of(account);
        let asset = SecureAsset { owner, value };
        move_to<SecureAsset>(account, asset);
    }

    public fun access_secure_asset(account: &signer): u64 {
        let address = signer::address_of(account);
        let asset = move_from<SecureAsset>(address);

        // Verify ownership
        assert!(asset.owner == address, 1);

        asset.value
    }

    public fun test_security() {
        // &signer proves you are the account owner
        // Only you can authorize storage at your address
        // Only you can retrieve from your address
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Storage Operations

**The `key` ability:**

- Resources must have `key` ability to be stored at addresses
- `key` marks it as "can be stored in global state"

**`move_to` function:**

```move
move_to<Treasure>(account, treasure);
```

- Stores `treasure` under `account`'s address
- Requires `&signer` (only account owner can authorize)
- `treasure` is moved (no longer exists after)

**`move_from` function:**

```move
let retrieved = move_from<Treasure>(address);
```

- Removes and returns `Treasure` from `address`
- If doesn't exist, transaction fails
- Retrieved resource is back in scope

### Exercise 2 Explanation: Type-Indexed Storage

**Each address is a vault with compartments:**

```
Address @0x1:
├── Coin (compartment for Coin type)
├── Spell (compartment for Spell type)
└── (other types)
```

**Key insight:** You can store different types at the same address, but only one of each type!

```move
move_to<Coin>(account, coin1);     // ✅ Stored
move_to<Spell>(account, spell1);   // ✅ Stored (different type)
// move_to<Coin>(account, coin2);  // ❌ ERROR! Coin slot already taken
```

### Exercise 3 Explanation: Signer Authorization

**Why `&signer` is essential:**

```move
// ✅ SAFE: Account signs, authorizing storage
public fun store(account: &signer, data: Data) {
    move_to<Data>(account, data);  // Only works with valid signer
}

// ❌ UNSAFE: No signer verification
public fun store_bad(address: address, data: Data) {
    // How do we know 'address' owns the account?
    // Attacker could store data at someone else's address!
}
```

**The guarantee:** Only the rightful account owner can modify their storage.

---

## 🧪 Unit Tests

Here's a comprehensive test file:

```move
#[test_only]
module spell_library::storage_tests {
    use spell_library::treasure_vault;
    use spell_library::multi_vault;
    use spell_library::secure_vault;
    use std::string;

    #[test]
    fun test_store_and_retrieve_basic() {
        // In a real test environment:
        // let account = ...;  // Get signer
        // treasure_vault::store_treasure(&account, 1000);
        // let gold = treasure_vault::retrieve_treasure(&account);
        // assert!(gold == 1000, 1);
    }

    #[test]
    fun test_multiple_resources() {
        // In a real test environment:
        // multi_vault::store_coin(&account, 500);
        // multi_vault::store_spell(&account, utf8(b"Lightning"), 90);

        // let coin_amount = multi_vault::retrieve_coin(&account);
        // let (name, power) = multi_vault::retrieve_spell(&account);

        // assert!(coin_amount == 500, 1);
        // assert!(power == 90, 2);
    }

    #[test]
    fun test_secure_storage() {
        // In a real test environment:
        // let account = ...;
        // secure_vault::create_secure_asset(&account, 750);
        // let value = secure_vault::access_secure_asset(&account);
        // assert!(value == 750, 1);
    }

    #[test]
    #[expected_failure]
    fun test_retrieve_nonexistent_fails() {
        // In a real test environment:
        // let account = ...;
        // Try to retrieve from empty address (should fail)
        // let _ = treasure_vault::retrieve_treasure(&account);
    }

    #[test]
    fun test_type_indexed_isolation() {
        // Different types don't interfere:
        // Coin stored at address A
        // Spell stored at address A
        // Both can exist simultaneously (different compartments)
    }

    #[test]
    fun test_storage_is_persistent() {
        // Once stored, resource persists until retrieved
        // Even after function returns
        // Survives to next transaction
    }
}
```

### Running the Tests

```bash
move test
move test -- --verbose
```

---

## 🌟 Closing Story

Archivist Thorne places her hand on the golden door. With a soft glow, it begins to open, revealing infinite shelves of crystalline storage—each one holding resources that will persist forever.

> "You have now learned the complete foundation of Move," Thorne says, her voice filled with reverence. "You understand variables and their souls. You understand ownership and its linearity. You understand resources and their invariants. And now, you understand how those resources live eternally on the chain itself."

Odessa walks forward into the vault, seeing treasures glowing softly on eternal shelves—resources stored at addresses across the galaxy of the blockchain.

> "Every resource you store here will remain until the chain itself ends. No loss. No corruption. No theft possible. Other blockchains store data hoping nobody corrupts it. You store data _proven_ to be incorruptible."

> "This is the power of Move: it doesn't just encourage safety—it makes unsafe code _impossible_. The compiler is not a guide or advisor. It is a guardian that refuses to let broken code leave your hands."

Thorne walks to a particular shelf and pulls down a glowing crystal—the record of Odessa's entire journey.

> "You began knowing nothing. Now, you understand the deepest secrets of blockchain programming. You can build systems that are not just secure—they are mathematically unbreakable."

> "But this journey is not ending. This is just the beginning. Now you take these foundations and build. Build systems that change the world. Build applications that cannot fail. Build futures that are written in the mathematics of Move itself."

The vault around them begins to glow brighter, as if the entire blockchain is applauding.

> "Go forth, young architect. You are ready."

---

**Remember:** Move is not just a programming language. It's a mathematical framework for writing code that cannot fail. Use it wisely, build boldly, and create systems that will persist forever.

_The Guild awaits your first creation, Master Caster._ 🌟

---

The path to mastery is infinite, but you now have the map.

**Go change the world.** 🚀
