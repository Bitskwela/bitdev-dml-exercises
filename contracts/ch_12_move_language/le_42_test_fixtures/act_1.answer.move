module fixtures::wallet {
    // Wallet struct with owner and coins
    struct Wallet has drop {
        owner: address,
        coins: u64
    }

    // Add coins to the wallet
    public fun add_coins(wallet: &mut Wallet, amount: u64) {
        wallet.coins = wallet.coins + amount;
    }

    // Spend coins from the wallet
    public fun spend_coins(wallet: &mut Wallet, amount: u64) {
        assert!(wallet.coins >= amount, 1);
        wallet.coins = wallet.coins - amount;
    }

    // ========== TEST FIXTURES ==========

    #[test_only]
    /// Creates a new wallet with 0 coins
    public fun setup_wallet(owner: address): Wallet {
        Wallet {
            owner,
            coins: 0
        }
    }

    #[test_only]
    /// Creates a wallet with a specific starting amount
    public fun setup_wallet_with_coins(owner: address, amount: u64): Wallet {
        Wallet {
            owner,
            coins: amount
        }
    }

    #[test_only]
    /// Gets the coin count for test assertions
    public fun get_coins(wallet: &Wallet): u64 {
        wallet.coins
    }

    // ========== TESTS ==========

    #[test]
    fun test_add_coins() {
        let mut wallet = setup_wallet(@0x1);
        add_coins(&mut wallet, 100);
        assert!(get_coins(&wallet) == 100, 0);
        
        add_coins(&mut wallet, 50);
        assert!(get_coins(&wallet) == 150, 0);
    }

    #[test]
    fun test_spend_coins() {
        let mut wallet = setup_wallet_with_coins(@0x1, 500);
        spend_coins(&mut wallet, 200);
        assert!(get_coins(&wallet) == 300, 0);
        
        spend_coins(&mut wallet, 300);
        assert!(get_coins(&wallet) == 0, 0);
    }

    #[test]
    #[expected_failure(abort_code = 1)]
    fun test_spend_coins_insufficient_funds() {
        let mut wallet = setup_wallet_with_coins(@0x1, 50);
        spend_coins(&mut wallet, 100); // Should abort!
    }
}
