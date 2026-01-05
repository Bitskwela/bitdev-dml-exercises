/// Module demonstrating fixed aliasing issues
module safety::aliasing_fix {
    struct Inventory has drop {
        items: u64,
        capacity: u64
    }
    
    /// Fixed: Read values through the mutable reference directly
    /// No conflicting borrows needed
    public fun check_and_add(inventory: &mut Inventory, amount: u64): bool {
        // Read values directly through the mutable reference
        let current_items = inventory.items;
        let max_capacity = inventory.capacity;
        let remaining = max_capacity - current_items;
        
        if (remaining >= amount) {
            inventory.items = current_items + amount;
            true
        } else {
            false
        }
    }
    
    /// Fixed: Extract values first, then perform modifications
    public fun transfer_items(from: &mut Inventory, to: &mut Inventory, amount: u64): bool {
        // Extract all needed values first
        let from_items = from.items;
        let to_items = to.items;
        let to_capacity = to.capacity;
        
        // Check conditions
        if (from_items < amount) {
            return false
        };
        
        let to_remaining = to_capacity - to_items;
        if (to_remaining < amount) {
            return false
        };
        
        // Now perform modifications
        from.items = from_items - amount;
        to.items = to_items + amount;
        true
    }
    
    /// Fixed: Extract all values, then apply all changes
    public fun swap_inventories(inv1: &mut Inventory, inv2: &mut Inventory) {
        // Extract all values first
        let items1 = inv1.items;
        let capacity1 = inv1.capacity;
        let items2 = inv2.items;
        let capacity2 = inv2.capacity;
        
        // Apply swapped values
        inv1.items = items2;
        inv1.capacity = capacity2;
        inv2.items = items1;
        inv2.capacity = capacity1;
    }
    
    // ============ Tests ============
    
    #[test]
    fun test_check_and_add_success() {
        let mut inv = Inventory { items: 5, capacity: 10 };
        let result = check_and_add(&mut inv, 3);
        assert!(result == true, 0);
        assert!(inv.items == 8, 1);
    }
    
    #[test]
    fun test_check_and_add_at_capacity() {
        let mut inv = Inventory { items: 5, capacity: 10 };
        let result = check_and_add(&mut inv, 5);
        assert!(result == true, 0);
        assert!(inv.items == 10, 1);
    }
    
    #[test]
    fun test_check_and_add_exceeds_capacity() {
        let mut inv = Inventory { items: 8, capacity: 10 };
        let result = check_and_add(&mut inv, 5);
        assert!(result == false, 0);
        assert!(inv.items == 8, 1); // Unchanged
    }
    
    #[test]
    fun test_transfer_items_success() {
        let mut from = Inventory { items: 10, capacity: 10 };
        let mut to = Inventory { items: 2, capacity: 10 };
        
        let result = transfer_items(&mut from, &mut to, 5);
        assert!(result == true, 0);
        assert!(from.items == 5, 1);
        assert!(to.items == 7, 2);
    }
    
    #[test]
    fun test_transfer_items_insufficient_source() {
        let mut from = Inventory { items: 3, capacity: 10 };
        let mut to = Inventory { items: 2, capacity: 10 };
        
        let result = transfer_items(&mut from, &mut to, 5);
        assert!(result == false, 0);
        assert!(from.items == 3, 1); // Unchanged
        assert!(to.items == 2, 2);   // Unchanged
    }
    
    #[test]
    fun test_transfer_items_insufficient_destination_capacity() {
        let mut from = Inventory { items: 10, capacity: 10 };
        let mut to = Inventory { items: 8, capacity: 10 };
        
        let result = transfer_items(&mut from, &mut to, 5);
        assert!(result == false, 0);
        assert!(from.items == 10, 1); // Unchanged
        assert!(to.items == 8, 2);    // Unchanged
    }
    
    #[test]
    fun test_swap_inventories() {
        let mut inv1 = Inventory { items: 10, capacity: 20 };
        let mut inv2 = Inventory { items: 5, capacity: 15 };
        
        swap_inventories(&mut inv1, &mut inv2);
        
        assert!(inv1.items == 5, 0);
        assert!(inv1.capacity == 15, 1);
        assert!(inv2.items == 10, 2);
        assert!(inv2.capacity == 20, 3);
    }
    
    #[test]
    fun test_swap_with_empty() {
        let mut inv1 = Inventory { items: 0, capacity: 100 };
        let mut inv2 = Inventory { items: 50, capacity: 50 };
        
        swap_inventories(&mut inv1, &mut inv2);
        
        assert!(inv1.items == 50, 0);
        assert!(inv1.capacity == 50, 1);
        assert!(inv2.items == 0, 2);
        assert!(inv2.capacity == 100, 3);
    }
}

/// Module demonstrating restructured code for borrow safety
module safety::restructure {
    struct Account has drop {
        balance: u64,
        pending: u64,
        locked: bool
    }
    
    /// Calculate available balance (balance - pending)
    /// Uses immutable reference - read only
    public fun available_balance(account: &Account): u64 {
        account.balance - account.pending
    }
    
