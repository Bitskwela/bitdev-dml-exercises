# Activity 1: Building an Upgradable Token System

Det approached Loy with a challenge. "We have a legacy token system that only tracks balances. We need to upgrade it to also track transaction history, but users shouldn't lose their existing balances."

Loy nodded. "Perfect use case for a storage migration. Let's build it together."

---

## Your Task

Create a module called `upgradable_token` that demonstrates proper upgrade and migration patterns.

### Requirements

1. **Define a constant** `VERSION` set to `2`

2. **Create a legacy struct** `LegacyBalance` with:

   - `amount: u64`

3. **Create a modern struct** `ModernBalance` with:

   - `amount: u64`
   - `total_received: u64`
   - `total_sent: u64`
   - `tx_count: u64`

4. **Implement `migrate_balance`** function that:

   - Takes a `&signer` parameter
   - Acquires `LegacyBalance`
   - Checks that `LegacyBalance` exists for the user
   - Checks that `ModernBalance` does NOT already exist
   - Moves the legacy balance amount to the new struct
   - Initializes tracking fields to `0`

5. **Implement `get_version`** function that returns the VERSION constant

### Error Codes

- `E_NO_LEGACY_DATA`: `1` - When no legacy data exists
- `E_ALREADY_MIGRATED`: `2` - When already migrated

### Starter Code

```move
module token::upgradable_token {
    use std::signer;

    // TODO: Define VERSION constant

    // TODO: Define error codes

    // TODO: Define LegacyBalance struct

    // TODO: Define ModernBalance struct

    // TODO: Implement migrate_balance function

    // TODO: Implement get_version function
}
```

### Expected Behavior

```move
// User has LegacyBalance { amount: 1000 }
migrate_balance(&user);
// User now has ModernBalance { amount: 1000, total_received: 0, total_sent: 0, tx_count: 0 }
// LegacyBalance is removed

// Calling migrate again should fail with E_ALREADY_MIGRATED
```

Good luck, Det!
