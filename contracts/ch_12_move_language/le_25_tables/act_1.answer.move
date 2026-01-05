module movestack::token_registry {
    use std::signer;
    use aptos_std::table::{Self, Table};

    // ============================================
    // Task 1: TokenInfo struct with copy, drop, store abilities
    // ============================================

    /// Stores information about a registered token.
    struct TokenInfo has copy, drop, store {
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64
    }

    // ============================================
    // Task 2: Registry struct with key ability
    // ============================================

    /// A registry that maps token IDs to their information.
    struct Registry has key {
        tokens: Table<u64, TokenInfo>
    }

    // ============================================
    // Task 3: initialize function
    // ============================================

    /// Initialize the registry for an account.
    /// Creates a new Registry with an empty table and moves it to the account.
    public fun initialize(account: &signer) {
        let registry = Registry {
            tokens: table::new()
        };
        move_to(account, registry);
    }

    // ============================================
    // Task 4: register_token function
    // ============================================

    /// Adds a new token to the registry with the given id and info.
    /// Aborts if a token with this id already exists.
    public fun register_token(
        registry: &mut Registry,
        id: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64
    ) {
        let info = TokenInfo { name, symbol, total_supply };
        table::add(&mut registry.tokens, id, info);
    }

    // ============================================
    // Task 5: get_token_info function
    // ============================================

    /// Returns a copy of TokenInfo for a given token id.
    /// Aborts if the token doesn't exist.
    public fun get_token_info(registry: &Registry, id: u64): TokenInfo {
        *table::borrow(&registry.tokens, id)
    }

    // ============================================
    // Task 6: token_exists function
    // ============================================

    /// Returns true if a token with the given id exists.
    public fun token_exists(registry: &Registry, id: u64): bool {
        table::contains(&registry.tokens, id)
    }

    // ============================================
    // Task 7: update_supply function
    // ============================================

    /// Updates the total_supply of an existing token.
    /// Aborts if the token doesn't exist.
    public fun update_supply(
        registry: &mut Registry,
        id: u64,
        new_supply: u64
    ) {
        let info = table::borrow_mut(&mut registry.tokens, id);
        info.total_supply = new_supply;
    }

    // ============================================
    // Task 8: remove_token function
    // ============================================

    /// Removes a token from the registry and returns its info.
    /// Aborts if the token doesn't exist.
    public fun remove_token(registry: &mut Registry, id: u64): TokenInfo {
        table::remove(&mut registry.tokens, id)
    }

    // ============================================
    // Task 9: safe_register function
    // ============================================

    /// Only registers if the token id doesn't already exist.
    /// Returns true if registered, false if already existed.
    public fun safe_register(
        registry: &mut Registry,
        id: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64
    ): bool {
        if (table::contains(&registry.tokens, id)) {
            false
        } else {
            let info = TokenInfo { name, symbol, total_supply };
            table::add(&mut registry.tokens, id, info);
            true
        }
    }

    // ============================================
    // Helper functions for testing
    // ============================================

    /// Creates a TokenInfo struct (helper for tests)
    public fun create_token_info(
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64
    ): TokenInfo {
        TokenInfo { name, symbol, total_supply }
    }

    /// Gets the name from TokenInfo
    public fun get_name(info: &TokenInfo): vector<u8> {
        info.name
    }

    /// Gets the symbol from TokenInfo
    public fun get_symbol(info: &TokenInfo): vector<u8> {
        info.symbol
    }

    /// Gets the total supply from TokenInfo
    public fun get_total_supply(info: &TokenInfo): u64 {
        info.total_supply
    }
}
