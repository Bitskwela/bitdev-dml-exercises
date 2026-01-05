````markdown
# Linked Structures in Move

## Opening Scene

Ronnie was sketching data structure diagrams on his tablet when Neri walked over, peering at the complex arrows and boxes.

"What are you working on?" Neri asked, pulling up a chair.

"I need to maintain an ordered list of validators," Ronnie explained. "They need to be sorted by stake amount, and I need to efficiently insert and remove entries while keeping the order."

Neri considered the problem. "Vectors can do ordered data, but inserting in the middle is expensive—you'd have to shift all subsequent elements."

"Exactly," Ronnie nodded. "In traditional programming, I'd use a linked list. But Move doesn't have pointers the same way..."

"We can still implement linked structures," Neri said. "We just need to think about it differently—using keys and tables, or using Option types for optional next references. Let me show you some patterns."

---

## Topics

### Understanding Linked Structures in Move

"In Move, we can't use raw pointers," Neri began. "But we can simulate linked structures using IDs as references and Tables for storage."

```move
module movestack::linked_concepts {
    use std::option::{Self, Option};
    use aptos_std::table::{Self, Table};

    /// A node in our linked structure
    /// Uses Option<u64> for the "next pointer" (None = end of list)
    struct Node has copy, drop, store {
        value: u64,
        next: Option<u64>  // ID of next node, or none
    }

    /// Linked list stored in a table
    struct LinkedList has key {
        nodes: Table<u64, Node>,
        head: Option<u64>,      // ID of first node
        tail: Option<u64>,      // ID of last node
        next_id: u64,           // Counter for generating unique IDs
        length: u64
    }
}
```

Ronnie studied the structure. "So instead of memory addresses, we use integer IDs?"

"Exactly," Neri confirmed. "The Table maps IDs to Node structs, and each Node stores the ID of the next node. It's indirect, but it works."

### Building a Basic Linked List

"Let's implement the core operations," Neri continued.

```move
module movestack::basic_linked_list {
    use std::option::{Self, Option};
    use std::signer;
    use aptos_std::table::{Self, Table};

    struct Node has copy, drop, store {
        value: u64,
        next: Option<u64>
    }

    struct LinkedList has key {
        nodes: Table<u64, Node>,
        head: Option<u64>,
        tail: Option<u64>,
        next_id: u64,
        length: u64
    }

    /// Initialize an empty linked list
    public fun initialize(account: &signer) {
        let list = LinkedList {
            nodes: table::new(),
            head: option::none(),
            tail: option::none(),
            next_id: 0,
            length: 0
        };
        move_to(account, list);
    }

    /// Check if the list is empty
    public fun is_empty(list: &LinkedList): bool {
        list.length == 0
    }

    /// Get the length of the list
    public fun length(list: &LinkedList): u64 {
        list.length
    }

    /// Generate a new unique ID
    fun generate_id(list: &mut LinkedList): u64 {
        let id = list.next_id;
        list.next_id = list.next_id + 1;
        id
    }
}
```

### Appending to the List

"Adding to the end is the simplest operation," Neri showed.

```move
module movestack::append_operations {
    use std::option::{Self, Option};
    use aptos_std::table::{Self, Table};

    struct Node has copy, drop, store {
        value: u64,
        next: Option<u64>
    }

    struct LinkedList has key {
        nodes: Table<u64, Node>,
        head: Option<u64>,
        tail: Option<u64>,
        next_id: u64,
        length: u64
    }

    /// Append a value to the end of the list
    public fun append(list: &mut LinkedList, value: u64) {
        let new_id = list.next_id;
        list.next_id = list.next_id + 1;

        // Create new node with no next
        let new_node = Node {
            value,
            next: option::none()
        };

        // If list is empty, new node is both head and tail
        if (option::is_none(&list.head)) {
            list.head = option::some(new_id);
            list.tail = option::some(new_id);
        } else {
            // Update current tail to point to new node
            let tail_id = *option::borrow(&list.tail);
            let tail_node = table::borrow_mut(&mut list.nodes, tail_id);
            tail_node.next = option::some(new_id);

            // Update tail reference
            list.tail = option::some(new_id);
        };

        // Add node to table
        table::add(&mut list.nodes, new_id, new_node);
        list.length = list.length + 1;
    }

    /// Prepend a value to the beginning of the list
    public fun prepend(list: &mut LinkedList, value: u64) {
        let new_id = list.next_id;
        list.next_id = list.next_id + 1;

        // Create new node pointing to current head
        let new_node = Node {
            value,
            next: list.head  // Point to old head (or none if empty)
        };

        // Add to table
        table::add(&mut list.nodes, new_id, new_node);

        // Update head
        list.head = option::some(new_id);

        // If this is the first node, also set tail
        if (option::is_none(&list.tail)) {
            list.tail = option::some(new_id);
        };

        list.length = list.length + 1;
    }
}
```

