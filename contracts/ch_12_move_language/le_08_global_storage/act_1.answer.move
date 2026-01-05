module movestack::config_storage {
    use std::signer;
    use std::string::String;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Config already exists at this address
    const E_CONFIG_EXISTS: u64 = 1;
    /// Config not found at the specified address
    const E_CONFIG_NOT_FOUND: u64 = 2;
    /// Caller is not the owner of the config
    const E_NOT_OWNER: u64 = 3;

    // ============================================
    // RESOURCES
    // ============================================

    /// Configuration resource stored at each admin's address.
    /// Each admin can have their own independent config.
    struct Config has key {
        /// Name of the application
        app_name: String,
        /// Maximum allowed connections
        max_connections: u64,
        /// Whether the system is in maintenance mode
        is_maintenance: bool,
    }

    // ============================================
    // ENTRY FUNCTIONS
    // ============================================

    /// Initialize a new config for the calling account.
    /// 
    /// # Arguments
    /// * `account` - The signer who will own this config
    /// * `app_name` - Name of the application
    /// * `max_connections` - Initial max connections setting
    /// 
    /// # Aborts
    /// * `E_CONFIG_EXISTS` - If a config already exists at caller's address
    public entry fun initialize(
        account: &signer,
        app_name: String,
        max_connections: u64
    ) {
        let addr = signer::address_of(account);
        
        // Ensure config doesn't already exist
        assert!(!exists<Config>(addr), E_CONFIG_EXISTS);
        
        // Create the config resource
        let config = Config {
            app_name,
            max_connections,
            is_maintenance: false,
        };
        
        // Publish to the signer's address
        move_to(account, config);
    }

    /// Update the max connections setting.
    /// Only the config owner can update their own config.
    /// 
    /// # Arguments
    /// * `account` - The signer (must be config owner)
    /// * `new_max` - New max connections value
    /// 
    /// # Aborts
    /// * `E_CONFIG_NOT_FOUND` - If no config exists at caller's address
    public entry fun update_max_connections(
        account: &signer,
        new_max: u64
    ) acquires Config {
        let addr = signer::address_of(account);
        
        // Ensure config exists
        assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
        
        // Borrow mutably and update
        let config = borrow_global_mut<Config>(addr);
        config.max_connections = new_max;
    }

    /// Toggle the maintenance mode flag.
    /// Only the config owner can toggle their own maintenance mode.
    /// 
    /// # Arguments
    /// * `account` - The signer (must be config owner)
    /// 
    /// # Aborts
    /// * `E_CONFIG_NOT_FOUND` - If no config exists at caller's address
    public entry fun toggle_maintenance(account: &signer) acquires Config {
        let addr = signer::address_of(account);
        
        // Ensure config exists
        assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
        
        // Borrow mutably and toggle
        let config = borrow_global_mut<Config>(addr);
        config.is_maintenance = !config.is_maintenance;
    }

    /// Remove and destroy the config (demonstrates move_from).
    /// Only the owner can remove their own config.
    /// 
    /// # Arguments
    /// * `account` - The signer (must be config owner)
    /// 
    /// # Aborts
    /// * `E_CONFIG_NOT_FOUND` - If no config exists at caller's address
    public entry fun remove_config(account: &signer) acquires Config {
        let addr = signer::address_of(account);
        
        // Ensure config exists
        assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
        
        // Move the resource out (removes it from global storage)
        let Config { 
            app_name: _, 
            max_connections: _, 
            is_maintenance: _ 
        } = move_from<Config>(addr);
        
        // Resource is destructured and dropped
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    /// Get the app name from a config.
    /// 
    /// # Arguments
    /// * `addr` - Address to read config from
    /// 
    /// # Returns
    /// The app name string
    /// 
    /// # Aborts
    /// * `E_CONFIG_NOT_FOUND` - If no config exists at the address
    public fun get_app_name(addr: address): String acquires Config {
        assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
        let config = borrow_global<Config>(addr);
        config.app_name
    }

    /// Get the max connections from a config.
    /// 
    /// # Arguments
    /// * `addr` - Address to read config from
    /// 
    /// # Returns
    /// The max connections value
    /// 
    /// # Aborts
    /// * `E_CONFIG_NOT_FOUND` - If no config exists at the address
    public fun get_max_connections(addr: address): u64 acquires Config {
        assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
        let config = borrow_global<Config>(addr);
        config.max_connections
    }

    /// Check if an address is in maintenance mode.
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// True if in maintenance mode, false otherwise
    /// 
    /// # Aborts
    /// * `E_CONFIG_NOT_FOUND` - If no config exists at the address
    public fun is_in_maintenance(addr: address): bool acquires Config {
        assert!(exists<Config>(addr), E_CONFIG_NOT_FOUND);
        let config = borrow_global<Config>(addr);
        config.is_maintenance
    }

    /// Check if a config exists at an address.
    /// This is safe to call on any address.
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// True if a config exists, false otherwise
    public fun config_exists(addr: address): bool {
        exists<Config>(addr)
    }

    // ============================================
    // TESTS
    // ============================================

    #[test_only]
    use std::string;

    #[test(admin = @0x123)]
    fun test_initialize_success(admin: &signer) acquires Config {
        let app_name = string::utf8(b"MoveStack");
        initialize(admin, app_name, 100);
        
        let addr = signer::address_of(admin);
        assert!(config_exists(addr), 0);
        assert!(get_max_connections(addr) == 100, 1);
        assert!(!is_in_maintenance(addr), 2);
    }

    #[test(admin = @0x123)]
    #[expected_failure(abort_code = E_CONFIG_EXISTS)]
    fun test_initialize_twice_fails(admin: &signer) {
        let app_name = string::utf8(b"MoveStack");
        initialize(admin, app_name, 100);
        
        // This should fail - config already exists
        initialize(admin, app_name, 200);
    }

    #[test(admin = @0x123)]
    fun test_update_max_connections(admin: &signer) acquires Config {
        let app_name = string::utf8(b"MoveStack");
        initialize(admin, app_name, 100);
        
        let addr = signer::address_of(admin);
        assert!(get_max_connections(addr) == 100, 0);
        
        update_max_connections(admin, 500);
        assert!(get_max_connections(addr) == 500, 1);
    }

    #[test(admin = @0x123)]
    fun test_toggle_maintenance(admin: &signer) acquires Config {
        let app_name = string::utf8(b"MoveStack");
        initialize(admin, app_name, 100);
        
        let addr = signer::address_of(admin);
        assert!(!is_in_maintenance(addr), 0);
        
        toggle_maintenance(admin);
        assert!(is_in_maintenance(addr), 1);
        
        toggle_maintenance(admin);
        assert!(!is_in_maintenance(addr), 2);
    }

    #[test(admin = @0x123)]
    fun test_remove_config(admin: &signer) acquires Config {
        let app_name = string::utf8(b"MoveStack");
        initialize(admin, app_name, 100);
        
        let addr = signer::address_of(admin);
        assert!(config_exists(addr), 0);
        
        remove_config(admin);
        assert!(!config_exists(addr), 1);
    }

    #[test(admin = @0x123)]
    #[expected_failure(abort_code = E_CONFIG_NOT_FOUND)]
    fun test_get_nonexistent_config_fails(admin: &signer) acquires Config {
        let addr = signer::address_of(admin);
        // This should fail - no config exists
        get_max_connections(addr);
    }

    #[test(admin = @0x123)]
    #[expected_failure(abort_code = E_CONFIG_NOT_FOUND)]
    fun test_update_nonexistent_config_fails(admin: &signer) acquires Config {
        // This should fail - no config exists
        update_max_connections(admin, 100);
    }

    #[test(admin = @0x123)]
    fun test_config_exists_returns_false(admin: &signer) {
        let addr = signer::address_of(admin);
        assert!(!config_exists(addr), 0);
    }

    #[test(admin1 = @0x111, admin2 = @0x222)]
    fun test_multiple_admins_independent_configs(
        admin1: &signer, 
        admin2: &signer
    ) acquires Config {
        let app1 = string::utf8(b"App One");
        let app2 = string::utf8(b"App Two");
        
        initialize(admin1, app1, 100);
        initialize(admin2, app2, 200);
        
        let addr1 = signer::address_of(admin1);
        let addr2 = signer::address_of(admin2);
        
        // Verify independent configs
        assert!(get_max_connections(addr1) == 100, 0);
        assert!(get_max_connections(addr2) == 200, 1);
        
        // Update one doesn't affect the other
        update_max_connections(admin1, 150);
        assert!(get_max_connections(addr1) == 150, 2);
        assert!(get_max_connections(addr2) == 200, 3);
    }

    #[test(admin = @0x123)]
    fun test_reinitialize_after_remove(admin: &signer) acquires Config {
        let app_name = string::utf8(b"MoveStack");
        initialize(admin, app_name, 100);
        
        let addr = signer::address_of(admin);
        remove_config(admin);
        
        // Should be able to initialize again after removal
        let new_app_name = string::utf8(b"MoveStack v2");
        initialize(admin, new_app_name, 250);
        
        assert!(get_max_connections(addr) == 250, 0);
    }
}
