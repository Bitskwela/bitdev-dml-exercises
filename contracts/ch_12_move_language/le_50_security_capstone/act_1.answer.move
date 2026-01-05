module secure_vault {
    use std::signer;
    
    // Error codes
    const E_ALREADY_INITIALIZED: u64 = 1;
    const E_VAULT_EXISTS: u64 = 2;
    const E_VAULT_NOT_FOUND: u64 = 3;
    const E_INSUFFICIENT_BALANCE: u64 = 4;
    const E_INVALID_AMOUNT: u64 = 5;
    const E_OVERFLOW: u64 = 6;
    const E_LOCKED: u64 = 7;
    const E_INVALID_ADDRESS: u64 = 8;
    
    const MAX_BALANCE: u64 = 18446744073709551615; // Max u64
    
    // Vault resource - stores user's balance with security features
    struct Vault has key {
        balance: u64,
        owner: address,
        locked: bool,  // Reentrancy guard
    }
    
    // Admin capability - controls privileged operations
    struct AdminCap has key, store {}
    
    // Initialize admin capability (one-time setup)
    public fun initialize_admin(account: &signer) {
        let addr = signer::address_of(account);
        // Security: Prevent re-initialization
        assert!(!exists<AdminCap>(addr), E_ALREADY_INITIALIZED);
        move_to(account, AdminCap {});
    }
    
    // Create a new vault for the caller
    public fun create_vault(account: &signer) {
        let addr = signer::address_of(account);
        
        // Security: Check vault doesn't already exist
        assert!(!exists<Vault>(addr), E_VAULT_EXISTS);
        
        // Create vault with proper initialization
        move_to(account, Vault {
            balance: 0,
            owner: addr,
            locked: false,
        });
    }
    
    // Deposit tokens into caller's vault
    public fun deposit(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        
        // Security: Input validation
        assert!(amount > 0, E_INVALID_AMOUNT);
        
        // Security: Check vault exists
        assert!(exists<Vault>(addr), E_VAULT_NOT_FOUND);
        
        let vault = borrow_global_mut<Vault>(addr);
        
        // Security: Overflow protection
        assert!(vault.balance <= MAX_BALANCE - amount, E_OVERFLOW);
        
        // Update balance
        vault.balance = vault.balance + amount;
    }
    
    // Withdraw tokens from caller's vault
    public fun withdraw(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        
        // Security: Input validation
        assert!(amount > 0, E_INVALID_AMOUNT);
        
        // Security: Check vault exists
        assert!(exists<Vault>(addr), E_VAULT_NOT_FOUND);
        
        let vault = borrow_global_mut<Vault>(addr);
        
        // Security: Reentrancy guard - check lock
        assert!(!vault.locked, E_LOCKED);
        
        // Security: Set reentrancy lock
        vault.locked = true;
        
        // Security: Access control - verify owner
        assert!(vault.owner == addr, E_VAULT_NOT_FOUND);
        
        // Security: Underflow protection
        assert!(vault.balance >= amount, E_INSUFFICIENT_BALANCE);
        
        // Update state BEFORE any external operations (Checks-Effects-Interactions)
        vault.balance = vault.balance - amount;
        
        // External operations would happen here...
        
        // Security: Release reentrancy lock
        vault.locked = false;
    }
    
    // Admin transfer between vaults (requires capability)
    public fun admin_transfer(
        _admin_cap: &AdminCap,  // Security: Capability-based access control
        from: address,
        to: address,
        amount: u64
    ) acquires Vault {
        // Security: Input validation
        assert!(amount > 0, E_INVALID_AMOUNT);
        assert!(from != @0x0, E_INVALID_ADDRESS);
        assert!(to != @0x0, E_INVALID_ADDRESS);
        assert!(from != to, E_INVALID_ADDRESS);
        
        // Security: Check both vaults exist
        assert!(exists<Vault>(from), E_VAULT_NOT_FOUND);
        assert!(exists<Vault>(to), E_VAULT_NOT_FOUND);
        
        // Borrow source vault and validate
        let from_vault = borrow_global_mut<Vault>(from);
        
        // Security: Reentrancy check on source
        assert!(!from_vault.locked, E_LOCKED);
        from_vault.locked = true;
        
        // Security: Check sufficient balance
        assert!(from_vault.balance >= amount, E_INSUFFICIENT_BALANCE);
        
        // Deduct from source
        from_vault.balance = from_vault.balance - amount;
        from_vault.locked = false;
        
        // Borrow destination vault
        let to_vault = borrow_global_mut<Vault>(to);
        
        // Security: Overflow check on destination
        assert!(to_vault.balance <= MAX_BALANCE - amount, E_OVERFLOW);
        
        // Add to destination
        to_vault.balance = to_vault.balance + amount;
    }
    
    // View function - get vault balance
    public fun get_balance(addr: address): u64 acquires Vault {
        assert!(exists<Vault>(addr), E_VAULT_NOT_FOUND);
        borrow_global<Vault>(addr).balance
    }
    
    // View function - check if vault exists
    public fun vault_exists(addr: address): bool {
        exists<Vault>(addr)
    }
}
