## Smart contract activity

```move
module movestack::counter {
    struct Counter has drop {
        value: u64
    }

    public fun new(): Counter {
        // TODO: Return a new Counter with value 0
    }

    public fun get_value(counter: &Counter): u64 {
        // TODO: Return the counter's value
    }

    public fun increment(counter: &mut Counter) {
        // TODO: Add 1 to the counter's value using mutable reference
    }

    public fun add(counter: &mut Counter, amount: u64) {
        // TODO: Add amount to the counter's value
    }

    public fun reset(counter: &mut Counter) {
        // TODO: Reset the counter's value to 0
    }
}
```

## Tasks for Learners

Implement functions that modify struct fields through mutable references (`&mut`). Mutable references allow you to change values in place without taking ownership.

- Inside the `new` function, create and return a new Counter with value 0:

  ```move
  Counter { value: 0 }
  ```

- Inside the `get_value` function, return the counter's value using an immutable reference:

  ```move
  counter.value
  ```

- Inside the `increment` function, add 1 to the counter's value through the mutable reference:

  ```move
  counter.value = counter.value + 1;
  ```

- Inside the `add` function, add the specified amount to the counter's value:

  ```move
  counter.value = counter.value + amount;
  ```

- Inside the `reset` function, set the counter's value back to 0:

  ```move
  counter.value = 0;
  ```

### Breakdown for learners

**Mutable references (`&mut`)** allow you to modify data without taking ownership. This is essential for updating struct fields in place.

- **`&T`** (immutable reference): Read-only access to data
- **`&mut T`** (mutable reference): Read and write access to data

**Why use mutable references?**

- **Efficiency**: Modify data in place without copying or moving
- **Safety**: Move's borrow checker ensures only one mutable reference exists at a time
- **Flexibility**: The caller retains ownership while the function modifies the data

**Key rule**: You cannot have both a mutable reference and any other reference to the same data simultaneously. This prevents data races and ensures memory safety.
