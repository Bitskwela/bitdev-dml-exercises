module abilities::ability_demo {
    use std::vector;

    // ============================================
    // Task 1: Config struct with copy and drop abilities
    // ============================================
    
    /// A freely copyable and droppable configuration struct.
    /// Safe for simple data that can be passed around without restrictions.
    struct Config has copy, drop {
        max_participants: u64,
        is_active: bool
    }

    // ============================================
    // Task 2: Record struct with key and store abilities
    // ============================================
    
    /// A storable record that can persist in global storage.
    /// Has key for top-level storage and store for nesting.
    struct Record has key, store {
        id: u64,
        data: vector<u8>
    }

    /// Wrapper to demonstrate that Record can be stored inside other structs
    struct RecordWrapper has key, store {
        inner: Record
    }

    // ============================================
    // Task 3: RestrictedToken with no abilities
    // ============================================
    
    /// A restricted token that cannot be copied, dropped, or stored.
    /// Must be explicitly created and consumed - perfect for unique assets.
    struct RestrictedToken {
        value: u64
    }

    /// Creates a new RestrictedToken with the given value
    public fun create_token(value: u64): RestrictedToken {
        RestrictedToken { value }
    }

    /// Consumes a RestrictedToken and returns its value.
    /// This is the only way to "get rid of" a RestrictedToken since it lacks drop.
    public fun consume_token(token: RestrictedToken): u64 {
        let RestrictedToken { value } = token;
        value
    }

    // ============================================
    // Helper functions for Config
    // ============================================

    /// Creates a new Config with the specified parameters
    public fun create_config(max_participants: u64, is_active: bool): Config {
        Config { max_participants, is_active }
    }

    /// Gets the max_participants from a Config
    public fun get_max_participants(config: &Config): u64 {
        config.max_participants
    }

    /// Gets the is_active status from a Config
    public fun is_active(config: &Config): bool {
        config.is_active
    }

    /// Demonstrates that Config can be copied - returns two copies
    public fun duplicate_config(config: Config): (Config, Config) {
        // Because Config has copy, we can return it twice
        (copy config, config)
    }

    // ============================================
    // Helper functions for Record
    // ============================================

    /// Creates a new Record
    public fun create_record(id: u64, data: vector<u8>): Record {
        Record { id, data }
    }

    /// Gets the id from a Record
    public fun get_record_id(record: &Record): u64 {
        record.id
    }

    /// Demonstrates that Record can be stored inside other structs
    public fun wrap_record(record: Record): RecordWrapper {
        RecordWrapper { inner: record }
    }

    /// Unwraps a RecordWrapper to get the inner Record
    public fun unwrap_record(wrapper: RecordWrapper): Record {
        let RecordWrapper { inner } = wrapper;
        inner
    }

    // ============================================
    // Utility functions for RestrictedToken
    // ============================================

    /// Gets the value without consuming the token (view only)
    public fun get_token_value(token: &RestrictedToken): u64 {
        token.value
    }

    /// Splits a token into two tokens with specified values.
    /// Consumes the original and creates two new tokens.
    public fun split_token(token: RestrictedToken, amount: u64): (RestrictedToken, RestrictedToken) {
        let original_value = consume_token(token);
        assert!(amount <= original_value, 1); // ERR_INSUFFICIENT_VALUE
        
        let token1 = create_token(amount);
        let token2 = create_token(original_value - amount);
        (token1, token2)
    }

    /// Merges two tokens into one by adding their values.
    public fun merge_tokens(token1: RestrictedToken, token2: RestrictedToken): RestrictedToken {
        let value1 = consume_token(token1);
        let value2 = consume_token(token2);
        create_token(value1 + value2)
    }

    // ============================================
    // Tests
    // ============================================

    #[test]
    fun test_config_copy_ability() {
        let config = create_config(100, true);
        
        // Test that we can copy the config
        let (config1, config2) = duplicate_config(config);
        
        // Both copies should have the same values
        assert!(get_max_participants(&config1) == 100, 0);
        assert!(get_max_participants(&config2) == 100, 1);
        assert!(is_active(&config1) == true, 2);
        assert!(is_active(&config2) == true, 3);
        
        // Config has drop, so these will be automatically cleaned up
    }

    #[test]
    fun test_config_can_be_passed_multiple_times() {
        let config = create_config(50, false);
        
        // Because of copy ability, we can use config multiple times
        let participants1 = get_max_participants(&config);
        let participants2 = get_max_participants(&config);
        let active = is_active(&config);
        
        assert!(participants1 == 50, 0);
        assert!(participants2 == 50, 1);
        assert!(active == false, 2);
    }

    #[test]
    fun test_record_store_ability() {
        let data = vector::empty<u8>();
        vector::push_back(&mut data, 1);
        vector::push_back(&mut data, 2);
        vector::push_back(&mut data, 3);
        
        let record = create_record(42, data);
        
        // Test that Record can be stored in a wrapper
        let wrapper = wrap_record(record);
        
        // Unwrap to get the record back
        let unwrapped = unwrap_record(wrapper);
        
        assert!(get_record_id(&unwrapped) == 42, 0);
        
        // Clean up: Record has store but not drop, so we need to handle it
        // In a real scenario, this would be stored in global storage
        // For testing, we destructure it
        let Record { id: _, data: _ } = unwrapped;
    }

    #[test]
    fun test_restricted_token_must_be_consumed() {
        // Create a token
        let token = create_token(1000);
        
        // Check value without consuming
        assert!(get_token_value(&token) == 1000, 0);
        
        // Must explicitly consume the token
        let value = consume_token(token);
        assert!(value == 1000, 1);
        
        // token no longer exists after consume_token
    }

    #[test]
    fun test_restricted_token_split() {
        let token = create_token(100);
        
        // Split into two tokens
        let (token1, token2) = split_token(token, 30);
        
        assert!(get_token_value(&token1) == 30, 0);
        assert!(get_token_value(&token2) == 70, 1);
        
        // Clean up both tokens
        let _ = consume_token(token1);
        let _ = consume_token(token2);
    }

    #[test]
    fun test_restricted_token_merge() {
        let token1 = create_token(50);
        let token2 = create_token(75);
        
        // Merge tokens
        let merged = merge_tokens(token1, token2);
        
        assert!(get_token_value(&merged) == 125, 0);
        
        // Clean up
        let _ = consume_token(merged);
    }

    #[test]
    #[expected_failure(abort_code = 1)]
    fun test_split_fails_with_insufficient_value() {
        let token = create_token(50);
        
        // This should fail - trying to split more than available
        let (t1, t2) = split_token(token, 100);
        
        // Clean up (won't reach here)
        let _ = consume_token(t1);
        let _ = consume_token(t2);
    }

    #[test]
    fun test_abilities_comparison() {
        // Config: has copy, drop - can be freely duplicated and discarded
        let config = create_config(10, true);
        let config_copy = copy config;
        assert!(get_max_participants(&config) == get_max_participants(&config_copy), 0);
        // Both configs automatically dropped at end of scope

        // Record: has key, store - can be stored but not copied or auto-dropped
        let record = create_record(1, vector::empty());
        // let record_copy = copy record; // This would fail! Record doesn't have copy
        let Record { id: _, data: _ } = record; // Must explicitly destructure

        // RestrictedToken: no abilities - maximum restriction
        let token = create_token(500);
        // let token_copy = copy token; // Would fail! No copy ability
        // Drop would also fail - must consume explicitly
        let _ = consume_token(token);
    }
}
