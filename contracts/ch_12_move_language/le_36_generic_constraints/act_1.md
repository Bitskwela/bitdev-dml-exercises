# Activity 1: Generic Constraints

## Initial Code

```move
module patrol::constrained_registry {
    use std::vector;
    use std::signer;

    // TODO: Define CopyableCache struct with type parameter T
    // T must have: copy, drop
    // Struct abilities: key
    // Fields: items (vector<T>), last_accessed (T)

    // TODO: Define PersistentStore struct with type parameter T
    // T must have: store
    // Struct abilities: key, store
    // Fields: data (T), backup (vector<T>)

    // TODO: Define FlexibleBox struct with type parameter T
    // T must have: copy, drop, store
    // Struct abilities: key, copy, drop, store
    // Field: contents (T)

    // TODO: Implement create_cache function
    // Requires T: copy + drop
    // Parameters: account (&signer), initial (T)

    // TODO: Implement cache_item function
    // Adds item to cache and updates last_accessed
    // Parameters: account (&signer), item (T)

    // TODO: Implement get_last_accessed function
    // Returns a copy of last_accessed item
    // Parameters: addr (address)
    // Returns: T

    // TODO: Implement create_store function
    // Requires T: store
    // Parameters: account (&signer), initial_data (T)

    // TODO: Implement create_box function
    // Requires T: copy + drop + store
    // Parameters: account (&signer), value (T)

    // TODO: Implement duplicate_box function
    // Creates two copies of a FlexibleBox
    // Parameters: box (FlexibleBox<T>)
    // Returns: (FlexibleBox<T>, FlexibleBox<T>)
}
```

---

## Tasks

### Task 1: Define CopyableCache Struct

Create a struct that caches items with copy and drop abilities.

```move
struct CopyableCache<T: copy + drop> has key {
    items: vector<T>,
    last_accessed: T
}
```

### Task 2: Define PersistentStore Struct

Create a struct for storing data that can persist.

```move
struct PersistentStore<T: store> has key, store {
    data: T,
    backup: vector<T>
}
```

### Task 3: Define FlexibleBox Struct

Create a maximally flexible container with all common abilities.

```move
struct FlexibleBox<T: copy + drop + store> has key, copy, drop, store {
    contents: T
}
```

### Task 4: Implement create_cache

Initialize a cache with an initial value.

```move
public fun create_cache<T: copy + drop>(account: &signer, initial: T) {
    move_to(account, CopyableCache<T> {
        items: vector::empty<T>(),
        last_accessed: initial
    });
}
```

### Task 5: Implement cache_item

Add item to cache and track it as last accessed.

```move
public fun cache_item<T: copy + drop>(
    account: &signer,
    item: T
) acquires CopyableCache {
    let addr = signer::address_of(account);
    let cache = borrow_global_mut<CopyableCache<T>>(addr);

    vector::push_back(&mut cache.items, copy item);
    cache.last_accessed = item;
}
```

### Task 6: Implement get_last_accessed

Return a copy of the last accessed item.

```move
public fun get_last_accessed<T: copy + drop>(addr: address): T acquires CopyableCache {
    let cache = borrow_global<CopyableCache<T>>(addr);
    cache.last_accessed
}
```

### Task 7: Implement create_store

Initialize a persistent store for storable types.

```move
public fun create_store<T: store>(account: &signer, initial_data: T) {
    move_to(account, PersistentStore<T> {
        data: initial_data,
        backup: vector::empty<T>()
    });
}
```

### Task 8: Implement create_box

Create a flexible box with maximum abilities.

```move
public fun create_box<T: copy + drop + store>(
    account: &signer,
    value: T
) {
    move_to(account, FlexibleBox<T> { contents: value });
}
```

### Task 9: Implement duplicate_box

Demonstrate copy ability by duplicating a box.

```move
public fun duplicate_box<T: copy + drop + store>(
    box: FlexibleBox<T>
): (FlexibleBox<T>, FlexibleBox<T>) {
    let copy1 = copy box;
    (copy1, box)
}
```

---

## Breakdown

### Why Ability Constraints?

Ability constraints ensure type safety:

- Without `copy`: Cannot duplicate values
- Without `drop`: Cannot discard values (must be explicitly handled)
- Without `store`: Cannot save to global storage
- Without `key`: Cannot be a top-level resource

### Constraint Syntax

Single constraint:

```move
<T: copy>
<T: store>
```

Multiple constraints use `+`:

```move
<T: copy + drop>
<T: copy + drop + store>
```

### Struct Ability Inheritance

When a struct has abilities, its type parameters often need matching abilities:

- `struct S<T> has copy` → T typically needs `copy`
- `struct S<T> has store` → T needs `store`
- `struct S<T> has key` → T needs `store` (for fields to be storable)

### Common Constraint Patterns

| Pattern                    | Use Case                               |
| -------------------------- | -------------------------------------- |
| `<T: copy>`                | Read/peek operations without consuming |
| `<T: drop>`                | Optional handling, filtering           |
| `<T: store>`               | Persistence, nested in resources       |
| `<T: copy + drop>`         | Caching, temporary storage             |
| `<T: copy + drop + store>` | Maximum flexibility                    |
