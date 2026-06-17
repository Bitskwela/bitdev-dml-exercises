## Smart contract activity

You are building a small counter system that lives across **three modules**, all themed
around mutable references (`&mut`). Every function that changes a counter borrows it
mutably instead of taking ownership, so the caller keeps the counter afterwards.

- `counter::operations` — the core `Counter` struct and its read/write primitives.
- `counter::transfers` — moving and rebalancing values between two counters.
- `counter::batch` — bulk operations built on top of `operations`.

```move
/// Counter operations module - basic increment/decrement with mutable references
module counter::operations {
    struct Counter has drop {
        value: u64
    }

    public fun new(): Counter {
        // TODO: Return a new Counter with value 0
    }

    public fun new_with_value(initial: u64): Counter {
        // TODO: Return a Counter starting at `initial`
    }

    public fun get_value(counter: &Counter): u64 {
        // TODO: Read the value through an immutable reference
    }

    public fun increment(counter: &mut Counter) {
        // TODO: Add 1 through the mutable reference
    }

    public fun decrement(counter: &mut Counter) {
        // TODO: Subtract 1, aborting if it would underflow
    }

    public fun add(counter: &mut Counter, amount: u64) {
        // TODO: Add `amount`
    }

    public fun subtract(counter: &mut Counter, amount: u64) {
        // TODO: Subtract `amount`, aborting if it would underflow
    }

    public fun set_value(counter: &mut Counter, new_value: u64) {
        // TODO: Overwrite the value (helper used by transfers/batch)
    }
}

/// Counter transfers module - moving values between counters
module counter::transfers {
    use counter::operations::{Self, Counter};

    public fun transfer(from: &mut Counter, to: &mut Counter, amount: u64) {
        // TODO: Subtract from `from`, add to `to`
    }

    public fun transfer_all(from: &mut Counter, to: &mut Counter) {
        // TODO: Move the entire value of `from` into `to`
    }

    public fun swap(counter1: &mut Counter, counter2: &mut Counter) {
        // TODO: Exchange the two counters' values
    }

    public fun balance_counters(counter1: &mut Counter, counter2: &mut Counter) {
        // TODO: Split the combined total evenly (counter1 keeps the odd remainder)
    }
}

/// Counter batch operations module - multiple operations at once
module counter::batch {
    use counter::operations::{Self, Counter};

    public fun increment_by(counter: &mut Counter, times: u64) {
        // TODO: Increment `times` times in a loop
    }

    public fun double(counter: &mut Counter) {
        // TODO: Double the value
    }

    public fun reset(counter: &mut Counter): u64 {
        // TODO: Zero the counter and return the old value
    }

    public fun multiply(counter: &mut Counter, multiplier: u64) {
        // TODO: Multiply the value by `multiplier`
    }

    public fun cap_at(counter: &mut Counter, max_value: u64) {
        // TODO: Clamp the value down to `max_value` if it exceeds it
    }
}
```

## Tasks for Learners

Implement functions that modify struct fields through mutable references (`&mut`).
Mutable references let you change values in place without taking ownership. Each snippet
below is copied directly from the working solution.

### Module `counter::operations`

The `Counter` struct has `drop` (it is plain data, not a resource), so it can be created
and discarded freely:

```move
struct Counter has drop {
    value: u64
}
```

- **`new`** — return a counter starting at zero:

  ```move
  public fun new(): Counter {
      Counter { value: 0 }
  }
  ```

- **`new_with_value`** — return a counter with a chosen start value:

  ```move
  public fun new_with_value(initial: u64): Counter {
      Counter { value: initial }
  }
  ```

- **`get_value`** — read through an **immutable** reference (`&Counter`):

  ```move
  public fun get_value(counter: &Counter): u64 {
      counter.value
  }
  ```

- **`increment`** — add 1 through the **mutable** reference (`&mut Counter`):

  ```move
  public fun increment(counter: &mut Counter) {
      counter.value = counter.value + 1;
  }
  ```

- **`decrement`** — subtract 1, aborting on underflow:

  ```move
  public fun decrement(counter: &mut Counter) {
      assert!(counter.value > 0, 0);
      counter.value = counter.value - 1;
  }
  ```

- **`add`** — add an arbitrary amount:

  ```move
  public fun add(counter: &mut Counter, amount: u64) {
      counter.value = counter.value + amount;
  }
  ```

