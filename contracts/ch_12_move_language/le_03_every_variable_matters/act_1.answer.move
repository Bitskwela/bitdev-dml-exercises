```move
module movestack::type_registry {

    // ============================================
    // TYPE DEMONSTRATIONS
    // ============================================

    /// Demonstrates all integer types in Move.
    /// Each type has a specific size: u8 (1 byte), u16 (2 bytes), u32 (4 bytes),
    /// u64 (8 bytes), u128 (16 bytes), u256 (32 bytes).
    public fun demonstrate_integers(): u64 {
        // u8: Perfect for small values like percentages, ages, or status codes
        let _tiny: u8 = 100;
        
        // u16: Good for larger counts up to 65,535
        let _small: u16 = 1000;
        
        // u32: Handles values up to ~4 billion
        let _medium: u32 = 1000000;
        
        // u64: The workhorse type for token amounts and most calculations
        let standard: u64 = 1000000000;
        
        // u128: For very large values, useful for high-precision math
        let _huge: u128 = 1000000000000000000;
        
        // u256: Maximum size, often used for cryptographic values
        let _massive: u256 = 1;
        
        // Return the u64 for testing
        standard
    }

    /// Demonstrates boolean and address primitive types.
    /// bool: true or false
    /// address: a 32-byte account identifier
    public fun demonstrate_bool_and_address(): bool {
        // Boolean for flags and conditions
        let is_active: bool = true;
        
        // Address type for account references
        // The @0x1 syntax creates an address literal
        let _admin: address = @0x1;
        
        is_active
    }

    /// Safely converts a u8 to u64 using the 'as' keyword.
    /// Upcasting (smaller to larger) is always safe in Move.
    public fun safe_type_conversion(value: u8): u64 {
        // The 'as' keyword performs type conversion
        // u8 -> u64 is safe because u64 can hold all u8 values
        (value as u64)
    }

    // ============================================
    // PRACTICAL APPLICATION
    // ============================================

    /// Validates if an age represents a valid adult (18-120).
    /// Uses u8 since ages fit within 0-255 range.
    public fun create_user_age(age: u8): bool {
        // Logical AND (&&) combines conditions
        // Returns true only if both conditions are met
        age >= 18 && age <= 120
    }

    /// Calculates total tokens from balance and bonus.
    /// Uses u64 which is standard for token amounts.
    public fun calculate_total_tokens(balance: u64, bonus: u64): u64 {
        // Simple addition - in production, consider overflow checks
        balance + bonus
    }

    // ============================================
    // BONUS: Additional type utilities
    // ============================================

    /// Demonstrates vector<u8> which is commonly used for byte strings
    public fun create_byte_string(): vector<u8> {
        // b"..." syntax creates a vector<u8> from ASCII bytes
        b"MoveStack"
    }

    /// Shows comparison between different sized integers after conversion
    public fun compare_with_conversion(small: u8, large: u64): bool {
        // Convert u8 to u64 for comparison
        (small as u64) < large
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_demonstrate_integers() {
        let result = demonstrate_integers();
        assert!(result == 1000000000, 0);
    }

    #[test]
    fun test_demonstrate_bool_and_address() {
        let result = demonstrate_bool_and_address();
        assert!(result == true, 0);
    }

    #[test]
    fun test_safe_type_conversion() {
        // Test with minimum value
        assert!(safe_type_conversion(0) == 0, 0);
        
        // Test with maximum u8 value
        assert!(safe_type_conversion(255) == 255, 1);
        
        // Test with typical value
        assert!(safe_type_conversion(100) == 100, 2);
    }

    #[test]
    fun test_create_user_age_valid() {
        // Test boundary: exactly 18
        assert!(create_user_age(18) == true, 0);
        
        // Test typical adult age
        assert!(create_user_age(25) == true, 1);
        
        // Test boundary: exactly 120
        assert!(create_user_age(120) == true, 2);
    }

    #[test]
    fun test_create_user_age_invalid() {
        // Test too young
        assert!(create_user_age(17) == false, 0);
        assert!(create_user_age(0) == false, 1);
        
        // Test too old
        assert!(create_user_age(121) == false, 2);
        assert!(create_user_age(255) == false, 3);
    }

    #[test]
    fun test_calculate_total_tokens() {
        // Test basic addition
        assert!(calculate_total_tokens(100, 50) == 150, 0);
        
        // Test with zero bonus
        assert!(calculate_total_tokens(1000, 0) == 1000, 1);
        
        // Test with zero balance
        assert!(calculate_total_tokens(0, 500) == 500, 2);
    }

    #[test]
    fun test_create_byte_string() {
        use std::vector;
        let bytes = create_byte_string();
        assert!(vector::length(&bytes) == 9, 0); // "MoveStack" is 9 characters
    }

    #[test]
    fun test_compare_with_conversion() {
        assert!(compare_with_conversion(10, 100) == true, 0);
        assert!(compare_with_conversion(100, 10) == false, 1);
        assert!(compare_with_conversion(50, 50) == false, 2); // equal, not less than
    }
}

```
