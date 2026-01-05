/// Counter operations module - basic increment/decrement with mutable references
module counter::operations {
    /// A simple counter that tracks a value
    struct Counter has drop {
        value: u64
    }
    
    /// Create a new counter starting at zero
    public fun new(): Counter {
        Counter { value: 0 }
    }
    
    /// Create a counter with a specific starting value
    public fun new_with_value(initial: u64): Counter {
        Counter { value: initial }
    }
    
    /// Get the current value (immutable reference)
    public fun get_value(counter: &Counter): u64 {
        counter.value
    }
    
    /// Increment the counter by 1
    public fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }
    
    /// Decrement the counter by 1 (abort if would underflow)
    public fun decrement(counter: &mut Counter) {
        assert!(counter.value > 0, 0);
        counter.value = counter.value - 1;
    }
    
    /// Add a specific amount to the counter
    public fun add(counter: &mut Counter, amount: u64) {
        counter.value = counter.value + amount;
    }
    
    /// Subtract a specific amount (abort if would underflow)
    public fun subtract(counter: &mut Counter, amount: u64) {
        assert!(counter.value >= amount, 1);
        counter.value = counter.value - amount;
    }
    
    /// Set the counter to a specific value (helper for swap)
    public fun set_value(counter: &mut Counter, new_value: u64) {
        counter.value = new_value;
    }
    
    #[test]
    fun test_new_counter() {
        let counter = new();
        assert!(get_value(&counter) == 0, 0);
    }
    
    #[test]
    fun test_new_with_value() {
        let counter = new_with_value(42);
        assert!(get_value(&counter) == 42, 0);
    }
    
    #[test]
    fun test_increment() {
        let mut counter = new();
        increment(&mut counter);
        assert!(get_value(&counter) == 1, 0);
        increment(&mut counter);
        assert!(get_value(&counter) == 2, 1);
    }
    
    #[test]
    fun test_decrement() {
        let mut counter = new_with_value(5);
        decrement(&mut counter);
        assert!(get_value(&counter) == 4, 0);
    }
    
    #[test]
    #[expected_failure]
    fun test_decrement_underflow() {
        let mut counter = new();
        decrement(&mut counter); // Should abort - can't go below 0
    }
    
    #[test]
    fun test_add() {
        let mut counter = new_with_value(10);
        add(&mut counter, 25);
        assert!(get_value(&counter) == 35, 0);
    }
    
    #[test]
    fun test_subtract() {
        let mut counter = new_with_value(100);
        subtract(&mut counter, 30);
        assert!(get_value(&counter) == 70, 0);
    }
    
    #[test]
    #[expected_failure]
    fun test_subtract_underflow() {
        let mut counter = new_with_value(10);
        subtract(&mut counter, 20); // Should abort
    }
}

/// Counter transfers module - moving values between counters
module counter::transfers {
    use counter::operations::{Self, Counter};
    
    /// Transfer value from one counter to another
    /// Aborts if source doesn't have enough value
    public fun transfer(from: &mut Counter, to: &mut Counter, amount: u64) {
        operations::subtract(from, amount);
        operations::add(to, amount);
    }
    
    /// Transfer all value from source to destination
    public fun transfer_all(from: &mut Counter, to: &mut Counter) {
        let amount = operations::get_value(from);
        transfer(from, to, amount);
    }
    
    /// Swap the values of two counters
    public fun swap(counter1: &mut Counter, counter2: &mut Counter) {
        let value1 = operations::get_value(counter1);
        let value2 = operations::get_value(counter2);
        
        operations::set_value(counter1, value2);
        operations::set_value(counter2, value1);
    }
    
    /// Balance two counters to have equal values (if possible)
    /// The total value should remain the same
    /// If total is odd, counter1 gets the extra 1
    public fun balance_counters(counter1: &mut Counter, counter2: &mut Counter) {
        let total = operations::get_value(counter1) + operations::get_value(counter2);
        let half = total / 2;
        let remainder = total % 2;
        
        operations::set_value(counter1, half + remainder);
        operations::set_value(counter2, half);
    }
    