    /// Process pending amount into balance
    /// Pattern: Extract values first, then modify
    public fun process_pending(account: &mut Account) {
        let pending_amount = account.pending;
        account.balance = account.balance + pending_amount;
        account.pending = 0;
    }
    
    /// Lock account and zero out pending
    /// Modify multiple fields through single reference
    public fun emergency_lock(account: &mut Account) {
        account.locked = true;
        account.pending = 0;
        // balance intentionally unchanged
    }
    
    /// Transfer pending from one account to another's balance
    /// Extract from source before modifying either
    public fun transfer_pending(from: &mut Account, to: &mut Account) {
        // Extract the pending amount first
        let amount = from.pending;
        
        // Now modify both accounts
        from.pending = 0;
        to.balance = to.balance + amount;
    }
    
    /// Consolidate: Add pending to balance for both accounts
    /// Process sequentially - complete one before the other
    public fun consolidate_both(acc1: &mut Account, acc2: &mut Account) {
        // Process first account completely
        let pending1 = acc1.pending;
        acc1.balance = acc1.balance + pending1;
        acc1.pending = 0;
        
        // Process second account completely
        let pending2 = acc2.pending;
        acc2.balance = acc2.balance + pending2;
        acc2.pending = 0;
    }
    
    // ============ Tests ============
    
    #[test]
    fun test_available_balance() {
        let account = Account { balance: 100, pending: 30, locked: false };
        assert!(available_balance(&account) == 70, 0);
    }
    
    #[test]
    fun test_available_balance_zero_pending() {
        let account = Account { balance: 100, pending: 0, locked: false };
        assert!(available_balance(&account) == 100, 0);
    }
    
    #[test]
    fun test_process_pending() {
        let mut account = Account { balance: 100, pending: 50, locked: false };
        process_pending(&mut account);
        assert!(account.balance == 150, 0);
        assert!(account.pending == 0, 1);
    }
    
    #[test]
    fun test_process_pending_zero() {
        let mut account = Account { balance: 100, pending: 0, locked: false };
        process_pending(&mut account);
        assert!(account.balance == 100, 0);
        assert!(account.pending == 0, 1);
    }
    
    #[test]
    fun test_emergency_lock() {
        let mut account = Account { balance: 100, pending: 50, locked: false };
        emergency_lock(&mut account);
        assert!(account.locked == true, 0);
        assert!(account.pending == 0, 1);
        assert!(account.balance == 100, 2);
    }
    
    #[test]
    fun test_transfer_pending() {
        let mut from = Account { balance: 100, pending: 50, locked: false };
        let mut to = Account { balance: 75, pending: 25, locked: false };
        
        transfer_pending(&mut from, &mut to);
        
        assert!(from.pending == 0, 0);
        assert!(to.balance == 125, 1);
        // from.balance and to.pending unchanged
        assert!(from.balance == 100, 2);
        assert!(to.pending == 25, 3);
    }
    
    #[test]
    fun test_consolidate_both() {
        let mut acc1 = Account { balance: 100, pending: 50, locked: false };
        let mut acc2 = Account { balance: 200, pending: 75, locked: false };
        
        consolidate_both(&mut acc1, &mut acc2);
        
        assert!(acc1.balance == 150, 0);
        assert!(acc1.pending == 0, 1);
        assert!(acc2.balance == 275, 2);
        assert!(acc2.pending == 0, 3);
    }
}

/// Module demonstrating safe reference patterns
module safety::patterns {
    struct Vault has drop {
        gold: u64,
        silver: u64,
        is_open: bool
    }
    
    /// Create a new vault (open by default)
    public fun new_vault(gold: u64, silver: u64): Vault {
        Vault {
            gold,
            silver,
            is_open: true
        }
    }
    
    /// Get total value (gold * 10 + silver)
    /// Pattern: Read-only access through immutable reference
    public fun total_value(vault: &Vault): u64 {
        (vault.gold * 10) + vault.silver
    }
    
    /// Deposit gold if vault is open
    /// Pattern: Check-then-modify through single reference
    public fun deposit_gold(vault: &mut Vault, amount: u64): bool {
        if (!vault.is_open) {
            return false
        };
        
        vault.gold = vault.gold + amount;
        true
    }
    
    /// Withdraw silver if vault is open and has enough
    /// Pattern: Multiple conditions, single modification
    public fun withdraw_silver(vault: &mut Vault, amount: u64): bool {
        if (!vault.is_open) {
            return false
        };
        
        if (vault.silver < amount) {
            return false
        };
        
        vault.silver = vault.silver - amount;
        true
    }
    
    /// Exchange gold for silver (1 gold = 10 silver)
    /// Pattern: Compute new values, then apply
    public fun exchange_gold_for_silver(vault: &mut Vault, gold_amount: u64): bool {
        // Check if vault has enough gold
        if (vault.gold < gold_amount) {
            return false
        };
        
        // Calculate silver to receive
        let silver_received = gold_amount * 10;
        
        // Apply changes
        vault.gold = vault.gold - gold_amount;
        vault.silver = vault.silver + silver_received;
        true
    }
    
