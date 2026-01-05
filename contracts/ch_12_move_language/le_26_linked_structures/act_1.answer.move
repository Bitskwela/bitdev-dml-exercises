module movestack::priority_queue {
    use std::option::{Self, Option};
    use std::signer;
    use std::vector;
    use aptos_std::table::{Self, Table};

    // ============================================
    // Task 1: QueueNode struct
    // ============================================

    /// A node in the priority queue containing priority, data, and link to next.
    struct QueueNode has copy, drop, store {
        priority: u64,
        data: vector<u8>,
        next: Option<u64>
    }

    // ============================================
    // Task 2: PriorityQueue struct
    // ============================================

    /// A priority queue implemented as a linked list sorted by priority (descending).
    struct PriorityQueue has key {
        nodes: Table<u64, QueueNode>,
        head: Option<u64>,
        next_id: u64,
        length: u64
    }

    // ============================================
    // Task 3: initialize function
    // ============================================

    /// Initialize an empty priority queue for the account.
    public fun initialize(account: &signer) {
        let queue = PriorityQueue {
            nodes: table::new(),
            head: option::none(),
            next_id: 0,
            length: 0
        };
        move_to(account, queue);
    }

    // ============================================
    // Task 4: is_empty function
    // ============================================

    /// Returns true if the queue has no elements.
    public fun is_empty(queue: &PriorityQueue): bool {
        queue.length == 0
    }

    // ============================================
    // Task 5: get_length function
    // ============================================

    /// Returns the number of elements in the queue.
    public fun get_length(queue: &PriorityQueue): u64 {
        queue.length
    }

    // ============================================
    // Task 6: insert function
    // ============================================

    /// Inserts a new node in sorted order by priority (highest first).
    /// Nodes with higher priority values come before lower ones.
    public fun insert(
        queue: &mut PriorityQueue,
        priority: u64,
        data: vector<u8>
    ) {
        let new_id = queue.next_id;
        queue.next_id = queue.next_id + 1;

        // Empty queue case
        if (option::is_none(&queue.head)) {
            let node = QueueNode {
                priority,
                data,
                next: option::none()
            };
            table::add(&mut queue.nodes, new_id, node);
            queue.head = option::some(new_id);
            queue.length = queue.length + 1;
            return
        };

        let head_id = *option::borrow(&queue.head);
        let head_node = table::borrow(&queue.nodes, head_id);

        // Insert before head if higher priority
        if (priority > head_node.priority) {
            let node = QueueNode {
                priority,
                data,
                next: queue.head
            };
            table::add(&mut queue.nodes, new_id, node);
            queue.head = option::some(new_id);
            queue.length = queue.length + 1;
            return
        };

        // Find insertion point
        let prev_id = head_id;
        let current = head_node.next;

        while (option::is_some(&current)) {
            let curr_id = *option::borrow(&current);
            let curr_node = table::borrow(&queue.nodes, curr_id);

            if (priority > curr_node.priority) {
                // Insert between prev and current
                let node = QueueNode {
                    priority,
                    data,
                    next: option::some(curr_id)
                };
                table::add(&mut queue.nodes, new_id, node);

                let prev_node = table::borrow_mut(&mut queue.nodes, prev_id);
                prev_node.next = option::some(new_id);

                queue.length = queue.length + 1;
                return
            };

            prev_id = curr_id;
            current = curr_node.next;
        };

        // Insert at end (lowest priority so far)
        let node = QueueNode {
            priority,
            data,
            next: option::none()
        };
        table::add(&mut queue.nodes, new_id, node);

        let prev_node = table::borrow_mut(&mut queue.nodes, prev_id);
        prev_node.next = option::some(new_id);

        queue.length = queue.length + 1;
    }

    // ============================================
    // Task 7: peek_highest function
    // ============================================

    /// Returns the data of the highest priority item without removing it.
    /// Returns option::none() if the queue is empty.
    public fun peek_highest(queue: &PriorityQueue): Option<vector<u8>> {
        if (option::is_none(&queue.head)) {
            return option::none()
        };

        let head_id = *option::borrow(&queue.head);
        let node = table::borrow(&queue.nodes, head_id);
        option::some(node.data)
    }

    // ============================================
    // Task 8: pop_highest function
    // ============================================

    /// Removes and returns the data of the highest priority item.
    /// Returns option::none() if the queue is empty.
    public fun pop_highest(queue: &mut PriorityQueue): Option<vector<u8>> {
        if (option::is_none(&queue.head)) {
            return option::none()
        };

        let head_id = *option::borrow(&queue.head);
        let head_node = table::remove(&mut queue.nodes, head_id);

        // Update head to next node
        queue.head = head_node.next;
        queue.length = queue.length - 1;

        option::some(head_node.data)
    }

    // ============================================
    // Task 9: get_all_priorities function
    // ============================================

    /// Returns a vector of all priorities in the queue (in order, highest first).
    public fun get_all_priorities(queue: &PriorityQueue): vector<u64> {
        let result = vector::empty<u64>();
        let current = queue.head;

        while (option::is_some(&current)) {
            let id = *option::borrow(&current);
            let node = table::borrow(&queue.nodes, id);
            vector::push_back(&mut result, node.priority);
            current = node.next;
        };

        result
    }

    // ============================================
    // Additional helper functions
    // ============================================

    /// Get the priority of the highest priority item.
    public fun peek_highest_priority(queue: &PriorityQueue): Option<u64> {
        if (option::is_none(&queue.head)) {
            return option::none()
        };

        let head_id = *option::borrow(&queue.head);
        let node = table::borrow(&queue.nodes, head_id);
        option::some(node.priority)
    }

    /// Check if a given priority exists in the queue.
    public fun contains_priority(queue: &PriorityQueue, target: u64): bool {
        let current = queue.head;

        while (option::is_some(&current)) {
            let id = *option::borrow(&current);
            let node = table::borrow(&queue.nodes, id);

            if (node.priority == target) {
                return true
            };

            // Since sorted descending, we can stop early
            if (node.priority < target) {
                return false
            };

            current = node.next;
        };

        false
    }

    /// Clear all items from the queue.
    public fun clear(queue: &mut PriorityQueue) {
        while (option::is_some(&queue.head)) {
            let head_id = *option::borrow(&queue.head);
            let head_node = table::remove(&mut queue.nodes, head_id);
            queue.head = head_node.next;
        };
        queue.length = 0;
    }
}
