# Vectors in Move

## Opening Scene

Salvo was setting up tables in the barangay hall, preparing for the quarterly relief distribution. Jaymart arrived with his laptop, looking determined but slightly overwhelmed.

"Kuya Salvo, I need your help," Jaymart said, opening his screen to reveal a mess of individual variable declarations. "I'm trying to track all 200 beneficiaries, but I can't keep creating variables like `beneficiary_1`, `beneficiary_2`, `beneficiary_3`..."

Salvo looked at the code and winced. "That's definitely not the way. You need a vector—it's like a dynamic list that can hold as many items as you need."

"A vector?" Jaymart asked, settling into a chair beside him.

"Think of it as a resizable container," Salvo explained, pulling up a fresh code editor. "You can add items, remove them, loop through them—all with a single variable. Let me show you how it works."

---

## Topics

### Creating Vectors

"There are several ways to create a vector in Move," Salvo began. "The most common is starting with an empty one."

```move
module beneficiary::registry {
    use std::vector;

    public fun create_empty_list(): vector<u64> {
        vector::empty<u64>()  // Creates an empty vector of u64
    }

    public fun create_with_initial_values(): vector<u64> {
        // Vector literal syntax
        vector[100, 200, 300, 400, 500]
    }

    public fun create_singleton(value: u64): vector<u64> {
        vector::singleton(value)  // Creates a vector with one element
    }
}
```

Jaymart nodded. "So the type inside the angle brackets tells Move what kind of data the vector holds?"

"Exactly," Salvo confirmed. "A `vector<u64>` can only hold `u64` values. A `vector<bool>` only holds booleans. This keeps your data type-safe."

### Adding Elements with Push

"To add items to a vector, use `push_back`," Salvo continued.

```move
module relief::distribution {
    use std::vector;

    public fun build_beneficiary_list(): vector<u64> {
        let beneficiaries = vector::empty<u64>();

        // Add beneficiary IDs one by one
        vector::push_back(&mut beneficiaries, 1001);
        vector::push_back(&mut beneficiaries, 1002);
        vector::push_back(&mut beneficiaries, 1003);
        vector::push_back(&mut beneficiaries, 1004);

        beneficiaries
    }

    public fun add_new_beneficiary(
        list: &mut vector<u64>,
        new_id: u64
    ) {
        vector::push_back(list, new_id);
    }

    public fun add_multiple(
        list: &mut vector<u64>,
        ids: vector<u64>
    ) {
        let i = 0;
        let len = vector::length(&ids);

        while (i < len) {
            let id = *vector::borrow(&ids, i);
            vector::push_back(list, id);
            i = i + 1;
        };
    }
}
```

"Notice the `&mut`," Salvo pointed out. "Push modifies the vector, so we need a mutable reference."

### Removing Elements with Pop

"To remove the last element, use `pop_back`," Salvo explained.

```move
module queue::processor {
    use std::vector;

    public fun process_last(queue: &mut vector<u64>): u64 {
        // Remove and return the last element
        vector::pop_back(queue)
    }

    public fun process_all(queue: &mut vector<u64>): u64 {
        let total = 0;

        // Keep processing until empty
        while (!vector::is_empty(queue)) {
            let value = vector::pop_back(queue);
            total = total + value;
        };

        total
    }

    public fun remove_last_n(list: &mut vector<u64>, count: u64) {
        let i = 0;
        while (i < count && !vector::is_empty(list)) {
            vector::pop_back(list);
            i = i + 1;
        };
    }
}
```

Jaymart asked, "What happens if we try to pop from an empty vector?"

"The transaction aborts," Salvo replied. "Always check `is_empty` first, or keep track of the length."

### Accessing Elements

"To read elements without removing them, use `borrow` for reading or `borrow_mut` for modifying," Salvo showed.

```move
module relief::calculator {
    use std::vector;

    public fun get_first(list: &vector<u64>): u64 {
        *vector::borrow(list, 0)  // Get element at index 0
    }

    public fun get_last(list: &vector<u64>): u64 {
        let len = vector::length(list);
        *vector::borrow(list, len - 1)
    }

    public fun update_at_index(
        list: &mut vector<u64>,
        index: u64,
        new_value: u64
    ) {
        let element = vector::borrow_mut(list, index);
        *element = new_value;
    }

    public fun double_all_values(list: &mut vector<u64>) {
        let i = 0;
        let len = vector::length(list);

        while (i < len) {
            let element = vector::borrow_mut(list, i);
            *element = *element * 2;
            i = i + 1;
        };
    }
}
```

### Iterating Over Vectors

"Looping through vectors is one of the most common operations," Salvo explained.

```move
module audit::report {
    use std::vector;

    public fun sum_all(amounts: &vector<u64>): u64 {
        let total = 0;
        let i = 0;
        let len = vector::length(amounts);

        while (i < len) {
            total = total + *vector::borrow(amounts, i);
            i = i + 1;
        };

        total
    }

    public fun count_above_threshold(
        values: &vector<u64>,
        threshold: u64
    ): u64 {
        let count = 0;
        let i = 0;
        let len = vector::length(values);

        while (i < len) {
            if (*vector::borrow(values, i) > threshold) {
                count = count + 1;
            };
            i = i + 1;
        };

        count
    }

    public fun find_index(
        list: &vector<u64>,
        target: u64
    ): u64 {
        let i = 0;
        let len = vector::length(list);

        while (i < len) {
            if (*vector::borrow(list, i) == target) {
                return i
            };
            i = i + 1;
        };

        len  // Return length as "not found" sentinel
    }
}
```

