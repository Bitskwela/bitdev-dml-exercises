````markdown
## Smart contract activity

```move
module movestack::priority_queue {
    use std::option::{Self, Option};
    use std::signer;
    use aptos_std::table::{Self, Table};

    // TODO: Define QueueNode struct with copy, drop, store abilities
    // Fields: priority (u64), data (vector<u8>), next (Option<u64>)

    // TODO: Define PriorityQueue struct with key ability
    // Fields: nodes (Table<u64, QueueNode>), head (Option<u64>),
    //         next_id (u64), length (u64)

    /// Initialize an empty priority queue
    public fun initialize(account: &signer) {
        // TODO: Create empty PriorityQueue and move to account
    }

    // TODO: Implement is_empty
    // Returns true if the queue has no elements

    // TODO: Implement get_length
    // Returns the number of elements in the queue

    // TODO: Implement insert
    // Inserts a new node in sorted order by priority (highest first)
    // Nodes with higher priority values should come before lower ones

    // TODO: Implement peek_highest
    // Returns the data of the highest priority item without removing it
    // Returns option::none() if queue is empty

    // TODO: Implement pop_highest
    // Removes and returns the data of the highest priority item
    // Returns option::none() if queue is empty

    // TODO: Implement get_all_priorities
    // Returns a vector of all priorities in the queue (in order)
}
```

## Tasks for Learners

- Define the `QueueNode` struct with appropriate abilities:

  ```move
  struct QueueNode has copy, drop, store {
      priority: u64,
      data: vector<u8>,
      next: Option<u64>
  }
  ```

- Define the `PriorityQueue` struct:

  ```move
  struct PriorityQueue has key {
      nodes: Table<u64, QueueNode>,
      head: Option<u64>,
      next_id: u64,
      length: u64
  }
  ```

- Implement `initialize` to create an empty queue:

  ```move
  public fun initialize(account: &signer) {
      let queue = PriorityQueue {
          nodes: table::new(),
          head: option::none(),
          next_id: 0,
          length: 0
      };
      move_to(account, queue);
  }
  ```

- Implement `is_empty` to check if queue is empty:

  ```move
  public fun is_empty(queue: &PriorityQueue): bool {
      queue.length == 0
  }
  ```

- Implement `get_length` to get queue size:

  ```move
  public fun get_length(queue: &PriorityQueue): u64 {
      queue.length
  }
  ```

- Implement `insert` to add in priority order (descending):

  ```move
  public fun insert(
      queue: &mut PriorityQueue,
      priority: u64,
      data: vector<u8>
  ) {
      let new_id = queue.next_id;
      queue.next_id = queue.next_id + 1;

      // Empty queue case
      if (option::is_none(&queue.head)) {
          let node = QueueNode { priority, data, next: option::none() };
          table::add(&mut queue.nodes, new_id, node);
          queue.head = option::some(new_id);
          queue.length = queue.length + 1;
          return
      };

      let head_id = *option::borrow(&queue.head);
      let head_node = table::borrow(&queue.nodes, head_id);

      // Insert before head if higher priority
      if (priority > head_node.priority) {
          let node = QueueNode { priority, data, next: queue.head };
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
              let node = QueueNode { priority, data, next: option::some(curr_id) };
              table::add(&mut queue.nodes, new_id, node);
              let prev_node = table::borrow_mut(&mut queue.nodes, prev_id);
              prev_node.next = option::some(new_id);
              queue.length = queue.length + 1;
              return
          };

          prev_id = curr_id;
          current = curr_node.next;
      };

      // Insert at end
      let node = QueueNode { priority, data, next: option::none() };
      table::add(&mut queue.nodes, new_id, node);
      let prev_node = table::borrow_mut(&mut queue.nodes, prev_id);
      prev_node.next = option::some(new_id);
      queue.length = queue.length + 1;
  }
  ```

- Implement `peek_highest` to view without removing:

  ```move
  public fun peek_highest(queue: &PriorityQueue): Option<vector<u8>> {
      if (option::is_none(&queue.head)) {
          return option::none()
      };
      let head_id = *option::borrow(&queue.head);
      let node = table::borrow(&queue.nodes, head_id);
      option::some(node.data)
  }
  ```

- Implement `pop_highest` to remove and return:

  ```move
  public fun pop_highest(queue: &mut PriorityQueue): Option<vector<u8>> {
      if (option::is_none(&queue.head)) {
          return option::none()
      };

      let head_id = *option::borrow(&queue.head);
      let head_node = table::remove(&mut queue.nodes, head_id);

      queue.head = head_node.next;
      queue.length = queue.length - 1;

      option::some(head_node.data)
  }
  ```

- Implement `get_all_priorities` to list all priorities:

  ```move
  public fun get_all_priorities(queue: &PriorityQueue): vector<u64> {
      let result = std::vector::empty<u64>();
      let current = queue.head;

      while (option::is_some(&current)) {
          let id = *option::borrow(&current);
          let node = table::borrow(&queue.nodes, id);
          std::vector::push_back(&mut result, node.priority);
          current = node.next;
      };

      result
  }
  ```

### Breakdown for learners

**Linked structure patterns** in Move use IDs as references and Tables for node storage.

**Key concepts:**

- `Option<u64>` acts as a nullable "pointer" (ID of next node)
- Tables store the actual node data keyed by unique IDs
- Head pointer tracks the first element
- ID counter ensures unique node identifiers

**Priority queue operations:**

- **Insert**: Find correct position, update prev.next to new, new.next to current
- **Peek**: Read head node's data without modification
- **Pop**: Remove head, update head to head.next

**Traversal pattern:**

```move
let current = queue.head;
while (option::is_some(&current)) {
    let id = *option::borrow(&current);
    let node = table::borrow(&queue.nodes, id);
    // Process node...
    current = node.next;
};
```

**Edge cases to handle:**

- Empty list operations
- Insert at head (new highest priority)
- Insert at tail (new lowest priority)
- Single element removal

**Trade-offs:**

- O(n) insertion for sorted order
- O(1) access to highest priority
- More verbose than traditional pointers but memory-safe
````
