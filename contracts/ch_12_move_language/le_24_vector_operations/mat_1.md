# Vector Operations

## Opening Scene

Salvo was reviewing the barangay's beneficiary list on his laptop when Neri approached with a concerned look on her face.

"Kuya Salvo, we have a problem," Neri said, sitting down across from him. "Some beneficiaries registered twice, and we need to remove duplicates. Also, we need to check if certain people are already in the list before adding them."

Salvo nodded thoughtfully. "Sounds like you need to learn some advanced vector operations. We've covered the basics—now let's look at searching, removing, and reorganizing elements."

"That's exactly what I need!" Neri pulled out her laptop eagerly.

---

## Topics

### Checking if Element Exists with contains

"First, let's learn how to check if an element is already in a vector," Salvo began.

```move
module barangay::beneficiary_list {
    use std::vector;

    /// Checks if a beneficiary ID is already registered
    public fun is_registered(
        beneficiaries: &vector<u64>,
        beneficiary_id: u64
    ): bool {
        vector::contains(beneficiaries, &beneficiary_id)
    }

    /// Adds a beneficiary only if not already registered
    public fun register_if_new(
        beneficiaries: &mut vector<u64>,
        beneficiary_id: u64
    ): bool {
        if (vector::contains(beneficiaries, &beneficiary_id)) {
            false  // Already exists
        } else {
            vector::push_back(beneficiaries, beneficiary_id);
            true   // Successfully added
        }
    }
}
```

Neri leaned in. "So `contains` takes a reference to the value we're looking for?"

"Correct," Salvo confirmed. "It returns `true` if the element exists, `false` otherwise."

### Finding Element Position with index_of

"Sometimes you need to know WHERE an element is, not just IF it exists," Salvo continued.

```move
module barangay::registry {
    use std::vector;

    /// Finds the position of a beneficiary in the list
    /// Returns (true, index) if found, (false, 0) if not found
    public fun find_beneficiary(
        beneficiaries: &vector<u64>,
        beneficiary_id: u64
    ): (bool, u64) {
        vector::index_of(beneficiaries, &beneficiary_id)
    }

    /// Gets the beneficiary at a specific position in the priority list
    public fun get_priority_position(
        priority_list: &vector<u64>,
        beneficiary_id: u64
    ): u64 {
        let (found, index) = vector::index_of(priority_list, &beneficiary_id);
        if (found) {
            index + 1  // Convert to 1-based position
        } else {
            0  // Not in list
        }
    }
}
```

"The function returns a tuple?" Neri asked.

"Yes! A `(bool, u64)` pair. The boolean tells you if it was found, and the u64 is the index. Always check the boolean before using the index."

### Removing Elements with remove

"To remove an element at a specific position, use `remove`," Salvo explained.

```move
module barangay::management {
    use std::vector;

    /// Removes a beneficiary at a specific index
    public fun remove_at_index(
        beneficiaries: &mut vector<u64>,
        index: u64
    ): u64 {
        vector::remove(beneficiaries, index)
    }

    /// Removes a specific beneficiary by ID
    public fun remove_beneficiary(
        beneficiaries: &mut vector<u64>,
        beneficiary_id: u64
    ): bool {
        let (found, index) = vector::index_of(beneficiaries, &beneficiary_id);
        if (found) {
            vector::remove(beneficiaries, index);
            true
        } else {
            false
        }
    }

    /// Removes all occurrences of a beneficiary (handles duplicates)
    public fun remove_all_occurrences(
        beneficiaries: &mut vector<u64>,
        beneficiary_id: u64
    ) {
        let (found, index) = vector::index_of(beneficiaries, &beneficiary_id);
        while (found) {
            vector::remove(beneficiaries, index);
            let result = vector::index_of(beneficiaries, &beneficiary_id);
            found = result.0;
            index = result.1;
        };
    }
}
```

"I see—`remove` shifts all elements after the removed one," Neri observed.

"Exactly. This maintains order but can be expensive for large vectors."

### Swapping Elements with swap

"If you don't care about order, `swap_remove` is more efficient," Salvo said.

