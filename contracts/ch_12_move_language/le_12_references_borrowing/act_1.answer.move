module movestack::borrowing_practice {
    // ============================================
    // STRUCT DEFINITIONS
    // ============================================
    
    /// Represents a user profile with reputation and verification status.
    /// No abilities - must be explicitly handled (moved or destructured).
    struct UserProfile {
        id: u64,
        reputation: u64,
        is_verified: bool
    }

    /// Represents a transaction between two users.
    /// No abilities - must be explicitly handled.
    struct Transaction {
        from_id: u64,
        to_id: u64,
        amount: u64
    }

    // ============================================
    // BASIC BORROWING FUNCTIONS
    // ============================================

    /// Gets the reputation of a user WITHOUT taking ownership.
    /// The &UserProfile parameter means we borrow the profile.
    /// After this function returns, the caller still owns their UserProfile.
    public fun get_reputation(user: &UserProfile): u64 {
        user.reputation
    }

    /// Checks if a user is trusted (high reputation AND verified).
    /// Borrows the user profile to read multiple fields.
    public fun is_trusted_user(user: &UserProfile): bool {
        user.reputation >= 100 && user.is_verified
    }

    /// Gets the amount from a transaction by borrowing it.
    public fun get_transaction_amount(tx: &Transaction): u64 {
        tx.amount
    }

    // ============================================
    // MULTIPLE BORROWS
    // ============================================

    /// Compares reputation between two users.
    /// Takes two immutable references - both users remain owned by caller.
    public fun compare_reputation(user_a: &UserProfile, user_b: &UserProfile): bool {
        user_a.reputation > user_b.reputation
    }

    /// Validates a transaction against the sender's profile.
    /// Borrows both the transaction and the user profile.
    public fun is_valid_transaction(tx: &Transaction, sender: &UserProfile): bool {
        // Check that from_id matches sender's id
        tx.from_id == sender.id &&
        // Check that sender is verified
        sender.is_verified &&
        // Check that amount is positive
        tx.amount > 0
    }

    // ============================================
    // BORROWING WITH OWNERSHIP
    // ============================================

    /// Demonstrates borrowing the same value multiple times.
    /// Creates a user, borrows it twice for different checks,
    /// then returns both results AND the original user.
    public fun create_and_check_user(): (u64, bool, UserProfile) {
        let user = UserProfile { 
            id: 1, 
            reputation: 150, 
            is_verified: true 
        };
        
        // First borrow - user is still ours after this
        let reputation = get_reputation(&user);
        
        // Second borrow - user is STILL ours after this
        let is_trusted = is_trusted_user(&user);
        
        // Return everything including the user (transferring ownership out)
        (reputation, is_trusted, user)
    }

    /// Destroys a UserProfile and returns its reputation.
    /// Takes ownership (not a reference) and destructures.
    public fun destroy_user(user: UserProfile): u64 {
        let UserProfile { id: _, reputation, is_verified: _ } = user;
        reputation
    }

    /// Destroys a Transaction.
    /// Helper function to properly consume transactions in tests.
    public fun destroy_transaction(tx: Transaction): u64 {
        let Transaction { from_id: _, to_id: _, amount } = tx;
        amount
    }

    // ============================================
    // BONUS: Additional borrowing patterns
    // ============================================

    /// Creates a new UserProfile. Helper for tests.
    public fun create_user(id: u64, reputation: u64, is_verified: bool): UserProfile {
        UserProfile { id, reputation, is_verified }
    }

    /// Creates a new Transaction. Helper for tests.
    public fun create_transaction(from_id: u64, to_id: u64, amount: u64): Transaction {
        Transaction { from_id, to_id, amount }
    }

    /// Checks multiple conditions on a borrowed user.
    /// Demonstrates reading multiple fields through one reference.
    public fun analyze_user(user: &UserProfile): (bool, bool, bool) {
        let is_active = user.id > 0;
        let is_reputable = user.reputation >= 50;
        let is_trusted = user.reputation >= 100 && user.is_verified;
        
        (is_active, is_reputable, is_trusted)
    }

    /// Gets sender and receiver IDs from a transaction.
    /// Shows borrowing to extract multiple values.
    public fun get_transaction_parties(tx: &Transaction): (u64, u64) {
        (tx.from_id, tx.to_id)
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_get_reputation() {
        let user = create_user(1, 250, true);
        
        // Borrow to check reputation
        let rep = get_reputation(&user);
        assert!(rep == 250, 0);
        
        // User still exists! Borrow again.
        let rep2 = get_reputation(&user);
        assert!(rep2 == 250, 1);
        
        // Clean up
        destroy_user(user);
    }

    #[test]
    fun test_is_trusted_user() {
        let trusted = create_user(1, 150, true);
        let not_verified = create_user(2, 150, false);
        let low_rep = create_user(3, 50, true);
        
        assert!(is_trusted_user(&trusted) == true, 0);
        assert!(is_trusted_user(&not_verified) == false, 1);
        assert!(is_trusted_user(&low_rep) == false, 2);
        
        destroy_user(trusted);
        destroy_user(not_verified);
        destroy_user(low_rep);
    }

    #[test]
    fun test_get_transaction_amount() {
        let tx = create_transaction(1, 2, 500);
        
        let amount = get_transaction_amount(&tx);
        assert!(amount == 500, 0);
        
        destroy_transaction(tx);
    }

    #[test]
    fun test_compare_reputation() {
        let high_rep = create_user(1, 500, true);
        let low_rep = create_user(2, 100, true);
        
        assert!(compare_reputation(&high_rep, &low_rep) == true, 0);
        assert!(compare_reputation(&low_rep, &high_rep) == false, 1);
        assert!(compare_reputation(&high_rep, &high_rep) == false, 2); // Equal, not greater
        
        destroy_user(high_rep);
        destroy_user(low_rep);
    }

    #[test]
    fun test_is_valid_transaction() {
        let sender = create_user(1, 100, true);
        let valid_tx = create_transaction(1, 2, 100);
        let wrong_sender_tx = create_transaction(99, 2, 100);
        let zero_amount_tx = create_transaction(1, 2, 0);
        
        assert!(is_valid_transaction(&valid_tx, &sender) == true, 0);
        assert!(is_valid_transaction(&wrong_sender_tx, &sender) == false, 1);
        assert!(is_valid_transaction(&zero_amount_tx, &sender) == false, 2);
        
        destroy_user(sender);
        destroy_transaction(valid_tx);
        destroy_transaction(wrong_sender_tx);
        destroy_transaction(zero_amount_tx);
    }

    #[test]
    fun test_is_valid_transaction_unverified_sender() {
        let unverified = create_user(1, 100, false);
        let tx = create_transaction(1, 2, 100);
        
        assert!(is_valid_transaction(&tx, &unverified) == false, 0);
        
        destroy_user(unverified);
        destroy_transaction(tx);
    }

    #[test]
    fun test_create_and_check_user() {
        let (reputation, is_trusted, user) = create_and_check_user();
        
        assert!(reputation == 150, 0);
        assert!(is_trusted == true, 1);
        
        // Verify we still have the user
        let final_rep = destroy_user(user);
        assert!(final_rep == 150, 2);
    }

    #[test]
    fun test_analyze_user() {
        let user = create_user(5, 120, true);
        
        let (is_active, is_reputable, is_trusted) = analyze_user(&user);
        
        assert!(is_active == true, 0);
        assert!(is_reputable == true, 1);
        assert!(is_trusted == true, 2);
        
        destroy_user(user);
    }

    #[test]
    fun test_multiple_borrows_same_value() {
        let user = create_user(1, 200, true);
        
        // Borrow the same user many times
        let r1 = get_reputation(&user);
        let r2 = get_reputation(&user);
        let trusted1 = is_trusted_user(&user);
        let trusted2 = is_trusted_user(&user);
        let (_, _, trusted3) = analyze_user(&user);
        
        assert!(r1 == 200, 0);
        assert!(r2 == 200, 1);
        assert!(trusted1 == true, 2);
        assert!(trusted2 == true, 3);
        assert!(trusted3 == true, 4);
        
        destroy_user(user);
    }
}
