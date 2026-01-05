module movestack::task_tracker {
    use std::signer;
    use std::string::String;
    use std::vector;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Task list not initialized for this address
    const E_NOT_INITIALIZED: u64 = 1;
    /// Task list already exists at this address
    const E_ALREADY_INITIALIZED: u64 = 2;
    /// Task with given ID not found
    const E_TASK_NOT_FOUND: u64 = 3;

    // ============================================
    // STRUCTS
    // ============================================

    /// A single task with ID, title, and completion status
    struct Task has store, drop, copy {
        id: u64,
        title: String,
        completed: bool,
    }

    /// Task list resource stored at each user's address
    struct TaskList has key {
        tasks: vector<Task>,
        next_id: u64,
    }

    // ============================================
    // INTERNAL HELPER FUNCTIONS
    // These directly access global storage, so they need `acquires`
    // ============================================

    /// Internal: Get immutable reference to task list
    /// 
    /// # Arguments
    /// * `addr` - Address to read task list from
    /// 
    /// # Returns
    /// Immutable reference to the TaskList
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If no task list exists at address
    fun get_task_list(addr: address): &TaskList acquires TaskList {
        assert!(exists<TaskList>(addr), E_NOT_INITIALIZED);
        borrow_global<TaskList>(addr)
    }

    /// Internal: Get mutable reference to task list
    /// 
    /// # Arguments
    /// * `addr` - Address to read task list from
    /// 
    /// # Returns
    /// Mutable reference to the TaskList
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If no task list exists at address
    fun get_task_list_mut(addr: address): &mut TaskList acquires TaskList {
        assert!(exists<TaskList>(addr), E_NOT_INITIALIZED);
        borrow_global_mut<TaskList>(addr)
    }

    // ============================================
    // ENTRY FUNCTIONS
    // ============================================

    /// Initialize a new task list for the caller.
    /// Uses move_to, so NO acquires annotation needed.
    /// 
    /// # Arguments
    /// * `account` - The signer who will own this task list
    /// 
    /// # Aborts
    /// * `E_ALREADY_INITIALIZED` - If task list already exists
    public entry fun initialize(account: &signer) {
        let addr = signer::address_of(account);
        assert!(!exists<TaskList>(addr), E_ALREADY_INITIALIZED);
        
        let task_list = TaskList {
            tasks: vector::empty<Task>(),
            next_id: 1,
        };
        // move_to does NOT require acquires
        move_to(account, task_list);
    }

    /// Add a new task to the caller's task list.
    /// Calls get_task_list_mut which acquires TaskList, so this needs acquires too.
    /// 
    /// # Arguments
    /// * `account` - The signer adding the task
    /// * `title` - Title of the new task
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If task list not initialized
    public entry fun add_task(
        account: &signer, 
        title: String
    ) acquires TaskList {
        let addr = signer::address_of(account);
        let task_list = get_task_list_mut(addr);
        
        let task = Task {
            id: task_list.next_id,
            title,
            completed: false,
        };
        
        vector::push_back(&mut task_list.tasks, task);
        task_list.next_id = task_list.next_id + 1;
    }

    /// Mark a task as completed.
    /// Calls get_task_list_mut which acquires TaskList.
    /// 
    /// # Arguments
    /// * `account` - The signer (task list owner)
    /// * `task_id` - ID of the task to complete
    /// 
    /// # Aborts
    /// * `E_NOT_INITIALIZED` - If task list not initialized
    /// * `E_TASK_NOT_FOUND` - If task ID doesn't exist
    public entry fun complete_task(
        account: &signer, 
        task_id: u64
    ) acquires TaskList {
        let addr = signer::address_of(account);
        let task_list = get_task_list_mut(addr);
        
        let i = 0;
        let len = vector::length(&task_list.tasks);
        while (i < len) {
            let task = vector::borrow_mut(&mut task_list.tasks, i);
            if (task.id == task_id) {
                task.completed = true;
                return
            };
            i = i + 1;
        };
        abort E_TASK_NOT_FOUND
    }

    /// Delete a task from the list.
    /// Demonstrates move_from pattern (if we were removing the whole list).
    /// 
    /// # Arguments
    /// * `account` - The signer (task list owner)
    /// * `task_id` - ID of the task to delete
    public entry fun delete_task(
        account: &signer,
        task_id: u64
    ) acquires TaskList {
        let addr = signer::address_of(account);
        let task_list = get_task_list_mut(addr);
        
        let i = 0;
        let len = vector::length(&task_list.tasks);
        while (i < len) {
            let task = vector::borrow(&task_list.tasks, i);
            if (task.id == task_id) {
                vector::remove(&mut task_list.tasks, i);
                return
            };
            i = i + 1;
        };
        abort E_TASK_NOT_FOUND
    }

    // ============================================
    // VIEW FUNCTIONS
    // These call helpers that acquire TaskList, so they need acquires too
    // ============================================

    /// Get the total number of tasks for an address.
    /// Calls get_task_list which acquires TaskList.
    /// 
    /// # Arguments
    /// * `addr` - Address to query
    /// 
    /// # Returns
    /// Number of tasks in the list
    public fun get_task_count(addr: address): u64 acquires TaskList {
        let task_list = get_task_list(addr);
        vector::length(&task_list.tasks)
    }

    /// Check if a task exists by ID.
    /// Calls get_task_list which acquires TaskList.
    /// 
    /// # Arguments
    /// * `addr` - Address to query
    /// * `task_id` - Task ID to look for
    /// 
    /// # Returns
    /// True if task exists, false otherwise
    public fun task_exists(addr: address, task_id: u64): bool acquires TaskList {
        let task_list = get_task_list(addr);
        let i = 0;
        let len = vector::length(&task_list.tasks);
        while (i < len) {
            let task = vector::borrow(&task_list.tasks, i);
            if (task.id == task_id) {
                return true
            };
            i = i + 1;
        };
        false
    }

    /// Get task completion status.
    /// Calls get_task_list which acquires TaskList.
    /// 
    /// # Arguments
    /// * `addr` - Address to query
    /// * `task_id` - Task ID to check
    /// 
    /// # Returns
    /// True if task is completed
    /// 
    /// # Aborts
    /// * `E_TASK_NOT_FOUND` - If task doesn't exist
    public fun is_task_completed(addr: address, task_id: u64): bool acquires TaskList {
        let task_list = get_task_list(addr);
        let i = 0;
        let len = vector::length(&task_list.tasks);
        while (i < len) {
            let task = vector::borrow(&task_list.tasks, i);
            if (task.id == task_id) {
                return task.completed
            };
            i = i + 1;
        };
        abort E_TASK_NOT_FOUND
    }

    /// Check if user has a task list.
    /// Only uses exists<T>, so NO acquires needed.
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// True if task list exists
    public fun has_task_list(addr: address): bool {
        // exists does NOT require acquires
        exists<TaskList>(addr)
    }

    // ============================================
    // TESTS
    // ============================================

    #[test_only]
    use std::string;

    #[test(user = @0x123)]
    fun test_initialize_success(user: &signer) {
        initialize(user);
        let addr = signer::address_of(user);
        assert!(has_task_list(addr), 0);
    }

    #[test(user = @0x123)]
    #[expected_failure(abort_code = E_ALREADY_INITIALIZED)]
    fun test_initialize_twice_fails(user: &signer) {
        initialize(user);
        initialize(user);  // Should fail
    }

    #[test(user = @0x123)]
    fun test_add_task(user: &signer) acquires TaskList {
        initialize(user);
        let addr = signer::address_of(user);
        
        let title = string::utf8(b"Write documentation");
        add_task(user, title);
        
        assert!(get_task_count(addr) == 1, 0);
        assert!(task_exists(addr, 1), 1);
        assert!(!is_task_completed(addr, 1), 2);
    }

    #[test(user = @0x123)]
    fun test_complete_task(user: &signer) acquires TaskList {
        initialize(user);
        let addr = signer::address_of(user);
        
        add_task(user, string::utf8(b"Task 1"));
        assert!(!is_task_completed(addr, 1), 0);
        
        complete_task(user, 1);
        assert!(is_task_completed(addr, 1), 1);
    }

    #[test(user = @0x123)]
    #[expected_failure(abort_code = E_TASK_NOT_FOUND)]
    fun test_complete_nonexistent_task(user: &signer) acquires TaskList {
        initialize(user);
        complete_task(user, 999);  // Task doesn't exist
    }

    #[test(user = @0x123)]
    fun test_multiple_tasks(user: &signer) acquires TaskList {
        initialize(user);
        let addr = signer::address_of(user);
        
        add_task(user, string::utf8(b"Task 1"));
        add_task(user, string::utf8(b"Task 2"));
        add_task(user, string::utf8(b"Task 3"));
        
        assert!(get_task_count(addr) == 3, 0);
        assert!(task_exists(addr, 1), 1);
        assert!(task_exists(addr, 2), 2);
        assert!(task_exists(addr, 3), 3);
        assert!(!task_exists(addr, 4), 4);
    }

    #[test(user = @0x123)]
    fun test_delete_task(user: &signer) acquires TaskList {
        initialize(user);
        let addr = signer::address_of(user);
        
        add_task(user, string::utf8(b"Task 1"));
        add_task(user, string::utf8(b"Task 2"));
        assert!(get_task_count(addr) == 2, 0);
        
        delete_task(user, 1);
        assert!(get_task_count(addr) == 1, 1);
        assert!(!task_exists(addr, 1), 2);
        assert!(task_exists(addr, 2), 3);
    }

    #[test(user = @0x123)]
    fun test_has_task_list_false(user: &signer) {
        let addr = signer::address_of(user);
        // No acquires needed for has_task_list
        assert!(!has_task_list(addr), 0);
    }

    #[test(user1 = @0x111, user2 = @0x222)]
    fun test_independent_task_lists(
        user1: &signer, 
        user2: &signer
    ) acquires TaskList {
        initialize(user1);
        initialize(user2);
        
        let addr1 = signer::address_of(user1);
        let addr2 = signer::address_of(user2);
        
        add_task(user1, string::utf8(b"User1 Task"));
        add_task(user2, string::utf8(b"User2 Task A"));
        add_task(user2, string::utf8(b"User2 Task B"));
        
        // Each user has independent task lists
        assert!(get_task_count(addr1) == 1, 0);
        assert!(get_task_count(addr2) == 2, 1);
    }
}