    #[test]
    fun test_transfer() {
        let mut from = operations::new_with_value(100);
        let mut to = operations::new_with_value(50);
        
        transfer(&mut from, &mut to, 30);
        
        assert!(operations::get_value(&from) == 70, 0);
        assert!(operations::get_value(&to) == 80, 1);
    }
    
    #[test]
    #[expected_failure]
    fun test_transfer_insufficient_funds() {
        let mut from = operations::new_with_value(10);
        let mut to = operations::new_with_value(50);
        
        transfer(&mut from, &mut to, 20); // Should abort
    }
    
    #[test]
    fun test_transfer_all() {
        let mut from = operations::new_with_value(100);
        let mut to = operations::new_with_value(25);
        
        transfer_all(&mut from, &mut to);
        
        assert!(operations::get_value(&from) == 0, 0);
        assert!(operations::get_value(&to) == 125, 1);
    }
    
    #[test]
    fun test_swap() {
        let mut c1 = operations::new_with_value(100);
        let mut c2 = operations::new_with_value(50);
        
        swap(&mut c1, &mut c2);
        
        assert!(operations::get_value(&c1) == 50, 0);
        assert!(operations::get_value(&c2) == 100, 1);
    }
    
    #[test]
    fun test_swap_with_zero() {
        let mut c1 = operations::new_with_value(42);
        let mut c2 = operations::new();
        
        swap(&mut c1, &mut c2);
        
        assert!(operations::get_value(&c1) == 0, 0);
        assert!(operations::get_value(&c2) == 42, 1);
    }
    
    #[test]
    fun test_balance_even_total() {
        let mut c1 = operations::new_with_value(100);
        let mut c2 = operations::new_with_value(50);
        
        balance_counters(&mut c1, &mut c2);
        
        // Total is 150, each gets 75
        assert!(operations::get_value(&c1) == 75, 0);
        assert!(operations::get_value(&c2) == 75, 1);
    }
    
    #[test]
    fun test_balance_odd_total() {
        let mut c1 = operations::new_with_value(100);
        let mut c2 = operations::new_with_value(51);
        
        balance_counters(&mut c1, &mut c2);
        
        // Total is 151, c1 gets 76, c2 gets 75
        assert!(operations::get_value(&c1) == 76, 0);
        assert!(operations::get_value(&c2) == 75, 1);
    }
}

/// Counter batch operations module - multiple operations at once
module counter::batch {
    use counter::operations::{Self, Counter};
    
    /// Increment a counter multiple times
    public fun increment_by(counter: &mut Counter, times: u64) {
        let mut i = 0;
        while (i < times) {
            operations::increment(counter);
            i = i + 1;
        };
    }
    
    /// Double the counter's value
    public fun double(counter: &mut Counter) {
        let current = operations::get_value(counter);
        operations::add(counter, current);
    }
    
    /// Reset counter to zero, returning the old value
    public fun reset(counter: &mut Counter): u64 {
        let old_value = operations::get_value(counter);
        operations::subtract(counter, old_value);
        old_value
    }
    
    /// Apply a multiplier to the counter's value
    public fun multiply(counter: &mut Counter, multiplier: u64) {
        let current = operations::get_value(counter);
        let new_value = current * multiplier;
        operations::set_value(counter, new_value);
    }
    
    /// Cap the counter at a maximum value
    public fun cap_at(counter: &mut Counter, max_value: u64) {
        let current = operations::get_value(counter);
        if (current > max_value) {
            let excess = current - max_value;
            operations::subtract(counter, excess);
        }
    }
    
    #[test]
    fun test_increment_by() {
        let mut counter = operations::new();
        increment_by(&mut counter, 5);
        assert!(operations::get_value(&counter) == 5, 0);
        
        increment_by(&mut counter, 10);
        assert!(operations::get_value(&counter) == 15, 1);
    }
    
    #[test]
    fun test_increment_by_zero() {
        let mut counter = operations::new_with_value(42);
        increment_by(&mut counter, 0);
        assert!(operations::get_value(&counter) == 42, 0);
    }
    
    #[test]
    fun test_double() {
        let mut counter = operations::new_with_value(7);
        double(&mut counter);
        assert!(operations::get_value(&counter) == 14, 0);
        
        double(&mut counter);
        assert!(operations::get_value(&counter) == 28, 1);
    }
    
