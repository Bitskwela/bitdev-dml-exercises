# Upgradability in Move

Loy was reviewing old contract code when Det walked in, looking puzzled.

"Loy, we need to add new features to our deployed module, but I don't want to lose all our existing data," Det said, scratching his head.

Loy smiled. "That's where **upgradability patterns** come in. Let me show you how we can design contracts that evolve gracefully."

---

## Understanding Upgradability

Unlike some blockchains where contracts are immutable, Move on Aptos supports **module upgrades**. However, this power comes with responsibilities:

```move
module upgrade_example::versioned_store {
    use std::signer;

    /// Version tracking for migrations
    const VERSION: u64 = 1;

    struct Config has key {
        version: u64,
        admin: address,
        // Future fields can be added in upgrades
    }

    public fun get_version(): u64 {
        VERSION
    }

    public entry fun initialize(admin: &signer) {
        let admin_addr = signer::address_of(admin);
        move_to(admin, Config {
            version: VERSION,
            admin: admin_addr,
        });
    }
}
```

Det nodded. "So we track the version in the code itself?"

"Exactly," Loy confirmed. "This helps us know which migration steps to run."

---

## Upgrade Patterns

### Pattern 1: Additive Changes

The safest upgrades only **add** new functionality:

```move
module upgrade_example::additive_upgrade {
    // V1 struct - original
    struct UserDataV1 has key, store {
        name: vector<u8>,
        score: u64,
    }

    // V2 adds new fields without breaking V1
    struct UserDataV2 has key, store {
        name: vector<u8>,
        score: u64,
        level: u64,        // New in V2
        badges: vector<u8>, // New in V2
    }
}
```

### Pattern 2: Wrapper Pattern

For more complex changes, use a wrapper:

```move
module upgrade_example::wrapper_pattern {
    use std::signer;
    use std::option::{Self, Option};

    struct DataWrapper has key {
        v1_data: Option<DataV1>,
        v2_data: Option<DataV2>,
        current_version: u64,
    }

    struct DataV1 has store {
        value: u64,
    }

    struct DataV2 has store {
        value: u64,
        metadata: vector<u8>,
    }

    public fun migrate_v1_to_v2(account: &signer) acquires DataWrapper {
        let addr = signer::address_of(account);
        let wrapper = borrow_global_mut<DataWrapper>(addr);

        assert!(wrapper.current_version == 1, 1);

        let v1 = option::extract(&mut wrapper.v1_data);
        let v2 = DataV2 {
            value: v1.value,
            metadata: vector::empty(),
        };

        option::fill(&mut wrapper.v2_data, v2);
        wrapper.current_version = 2;

        // V1 data is dropped
        let DataV1 { value: _ } = v1;
    }
}
```

---

## Storage Migration

"What if we need to transform existing data?" Det asked.

Loy pulled up another example. "We create **migration functions** that users or admins can call."

```move
module upgrade_example::storage_migration {
    use std::signer;

    const E_ALREADY_MIGRATED: u64 = 1;
    const E_NOT_MIGRATED: u64 = 2;

    struct LegacyData has key {
        points: u64,
    }

    struct ModernData has key {
        points: u64,
        multiplier: u64,
        last_updated: u64,
    }

    /// Migration function - call once per user
    public entry fun migrate_to_modern(user: &signer) acquires LegacyData {
        let user_addr = signer::address_of(user);

        // Ensure legacy data exists
        assert!(exists<LegacyData>(user_addr), E_NOT_MIGRATED);
        // Ensure not already migrated
        assert!(!exists<ModernData>(user_addr), E_ALREADY_MIGRATED);

        // Extract old data
        let LegacyData { points } = move_from<LegacyData>(user_addr);

        // Create new data with defaults for new fields
        move_to(user, ModernData {
            points,
            multiplier: 1,
            last_updated: 0,
        });
    }
}
```

---

## Best Practices

Det was taking notes as Loy summarized:

1. **Always version your modules** - Track versions in constants
2. **Plan for backwards compatibility** - Old data should remain accessible
3. **Use migration functions** - Let users migrate at their own pace
4. **Test upgrades thoroughly** - Simulate migrations before deployment
5. **Document breaking changes** - Communicate what changes between versions

"Remember," Loy concluded, "good upgradability is about respecting your users' data while still being able to improve your contracts."

Det grinned. "Now I can confidently plan our upgrade strategy!"
