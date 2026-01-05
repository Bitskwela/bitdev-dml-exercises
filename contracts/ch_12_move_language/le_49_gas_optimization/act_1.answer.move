module token_registry_optimized {
    use std::signer;
    use std::vector;
    
    struct TokenRegistry has key {
        tokens: vector<TokenInfo>,
        total_supply: u64,
        is_active: bool,
    }
    
    struct TokenInfo has store, drop, copy {
        id: u64,
        balance: u64,
        owner: address,
    }
    
    // OPTIMIZED: Single storage read instead of three
    public fun get_registry_stats(addr: address): (u64, u64, bool) acquires TokenRegistry {
        let registry = borrow_global<TokenRegistry>(addr);
        let token_count = vector::length(&registry.tokens);
        let supply = registry.total_supply;
        let active = registry.is_active;
        (token_count, supply, active)
    }
    
    // OPTIMIZED: Cache vector length before loop
    public fun calculate_total_balance(addr: address): u64 acquires TokenRegistry {
        let registry = borrow_global<TokenRegistry>(addr);
        let total = 0;
        let i = 0;
        let len = vector::length(&registry.tokens);  // Cache length
        while (i < len) {
            total = total + vector::borrow(&registry.tokens, i).balance;
            i = i + 1;
        };
        total
    }
    
    // OPTIMIZED: Check cheap boolean first, then storage operations
    public fun can_transfer(
        registry_addr: address,
        amount: u64,
        has_permission: bool
    ): bool acquires TokenRegistry {
        // Check has_permission first (free - it's a parameter)
        // Short-circuit prevents storage read if permission is false
        has_permission && {
            let registry = borrow_global<TokenRegistry>(registry_addr);
            registry.is_active && registry.total_supply >= amount
        }
    }
}
