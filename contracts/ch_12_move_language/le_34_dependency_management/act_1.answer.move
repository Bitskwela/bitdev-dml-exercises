// ============================================
// Move.toml (Complete Solution)
// ============================================
// 
// [package]
// name = "DeFiVault"
// version = "1.0.0"
// 
// [addresses]
// defi_vault = "0xcafe"
// aptos_framework = "0x1"
// std = "0x1"
// 
// [dependencies]
// AptosFramework = { git = "https://github.com/aptos-labs/aptos-core.git", subdir = "aptos-move/framework/aptos-framework", rev = "mainnet" }
// CoreUtils = { local = "../core_utils" }
// 
// [dev-addresses]
// defi_vault = "0x0"
// 
// [dev-dependencies]
// TestHelpers = { local = "../test_helpers" }
// 
// ============================================

module defi_vault::vault {
    use aptos_framework::coin;
    use std::signer;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Vault does not exist at the address
    const E_VAULT_NOT_EXISTS: u64 = 1;
    /// Vault already exists at the address
    const E_VAULT_EXISTS: u64 = 2;
    /// Insufficient balance for withdrawal
    const E_INSUFFICIENT_BALANCE: u64 = 3;

    // ============================================
    // STRUCTS
    // ============================================

    /// A vault that holds a balance of a specific coin type
    /// The phantom type parameter allows different vaults for different coins
    struct Vault<phantom CoinType> has key {
        balance: u64,
    }

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    /// Create a new vault for the signer
    /// 
    /// # Type Parameters
    /// * `CoinType` - The type of coin this vault will hold
    /// 
    /// # Arguments
    /// * `account` - The signer creating the vault
    /// 
    /// # Aborts
    /// * `E_VAULT_EXISTS` - If vault already exists for this coin type
    public fun create_vault<CoinType>(account: &signer) {
        let addr = signer::address_of(account);
        assert!(!exists<Vault<CoinType>>(addr), E_VAULT_EXISTS);
        move_to(account, Vault<CoinType> { balance: 0 });
    }

    /// Deposit into the vault
    /// 
    /// # Type Parameters
    /// * `CoinType` - The type of coin to deposit
    /// 
    /// # Arguments
    /// * `account` - The signer depositing
    /// * `amount` - Amount to deposit
    /// 
    /// # Aborts
    /// * `E_VAULT_NOT_EXISTS` - If no vault exists
    public fun deposit<CoinType>(
        account: &signer, 
        amount: u64
    ) acquires Vault {
        let addr = signer::address_of(account);
        assert!(exists<Vault<CoinType>>(addr), E_VAULT_NOT_EXISTS);
        let vault = borrow_global_mut<Vault<CoinType>>(addr);
        vault.balance = vault.balance + amount;
    }

    /// Withdraw from the vault
    /// 
    /// # Type Parameters
    /// * `CoinType` - The type of coin to withdraw
    /// 
    /// # Arguments
    /// * `account` - The signer withdrawing
    /// * `amount` - Amount to withdraw
    /// 
    /// # Aborts
    /// * `E_VAULT_NOT_EXISTS` - If no vault exists
    /// * `E_INSUFFICIENT_BALANCE` - If balance is too low
    public fun withdraw<CoinType>(
        account: &signer,
        amount: u64
    ) acquires Vault {
        let addr = signer::address_of(account);
        assert!(exists<Vault<CoinType>>(addr), E_VAULT_NOT_EXISTS);
        let vault = borrow_global_mut<Vault<CoinType>>(addr);
        assert!(vault.balance >= amount, E_INSUFFICIENT_BALANCE);
        vault.balance = vault.balance - amount;
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    /// Get the vault balance
    /// 
    /// # Type Parameters
    /// * `CoinType` - The coin type to check
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// The balance in the vault
    public fun get_balance<CoinType>(addr: address): u64 acquires Vault {
        assert!(exists<Vault<CoinType>>(addr), E_VAULT_NOT_EXISTS);
        borrow_global<Vault<CoinType>>(addr).balance
    }

    /// Check if a vault exists
    /// 
    /// # Type Parameters
    /// * `CoinType` - The coin type to check
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// True if vault exists
    public fun vault_exists<CoinType>(addr: address): bool {
        exists<Vault<CoinType>>(addr)
    }
}

// ============================================
// EXAMPLE: Using external dependencies
// ============================================

module defi_vault::coin_vault {
    use aptos_framework::coin::{Self, Coin};
    use std::signer;

    /// A vault that actually holds coins (not just a balance counter)
    struct CoinVault<phantom CoinType> has key {
        coins: Coin<CoinType>,
    }

    /// Create vault with actual coin storage
    public fun create_coin_vault<CoinType>(account: &signer) {
        move_to(account, CoinVault<CoinType> {
            coins: coin::zero<CoinType>()
        });
    }

    /// Deposit actual coins
    public fun deposit_coins<CoinType>(
        account: &signer,
        coins: Coin<CoinType>
    ) acquires CoinVault {
        let addr = signer::address_of(account);
        let vault = borrow_global_mut<CoinVault<CoinType>>(addr);
        coin::merge(&mut vault.coins, coins);
    }

    /// Get vault coin value
    public fun get_coin_value<CoinType>(addr: address): u64 acquires CoinVault {
        let vault = borrow_global<CoinVault<CoinType>>(addr);
        coin::value(&vault.coins)
    }
}
