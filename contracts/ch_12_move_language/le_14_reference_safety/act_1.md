## Smart contract activity

```move
module movestack::inventory {
    struct Inventory has drop {
        items: u64,
        capacity: u64
    }

    public fun new(capacity: u64): Inventory {
        Inventory { items: 0, capacity }
    }

    public fun add_items(inv: &mut Inventory, amount: u64): bool {
        // TODO: Check if there's enough capacity, then add items
        // Return true if successful, false if not enough space
        false
    }

    public fun transfer(from: &mut Inventory, to: &mut Inventory, amount: u64): bool {
        // TODO: Transfer items from one inventory to another
        // Must read values before modifying to avoid aliasing issues
        false
    }

    public fun get_available_space(inv: &Inventory): u64 {
        // TODO: Return remaining capacity
        0
    }
}
```

## Tasks for Learners

Fix reference safety violations by understanding Move's borrow checker rules. The key is to read all values before modifying, avoiding conflicting borrows.

- Inside the `add_items` function, read values first, then modify to avoid aliasing:

  ```move
  let current = inv.items;
  let cap = inv.capacity;
  if (current + amount <= cap) {
      inv.items = current + amount;
      true
  } else {
      false
  }
  ```

- Inside the `transfer` function, extract all values before any modifications:

  ```move
  let from_items = from.items;
  let to_items = to.items;
  let to_cap = to.capacity;
  if (from_items >= amount && to_items + amount <= to_cap) {
      from.items = from_items - amount;
      to.items = to_items + amount;
      true
  } else {
      false
  }
  ```

- Inside the `get_available_space` function, calculate remaining capacity:

  ```move
  inv.capacity - inv.items
  ```

### Breakdown for learners

**Reference safety rules** prevent data races and ensure memory safety. Move's borrow checker enforces these rules at compile time.

**Key aliasing rules:**

- You can have **multiple immutable references** (`&T`) to the same data
- You can have **only one mutable reference** (`&mut T`) at a time
- You **cannot** have a mutable reference while any immutable reference exists

**The "extract then modify" pattern:**

1. Read all values you need using the reference
2. Store them in local variables
3. Then perform modifications

**Why this matters:**

- **Prevents data races**: No simultaneous read/write conflicts
- **Compile-time safety**: Errors caught before runtime
- **Predictable behavior**: Clear ownership and access rules

**Common fix**: When you need to read and write in the same function, read all necessary values into local variables first, then perform all writes afterward.