```move
module barangay::fast_ops {
    use std::vector;

    /// Swaps two elements in the vector
    public fun swap_positions(
        list: &mut vector<u64>,
        index_a: u64,
        index_b: u64
    ) {
        vector::swap(list, index_a, index_b);
    }

    /// Removes element by swapping with last element (O(1) operation)
    public fun fast_remove_at(
        list: &mut vector<u64>,
        index: u64
    ): u64 {
        vector::swap_remove(list, index)
    }

    /// Fast removal of a specific value
    public fun fast_remove_value(
        list: &mut vector<u64>,
        value: u64
    ): bool {
        let (found, index) = vector::index_of(list, &value);
        if (found) {
            vector::swap_remove(list, index);
            true
        } else {
            false
        }
    }

    /// Moves an element to the front of the list
    public fun move_to_front(
        list: &mut vector<u64>,
        index: u64
    ) {
        if (index > 0) {
            vector::swap(list, 0, index);
        };
    }
}
```

### Combining Operations

"Let me show you a real-world example combining all these operations," Salvo said.

```move
module barangay::relief_distribution {
    use std::vector;

    struct DistributionList has drop {
        beneficiaries: vector<u64>,
        distributed: vector<u64>
    }

    /// Creates a new distribution tracker
    public fun create_list(): DistributionList {
        DistributionList {
            beneficiaries: vector::empty<u64>(),
            distributed: vector::empty<u64>()
        }
    }

    /// Adds a beneficiary if not already in list
    public fun add_beneficiary(
        list: &mut DistributionList,
        id: u64
    ): bool {
        if (vector::contains(&list.beneficiaries, &id)) {
            false
        } else {
            vector::push_back(&mut list.beneficiaries, id);
            true
        }
    }

    /// Marks a beneficiary as having received relief
    public fun mark_distributed(
        list: &mut DistributionList,
        id: u64
    ): bool {
        let (found, index) = vector::index_of(&list.beneficiaries, &id);
        if (found) {
            // Remove from pending list (fast, order doesn't matter)
            vector::swap_remove(&mut list.beneficiaries, index);
            // Add to distributed list
            vector::push_back(&mut list.distributed, id);
            true
        } else {
            false
        }
    }

    /// Checks if someone already received relief
    public fun has_received(list: &DistributionList, id: u64): bool {
        vector::contains(&list.distributed, &id)
    }

    /// Gets count of pending distributions
    public fun pending_count(list: &DistributionList): u64 {
        vector::length(&list.beneficiaries)
    }
}
```

---

## Concept Breakdown

### Search Operations

| Operation | Syntax                        | Returns       |
| --------- | ----------------------------- | ------------- |
| Contains  | `vector::contains(&v, &elem)` | `bool`        |
| Index Of  | `vector::index_of(&v, &elem)` | `(bool, u64)` |

### Removal Operations

| Operation   | Syntax                               | Behavior                         |
| ----------- | ------------------------------------ | -------------------------------- |
| Remove      | `vector::remove(&mut v, index)`      | Preserves order, shifts elements |
| Swap Remove | `vector::swap_remove(&mut v, index)` | Faster, doesn't preserve order   |

### Swap Operations

| Operation | Syntax                       | Notes                  |
| --------- | ---------------------------- | ---------------------- |
| Swap      | `vector::swap(&mut v, i, j)` | Exchanges two elements |

### Performance Considerations

| Operation     | Time Complexity | Use When             |
| ------------- | --------------- | -------------------- |
| `contains`    | O(n)            | Checking existence   |
| `index_of`    | O(n)            | Finding position     |
| `remove`      | O(n)            | Order matters        |
| `swap_remove` | O(1)            | Order doesn't matter |
| `swap`        | O(1)            | Reordering elements  |

---

## Closing Scene

Neri finished typing and looked up with a satisfied expression. "Now I can properly manage the beneficiary list—checking for duplicates, removing entries, and even doing fast removals when order doesn't matter."

"Exactly," Salvo said. "The key is choosing the right operation for your use case. `remove` when order matters, `swap_remove` when speed matters."

"Thanks, Kuya Salvo! This will make the relief distribution so much more efficient."

Salvo smiled. "That's what good code is all about—making real-world processes better. Now let's go help with the actual distribution!"
