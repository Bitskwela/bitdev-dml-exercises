// ============================================
// Move.toml (Complete Solution)
// ============================================
// 
// [package]
// name = "TokenProject"
// version = "1.0.0"
// 
// [addresses]
// tokenproject = "0xcafe"
// admin = "0x1"
// 
// [dev-addresses]
// tokenproject = "0x0"
// admin = "0x0"
// 
// [dependencies]
// 
// ============================================

module tokenproject::managed_token {
    use std::signer;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Caller is not the admin
    const E_NOT_ADMIN: u64 = 1;

    // ============================================
    // CONSTANTS
    // ============================================

    /// Admin address defined using named address from Move.toml
    const ADMIN_ADDRESS: address = @admin;

    // ============================================
    // STRUCTS
    // ============================================

    /// Token information resource
    struct TokenInfo has key {
        name: vector<u8>,
        total_supply: u64,
    }

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    /// Initialize the token - only admin can call
    /// 
    /// # Arguments
    /// * `account` - The signer (must be admin)
    /// * `name` - The token name as bytes
    /// 
    /// # Aborts
    /// * `E_NOT_ADMIN` - If caller is not the admin address
    public fun initialize(account: &signer, name: vector<u8>) {
        assert!(signer::address_of(account) == ADMIN_ADDRESS, E_NOT_ADMIN);
        move_to(account, TokenInfo { 
            name,
            total_supply: 0 
        });
    }

    /// Get the admin address
    /// 
    /// # Returns
    /// The admin address from named address configuration
    public fun get_admin(): address {
        @admin
    }

    /// Alternative: return the constant
    public fun get_admin_from_const(): address {
        ADMIN_ADDRESS
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    /// Check if an address is the admin
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// True if the address matches the admin address
    public fun is_admin(addr: address): bool {
        addr == ADMIN_ADDRESS
    }

    /// Get the module's named address
    /// 
    /// # Returns
    /// The tokenproject named address
    public fun get_module_address(): address {
        @tokenproject
    }
}

// ============================================
// ADDITIONAL EXAMPLES
// ============================================

module tokenproject::address_examples {
    
    // Different ways to use named addresses
    
    // As a constant
    const MY_ADDRESS: address = @tokenproject;
    
    // In a function return
    public fun get_self(): address {
        @tokenproject
    }
    
    // Comparing addresses
    public fun is_tokenproject(addr: address): bool {
        addr == @tokenproject
    }
    
    // Using literal address (less flexible)
    public fun get_literal(): address {
        @0xcafe  // Same as @tokenproject, but hardcoded
    }
}