"Notice how we handle the empty list case specially," Neri pointed out. "When the list is empty, the new node becomes both head and tail."

### Traversing the List

"Reading through the list requires following the chain of next references," Neri explained.

```move
module movestack::traversal {
    use std::option::{Self, Option};
    use std::vector;
    use aptos_std::table::{Self, Table};

    struct Node has copy, drop, store {
        value: u64,
        next: Option<u64>
    }

    struct LinkedList has key {
        nodes: Table<u64, Node>,
        head: Option<u64>,
        tail: Option<u64>,
        next_id: u64,
        length: u64
    }

    /// Get the first value (if exists)
    public fun get_first(list: &LinkedList): Option<u64> {
        if (option::is_none(&list.head)) {
            option::none()
        } else {
            let head_id = *option::borrow(&list.head);
            let node = table::borrow(&list.nodes, head_id);
            option::some(node.value)
        }
    }

    /// Get the last value (if exists)
    public fun get_last(list: &LinkedList): Option<u64> {
        if (option::is_none(&list.tail)) {
            option::none()
        } else {
            let tail_id = *option::borrow(&list.tail);
            let node = table::borrow(&list.nodes, tail_id);
            option::some(node.value)
        }
    }

    /// Convert list to vector (for iteration)
    public fun to_vector(list: &LinkedList): vector<u64> {
        let result = vector::empty<u64>();
        let current = list.head;

        while (option::is_some(&current)) {
            let id = *option::borrow(&current);
            let node = table::borrow(&list.nodes, id);
            vector::push_back(&mut result, node.value);
            current = node.next;
        };

        result
    }

    /// Sum all values in the list
    public fun sum_all(list: &LinkedList): u64 {
        let total = 0u64;
        let current = list.head;

        while (option::is_some(&current)) {
            let id = *option::borrow(&current);
            let node = table::borrow(&list.nodes, id);
            total = total + node.value;
            current = node.next;
        };

        total
    }

    /// Find a value and return its position (0-indexed)
    public fun find(list: &LinkedList, target: u64): Option<u64> {
        let current = list.head;
        let position = 0u64;

        while (option::is_some(&current)) {
            let id = *option::borrow(&current);
            let node = table::borrow(&list.nodes, id);

            if (node.value == target) {
                return option::some(position)
            };

            current = node.next;
            position = position + 1;
        };

        option::none()
    }
}
```

### Removing from the List

"Removal is trickier because we need to update the previous node's next pointer," Neri explained.

