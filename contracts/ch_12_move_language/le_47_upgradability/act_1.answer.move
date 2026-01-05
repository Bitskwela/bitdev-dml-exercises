module token::upgradable_token {
    use std::signer;

    /// Current module version
    const VERSION: u64 = 2;

    /// Error: No legacy data exists to migrate
    const E_NO_LEGACY_DATA: u64 = 1;
    /// Error: Already migrated to modern format
    const E_ALREADY_MIGRATED: u64 = 2;

    /// Legacy balance structure (V1)
    struct LegacyBalance has key {
        amount: u64,
    }

    /// Modern balance structure with tracking (V2)
    struct ModernBalance has key {
        amount: u64,
        total_received: u64,
        total_sent: u64,
        tx_count: u64,
    }

    /// Migrate from legacy to modern balance format
    public entry fun migrate_balance(user: &signer) acquires LegacyBalance {
        let user_addr = signer::address_of(user);

        // Ensure legacy data exists
        assert!(exists<LegacyBalance>(user_addr), E_NO_LEGACY_DATA);
        // Ensure not already migrated
        assert!(!exists<ModernBalance>(user_addr), E_ALREADY_MIGRATED);

        // Extract legacy data
        let LegacyBalance { amount } = move_from<LegacyBalance>(user_addr);

        // Create modern data with tracking fields initialized to 0
        move_to(user, ModernBalance {
            amount,
            total_received: 0,
            total_sent: 0,
            tx_count: 0,
        });
    }

    /// Get the current module version
    public fun get_version(): u64 {
        VERSION
    }
}
