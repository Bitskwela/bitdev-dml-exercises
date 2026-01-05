## Smart contract activity

```move
module relief::distribution {
    use std::vector;

    // TODO: Define Beneficiary struct with copy, drop, store abilities
    // Fields: id (u64), name (vector<u8>), priority (u8)

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

    // TODO: Implement is_registered - checks if ID exists in list using contains

    // TODO: Implement add_if_new - adds ID only if not already present, returns bool

    // TODO: Implement find_position - returns (bool, u64) for ID position using index_of

    // TODO: Implement remove_by_id - removes ID from list if found, returns bool

    // TODO: Implement fast_remove_by_id - removes using swap_remove, returns bool

    // TODO: Implement swap_priorities - swaps two elements at given indices

    // TODO: Implement move_to_front - moves element at index to front using swap
}
```

## Tasks for Learners

Complete the relief distribution module by implementing vector operations.

- Define the `Beneficiary` struct with `copy`, `drop`, and `store` abilities:

  ```move
  struct Beneficiary has copy, drop, store {
      id: u64,
      name: vector<u8>,
      priority: u8,
  }
  ```

- Implement `is_registered` to check if an ID is in the list:

  ```move
  public fun is_registered(list: &vector<u64>, id: u64): bool {
      vector::contains(list, &id)
  }
  ```

- Implement `add_if_new` to add only if not present:

  ```move
  public fun add_if_new(list: &mut vector<u64>, id: u64): bool {
      if (vector::contains(list, &id)) {
          false
      } else {
          vector::push_back(list, id);
          true
      }
  }
  ```

- Implement `find_position` to get the index of an ID:

  ```move
  public fun find_position(list: &vector<u64>, id: u64): (bool, u64) {
      vector::index_of(list, &id)
  }
  ```

- Implement `remove_by_id` to remove an ID (preserves order):

  ```move
  public fun remove_by_id(list: &mut vector<u64>, id: u64): bool {
      let (found, index) = vector::index_of(list, &id);
      if (found) {
          vector::remove(list, index);
          true
      } else {
          false
      }
  }
  ```

- Implement `fast_remove_by_id` using swap_remove (faster, doesn't preserve order):

  ```move
  public fun fast_remove_by_id(list: &mut vector<u64>, id: u64): bool {
      let (found, index) = vector::index_of(list, &id);
      if (found) {
          vector::swap_remove(list, index);
          true
      } else {
          false
      }
  }
  ```

- Implement `swap_priorities` to swap two elements:

  ```move
  public fun swap_priorities(list: &mut vector<u64>, index_a: u64, index_b: u64) {
      vector::swap(list, index_a, index_b);
  }
  ```

- Implement `move_to_front` to move an element to the front:

  ```move
  public fun move_to_front(list: &mut vector<u64>, index: u64) {
      if (index > 0) {
          vector::swap(list, 0, index);
      };
  }
  ```

### Breakdown for learners

**contains**: Checks if a value exists in the vector. Takes an immutable reference to both the vector and the search value. Returns `bool`.

**index_of**: Finds the position of a value. Returns a tuple `(bool, u64)` where the bool indicates if found, and u64 is the index. Always check the bool before using the index!

**remove**: Removes element at index and shifts all following elements left. Preserves order but is O(n) complexity.

**swap_remove**: Removes element by swapping with the last element, then popping. O(1) but doesn't preserve order.

**swap**: Exchanges two elements at given indices. Useful for reordering without removing.

**Best Practice**: Use `swap_remove` when order doesn't matter for better performance. Use `remove` when maintaining order is important.
