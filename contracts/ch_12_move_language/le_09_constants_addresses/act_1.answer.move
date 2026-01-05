````move
```move
module movestack::config {
    
    // ============================================
    // ERROR CODES
    // ============================================
    
    /// Error when an amount is invalid (zero or negative context)
    const EINVALID_AMOUNT: u64 = 1;
    
    /// Error when caller is not authorized for an operation
    const EUNAUTHORIZED: u64 = 2;
    
    /// Error when a limit has been exceeded
    const ELIMIT_EXCEEDED: u64 = 3;

    // ============================================
    // SYSTEM LIMITS
    // ============================================
    
    /// Maximum token supply: 1 billion units
    /// Using underscores improves readability for large numbers
    const MAX_SUPPLY: u64 = 1_000_000_000;
    
    /// Minimum stake required to participate: 100 units
    const MIN_STAKE: u64 = 100;
    
    /// Maximum number of validators in the network
    const MAX_VALIDATORS: u64 = 100;

    // ============================================
    // CONFIGURATION GETTERS
    // ============================================

    /// Returns the maximum supply constant.
    /// Getter functions allow other modules to access configuration
    /// without exposing the constant directly.
    public fun get_max_supply(): u64 {
        MAX_SUPPLY
    }

    /// Returns the minimum stake requirement.
    public fun get_min_stake(): u64 {
        MIN_STAKE
    }

    /// Returns the maximum number of validators allowed.
    public fun get_max_validators(): u64 {
        MAX_VALIDATORS
    }

    // ============================================
    // VALIDATION FUNCTIONS
    // ============================================

    /// Validates that an amount is within acceptable bounds.
    /// Aborts with EINVALID_AMOUNT if amount is zero.
    /// Aborts with ELIMIT_EXCEEDED if amount exceeds MAX_SUPPLY.
    public fun validate_amount(amount: u64) {
        // Amount must be greater than zero
        assert!(amount > 0, EINVALID_AMOUNT);
        // Amount must not exceed maximum supply
        assert!(amount <= MAX_SUPPLY, ELIMIT_EXCEEDED);
    }

    /// Validates that a stake meets minimum requirements.
    /// Aborts with EINVALID_AMOUNT if stake is below minimum.
    /// Returns true if validation passes.
    public fun validate_stake(stake: u64): bool {
        assert!(stake >= MIN_STAKE, EINVALID_AMOUNT);
        true
    }

    // ============================================
    // ADDRESS UTILITIES
    // ============================================

    /// Returns the module's named address.
    /// Named addresses are resolved at compile time based on Move.toml
    /// or compiler configuration, enabling deployment flexibility.
    public fun get_module_address(): address {
        @movestack
    }

    // ============================================
    // BONUS: Additional configuration utilities
    // ============================================

    /// Returns the error code for invalid amounts.
    /// Useful when other modules need to match error codes.
    public fun error_invalid_amount(): u64 {
        EINVALID_AMOUNT
    }

    /// Returns the error code for unauthorized access.
    public fun error_unauthorized(): u64 {
        EUNAUTHORIZED
    }

    /// Returns the error code for exceeded limits.
    public fun error_limit_exceeded(): u64 {
        ELIMIT_EXCEEDED
    }

    /// Checks if an amount is within valid range without aborting.
    /// Returns true if valid, false otherwise.
    public fun is_valid_amount(amount: u64): bool {
        amount > 0 && amount <= MAX_SUPPLY
    }

    /// Checks if a stake meets minimum requirements without aborting.
    public fun is_valid_stake(stake: u64): bool {
        stake >= MIN_STAKE
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_get_max_supply() {
        assert!(get_max_supply() == 1_000_000_000, 0);
    }

    #[test]
    fun test_get_min_stake() {
        assert!(get_min_stake() == 100, 0);
    }

    #[test]
    fun test_get_max_validators() {
        assert!(get_max_validators() == 100, 0);
    }

    #[test]
    fun test_validate_amount_valid() {
        // Valid amounts should not abort
        validate_amount(1);
        validate_amount(500);
        validate_amount(1_000_000_000);
    }

    #[test]
    #[expected_failure(abort_code = EINVALID_AMOUNT)]
    fun test_validate_amount_zero() {
        // Zero should abort with EINVALID_AMOUNT
        validate_amount(0);
    }

    #[test]
    #[expected_failure(abort_code = ELIMIT_EXCEEDED)]
    fun test_validate_amount_exceeds_max() {
        // Exceeding max supply should abort with ELIMIT_EXCEEDED
        validate_amount(1_000_000_001);
    }

    #[test]
    fun test_validate_stake_valid() {
        // Valid stakes should return true
        assert!(validate_stake(100) == true, 0);
        assert!(validate_stake(1000) == true, 1);
    }

    #[test]
    #[expected_failure(abort_code = EINVALID_AMOUNT)]
    fun test_validate_stake_below_minimum() {
        // Below minimum should abort
        validate_stake(99);
    }

    #[test]
    fun test_get_module_address() {
        // Should return the movestack named address
        let addr = get_module_address();
        assert!(addr == @movestack, 0);
    }

    #[test]
    fun test_is_valid_amount() {
        assert!(is_valid_amount(1) == true, 0);
        assert!(is_valid_amount(500) == true, 1);
        assert!(is_valid_amount(0) == false, 2);
        assert!(is_valid_amount(1_000_000_001) == false, 3);
    }

    #[test]
    fun test_is_valid_stake() {
        assert!(is_valid_stake(100) == true, 0);
        assert!(is_valid_stake(99) == false, 1);
        assert!(is_valid_stake(0) == false, 2);
    }

    #[test]
    fun test_error_code_getters() {
        assert!(error_invalid_amount() == 1, 0);
        assert!(error_unauthorized() == 2, 1);
        assert!(error_limit_exceeded() == 3, 2);
    }
}

```

````
