module movestack::counter {
    use std::signer;

    /// A simple counter resource that tracks a value
    struct Counter has key {
        value: u64,
    }

    /// Initialize a new counter for the calling account
    public entry fun initialize(account: &signer) {
        let counter = Counter { value: 0 };
        move_to(account, counter);
    }

    /// Get the current counter value for an address
    public fun get_value(addr: address): u64 acquires Counter {
        let counter = borrow_global<Counter>(addr);
        counter.value
    }

    /// Increment the counter (bonus functionality)
    public entry fun increment(account: &signer) acquires Counter {
        let addr = signer::address_of(account);
        let counter = borrow_global_mut<Counter>(addr);
        counter.value = counter.value + 1;
    }

    // ============ Tests ============

    #[test(account = @0x1)]
    fun test_initialize(account: &signer) acquires Counter {
        initialize(account);
        let addr = signer::address_of(account);
        assert!(get_value(addr) == 0, 0);
    }

    #[test(account = @0x1)]
    fun test_increment(account: &signer) acquires Counter {
        initialize(account);
        let addr = signer::address_of(account);
        
        increment(account);
        assert!(get_value(addr) == 1, 0);
        
        increment(account);
        assert!(get_value(addr) == 2, 0);
    }
}