```move
module movestack::removal {
    use std::option::{Self, Option};
    use aptos_std::table::{Self, Table};

    struct Node has copy, drop, store {
        value: u64,
        next: Option<u64>
    }

    struct LinkedList has key {
        nodes: Table<u64, Node>,
        head: Option<u64>,
        tail: Option<u64>,
        next_id: u64,
        length: u64
    }

    /// Remove and return the first element
    public fun pop_front(list: &mut LinkedList): Option<u64> {
        if (option::is_none(&list.head)) {
            return option::none()
        };

        let head_id = *option::borrow(&list.head);
        let head_node = table::remove(&mut list.nodes, head_id);

        // Update head to next node
        list.head = head_node.next;

        // If list is now empty, clear tail too
        if (option::is_none(&list.head)) {
            list.tail = option::none();
        };

        list.length = list.length - 1;
        option::some(head_node.value)
    }

    /// Remove the first occurrence of a value
    public fun remove_value(list: &mut LinkedList, target: u64): bool {
        if (option::is_none(&list.head)) {
            return false
        };

        let head_id = *option::borrow(&list.head);
        let head_node = table::borrow(&list.nodes, head_id);

        // Special case: removing head
        if (head_node.value == target) {
            let _ = pop_front(list);
            return true
        };

        // Search for node with target value
        let prev_id = head_id;
        let current = head_node.next;

        while (option::is_some(&current)) {
            let curr_id = *option::borrow(&current);
            let curr_node = table::borrow(&list.nodes, curr_id);

            if (curr_node.value == target) {
                // Found it! Update previous node's next
                let next_of_removed = curr_node.next;
                let prev_node = table::borrow_mut(&mut list.nodes, prev_id);
                prev_node.next = next_of_removed;

                // If we removed the tail, update tail reference
                if (option::is_none(&next_of_removed)) {
                    list.tail = option::some(prev_id);
                };

                // Remove the node
                let _ = table::remove(&mut list.nodes, curr_id);
                list.length = list.length - 1;
                return true
            };

            prev_id = curr_id;
            current = curr_node.next;
        };

        false
    }
}
```

### Ordered Insertion

"For maintaining sorted order, we insert at the correct position," Neri showed.

```move
module movestack::ordered_list {
    use std::option::{Self, Option};
    use aptos_std::table::{Self, Table};

    struct Node has copy, drop, store {
        value: u64,
        next: Option<u64>
    }

    struct OrderedList has key {
        nodes: Table<u64, Node>,
        head: Option<u64>,
        next_id: u64,
        length: u64
    }

    /// Insert value in sorted order (ascending)
    public fun insert_sorted(list: &mut OrderedList, value: u64) {
        let new_id = list.next_id;
        list.next_id = list.next_id + 1;

        // Empty list or value should be first
        if (option::is_none(&list.head)) {
            let node = Node { value, next: option::none() };
            table::add(&mut list.nodes, new_id, node);
            list.head = option::some(new_id);
            list.length = list.length + 1;
            return
        };

        let head_id = *option::borrow(&list.head);
        let head_node = table::borrow(&list.nodes, head_id);

        // Insert before head if smaller
        if (value < head_node.value) {
            let node = Node { value, next: list.head };
            table::add(&mut list.nodes, new_id, node);
            list.head = option::some(new_id);
            list.length = list.length + 1;
            return
        };

        // Find insertion point
        let prev_id = head_id;
        let current = head_node.next;

        while (option::is_some(&current)) {
            let curr_id = *option::borrow(&current);
            let curr_node = table::borrow(&list.nodes, curr_id);

            if (value < curr_node.value) {
                // Insert between prev and current
                let node = Node { value, next: option::some(curr_id) };
                table::add(&mut list.nodes, new_id, node);

                let prev_node = table::borrow_mut(&mut list.nodes, prev_id);
                prev_node.next = option::some(new_id);

                list.length = list.length + 1;
                return
            };

            prev_id = curr_id;
            current = curr_node.next;
        };

        // Insert at end
        let node = Node { value, next: option::none() };
        table::add(&mut list.nodes, new_id, node);

        let prev_node = table::borrow_mut(&mut list.nodes, prev_id);
        prev_node.next = option::some(new_id);

        list.length = list.length + 1;
    }
}
```

---

## Closing Scene

Ronnie reviewed the patterns on his tablet. "So we simulate pointers with IDs, use Tables for storage, and Option types for nullable references."

"Exactly," Neri confirmed. "It's more verbose than pointer-based linked lists, but it gives us the same capabilities with Move's safety guarantees. The compiler ensures we never have dangling references."

"And for my validator ordering problem," Ronnie continued, "I can use the sorted insertion pattern to maintain order by stake amount."

Neri nodded. "Right. Though for your use case, you might also consider a combination of Table for O(1) lookups and a separate sorted vector for ordering—sometimes hybrid approaches work better."

"That's a good point," Ronnie said, saving his notes. "The key is understanding these patterns so I can pick the right tool for each situation."

"That's the architect mindset," Neri smiled. "Now let's put it into practice."
````
