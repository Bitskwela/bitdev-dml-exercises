// ============================================
// FILE: sources/coin.move
// Base module - no project dependencies
// ============================================

module movestack::coin {
    use std::signer;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Insufficient balance for operation
    const E_INSUFFICIENT_BALANCE: u64 = 1;
    /// Coin already exists at address
    const E_ALREADY_EXISTS: u64 = 2;

    // ============================================
    // STRUCTS
    // ============================================

    /// Represents a coin balance at an address
    struct Coin has key {
        value: u64
    }

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    /// Mint new coins to an account
    /// 
    /// # Arguments
    /// * `account` - The signer receiving the coins
    /// * `amount` - Amount to mint
    public fun mint(account: &signer, amount: u64) {
        move_to(account, Coin { value: amount });
    }

    /// Get the balance of an address
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// The coin balance, or 0 if no coins exist
    public fun balance(addr: address): u64 acquires Coin {
        if (exists<Coin>(addr)) {
            borrow_global<Coin>(addr).value
        } else {
            0
        }
    }

    /// Deduct coins from an address
    /// 
    /// # Arguments
    /// * `addr` - Address to deduct from
    /// * `amount` - Amount to deduct
    /// 
    /// # Aborts
    /// * `E_INSUFFICIENT_BALANCE` - If balance is less than amount
    public fun deduct(addr: address, amount: u64) acquires Coin {
        let coin = borrow_global_mut<Coin>(addr);
        assert!(coin.value >= amount, E_INSUFFICIENT_BALANCE);
        coin.value = coin.value - amount;
    }

    /// Add coins to an existing balance
    /// 
    /// # Arguments
    /// * `addr` - Address to credit
    /// * `amount` - Amount to add
    public fun credit(addr: address, amount: u64) acquires Coin {
        let coin = borrow_global_mut<Coin>(addr);
        coin.value = coin.value + amount;
    }

    /// Check if an address has coins
    public fun has_coins(addr: address): bool {
        exists<Coin>(addr)
    }
}

// ============================================
// FILE: sources/shop.move
// Mid-level module - depends on coin
// ============================================

module movestack::shop {
    use std::signer;
    use movestack::coin;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Buyer doesn't have enough coins
    const E_INSUFFICIENT_FUNDS: u64 = 2;
    /// Item doesn't exist at address
    const E_ITEM_NOT_FOUND: u64 = 3;

    // ============================================
    // STRUCTS
    // ============================================

    /// Represents an item for sale
    struct Item has key, store {
        name: vector<u8>,
        price: u64
    }

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    /// Create a new item for sale
    /// 
    /// # Arguments
    /// * `seller` - The signer creating the item
    /// * `name` - Item name as bytes
    /// * `price` - Price in coins
    public fun create_item(seller: &signer, name: vector<u8>, price: u64) {
        move_to(seller, Item { name, price });
    }

    /// Get the price of an item
    /// 
    /// # Arguments
    /// * `seller_addr` - Address where item is stored
    /// 
    /// # Returns
    /// The price of the item
    public fun get_price(seller_addr: address): u64 acquires Item {
        assert!(exists<Item>(seller_addr), E_ITEM_NOT_FOUND);
        borrow_global<Item>(seller_addr).price
    }

    /// Get the name of an item
    public fun get_name(seller_addr: address): vector<u8> acquires Item {
        assert!(exists<Item>(seller_addr), E_ITEM_NOT_FOUND);
        borrow_global<Item>(seller_addr).name
    }

    /// Buy an item from a seller
    /// 
    /// # Arguments
    /// * `buyer` - The signer purchasing the item
    /// * `seller_addr` - Address of the seller
    /// 
    /// # Aborts
    /// * `E_INSUFFICIENT_FUNDS` - If buyer doesn't have enough coins
    /// 
    /// # Effects
    /// Deducts coins from buyer, credits seller
    public entry fun buy(buyer: &signer, seller_addr: address) acquires Item {
        let buyer_addr = signer::address_of(buyer);
        let item = borrow_global<Item>(seller_addr);
        let price = item.price;

        // Check balance using coin module
        let buyer_balance = coin::balance(buyer_addr);
        assert!(buyer_balance >= price, E_INSUFFICIENT_FUNDS);

        // Transfer coins: deduct from buyer, credit to seller
        coin::deduct(buyer_addr, price);
        coin::credit(seller_addr, price);
    }

    /// Check if an item exists at an address
    public fun item_exists(addr: address): bool {
        exists<Item>(addr)
    }
}

// ============================================
// FILE: sources/inventory.move
// Top-level module - depends on coin and shop
// ============================================

module movestack::inventory {
    use std::signer;
    use std::vector;
    use movestack::coin;
    use movestack::shop;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Inventory not initialized
    const E_NOT_INITIALIZED: u64 = 4;
    /// Inventory already exists
    const E_ALREADY_INITIALIZED: u64 = 5;

    // ============================================
    // STRUCTS
    // ============================================

    /// Tracks a player's purchased items and spending
    struct PlayerInventory has key {
        items: vector<vector<u8>>,
        total_spent: u64
    }

    // ============================================
    // ENTRY FUNCTIONS
    // ============================================

    /// Initialize a player's inventory
    /// 
    /// # Arguments
    /// * `account` - The signer to initialize inventory for
    public entry fun initialize(account: &signer) {
        let addr = signer::address_of(account);
        assert!(!exists<PlayerInventory>(addr), E_ALREADY_INITIALIZED);
        
        move_to(account, PlayerInventory {
            items: vector::empty(),
            total_spent: 0
        });
    }

    /// Purchase an item and add to inventory
    /// 
    /// # Arguments
    /// * `buyer` - The signer making the purchase
    /// * `seller_addr` - Address of the seller
    /// * `item_name` - Name of the item being purchased
    /// 
    /// # Effects
    /// Executes purchase via shop, updates inventory
    public entry fun purchase_item(
        buyer: &signer, 
        seller_addr: address,
        item_name: vector<u8>
    ) acquires PlayerInventory {
        let buyer_addr = signer::address_of(buyer);
        assert!(exists<PlayerInventory>(buyer_addr), E_NOT_INITIALIZED);
        
        // Get price from shop module
        let price = shop::get_price(seller_addr);
        
        // Execute purchase through shop module
        shop::buy(buyer, seller_addr);
        
        // Update inventory tracking
        let inventory = borrow_global_mut<PlayerInventory>(buyer_addr);
        vector::push_back(&mut inventory.items, item_name);
        inventory.total_spent = inventory.total_spent + price;
    }

    // ============================================
    // PUBLIC VIEW FUNCTIONS
    // ============================================

    /// Get total amount spent by a player
    public fun get_total_spent(addr: address): u64 acquires PlayerInventory {
        assert!(exists<PlayerInventory>(addr), E_NOT_INITIALIZED);
        borrow_global<PlayerInventory>(addr).total_spent
    }

    /// Get the number of items in inventory
    public fun get_item_count(addr: address): u64 acquires PlayerInventory {
        assert!(exists<PlayerInventory>(addr), E_NOT_INITIALIZED);
        vector::length(&borrow_global<PlayerInventory>(addr).items)
    }

    /// Check if player has inventory initialized
    public fun is_initialized(addr: address): bool {
        exists<PlayerInventory>(addr)
    }

    /// Get player's current coin balance (delegates to coin module)
    public fun get_balance(addr: address): u64 {
        coin::balance(addr)
    }
}
