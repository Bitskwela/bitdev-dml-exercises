module movestack::token_vault {
    use std::signer;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Vault not initialized for this address
    const E_NOT_INITIALIZED: u64 = 1;
    /// Vault already exists at this address
    const E_ALREADY_INITIALIZED: u64 = 2;
    /// Attempting to withdraw more than available balance
    const E_INSUFFICIENT_BALANCE: u64 = 3;

    // ============================================
    // STRUCTS
    // ============================================

    /// A vault that holds a token balance for an account
    struct Vault has key {
        balance: u64
    }

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    /// Initialize a new vault for the signer
    /// 
    /// # Arguments
    /// * `account` - The signer who will own the vault
    /// 
    /// # Aborts
    /// * `E_ALREADY_INITIALIZED` - If vault already exists
    public fun initialize(account: &signer) {
        let addr = signer::address_of(account);
        assert!(!exists<Vault>(addr), E_ALREADY_INITIALIZED);
        move_to(account, Vault { balance: 0 });
    }

    /// Deposit tokens into the signer's vault
    /// 
    /// # Arguments
    /// * `account` - The signer who owns the vault
    /// * `amount` - Amount to deposit
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If vault doesn't exist
    public fun deposit(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        assert!(exists<Vault>(addr), E_NOT_INITIALIZED);
        let vault = borrow_global_mut<Vault>(addr);
        vault.balance = vault.balance + amount;
    }

    /// Withdraw tokens from the signer's vault
    /// 
    /// # Arguments
    /// * `account` - The signer who owns the vault
    /// * `amount` - Amount to withdraw
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If vault doesn't exist
    /// * `E_INSUFFICIENT_BALANCE` - If balance < amount
    public fun withdraw(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        assert!(exists<Vault>(addr), E_NOT_INITIALIZED);
        let vault = borrow_global_mut<Vault>(addr);
        assert!(vault.balance >= amount, E_INSUFFICIENT_BALANCE);
        vault.balance = vault.balance - amount;
    }

    /// Get the balance of a vault at the given address
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// The current balance
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If vault doesn't exist
    public fun get_balance(addr: address): u64 acquires Vault {
        assert!(exists<Vault>(addr), E_NOT_INITIALIZED);
        borrow_global<Vault>(addr).balance
    }

    // ============================================
    // UNIT TESTS
    // ============================================

    /// Test that initialization creates a vault with zero balance
    #[test(user = @0x1)]
    fun test_initialize(user: &signer) acquires Vault {
        initialize(user);
        assert!(get_balance(@0x1) == 0, 0);
    }

    /// Test that deposit correctly increases the balance
    #[test(user = @0x1)]
    fun test_deposit(user: &signer) acquires Vault {
        initialize(user);
        deposit(user, 100);
        assert!(get_balance(@0x1) == 100, 0);
    }

    /// Test that multiple deposits accumulate correctly
    #[test(user = @0x1)]
    fun test_multiple_deposits(user: &signer) acquires Vault {
        initialize(user);
        deposit(user, 100);
        deposit(user, 50);
        deposit(user, 25);
        assert!(get_balance(@0x1) == 175, 0);
    }

    /// Test that withdrawal correctly decreases the balance
    #[test(user = @0x1)]
    fun test_withdraw(user: &signer) acquires Vault {
        initialize(user);
        deposit(user, 100);
        withdraw(user, 40);
        assert!(get_balance(@0x1) == 60, 0);
    }

    /// Test that withdrawing the full balance leaves zero
    #[test(user = @0x1)]
    fun test_withdraw_all(user: &signer) acquires Vault {
        initialize(user);
        deposit(user, 100);
        withdraw(user, 100);
        assert!(get_balance(@0x1) == 0, 0);
    }

    /// Test that withdrawing more than balance aborts with correct error
    #[test(user = @0x1)]
    #[expected_failure(abort_code = E_INSUFFICIENT_BALANCE)]
    fun test_withdraw_insufficient(user: &signer) acquires Vault {
        initialize(user);
        deposit(user, 50);
        withdraw(user, 100);  // Should abort - only has 50
    }

    /// Test that withdrawing from empty vault aborts
    #[test(user = @0x1)]
    #[expected_failure(abort_code = E_INSUFFICIENT_BALANCE)]
    fun test_withdraw_from_empty(user: &signer) acquires Vault {
        initialize(user);
        withdraw(user, 1);  // Should abort - balance is 0
    }

    /// Test that double initialization aborts with correct error
    #[test(user = @0x1)]
    #[expected_failure(abort_code = E_ALREADY_INITIALIZED)]
    fun test_double_initialize(user: &signer) {
        initialize(user);
        initialize(user);  // Should abort - already initialized
    }

    /// Test that deposit to uninitialized vault aborts
    #[test(user = @0x1)]
    #[expected_failure(abort_code = E_NOT_INITIALIZED)]
    fun test_deposit_not_initialized(user: &signer) acquires Vault {
        deposit(user, 100);  // Should abort - not initialized
    }

    /// Test that withdraw from uninitialized vault aborts
    #[test(user = @0x1)]
    #[expected_failure(abort_code = E_NOT_INITIALIZED)]
    fun test_withdraw_not_initialized(user: &signer) acquires Vault {
        withdraw(user, 100);  // Should abort - not initialized
    }

    /// Test that get_balance on uninitialized vault aborts
    #[test]
    #[expected_failure(abort_code = E_NOT_INITIALIZED)]
    fun test_get_balance_not_initialized() acquires Vault {
        get_balance(@0x999);  // Should abort - not initialized
    }

    /// Test deposit and withdraw sequence
    #[test(user = @0x1)]
    fun test_deposit_withdraw_sequence(user: &signer) acquires Vault {
        initialize(user);
        
        deposit(user, 100);
        assert!(get_balance(@0x1) == 100, 0);
        
        withdraw(user, 30);
        assert!(get_balance(@0x1) == 70, 1);
        
        deposit(user, 50);
        assert!(get_balance(@0x1) == 120, 2);
        
        withdraw(user, 120);
        assert!(get_balance(@0x1) == 0, 3);
    }
}
