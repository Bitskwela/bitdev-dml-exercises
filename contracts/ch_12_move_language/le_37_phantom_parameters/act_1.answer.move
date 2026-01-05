module phantom_exercise::typed_vault {
    
    // State marker types
    struct Active {}
    struct Frozen {}
    
    // Asset marker types
    struct Gold {}
    struct Silver {}
    
    // Vault with phantom parameters for state and asset tracking
    struct Vault<phantom State, phantom Asset> has store {
        balance: u64,
        owner: address
    }
    
    // Create a new Active vault for a specific asset type
    public fun create_vault<Asset>(owner: address): Vault<Active, Asset> {
        Vault<Active, Asset> {
            balance: 0,
            owner
        }
    }
    
    // Deposit into an Active vault only
    public fun deposit<Asset>(vault: &mut Vault<Active, Asset>, amount: u64) {
        vault.balance = vault.balance + amount;
    }
    
    // Freeze an Active vault, returning a Frozen vault
    public fun freeze_vault<Asset>(vault: Vault<Active, Asset>): Vault<Frozen, Asset> {
        Vault<Frozen, Asset> {
            balance: vault.balance,
            owner: vault.owner
        }
    }
    
    // Unfreeze a Frozen vault, returning an Active vault
    public fun unfreeze_vault<Asset>(vault: Vault<Frozen, Asset>): Vault<Active, Asset> {
        Vault<Active, Asset> {
            balance: vault.balance,
            owner: vault.owner
        }
    }
    
    // Get balance (works for any state)
    public fun get_balance<State, Asset>(vault: &Vault<State, Asset>): u64 {
        vault.balance
    }
    
    // Additional helper: get owner (works for any state and asset)
    public fun get_owner<State, Asset>(vault: &Vault<State, Asset>): address {
        vault.owner
    }
    
    #[test]
    fun test_vault_operations() {
        let owner = @0x1;
        
        // Create a Gold vault
        let gold_vault: Vault<Active, Gold> = create_vault<Gold>(owner);
        assert!(get_balance(&gold_vault) == 0, 0);
        
        // Deposit into active vault
        deposit(&mut gold_vault, 100);
        assert!(get_balance(&gold_vault) == 100, 1);
        
        // Freeze the vault
        let frozen_vault: Vault<Frozen, Gold> = freeze_vault(gold_vault);
        assert!(get_balance(&frozen_vault) == 100, 2);
        
        // Cannot deposit into frozen vault - this would fail:
        // deposit(&mut frozen_vault, 50); // Compile error!
        
        // Unfreeze to deposit again
        let active_again: Vault<Active, Gold> = unfreeze_vault(frozen_vault);
        deposit(&mut active_again, 50);
        assert!(get_balance(&active_again) == 150, 3);
        
        // Clean up
        let Vault { balance: _, owner: _ } = active_again;
    }
    
    #[test]
    fun test_different_assets() {
        let owner = @0x1;
        
        // Create vaults for different assets
        let gold_vault: Vault<Active, Gold> = create_vault<Gold>(owner);
        let silver_vault: Vault<Active, Silver> = create_vault<Silver>(owner);
        
        deposit(&mut gold_vault, 1000);
        deposit(&mut silver_vault, 5000);
        
        // Type system prevents mixing assets
        // Cannot accidentally use gold functions on silver vaults
        
        assert!(get_balance(&gold_vault) == 1000, 0);
        assert!(get_balance(&silver_vault) == 5000, 1);
        
        // Clean up
        let Vault { balance: _, owner: _ } = gold_vault;
        let Vault { balance: _, owner: _ } = silver_vault;
    }
}
