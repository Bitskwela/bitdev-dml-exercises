module savings::secure_fund {

    // ============================================
    // ERROR CODES
    // ============================================

    /// Insufficient balance for withdrawal
    const E_INSUFFICIENT_BALANCE: u64 = 1;

    /// Invalid amount (zero or negative logic)
    const E_INVALID_AMOUNT: u64 = 2;

    /// User is not authorized for this action
    const E_NOT_AUTHORIZED: u64 = 3;

    /// Fund or distribution is closed
    const E_FUND_CLOSED: u64 = 4;

    /// Relief has already been claimed
    const E_ALREADY_CLAIMED: u64 = 5;

    // ============================================
    // TASK 1: safe_withdraw
    // Using abort for explicit error handling
    // ============================================

    /// Safely withdraws an amount from a balance
    ///
    /// # Arguments
    /// * `balance` - Current balance
    /// * `amount` - Amount to withdraw
    ///
    /// # Returns
    /// New balance after withdrawal
    ///
    /// # Aborts
    /// * E_INVALID_AMOUNT - if amount is 0
    /// * E_INSUFFICIENT_BALANCE - if amount > balance
    public fun safe_withdraw(balance: u64, amount: u64): u64 {
        // Check for zero amount first
        if (amount == 0) {
            abort E_INVALID_AMOUNT
        };

        // Check for sufficient balance
        if (amount > balance) {
            abort E_INSUFFICIENT_BALANCE
        };

        // Return new balance
        balance - amount
    }

    // ============================================
    // TASK 2: validate_deposit
    // Using assert! macro for cleaner validation
    // ============================================

    /// Validates and processes a deposit
    ///
    /// # Arguments
    /// * `balance` - Current balance
    /// * `amount` - Amount to deposit
    /// * `is_fund_open` - Whether the fund accepts deposits
    ///
    /// # Returns
    /// New balance after deposit
    ///
    /// # Aborts
    /// * E_INVALID_AMOUNT - if amount is 0
    /// * E_FUND_CLOSED - if fund is not accepting deposits
    public fun validate_deposit(balance: u64, amount: u64, is_fund_open: bool): u64 {
        // Use assert! for clean single-condition checks
        assert!(amount > 0, E_INVALID_AMOUNT);
        assert!(is_fund_open, E_FUND_CLOSED);

        // Process the deposit
        balance + amount
    }

    // ============================================
    // TASK 3: claim_relief
    // Multiple validation checks with assert!
    // ============================================

    /// Claims relief distribution after validation
    ///
    /// # Arguments
    /// * `is_registered` - Whether the claimant is registered
    /// * `has_claimed` - Whether they've already claimed
    /// * `is_distribution_open` - Whether distribution is active
    ///
    /// # Returns
    /// Relief amount (1000)
    ///
    /// # Aborts
    /// * E_NOT_AUTHORIZED - if not registered
    /// * E_ALREADY_CLAIMED - if already claimed
    /// * E_FUND_CLOSED - if distribution is closed
    public fun claim_relief(
        is_registered: bool,
        has_claimed: bool,
        is_distribution_open: bool
    ): u64 {
        // Stack validations at the beginning (fail fast pattern)
        assert!(is_registered, E_NOT_AUTHORIZED);
        assert!(!has_claimed, E_ALREADY_CLAIMED);
        assert!(is_distribution_open, E_FUND_CLOSED);

        // All checks passed, return relief amount
        1000
    }

    // ============================================
    // TASK 4: admin_transfer
    // Combining abort and assert patterns
    // ============================================

    /// Admin-only transfer with complex validation
    ///
    /// # Arguments
    /// * `is_admin` - Whether the caller is an admin
    /// * `balance` - Current fund balance
    /// * `amount` - Amount to transfer
    ///
    /// # Returns
    /// Remaining balance after transfer
    ///
    /// # Aborts
    /// * E_NOT_AUTHORIZED - if not an admin
    /// * E_INVALID_AMOUNT - if amount is 0 or exceeds balance
    public fun admin_transfer(
        is_admin: bool,
        balance: u64,
        amount: u64
    ): u64 {
        // Simple boolean check - use assert!
        assert!(is_admin, E_NOT_AUTHORIZED);

        // Complex condition with multiple parts - use if/abort
        if (amount == 0 || amount > balance) {
            abort E_INVALID_AMOUNT
        };

        // Return remaining balance
        balance - amount
    }

    // ============================================
    // UNIT TESTS
    // ============================================

    #[test]
    fun test_safe_withdraw_success() {
        let result = safe_withdraw(100, 30);
        assert!(result == 70, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_INVALID_AMOUNT)]
    fun test_safe_withdraw_zero_amount() {
        safe_withdraw(100, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_INSUFFICIENT_BALANCE)]
    fun test_safe_withdraw_insufficient() {
        safe_withdraw(50, 100);
    }

    #[test]
    fun test_validate_deposit_success() {
        let result = validate_deposit(100, 50, true);
        assert!(result == 150, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_INVALID_AMOUNT)]
    fun test_validate_deposit_zero_amount() {
        validate_deposit(100, 0, true);
    }

    #[test]
    #[expected_failure(abort_code = E_FUND_CLOSED)]
    fun test_validate_deposit_fund_closed() {
        validate_deposit(100, 50, false);
    }

    #[test]
    fun test_claim_relief_success() {
        let amount = claim_relief(true, false, true);
        assert!(amount == 1000, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_NOT_AUTHORIZED)]
    fun test_claim_relief_not_registered() {
        claim_relief(false, false, true);
    }

    #[test]
    #[expected_failure(abort_code = E_ALREADY_CLAIMED)]
    fun test_claim_relief_already_claimed() {
        claim_relief(true, true, true);
    }

    #[test]
    #[expected_failure(abort_code = E_FUND_CLOSED)]
    fun test_claim_relief_distribution_closed() {
        claim_relief(true, false, false);
    }

    #[test]
    fun test_admin_transfer_success() {
        let result = admin_transfer(true, 1000, 300);
        assert!(result == 700, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_NOT_AUTHORIZED)]
    fun test_admin_transfer_not_admin() {
        admin_transfer(false, 1000, 300);
    }

    #[test]
    #[expected_failure(abort_code = E_INVALID_AMOUNT)]
    fun test_admin_transfer_zero_amount() {
        admin_transfer(true, 1000, 0);
    }

    #[test]
    #[expected_failure(abort_code = E_INVALID_AMOUNT)]
    fun test_admin_transfer_exceeds_balance() {
        admin_transfer(true, 100, 500);
    }
}