- **`subtract`** — subtract an amount, aborting on underflow:

  ```move
  public fun subtract(counter: &mut Counter, amount: u64) {
      assert!(counter.value >= amount, 1);
      counter.value = counter.value - amount;
  }
  ```

- **`set_value`** — overwrite the value (a helper that `transfers` and `batch` reuse):

  ```move
  public fun set_value(counter: &mut Counter, new_value: u64) {
      counter.value = new_value;
  }
  ```

### Module `counter::transfers`

This module imports the counter type and its operations. Note the `use` line so the
struct and helpers are in scope:

```move
use counter::operations::{Self, Counter};
```

- **`transfer`** — move `amount` from one counter to another:

  ```move
  public fun transfer(from: &mut Counter, to: &mut Counter, amount: u64) {
      operations::subtract(from, amount);
      operations::add(to, amount);
  }
  ```

- **`transfer_all`** — move the entire balance:

  ```move
  public fun transfer_all(from: &mut Counter, to: &mut Counter) {
      let amount = operations::get_value(from);
      transfer(from, to, amount);
  }
  ```

- **`swap`** — exchange the two counters' values:

  ```move
  public fun swap(counter1: &mut Counter, counter2: &mut Counter) {
      let value1 = operations::get_value(counter1);
      let value2 = operations::get_value(counter2);

      operations::set_value(counter1, value2);
      operations::set_value(counter2, value1);
  }
  ```

- **`balance_counters`** — split the combined total evenly; if the total is odd, `counter1` keeps the extra 1:

  ```move
  public fun balance_counters(counter1: &mut Counter, counter2: &mut Counter) {
      let total = operations::get_value(counter1) + operations::get_value(counter2);
      let half = total / 2;
      let remainder = total % 2;

      operations::set_value(counter1, half + remainder);
      operations::set_value(counter2, half);
  }
  ```

### Module `counter::batch`

Same import as `transfers`: `use counter::operations::{Self, Counter};`

- **`increment_by`** — increment in a loop `times` times:

  ```move
  public fun increment_by(counter: &mut Counter, times: u64) {
      let mut i = 0;
      while (i < times) {
          operations::increment(counter);
          i = i + 1;
      };
  }
  ```

- **`double`** — add the counter's value to itself:

  ```move
  public fun double(counter: &mut Counter) {
      let current = operations::get_value(counter);
      operations::add(counter, current);
  }
  ```

- **`reset`** — zero the counter and **return the old value**:

  ```move
  public fun reset(counter: &mut Counter): u64 {
      let old_value = operations::get_value(counter);
      operations::subtract(counter, old_value);
      old_value
  }
  ```

- **`multiply`** — multiply by a factor:

  ```move
  public fun multiply(counter: &mut Counter, multiplier: u64) {
      let current = operations::get_value(counter);
      let new_value = current * multiplier;
      operations::set_value(counter, new_value);
  }
  ```

- **`cap_at`** — clamp the value down to a maximum:

  ```move
  public fun cap_at(counter: &mut Counter, max_value: u64) {
      let current = operations::get_value(counter);
      if (current > max_value) {
          let excess = current - max_value;
          operations::subtract(counter, excess);
      }
  }
  ```

- **(Optional / bonus)** The instructor solution also ships a `#[test_only] module counter::integration_tests` plus `#[test]` functions inside each module that exercise these operations end-to-end. Writing your own tests is great practice, but they are not required to satisfy the core lesson.

### Breakdown for learners

**Mutable references (`&mut`)** let you modify data without taking ownership. This is
essential for updating struct fields in place across all three modules above.

- **`&T`** (immutable reference): read-only access — used by `get_value`.
- **`&mut T`** (mutable reference): read **and** write access — used by every mutating function.

**Why use mutable references?**

- **Efficiency**: modify in place without copying or moving the `Counter`.
- **Safety**: Move's borrow checker guarantees only one mutable reference exists at a time.
- **Flexibility**: the caller keeps ownership while the function does its work.

**Module composition**: `transfers` and `batch` never touch the `Counter` field directly
— they go through `operations` (`get_value`, `add`, `subtract`, `set_value`). This keeps
the field-level logic in one place and shows how `&mut` references flow through function
calls across modules.

**Key rule**: you cannot hold a mutable reference and any other reference to the same data
at the same time. That is what prevents data races and keeps the program memory-safe.
