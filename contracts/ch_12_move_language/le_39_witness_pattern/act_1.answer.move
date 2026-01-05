module witness_exercise::token_factory {
    use std::signer;
    
    // Genesis witness - can only be created once during module init
    struct Genesis has drop {}
    
    struct TokenRegistry has key {
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64,
        is_initialized: bool
    }
    
    // MintPermission is a hot potato - no abilities means it must be consumed
    struct MintPermission { amount: u64 }
    
    const E_ALREADY_INITIALIZED: u64 = 1;
    const E_NOT_ADMIN: u64 = 2;
    
    // Called automatically during module publication - only once ever
    fun init_module(account: &signer) {
        // Create the Genesis witness - this is the only place it can be created
        let witness = Genesis {};
        // Use the witness for initialization
        initialize_with_witness(account, witness);
    }
    
    // Consumes the Genesis witness to prove one-time initialization
    fun initialize_with_witness(account: &signer, witness: Genesis) {
        // Destructure and consume the witness - proves we have authorization
        let Genesis {} = witness;
        
        // Now we can safely initialize the registry
        move_to(account, TokenRegistry {
            name: b"FactoryToken",
            symbol: b"FTK",
            total_supply: 0,
            is_initialized: true
        });
    }
    
    // Creates a mint permission - only admin can do this
    public fun create_mint_permission(admin: &signer, amount: u64): MintPermission {
        // Verify the caller is the admin
        assert!(signer::address_of(admin) == @token_factory, E_NOT_ADMIN);
        // Return the permission (hot potato - must be used)
        MintPermission { amount }
    }
    
    // Consumes the mint permission and returns the minted amount
    public fun mint_with_permission(permission: MintPermission): u64 {
        // Destructure to consume the permission
        let MintPermission { amount } = permission;
        // In a real implementation, this would update total_supply
        amount
    }
    
    #[test(admin = @token_factory)]
    fun test_mint_permission(admin: &signer) {
        // Create a permission for 1000 tokens
        let permission = create_mint_permission(admin, 1000);
        
        // Use the permission - must be consumed
        let minted = mint_with_permission(permission);
        
        assert!(minted == 1000, 1);
    }
    
    #[test(fake_admin = @0x999)]
    #[expected_failure(abort_code = E_NOT_ADMIN)]
    fun test_unauthorized_mint(fake_admin: &signer) {
        // This should fail - not the admin
        let _permission = create_mint_permission(fake_admin, 1000);
    }
}