### Transforming Vectors

"Often you'll want to create a new vector based on an existing one," Salvo continued.

```move
module data::transformer {
    use std::vector;

    public fun filter_above(
        input: &vector<u64>,
        threshold: u64
    ): vector<u64> {
        let result = vector::empty<u64>();
        let i = 0;
        let len = vector::length(input);

        while (i < len) {
            let value = *vector::borrow(input, i);
            if (value > threshold) {
                vector::push_back(&mut result, value);
            };
            i = i + 1;
        };

        result
    }

    public fun map_double(input: &vector<u64>): vector<u64> {
        let result = vector::empty<u64>();
        let i = 0;
        let len = vector::length(input);

        while (i < len) {
            let value = *vector::borrow(input, i);
            vector::push_back(&mut result, value * 2);
            i = i + 1;
        };

        result
    }

    public fun take_first_n(
        input: &vector<u64>,
        n: u64
    ): vector<u64> {
        let result = vector::empty<u64>();
        let i = 0;
        let len = vector::length(input);
        let limit = if (n < len) { n } else { len };

        while (i < limit) {
            vector::push_back(&mut result, *vector::borrow(input, i));
            i = i + 1;
        };

        result
    }
}
```

### Advanced Vector Operations

"The standard library provides some additional useful operations," Salvo showed.

```move
module data::operations {
    use std::vector;

    public fun reverse_in_place(list: &mut vector<u64>) {
        vector::reverse(list);
    }

    public fun append_vectors(
        base: &mut vector<u64>,
        other: vector<u64>
    ) {
        vector::append(base, other);  // Adds all elements from other to base
    }

    public fun check_contains(
        list: &vector<u64>,
        target: u64
    ): bool {
        vector::contains(list, &target)
    }

    public fun remove_at_index(
        list: &mut vector<u64>,
        index: u64
    ): u64 {
        vector::remove(list, index)  // Removes and returns element at index
    }

    public fun swap_positions(
        list: &mut vector<u64>,
        i: u64,
        j: u64
    ) {
        vector::swap(list, i, j);  // Swap elements at indices i and j
    }

    public fun swap_and_remove(
        list: &mut vector<u64>,
        index: u64
    ): u64 {
        // Efficient removal: swaps with last element, then pops
        vector::swap_remove(list, index)
    }
}
```

Jaymart looked intrigued. "What's the difference between `remove` and `swap_remove`?"

"Good question! `remove` preserves order but is slower for large vectors because it shifts all elements after the removed one. `swap_remove` is faster but changes the order," Salvo explained.

---

## Closing Scene

Jaymart's code had transformed from a mess of individual variables into clean, manageable vector operations. He scrolled through his new beneficiary management system with satisfaction.

"This is amazing, Kuya Salvo," Jaymart said. "I went from 200 variables to just one vector. And I can easily add or remove beneficiaries without changing the code structure."

"That's the power of collections," Salvo replied, reviewing the final code. "Vectors let you write code that works regardless of whether you have 10 beneficiaries or 10,000."

Jaymart ran a quick test, adding several beneficiaries, filtering by criteria, and calculating totals. "And the iteration patterns—I can process all of them with the same loop."

"Just remember a few key things," Salvo cautioned. "Always check bounds before accessing elements. Use `is_empty` before `pop_back`. And choose between `remove` and `swap_remove` based on whether order matters."

"Got it," Jaymart nodded, saving his work. "Bounds checking, empty checks, and order awareness."

Salvo smiled. "You're ready to handle any collection of data the barangay throws at you."

---

## Summary

### Creating Vectors

- `vector::empty<T>()` creates an empty vector of type T
- `vector[a, b, c]` creates a vector with initial values
- `vector::singleton(value)` creates a single-element vector

### Adding and Removing Elements

- `vector::push_back(&mut v, value)` adds to the end
- `vector::pop_back(&mut v)` removes and returns the last element
- `vector::is_empty(&v)` checks if the vector has no elements

### Accessing Elements

- `vector::borrow(&v, index)` returns a reference to element at index
- `vector::borrow_mut(&mut v, index)` returns a mutable reference
- `vector::length(&v)` returns the number of elements

### Iteration Pattern

- Use a `while` loop with an index counter
- Check `i < vector::length(&v)` as the condition
- Access elements with `vector::borrow(&v, i)`

### Transformation Operations

- `vector::reverse(&mut v)` reverses in place
- `vector::append(&mut v, other)` appends another vector
- `vector::contains(&v, &value)` checks for element presence
- `vector::remove(&mut v, index)` removes at index (preserves order)
- `vector::swap_remove(&mut v, index)` removes at index (faster, changes order)

### Best Practices

- Always check vector length before accessing by index
- Use `is_empty` before calling `pop_back`
- Choose `swap_remove` over `remove` when order doesn't matter
- Remember vectors are zero-indexed
