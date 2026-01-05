module vector_demo::task_queue {
    use std::vector;

    // ============================================
    // Task 1: Task struct with copy, drop, store abilities
    // ============================================
    
    /// A task in the queue with ID and priority.
    /// Higher priority values indicate more urgent tasks.
    struct Task has copy, drop, store {
        id: u64,
        priority: u8
    }

    /// Creates a new task
    public fun create_task(id: u64, priority: u8): Task {
        Task { id, priority }
    }

    /// Gets the ID from a task
    public fun get_task_id(task: &Task): u64 {
        task.id
    }

    /// Gets the priority from a task
    public fun get_task_priority(task: &Task): u8 {
        task.priority
    }

    /// Creates an empty task queue
    public fun create_queue(): vector<Task> {
        vector::empty()
    }

    // ============================================
    // Task 2: add_task function
    // ============================================
    
    /// Adds a new task to the end of the queue.
    public fun add_task(queue: &mut vector<Task>, id: u64, priority: u8) {
        let task = Task { id, priority };
        vector::push_back(queue, task);
    }

    // ============================================
    // Task 3: remove_last_task function
    // ============================================
    
    /// Removes and returns the most recently added task.
    /// Aborts if the queue is empty.
    public fun remove_last_task(queue: &mut vector<Task>): Task {
        vector::pop_back(queue)
    }

    // ============================================
    // Task 4: get_queue_size function
    // ============================================
    
    /// Returns the number of tasks in the queue.
    public fun get_queue_size(queue: &vector<Task>): u64 {
        vector::length(queue)
    }

    // ============================================
    // Task 5: find_task_index function
    // ============================================
    
    /// Finds a task by its ID and returns (found, index).
    /// Returns (true, index) if found, (false, 0) if not found.
    public fun find_task_index(queue: &vector<Task>, task_id: u64): (bool, u64) {
        let mut i = 0u64;
        let len = vector::length(queue);
        
        while (i < len) {
            let task = vector::borrow(queue, i);
            if (task.id == task_id) {
                return (true, i)
            };
            i = i + 1;
        };
        
        (false, 0)
    }

    // ============================================
    // Task 6: remove_task_by_id function
    // ============================================
    
    /// Removes a specific task by its ID.
    /// Returns true if task was found and removed, false otherwise.
    public fun remove_task_by_id(queue: &mut vector<Task>, task_id: u64): bool {
        let (found, index) = find_task_index(queue, task_id);
        
        if (found) {
            // Remove the task at the found index
            vector::remove(queue, index);
            true
        } else {
            false
        }
    }

    // ============================================
    // Task 7: get_highest_priority_task function
    // ============================================
    
    /// Finds and returns a copy of the highest priority task.
    /// Does not remove the task from the queue.
    /// Aborts if queue is empty.
    public fun get_highest_priority_task(queue: &vector<Task>): Task {
        let len = vector::length(queue);
        assert!(len > 0, 1);  // Queue must not be empty
        
        let mut highest = vector::borrow(queue, 0);
        let mut i = 1u64;
        
        while (i < len) {
            let current = vector::borrow(queue, i);
            if (current.priority > highest.priority) {
                highest = current;
            };
            i = i + 1;
        };
        
        *highest  // Return a copy
    }

    // ============================================
    // Task 8: pop_highest_priority function
    // ============================================
    
    /// Removes and returns the highest priority task.
    /// Aborts if queue is empty.
    public fun pop_highest_priority(queue: &mut vector<Task>): Task {
        let len = vector::length(queue);
        assert!(len > 0, 1);  // Queue must not be empty
        
        // Find the index of the highest priority task
        let mut highest_idx = 0u64;
        let mut highest_priority = vector::borrow(queue, 0).priority;
        let mut i = 1u64;
        
        while (i < len) {
            let current = vector::borrow(queue, i);
            if (current.priority > highest_priority) {
                highest_priority = current.priority;
                highest_idx = i;
            };
            i = i + 1;
        };
        
        // Remove and return the highest priority task
        vector::remove(queue, highest_idx)
    }

    // ============================================
    // Bonus: Additional utility functions
    // ============================================
    
    /// Checks if the queue is empty
    public fun is_queue_empty(queue: &vector<Task>): bool {
        vector::is_empty(queue)
    }

    /// Gets all tasks with priority above a threshold
    public fun get_urgent_tasks(queue: &vector<Task>, min_priority: u8): vector<Task> {
        let mut result = vector::empty<Task>();
        let mut i = 0u64;
        let len = vector::length(queue);
        
        while (i < len) {
            let task = vector::borrow(queue, i);
            if (task.priority >= min_priority) {
                vector::push_back(&mut result, *task);
            };
            i = i + 1;
        };
        
        result
    }

    /// Updates the priority of a task by ID
    /// Returns true if task was found and updated
    public fun update_task_priority(
        queue: &mut vector<Task>, 
        task_id: u64, 
        new_priority: u8
    ): bool {
        let mut i = 0u64;
        let len = vector::length(queue);
        
        while (i < len) {
            let task = vector::borrow_mut(queue, i);
            if (task.id == task_id) {
                task.priority = new_priority;
                return true
            };
            i = i + 1;
        };
        
        false
    }

    /// Clears all tasks from the queue
    public fun clear_queue(queue: &mut vector<Task>) {
        while (!vector::is_empty(queue)) {
            vector::pop_back(queue);
        };
    }

    /// Gets the total count of tasks above a priority threshold
    public fun count_urgent(queue: &vector<Task>, min_priority: u8): u64 {
        let mut count = 0u64;
        let mut i = 0u64;
        let len = vector::length(queue);
        
        while (i < len) {
            let task = vector::borrow(queue, i);
            if (task.priority >= min_priority) {
                count = count + 1;
            };
            i = i + 1;
        };
        
        count
    }

    // ============================================
    // Tests
    // ============================================

    #[test]
    fun test_add_and_size() {
        let mut queue = create_queue();
        assert!(get_queue_size(&queue) == 0, 1);
        
        add_task(&mut queue, 1, 5);
        add_task(&mut queue, 2, 3);
        add_task(&mut queue, 3, 8);
        
        assert!(get_queue_size(&queue) == 3, 2);
    }

    #[test]
    fun test_remove_last() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 5);
        add_task(&mut queue, 2, 3);
        
        let task = remove_last_task(&mut queue);
        assert!(get_task_id(&task) == 2, 1);
        assert!(get_queue_size(&queue) == 1, 2);
    }

    #[test]
    fun test_find_task() {
        let mut queue = create_queue();
        add_task(&mut queue, 10, 5);
        add_task(&mut queue, 20, 3);
        add_task(&mut queue, 30, 8);
        
        let (found, idx) = find_task_index(&queue, 20);
        assert!(found == true, 1);
        assert!(idx == 1, 2);
        
        let (not_found, _) = find_task_index(&queue, 99);
        assert!(not_found == false, 3);
    }

    #[test]
    fun test_remove_by_id() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 5);
        add_task(&mut queue, 2, 3);
        add_task(&mut queue, 3, 8);
        
        let removed = remove_task_by_id(&mut queue, 2);
        assert!(removed == true, 1);
        assert!(get_queue_size(&queue) == 2, 2);
        
        let (found, _) = find_task_index(&queue, 2);
        assert!(found == false, 3);
    }

    #[test]
    fun test_highest_priority() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 5);
        add_task(&mut queue, 2, 10);
        add_task(&mut queue, 3, 3);
        
        let highest = get_highest_priority_task(&queue);
        assert!(get_task_id(&highest) == 2, 1);
        assert!(get_task_priority(&highest) == 10, 2);
    }

    #[test]
    fun test_pop_highest_priority() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 5);
        add_task(&mut queue, 2, 10);
        add_task(&mut queue, 3, 3);
        
        let popped = pop_highest_priority(&mut queue);
        assert!(get_task_id(&popped) == 2, 1);
        assert!(get_queue_size(&queue) == 2, 2);
        
        // Task 2 should no longer exist
        let (found, _) = find_task_index(&queue, 2);
        assert!(found == false, 3);
    }

    #[test]
    fun test_get_urgent_tasks() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 3);
        add_task(&mut queue, 2, 7);
        add_task(&mut queue, 3, 5);
        add_task(&mut queue, 4, 9);
        
        let urgent = get_urgent_tasks(&queue, 5);
        assert!(vector::length(&urgent) == 3, 1);  // Tasks with priority >= 5
    }

    #[test]
    fun test_update_priority() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 5);
        
        let updated = update_task_priority(&mut queue, 1, 10);
        assert!(updated == true, 1);
        
        let task = vector::borrow(&queue, 0);
        assert!(task.priority == 10, 2);
    }

    #[test]
    fun test_clear_queue() {
        let mut queue = create_queue();
        add_task(&mut queue, 1, 5);
        add_task(&mut queue, 2, 3);
        add_task(&mut queue, 3, 8);
        
        clear_queue(&mut queue);
        assert!(is_queue_empty(&queue), 1);
    }
}
