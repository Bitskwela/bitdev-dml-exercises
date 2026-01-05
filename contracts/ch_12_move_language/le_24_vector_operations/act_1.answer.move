module relief::distribution {
    use std::vector;

    // ============================================
    // Task 1: Beneficiary struct with copy, drop, store abilities
    // ============================================
    
    /// A beneficiary entry with ID, name, and priority level.
    struct Beneficiary has copy, drop, store {
        id: u64,
        name: vector<u8>,
        priority: u8
    }

    /// Creates a new beneficiary entry
    public fun create_beneficiary(id: u64, name: vector<u8>, priority: u8): Beneficiary {
        Beneficiary { id, name, priority }
    }

    /// Gets the beneficiary ID
    public fun get_id(b: &Beneficiary): u64 {
        b.id
    }

    /// Gets the beneficiary priority
    public fun get_priority(b: &Beneficiary): u8 {
        b.priority
    }

    /// Creates an empty beneficiary list
    public fun create_list(): vector<u64> {
        vector::empty<u64>()
    }

    // ============================================
    // Task 2: is_registered function
    // ============================================
    
    /// Checks if an ID is already in the list.
    public fun is_registered(list: &vector<u64>, id: u64): bool {
        vector::contains(list, &id)
    }

    // ============================================
    // Task 3: add_if_new function
    // ============================================
    
    /// Adds an ID to the list only if not already present.
    /// Returns true if added, false if already existed.
    public fun add_if_new(list: &mut vector<u64>, id: u64): bool {
        if (vector::contains(list, &id)) {
            false
        } else {
            vector::push_back(list, id);
            true
        }
    }

    // ============================================
    // Task 4: find_position function
    // ============================================
    
    /// Finds the position of an ID in the list.
    /// Returns (true, index) if found, (false, 0) otherwise.
    public fun find_position(list: &vector<u64>, id: u64): (bool, u64) {
        vector::index_of(list, &id)
    }

    // ============================================
    // Task 5: remove_by_id function
    // ============================================
    
    /// Removes an ID from the list if found.
    /// Preserves order of remaining elements.
    /// Returns true if removed, false if not found.
    public fun remove_by_id(list: &mut vector<u64>, id: u64): bool {
        let (found, index) = vector::index_of(list, &id);
        if (found) {
            vector::remove(list, index);
            true
        } else {
            false
        }
    }

    // ============================================
    // Task 6: fast_remove_by_id function
    // ============================================
    
    /// Removes an ID using swap_remove for O(1) performance.
    /// Does NOT preserve order of remaining elements.
    /// Returns true if removed, false if not found.
    public fun fast_remove_by_id(list: &mut vector<u64>, id: u64): bool {
        let (found, index) = vector::index_of(list, &id);
        if (found) {
            vector::swap_remove(list, index);
            true
        } else {
            false
        }
    }

    // ============================================
    // Task 7: swap_priorities function
    // ============================================
    
    /// Swaps two elements in the list at the given indices.
    public fun swap_priorities(list: &mut vector<u64>, index_a: u64, index_b: u64) {
        vector::swap(list, index_a, index_b);
    }

    // ============================================
    // Task 8: move_to_front function
    // ============================================
    
    /// Moves an element to the front of the list by swapping with index 0.
    public fun move_to_front(list: &mut vector<u64>, index: u64) {
        if (index > 0) {
            vector::swap(list, 0, index);
        };
    }

    // ============================================
    // Unit Tests
    // ============================================

    #[test]
    fun test_is_registered() {
        let list = vector[100, 200, 300];
        
        assert!(is_registered(&list, 200) == true, 0);
        assert!(is_registered(&list, 400) == false, 1);
    }

    #[test]
    fun test_add_if_new() {
        let list = create_list();
        
        // First add should succeed
        assert!(add_if_new(&mut list, 100) == true, 0);
        assert!(vector::length(&list) == 1, 1);
        
        // Duplicate should fail
        assert!(add_if_new(&mut list, 100) == false, 2);
        assert!(vector::length(&list) == 1, 3);
        
        // New ID should succeed
        assert!(add_if_new(&mut list, 200) == true, 4);
        assert!(vector::length(&list) == 2, 5);
    }

    #[test]
    fun test_find_position() {
        let list = vector[100, 200, 300, 400];
        
        let (found, index) = find_position(&list, 300);
        assert!(found == true, 0);
        assert!(index == 2, 1);
        
        let (found2, _) = find_position(&list, 999);
        assert!(found2 == false, 2);
    }

    #[test]
    fun test_remove_by_id() {
        let list = vector[100, 200, 300, 400];
        
        // Remove middle element
        assert!(remove_by_id(&mut list, 200) == true, 0);
        assert!(vector::length(&list) == 3, 1);
        
        // Verify order preserved: [100, 300, 400]
        assert!(*vector::borrow(&list, 0) == 100, 2);
        assert!(*vector::borrow(&list, 1) == 300, 3);
        assert!(*vector::borrow(&list, 2) == 400, 4);
        
        // Try to remove non-existent
        assert!(remove_by_id(&mut list, 999) == false, 5);
    }

    #[test]
    fun test_fast_remove_by_id() {
        let list = vector[100, 200, 300, 400];
        
        // Fast remove middle element (swaps with last)
        assert!(fast_remove_by_id(&mut list, 200) == true, 0);
        assert!(vector::length(&list) == 3, 1);
        
        // Order NOT preserved: [100, 400, 300] (400 swapped into 200's position)
        assert!(*vector::borrow(&list, 0) == 100, 2);
        assert!(*vector::borrow(&list, 1) == 400, 3);
        assert!(*vector::borrow(&list, 2) == 300, 4);
    }

    #[test]
    fun test_swap_priorities() {
        let list = vector[100, 200, 300];
        
        swap_priorities(&mut list, 0, 2);
        
        assert!(*vector::borrow(&list, 0) == 300, 0);
        assert!(*vector::borrow(&list, 2) == 100, 1);
    }

    #[test]
    fun test_move_to_front() {
        let list = vector[100, 200, 300, 400];
        
        move_to_front(&mut list, 2);
        
        // 300 should now be at front
        assert!(*vector::borrow(&list, 0) == 300, 0);
        assert!(*vector::borrow(&list, 2) == 100, 1);
    }

    #[test]
    fun test_move_to_front_already_first() {
        let list = vector[100, 200, 300];
        
        // Moving index 0 to front should be a no-op
        move_to_front(&mut list, 0);
        
        assert!(*vector::borrow(&list, 0) == 100, 0);
    }
}
