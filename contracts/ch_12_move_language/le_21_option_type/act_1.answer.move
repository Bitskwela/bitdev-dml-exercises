module option_demo::user_registry {
    use std::option::{Self, Option};
    use std::vector;

    // ============================================
    // Task 1: User struct with copy and drop abilities
    // ============================================
    
    /// A user record that can be copied and dropped.
    /// Used for registry lookups and balance queries.
    struct User has copy, drop {
        id: u64,
        balance: u64
    }

    /// Creates a new user with the given ID and balance
    public fun create_user(id: u64, balance: u64): User {
        User { id, balance }
    }

    /// Gets the ID from a user
    public fun get_id(user: &User): u64 {
        user.id
    }

    /// Gets the balance from a user
    public fun get_balance(user: &User): u64 {
        user.balance
    }

    // ============================================
    // Task 2: find_user function
    // ============================================
    
    /// Searches for a user by ID in the given vector.
    /// Returns some(user) if found, none() if not found.
    public fun find_user(users: &vector<User>, target_id: u64): Option<User> {
        let mut i = 0u64;
        let len = vector::length(users);
        
        while (i < len) {
            let user = *vector::borrow(users, i);
            if (user.id == target_id) {
                return option::some(user)
            };
            i = i + 1;
        };
        
        option::none()
    }

    // ============================================
    // Task 3: get_user_balance function
    // ============================================
    
    /// Gets the balance for a user with the given ID.
    /// Returns 0 if the user is not found.
    public fun get_user_balance(users: &vector<User>, user_id: u64): u64 {
        let user_opt = find_user(users, user_id);
        
        if (option::is_some(&user_opt)) {
            let user = option::destroy_some(user_opt);
            user.balance
        } else {
            option::destroy_none(user_opt);
            0
        }
    }

    // Alternative implementation using destroy_with_default pattern:
    // public fun get_user_balance_alt(users: &vector<User>, user_id: u64): u64 {
    //     let user_opt = find_user(users, user_id);
    //     if (option::is_some(&user_opt)) {
    //         option::destroy_some(user_opt).balance
    //     } else {
    //         option::destroy_none(user_opt);
    //         0
    //     }
    // }

    // ============================================
    // Task 4: find_highest_balance function
    // ============================================
    
    /// Finds the user with the highest balance in the vector.
    /// Returns some(user) if vector is non-empty, none() if empty.
    /// If multiple users have the same highest balance, returns the first one.
    public fun find_highest_balance(users: &vector<User>): Option<User> {
        let len = vector::length(users);
        
        // Empty vector case
        if (len == 0) {
            return option::none()
        };
        
        // Start with first user as the highest
        let mut highest = *vector::borrow(users, 0);
        let mut i = 1u64;
        
        // Check remaining users
        while (i < len) {
            let current = *vector::borrow(users, i);
            if (current.balance > highest.balance) {
                highest = current;
            };
            i = i + 1;
        };
        
        option::some(highest)
    }

    // ============================================
    // Bonus: Additional utility functions
    // ============================================
    
    /// Finds all users with balance greater than the threshold.
    /// Returns an empty vector if no users match.
    public fun find_users_above_balance(
        users: &vector<User>, 
        threshold: u64
    ): vector<User> {
        let mut result = vector::empty<User>();
        let mut i = 0u64;
        let len = vector::length(users);
        
        while (i < len) {
            let user = *vector::borrow(users, i);
            if (user.balance > threshold) {
                vector::push_back(&mut result, user);
            };
            i = i + 1;
        };
        
        result
    }

    /// Updates a user's balance if they exist.
    /// Returns true if update succeeded, false if user not found.
    public fun update_user_balance(
        users: &mut vector<User>, 
        user_id: u64, 
        new_balance: u64
    ): bool {
        let mut i = 0u64;
        let len = vector::length(users);
        
        while (i < len) {
            let user = vector::borrow_mut(users, i);
            if (user.id == user_id) {
                user.balance = new_balance;
                return true
            };
            i = i + 1;
        };
        
        false
    }

    // ============================================
    // Test helpers
    // ============================================

    #[test]
    fun test_find_user_exists() {
        let users = vector[
            create_user(1, 100),
            create_user(2, 200),
            create_user(3, 300)
        ];
        
        let result = find_user(&users, 2);
        assert!(option::is_some(&result), 1);
        
        let user = option::destroy_some(result);
        assert!(get_id(&user) == 2, 2);
        assert!(get_balance(&user) == 200, 3);
    }

    #[test]
    fun test_find_user_not_exists() {
        let users = vector[
            create_user(1, 100),
            create_user(2, 200)
        ];
        
        let result = find_user(&users, 99);
        assert!(option::is_none(&result), 1);
        option::destroy_none(result);
    }

    #[test]
    fun test_get_user_balance_exists() {
        let users = vector[
            create_user(1, 100),
            create_user(2, 250)
        ];
        
        let balance = get_user_balance(&users, 2);
        assert!(balance == 250, 1);
    }

    #[test]
    fun test_get_user_balance_not_exists() {
        let users = vector[
            create_user(1, 100)
        ];
        
        let balance = get_user_balance(&users, 99);
        assert!(balance == 0, 1);
    }

    #[test]
    fun test_find_highest_balance() {
        let users = vector[
            create_user(1, 100),
            create_user(2, 500),
            create_user(3, 200)
        ];
        
        let result = find_highest_balance(&users);
        assert!(option::is_some(&result), 1);
        
        let user = option::destroy_some(result);
        assert!(get_id(&user) == 2, 2);
        assert!(get_balance(&user) == 500, 3);
    }

    #[test]
    fun test_find_highest_balance_empty() {
        let users: vector<User> = vector[];
        
        let result = find_highest_balance(&users);
        assert!(option::is_none(&result), 1);
        option::destroy_none(result);
    }

    #[test]
    fun test_find_users_above_balance() {
        let users = vector[
            create_user(1, 100),
            create_user(2, 500),
            create_user(3, 200),
            create_user(4, 50)
        ];
        
        let above_150 = find_users_above_balance(&users, 150);
        assert!(vector::length(&above_150) == 2, 1);
    }

    #[test]
    fun test_update_user_balance() {
        let mut users = vector[
            create_user(1, 100),
            create_user(2, 200)
        ];
        
        let updated = update_user_balance(&mut users, 1, 999);
        assert!(updated == true, 1);
        
        let balance = get_user_balance(&users, 1);
        assert!(balance == 999, 2);
        
        let not_updated = update_user_balance(&mut users, 99, 500);
        assert!(not_updated == false, 3);
    }
}
