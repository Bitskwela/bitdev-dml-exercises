module movestack::batch_processor {
    use std::vector;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Input vector is empty
    const E_EMPTY_INPUT: u64 = 1;

    // ============================================
    // TASK 1: Sum until limit
    // Using while loop with condition check
    // ============================================

    /// Sums numbers from 1 upward until adding the next would exceed the limit
    /// 
    /// # Arguments
    /// * `limit` - The maximum allowed sum
    /// 
    /// # Returns
    /// The largest sum of consecutive integers starting from 1 that doesn't exceed limit
    /// 
    /// # Example
    /// sum_until_limit(10) = 10 (1+2+3+4=10)
    /// sum_until_limit(11) = 10 (adding 5 would make 15 > 11)
    public fun sum_until_limit(limit: u64): u64 {
        let sum = 0;
        let n = 1;

        // Keep adding while adding n won't exceed limit
        while (sum + n <= limit) {
            sum = sum + n;
            n = n + 1;
        };

        sum
    }

    // ============================================
    // TASK 2: Count valid items
    // Using while loop with continue for skipping
    // ============================================

    /// Counts how many items in the vector are greater than the threshold
    /// 
    /// # Arguments
    /// * `items` - Vector of values to check
    /// * `threshold` - Minimum value (exclusive) to count
    /// 
    /// # Returns
    /// Number of items where value > threshold
    public fun count_valid_items(items: &vector<u64>, threshold: u64): u64 {
        let count = 0;
        let i = 0;
        let len = vector::length(items);

        while (i < len) {
            let value = *vector::borrow(items, i);
            i = i + 1;

            // Skip items that don't meet threshold
            if (value <= threshold) {
                continue
            };

            // Count valid items
            count = count + 1;
        };

        count
    }

    // ============================================
    // TASK 3: Find first match
    // Using loop with break for early exit
    // ============================================

    /// Finds the index of the first occurrence of target in the vector
    /// 
    /// # Arguments
    /// * `items` - Vector to search
    /// * `target` - Value to find
    /// 
    /// # Returns
    /// Index of first match, or vector length if not found (sentinel value)
    public fun find_first_match(items: &vector<u64>, target: u64): u64 {
        let i = 0;
        let len = vector::length(items);

        loop {
            // If we've checked all items, return length (not found)
            if (i >= len) {
                break
            };

            // Check if current item matches
            if (*vector::borrow(items, i) == target) {
                return i
            };

            i = i + 1;
        };

        len  // Sentinel value indicating not found
    }

    // ============================================
    // TASK 4: Process batch
    // Using while loop with break at batch limit
    // ============================================

    /// Processes at most batch_size items from the vector, summing their values
    /// 
    /// # Arguments
    /// * `items` - Vector of values to process
    /// * `batch_size` - Maximum number of items to process
    /// 
    /// # Returns
    /// Sum of the processed items (up to batch_size items)
    public fun process_batch(items: &vector<u64>, batch_size: u64): u64 {
        let sum = 0;
        let i = 0;
        let len = vector::length(items);
        let processed = 0;

        while (i < len) {
            // Check batch limit before processing
            if (processed >= batch_size) {
                break
            };

            // Process item
            sum = sum + *vector::borrow(items, i);
            processed = processed + 1;
            i = i + 1;
        };

        sum
    }

    // ============================================
    // TASK 5: Filter and sum
    // Using while loop with continue for filtering
    // ============================================

    /// Sums only values that fall within the specified range (inclusive)
    /// 
    /// # Arguments
    /// * `items` - Vector of values
    /// * `min_value` - Minimum acceptable value (inclusive)
    /// * `max_value` - Maximum acceptable value (inclusive)
    /// 
    /// # Returns
    /// Sum of values where min_value <= value <= max_value
    public fun filter_and_sum(
        items: &vector<u64>,
        min_value: u64,
        max_value: u64
    ): u64 {
        let sum = 0;
        let i = 0;
        let len = vector::length(items);

        while (i < len) {
            let value = *vector::borrow(items, i);
            i = i + 1;

            // Skip values outside the range
            if (value < min_value || value > max_value) {
                continue
            };

            // Add valid values to sum
            sum = sum + value;
        };

        sum
    }

    // ============================================
    // BONUS: Queue processing with mutation
    // ============================================

    /// Processes all items from a queue (vector), removing them as processed
    /// 
    /// # Arguments
    /// * `queue` - Mutable vector to process (will be emptied)
    /// 
    /// # Returns
    /// Sum of all processed items
    public fun drain_queue(queue: &mut vector<u64>): u64 {
        let sum = 0;

        // Process until queue is empty
        while (!vector::is_empty(queue)) {
            let item = vector::pop_back(queue);
            sum = sum + item;
        };

        sum
    }

    /// Processes items from queue until an item exceeds the threshold
    /// 
    /// # Arguments
    /// * `queue` - Mutable vector to process
    /// * `threshold` - Stop processing when an item exceeds this
    /// 
    /// # Returns
    /// Sum of processed items (not including the one that exceeded threshold)
    public fun process_until_threshold(queue: &mut vector<u64>, threshold: u64): u64 {
        let sum = 0;

        loop {
            // Check if queue is empty
            if (vector::is_empty(queue)) {
                break
            };

            // Peek at the last item (we'll process from the back)
            let item = vector::pop_back(queue);

            // If item exceeds threshold, push it back and stop
            if (item > threshold) {
                vector::push_back(queue, item);
                break
            };

            // Process the item
            sum = sum + item;
        };

        sum
    }

    // ============================================
    // TEST FUNCTIONS
    // ============================================

    #[test]
    fun test_sum_until_limit() {
        // 1+2+3+4 = 10
        assert!(sum_until_limit(10) == 10, 1);
        // 1+2+3+4+5 = 15
        assert!(sum_until_limit(15) == 15, 2);
        // 1+2 = 3 (adding 3 would make 6 > 5)
        assert!(sum_until_limit(5) == 3, 3);
        // Edge case: limit 0
        assert!(sum_until_limit(0) == 0, 4);
        // Edge case: limit 1
        assert!(sum_until_limit(1) == 1, 5);
        // 1+2+3 = 6 (adding 4 would make 10 > 9)
        assert!(sum_until_limit(9) == 6, 6);
    }

    #[test]
    fun test_count_valid_items() {
        let items = vector[1, 5, 3, 8, 2];
        // 5 and 8 are > 3
        assert!(count_valid_items(&items, 3) == 2, 1);

        let all_high = vector[10, 20, 30];
        // All > 5
        assert!(count_valid_items(&all_high, 5) == 3, 2);

        let all_low = vector[1, 2, 3];
        // None > 10
        assert!(count_valid_items(&all_low, 10) == 0, 3);

        let empty = vector::empty<u64>();
        assert!(count_valid_items(&empty, 5) == 0, 4);
    }

    #[test]
    fun test_find_first_match() {
        let items = vector[10, 20, 30, 20];
        // First 20 is at index 1
        assert!(find_first_match(&items, 20) == 1, 1);
        // 10 is at index 0
        assert!(find_first_match(&items, 10) == 0, 2);
        // 30 is at index 2
        assert!(find_first_match(&items, 30) == 2, 3);
        // 99 not found, return length (4)
        assert!(find_first_match(&items, 99) == 4, 4);

        let empty = vector::empty<u64>();
        assert!(find_first_match(&empty, 5) == 0, 5);
    }

    #[test]
    fun test_process_batch() {
        let items = vector[10, 20, 30, 40, 50];
        // Process first 3: 10+20+30 = 60
        assert!(process_batch(&items, 3) == 60, 1);
        // Process all 5: 10+20+30+40+50 = 150
        assert!(process_batch(&items, 10) == 150, 2);
        // Process just 1
        assert!(process_batch(&items, 1) == 10, 3);

        let single = vector[100];
        assert!(process_batch(&single, 5) == 100, 4);

        let empty = vector::empty<u64>();
        assert!(process_batch(&empty, 10) == 0, 5);
    }

    #[test]
    fun test_filter_and_sum() {
        let items = vector[5, 15, 25, 35];
        // 15 and 25 are in range [10, 30]
        assert!(filter_and_sum(&items, 10, 30) == 40, 1);

        let nums = vector[1, 2, 3, 4, 5];
        // 2, 3, 4 are in range [2, 4]
        assert!(filter_and_sum(&nums, 2, 4) == 9, 2);

        let high = vector[100, 200, 300];
        // Only 100 is in range [50, 150]
        assert!(filter_and_sum(&high, 50, 150) == 100, 3);

        // No values in range
        assert!(filter_and_sum(&nums, 10, 20) == 0, 4);

        // All values in range
        assert!(filter_and_sum(&nums, 1, 5) == 15, 5);
    }

    #[test]
    fun test_drain_queue() {
        let queue = vector[1, 2, 3, 4, 5];
        let sum = drain_queue(&mut queue);
        assert!(sum == 15, 1);
        assert!(vector::is_empty(&queue), 2);

        let empty = vector::empty<u64>();
        assert!(drain_queue(&mut empty) == 0, 3);
    }

    #[test]
    fun test_process_until_threshold() {
        // Process from back: 5, then 100 > 50, stop
        let queue = vector[10, 20, 100, 5];
        let sum = process_until_threshold(&mut queue, 50);
        assert!(sum == 5, 1);
        // 100, 20, 10 should remain
        assert!(vector::length(&queue) == 3, 2);

        // All items under threshold
        let queue2 = vector[1, 2, 3];
        let sum2 = process_until_threshold(&mut queue2, 10);
        assert!(sum2 == 6, 3);
        assert!(vector::is_empty(&queue2), 4);
    }
}
