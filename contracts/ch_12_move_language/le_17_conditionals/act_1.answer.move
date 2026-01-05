module movestack::access_control {

    // ============================================
    // ERROR CODES
    // ============================================

    /// Invalid role provided
    const E_INVALID_ROLE: u64 = 1;

    // ============================================
    // CONSTANTS
    // ============================================

    /// Role constants for readability
    const ROLE_GUEST: u8 = 0;
    const ROLE_MEMBER: u8 = 1;
    const ROLE_ADMIN: u8 = 2;

    // ============================================
    // TASK 1: Get role name based on role code
    // Using if/else if/else chain
    // ============================================

    /// Returns a role identifier based on the role code
    /// 
    /// # Arguments
    /// * `role` - The role code to look up
    /// 
    /// # Returns
    /// Role identifier: 0 for Guest, 1 for Member, 2 for Admin
    /// Defaults to 0 (Guest) for unknown roles
    public fun get_role_name(role: u8): u8 {
        if (role == ROLE_GUEST) {
            0  // Guest
        } else if (role == ROLE_MEMBER) {
            1  // Member
        } else if (role == ROLE_ADMIN) {
            2  // Admin
        } else {
            0  // Default to Guest for unknown roles
        }
    }

    // ============================================
    // TASK 2: Check feature access
    // Using logical operators in condition
    // ============================================

    /// Checks if a user can access a feature based on role and status
    /// 
    /// # Arguments
    /// * `user_role` - The user's current role (0, 1, or 2)
    /// * `required_role` - The minimum role needed for the feature
    /// * `is_active` - Whether the user's account is active
    /// 
    /// # Returns
    /// true if user is active AND has sufficient role level
    public fun can_access_feature(user_role: u8, required_role: u8, is_active: bool): bool {
        // User must be active AND have at least the required role
        is_active && user_role >= required_role
    }

    // ============================================
    // TASK 3: Calculate access level
    // Using nested conditionals
    // ============================================

    /// Calculates access level based on role, activity, and verification
    /// 
    /// # Arguments
    /// * `role` - User's role (0=Guest, 1=Member, 2=Admin)
    /// * `is_active` - Whether account is active
    /// * `is_verified` - Whether account is verified
    /// 
    /// # Returns
    /// Access level score based on the rules:
    /// - Inactive: 0
    /// - Active guest: 10
    /// - Active member: 30 (verified) or 20 (unverified)
    /// - Active admin: 100 (verified) or 50 (unverified)
    public fun get_access_level(role: u8, is_active: bool, is_verified: bool): u64 {
        // First check: must be active
        if (!is_active) {
            0
        } else {
            // Active user - check role
            if (role == ROLE_ADMIN) {
                // Admin role
                if (is_verified) {
                    100
                } else {
                    50
                }
            } else if (role == ROLE_MEMBER) {
                // Member role
                if (is_verified) {
                    30
                } else {
                    20
                }
            } else {
                // Guest role (default)
                10
            }
        }
    }

    // ============================================
    // TASK 4: Complex permission calculation
    // Using conditionals and variable accumulation
    // ============================================

    /// Calculates a comprehensive permission score
    /// 
    /// # Arguments
    /// * `role` - User's role
    /// * `is_active` - Whether account is active
    /// * `is_verified` - Whether account is verified
    /// * `account_age_days` - Number of days since account creation
    /// 
    /// # Returns
    /// Permission score based on:
    /// - 0 if inactive
    /// - Base: 10 (guest), 50 (member), 100 (admin)
    /// - +25 bonus if verified
    /// - +15 bonus if account age >= 30 days
    public fun calculate_permission_score(
        role: u8,
        is_active: bool,
        is_verified: bool,
        account_age_days: u64
    ): u64 {
        // Guard clause: inactive users get no permissions
        if (!is_active) {
            return 0
        };

        // Calculate base score based on role
        let score = if (role == ROLE_ADMIN) {
            100
        } else if (role == ROLE_MEMBER) {
            50
        } else {
            10
        };

        // Add verification bonus
        if (is_verified) {
            score = score + 25;
        };

        // Add account age bonus
        if (account_age_days >= 30) {
            score = score + 15;
        };

        score
    }

    // ============================================
    // BONUS: Simplified boolean returns
    // Direct boolean expressions without if/else
    // ============================================

    /// Returns true if the user is a privileged user (member or admin)
    /// 
    /// # Arguments
    /// * `role` - The user's role
    /// 
    /// # Returns
    /// true if role is Member (1) or Admin (2)
    public fun is_privileged(role: u8): bool {
        // Direct boolean expression - no if/else needed
        role >= ROLE_MEMBER
    }

    /// Returns true if user needs additional verification
    /// 
    /// # Arguments
    /// * `role` - The user's role
    /// * `account_age_days` - Number of days since account creation
    /// 
    /// # Returns
    /// true if new user (< 7 days) OR admin role
    public fun needs_extra_verification(role: u8, account_age_days: u64): bool {
        // Combine conditions with OR operator
        account_age_days < 7 || role == ROLE_ADMIN
    }

    // ============================================
    // TEST FUNCTIONS
    // ============================================

    #[test]
    fun test_get_role_name() {
        assert!(get_role_name(0) == 0, 1);
        assert!(get_role_name(1) == 1, 2);
        assert!(get_role_name(2) == 2, 3);
        assert!(get_role_name(5) == 0, 4);  // Unknown defaults to guest
        assert!(get_role_name(255) == 0, 5);
    }

    #[test]
    fun test_can_access_feature() {
        // Active admin can access member feature
        assert!(can_access_feature(2, 1, true) == true, 1);
        // Active member cannot access admin feature
        assert!(can_access_feature(1, 2, true) == false, 2);
        // Inactive admin cannot access anything
        assert!(can_access_feature(2, 1, false) == false, 3);
        // Active guest can access guest feature
        assert!(can_access_feature(0, 0, true) == true, 4);
        // Same role can access
        assert!(can_access_feature(1, 1, true) == true, 5);
    }

    #[test]
    fun test_get_access_level() {
        // Inactive users get 0
        assert!(get_access_level(2, false, true) == 0, 1);
        assert!(get_access_level(1, false, false) == 0, 2);

        // Active guest
        assert!(get_access_level(0, true, false) == 10, 3);
        assert!(get_access_level(0, true, true) == 10, 4);

        // Active member
        assert!(get_access_level(1, true, false) == 20, 5);
        assert!(get_access_level(1, true, true) == 30, 6);

        // Active admin
        assert!(get_access_level(2, true, false) == 50, 7);
        assert!(get_access_level(2, true, true) == 100, 8);
    }

    #[test]
    fun test_calculate_permission_score() {
        // Inactive user
        assert!(calculate_permission_score(2, false, true, 100) == 0, 1);

        // Guest variations
        assert!(calculate_permission_score(0, true, false, 0) == 10, 2);
        assert!(calculate_permission_score(0, true, true, 0) == 35, 3);  // 10 + 25
        assert!(calculate_permission_score(0, true, false, 30) == 25, 4);  // 10 + 15
        assert!(calculate_permission_score(0, true, true, 30) == 50, 5);  // 10 + 25 + 15

        // Member variations
        assert!(calculate_permission_score(1, true, false, 0) == 50, 6);
        assert!(calculate_permission_score(1, true, true, 60) == 90, 7);  // 50 + 25 + 15

        // Admin variations
        assert!(calculate_permission_score(2, true, false, 10) == 100, 8);
        assert!(calculate_permission_score(2, true, true, 30) == 140, 9);  // 100 + 25 + 15
    }

    #[test]
    fun test_is_privileged() {
        assert!(is_privileged(0) == false, 1);  // Guest
        assert!(is_privileged(1) == true, 2);   // Member
        assert!(is_privileged(2) == true, 3);   // Admin
    }

    #[test]
    fun test_needs_extra_verification() {
        // New user (< 7 days)
        assert!(needs_extra_verification(0, 3) == true, 1);
        assert!(needs_extra_verification(1, 6) == true, 2);

        // Admin (any age)
        assert!(needs_extra_verification(2, 60) == true, 3);
        assert!(needs_extra_verification(2, 0) == true, 4);

        // Established non-admin
        assert!(needs_extra_verification(0, 30) == false, 5);
        assert!(needs_extra_verification(1, 7) == false, 6);
    }
}
