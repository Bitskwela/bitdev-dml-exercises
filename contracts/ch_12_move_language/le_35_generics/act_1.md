# Activity 1: Generics

## Initial Code

```move
module patrol::generic_storage {
    use std::vector;
    use std::signer;

    // TODO: Define a generic Container struct with type parameter T
    // Should have abilities: key
    // Fields: items (vector of T), capacity (u64)

    // TODO: Define a generic Wrapper struct with type parameter T
    // Should have abilities: copy, drop, store
    // Field: value (T)

    // TODO: Implement init_container that creates a Container<T> for any type
    // Parameters: account (&signer), max_capacity (u64)

    // TODO: Implement wrap function that wraps any value in a Wrapper
    // Parameters: value (T)
    // Returns: Wrapper<T>

    // TODO: Implement unwrap function that extracts value from Wrapper
    // Parameters: wrapper (Wrapper<T>)
    // Returns: T

    // TODO: Implement add_item that adds an item to a Container
    // Parameters: account (&signer), item (T)
    // Should check capacity before adding

    // TODO: Implement get_item_count that returns number of items
    // Parameters: addr (address)
    // Returns: u64
}
```

---

## Tasks

### Task 1: Define the Generic Container Struct

Create a struct that can hold a vector of any type T.

```move
struct Container<T> has key {
    items: vector<T>,
    capacity: u64
}
```

### Task 2: Define the Generic Wrapper Struct

Create a simple wrapper that holds a single value of any type.

```move
struct Wrapper<T> has copy, drop, store {
    value: T
}
```

### Task 3: Implement init_container

Initialize a container for storing items of type T.

```move
public fun init_container<T: store>(account: &signer, max_capacity: u64) {
    move_to(account, Container<T> {
        items: vector::empty<T>(),
        capacity: max_capacity
    });
}
```

### Task 4: Implement wrap Function

Create a generic function to wrap any value.

```move
public fun wrap<T>(value: T): Wrapper<T> {
    Wrapper { value }
}
```

### Task 5: Implement unwrap Function

Extract the value from a wrapper by destructuring.

```move
public fun unwrap<T>(wrapper: Wrapper<T>): T {
    let Wrapper { value } = wrapper;
    value
}
```

### Task 6: Implement add_item

Add an item to the container with capacity checking.

```move
public fun add_item<T: store>(account: &signer, item: T) acquires Container {
    let addr = signer::address_of(account);
    let container = borrow_global_mut<Container<T>>(addr);

    assert!(vector::length(&container.items) < container.capacity, 1);
    vector::push_back(&mut container.items, item);
}
```

### Task 7: Implement get_item_count

Return the count of items in a container.

```move
public fun get_item_count<T: store>(addr: address): u64 acquires Container {
    let container = borrow_global<Container<T>>(addr);
    vector::length(&container.items)
}
```

---

## Breakdown

### Generic Type Parameters

The `<T>` syntax declares a type parameter:

- `Container<T>` - T is a placeholder for any type
- When used: `Container<u64>`, `Container<bool>`, `Container<MyStruct>`
- Each instantiation creates a distinct type

### Ability Constraints on Type Parameters

When a generic struct has abilities, the type parameter may need matching abilities:

- `struct Container<T> has key` - T needs `store` to be stored in Container
- `struct Wrapper<T> has copy, drop, store` - T needs `copy`, `drop`, `store`
- Constraints are written as `<T: copy + drop + store>`

### Generic Functions

Functions use the same type parameter syntax:

- `fun wrap<T>(value: T): Wrapper<T>` - works with any type
- The compiler infers T from the argument type
- Explicit: `wrap<u64>(42)` or inferred: `wrap(42)`

### Working with Generic Resources

When accessing global storage with generics:

- Must specify the type: `borrow_global<Container<T>>(addr)`
- The `acquires` annotation uses the generic: `acquires Container`
- Type parameter constraints like `T: store` ensure the type can be stored
