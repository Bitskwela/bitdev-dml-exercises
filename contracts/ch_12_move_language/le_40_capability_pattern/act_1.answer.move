module capability_exercise::vault_access {
    use std::signer;
    
    // Admin capability - grants permission to manage other capabilities
    struct AdminCapability has key, store {}
    
    // Withdraw capability with spending limit
    struct WithdrawCapability has key, store {
        max_amount: u64
    }
    
    struct Vault has key {
        balance: u64
    }
    
    const E_NOT_OWNER: u64 = 1;
    const E_NO_CAPABILITY: u64 = 2;
    const E_INSUFFICIENT_ALLOWANCE: u64 = 3;
    const E_INSUFFICIENT_BALANCE: u64 = 4;
    
    // Initialize vault and grant admin capability to owner
    public fun initialize(owner: &signer, initial_balance: u64) {
        move_to(owner, Vault { balance: initial_balance });
        // Owner gets admin capability
        move_to(owner, AdminCapability {});
    }
    
    // Admin grants withdraw capability to a recipient
    public fun grant_withdraw_capability(
        admin: &signer,
        recipient: &signer,
        max_amount: u64
    ) acquires AdminCapability {
        let admin_addr = signer::address_of(admin);
        // Verify admin has the AdminCapability
        assert!(exists<AdminCapability>(admin_addr), E_NO_CAPABILITY);
        
        // Grant withdraw capability to recipient
        move_to(recipient, WithdrawCapability { max_amount });
    }
    
    // Withdraw using capability (deducts from allowance)
    public fun withdraw(
        user: &signer,
        vault_addr: address,
        amount: u64
    ): u64 acquires WithdrawCapability, Vault {
        let user_addr = signer::address_of(user);
        
        // Verify user has withdraw capability
        assert!(exists<WithdrawCapability>(user_addr), E_NO_CAPABILITY);
        
        // Check and update allowance
        let cap = borrow_global_mut<WithdrawCapability>(user_addr);
        assert!(cap.max_amount >= amount, E_INSUFFICIENT_ALLOWANCE);
        cap.max_amount = cap.max_amount - amount;
        
        // Withdraw from vault
        let vault = borrow_global_mut<Vault>(vault_addr);
        assert!(vault.balance >= amount, E_INSUFFICIENT_BALANCE);
        vault.balance = vault.balance - amount;
        
        amount
    }
    
    // Revoke withdraw capability
    public fun revoke_withdraw_capability(user: &signer) acquires WithdrawCapability {
        let user_addr = signer::address_of(user);
        assert!(exists<WithdrawCapability>(user_addr), E_NO_CAPABILITY);
        
        // Remove and destroy the capability
        let WithdrawCapability { max_amount: _ } = move_from<WithdrawCapability>(user_addr);
    }
    
    // View remaining allowance
    public fun get_allowance(addr: address): u64 acquires WithdrawCapability {
        if (exists<WithdrawCapability>(addr)) {
            borrow_global<WithdrawCapability>(addr).max_amount
        } else {
            0
        }
    }
    
    // Check if address has admin capability
    public fun is_admin(addr: address): bool {
        exists<AdminCapability>(addr)
    }
    
    // Get vault balance
    public fun get_balance(vault_addr: address): u64 acquires Vault {
        borrow_global<Vault>(vault_addr).balance
    }
    
    #[test(owner = @capability_exercise, user = @0x123)]
    fun test_capability_flow(owner: &signer, user: &signer) acquires AdminCapability, WithdrawCapability, Vault {
        // Initialize vault with 1000 balance
        initialize(owner, 1000);
        
        // Grant user withdraw capability with 500 limit
        grant_withdraw_capability(owner, user, 500);
        
        // User withdraws 200
        let withdrawn = withdraw(user, signer::address_of(owner), 200);
        assert!(withdrawn == 200, 1);
        
        // Check remaining allowance is 300
        assert!(get_allowance(signer::address_of(user)) == 300, 2);
        
        // Check vault balance is 800
        assert!(get_balance(signer::address_of(owner)) == 800, 3);
    }
    
    #[test(owner = @capability_exercise, user = @0x123)]
    fun test_revoke_capability(owner: &signer, user: &signer) acquires AdminCapability, WithdrawCapability {
        initialize(owner, 1000);
        grant_withdraw_capability(owner, user, 500);
        
        // Revoke the capability
        revoke_withdraw_capability(user);
        
        // Allowance should be 0 now
        assert!(get_allowance(signer::address_of(user)) == 0, 1);
    }
    
    #[test(fake_admin = @0x999, user = @0x123)]
    #[expected_failure(abort_code = E_NO_CAPABILITY)]
    fun test_unauthorized_grant(fake_admin: &signer, user: &signer) acquires AdminCapability {
        // This should fail - fake_admin doesn't have AdminCapability
        grant_withdraw_capability(fake_admin, user, 500);
    }
}