    #[test]
    fun test_double_zero() {
        let mut counter = operations::new();
        double(&mut counter);
        assert!(operations::get_value(&counter) == 0, 0);
    }
    
    #[test]
    fun test_reset() {
        let mut counter = operations::new_with_value(100);
        let old = reset(&mut counter);
        
        assert!(old == 100, 0);
        assert!(operations::get_value(&counter) == 0, 1);
    }
    
    #[test]
    fun test_reset_already_zero() {
        let mut counter = operations::new();
        let old = reset(&mut counter);
        
        assert!(old == 0, 0);
        assert!(operations::get_value(&counter) == 0, 1);
    }
    
    #[test]
    fun test_multiply() {
        let mut counter = operations::new_with_value(10);
        multiply(&mut counter, 5);
        assert!(operations::get_value(&counter) == 50, 0);
    }
    
    #[test]
    fun test_multiply_by_zero() {
        let mut counter = operations::new_with_value(100);
        multiply(&mut counter, 0);
        assert!(operations::get_value(&counter) == 0, 0);
    }
    
    #[test]
    fun test_multiply_by_one() {
        let mut counter = operations::new_with_value(42);
        multiply(&mut counter, 1);
        assert!(operations::get_value(&counter) == 42, 0);
    }
    
    #[test]
    fun test_cap_at_reduces_value() {
        let mut counter = operations::new_with_value(100);
        cap_at(&mut counter, 50);
        assert!(operations::get_value(&counter) == 50, 0);
    }
    
    #[test]
    fun test_cap_at_no_change_when_under() {
        let mut counter = operations::new_with_value(30);
        cap_at(&mut counter, 50);
        assert!(operations::get_value(&counter) == 30, 0);
    }
    
    #[test]
    fun test_cap_at_equal_value() {
        let mut counter = operations::new_with_value(50);
        cap_at(&mut counter, 50);
        assert!(operations::get_value(&counter) == 50, 0);
    }
}

/// Integration tests for counter system
#[test_only]
module counter::integration_tests {
    use counter::operations;
    use counter::transfers;
    use counter::batch;
    
    #[test]
    fun test_complex_workflow() {
        // Create two counters
        let mut primary = operations::new_with_value(100);
        let mut secondary = operations::new();
        
        // Perform batch operations on primary
        batch::double(&mut primary);
        assert!(operations::get_value(&primary) == 200, 0);
        
        // Transfer some to secondary
        transfers::transfer(&mut primary, &mut secondary, 75);
        assert!(operations::get_value(&primary) == 125, 1);
        assert!(operations::get_value(&secondary) == 75, 2);
        
        // Increment secondary multiple times
        batch::increment_by(&mut secondary, 25);
        assert!(operations::get_value(&secondary) == 100, 3);
        
        // Balance them
        transfers::balance_counters(&mut primary, &mut secondary);
        assert!(operations::get_value(&primary) == 113, 4);  // (125 + 100) / 2 + 1
        assert!(operations::get_value(&secondary) == 112, 5); // (125 + 100) / 2
    }
    
    #[test]
    fun test_multiple_counters() {
        let mut c1 = operations::new_with_value(50);
        let mut c2 = operations::new_with_value(30);
        let mut c3 = operations::new_with_value(20);
        
        // Transfer in chain: c1 -> c2 -> c3
        transfers::transfer(&mut c1, &mut c2, 10);
        transfers::transfer(&mut c2, &mut c3, 20);
        
        assert!(operations::get_value(&c1) == 40, 0);
        assert!(operations::get_value(&c2) == 20, 1);
        assert!(operations::get_value(&c3) == 40, 2);
        
        // Swap c1 and c3
        transfers::swap(&mut c1, &mut c3);
        assert!(operations::get_value(&c1) == 40, 3);
        assert!(operations::get_value(&c3) == 40, 4);
    }
    
    #[test]
    fun test_reset_and_redistribute() {
        let mut source = operations::new_with_value(100);
        let mut target = operations::new_with_value(50);
        
        // Reset source and add to target
        let old_value = batch::reset(&mut source);
        operations::add(&mut target, old_value);
        
        assert!(operations::get_value(&source) == 0, 0);
        assert!(operations::get_value(&target) == 150, 1);
    }
}