    /// Close vault and return all contents
    /// Pattern: Extract values, modify state, return values
    public fun close_and_empty(vault: &mut Vault): (u64, u64) {
        // Extract current values
        let gold = vault.gold;
        let silver = vault.silver;
        
        // Modify vault state
        vault.gold = 0;
        vault.silver = 0;
        vault.is_open = false;
        
        // Return extracted values
        (gold, silver)
    }
    
    /// Merge two vaults (add second's contents to first, empty second)
    /// Pattern: Extract from source, apply to destination
    public fun merge_vaults(dest: &mut Vault, source: &mut Vault) {
        // Extract values from source
        let source_gold = source.gold;
        let source_silver = source.silver;
        
        // Add to destination
        dest.gold = dest.gold + source_gold;
        dest.silver = dest.silver + source_silver;
        
        // Zero out source
        source.gold = 0;
        source.silver = 0;
    }
    
    // ============ Tests ============
    
    #[test]
    fun test_new_vault() {
        let vault = new_vault(10, 50);
        assert!(vault.gold == 10, 0);
        assert!(vault.silver == 50, 1);
        assert!(vault.is_open == true, 2);
    }
    
    #[test]
    fun test_total_value() {
        let vault = new_vault(10, 50);
        assert!(total_value(&vault) == 150, 0); // 10*10 + 50
    }
    
    #[test]
    fun test_total_value_zero() {
        let vault = new_vault(0, 0);
        assert!(total_value(&vault) == 0, 0);
    }
    
    #[test]
    fun test_deposit_gold_open_vault() {
        let mut vault = new_vault(10, 20);
        let result = deposit_gold(&mut vault, 5);
        assert!(result == true, 0);
        assert!(vault.gold == 15, 1);
    }
    
    #[test]
    fun test_deposit_gold_closed_vault() {
        let mut vault = new_vault(10, 20);
        vault.is_open = false;
        let result = deposit_gold(&mut vault, 5);
        assert!(result == false, 0);
        assert!(vault.gold == 10, 1); // Unchanged
    }
    
    #[test]
    fun test_withdraw_silver_success() {
        let mut vault = new_vault(10, 50);
        let result = withdraw_silver(&mut vault, 30);
        assert!(result == true, 0);
        assert!(vault.silver == 20, 1);
    }
    
    #[test]
    fun test_withdraw_silver_insufficient() {
        let mut vault = new_vault(10, 20);
        let result = withdraw_silver(&mut vault, 30);
        assert!(result == false, 0);
        assert!(vault.silver == 20, 1); // Unchanged
    }
    
    #[test]
    fun test_withdraw_silver_closed() {
        let mut vault = new_vault(10, 50);
        vault.is_open = false;
        let result = withdraw_silver(&mut vault, 10);
        assert!(result == false, 0);
        assert!(vault.silver == 50, 1); // Unchanged
    }
    
    #[test]
    fun test_exchange_gold_for_silver_success() {
        let mut vault = new_vault(10, 50);
        let result = exchange_gold_for_silver(&mut vault, 5);
        assert!(result == true, 0);
        assert!(vault.gold == 5, 1);
        assert!(vault.silver == 100, 2); // 50 + 5*10
    }
    
    #[test]
    fun test_exchange_gold_for_silver_insufficient() {
        let mut vault = new_vault(3, 50);
        let result = exchange_gold_for_silver(&mut vault, 5);
        assert!(result == false, 0);
        assert!(vault.gold == 3, 1);   // Unchanged
        assert!(vault.silver == 50, 2); // Unchanged
    }
    
    #[test]
    fun test_close_and_empty() {
        let mut vault = new_vault(10, 50);
        let (gold, silver) = close_and_empty(&mut vault);
        
        assert!(gold == 10, 0);
        assert!(silver == 50, 1);
        assert!(vault.gold == 0, 2);
        assert!(vault.silver == 0, 3);
        assert!(vault.is_open == false, 4);
    }
    
    #[test]
    fun test_merge_vaults() {
        let mut dest = new_vault(10, 20);
        let mut source = new_vault(5, 30);
        
        merge_vaults(&mut dest, &mut source);
        
        assert!(dest.gold == 15, 0);
        assert!(dest.silver == 50, 1);
        assert!(source.gold == 0, 2);
        assert!(source.silver == 0, 3);
    }
    
    #[test]
    fun test_merge_vaults_empty_source() {
        let mut dest = new_vault(10, 20);
        let mut source = new_vault(0, 0);
        
        merge_vaults(&mut dest, &mut source);
        
        assert!(dest.gold == 10, 0);
        assert!(dest.silver == 20, 1);
    }
    
    #[test]
    fun test_merge_vaults_into_empty() {
        let mut dest = new_vault(0, 0);
        let mut source = new_vault(10, 20);
        
        merge_vaults(&mut dest, &mut source);
        
        assert!(dest.gold == 10, 0);
        assert!(dest.silver == 20, 1);
        assert!(source.gold == 0, 2);
        assert!(source.silver == 0, 3);
    }
}
