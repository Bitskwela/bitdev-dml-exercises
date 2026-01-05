# Sets and Maps: Odessa's Unique Collection

## The Duplicate Dilemma

Odessa ran the community library in Barangay Maliwanag, carefully cataloging every book donation. But lately, she faced a frustrating problem—volunteers kept registering the same books multiple times.

"Jaymart, look at this mess!" Odessa showed her assistant the registry. "We have 'Noli Me Tangere' listed five times because different people donated copies without checking!"

Jaymart scratched his head. "We need a system that automatically prevents duplicates, 'te."

"Exactly," Odessa agreed. "And we need to track who donated each unique book too."

## VecSet: Ensuring Uniqueness

In Move, `VecSet` provides a set data structure that guarantees no duplicate elements. It's built on top of vectors but enforces uniqueness.

```move
module library::registry {
    use sui::vec_set::{Self, VecSet};

    public struct BookRegistry has key {
        id: UID,
        // Each ISBN can only appear once
        registered_isbns: VecSet<u64>,
    }

    public fun create_registry(ctx: &mut TxContext): BookRegistry {
        BookRegistry {
            id: object::new(ctx),
            registered_isbns: vec_set::empty(),
        }
    }

    public fun register_book(registry: &mut BookRegistry, isbn: u64) {
        // insert() will abort if the element already exists!
        vec_set::insert(&mut registry.registered_isbns, isbn);
    }

    public fun is_registered(registry: &BookRegistry, isbn: u64): bool {
        vec_set::contains(&registry.registered_isbns, &isbn)
    }
}
```

## Key VecSet Operations

```move
// Create an empty set
let mut books: VecSet<u64> = vec_set::empty();

// Create a set with one element
let single: VecSet<u64> = vec_set::singleton(12345);

// Insert an element (aborts if duplicate!)
vec_set::insert(&mut books, 67890);

// Safe check before insert
if (!vec_set::contains(&books, &67890)) {
    vec_set::insert(&mut books, 67890);
};

// Remove an element
vec_set::remove(&mut books, &67890);

// Check if set is empty
let empty: bool = vec_set::is_empty(&books);

// Get the size
let count: u64 = vec_set::size(&books);

// Convert to vector (destroys the set)
let book_list: vector<u64> = vec_set::into_keys(books);
```

## VecMap: Key-Value Pairs

"But 'te," Jaymart pointed out, "we also need to know WHO donated each book!"

Odessa nodded. "That's where we need a map—connecting each book to its donor."

`VecMap` stores key-value pairs where each key is unique:

```move
module library::donations {
    use sui::vec_map::{Self, VecMap};

    public struct DonationTracker has key {
        id: UID,
        // ISBN -> Donor address
        book_donors: VecMap<u64, address>,
    }

    public fun create_tracker(ctx: &mut TxContext): DonationTracker {
        DonationTracker {
            id: object::new(ctx),
            book_donors: vec_map::empty(),
        }
    }

    public fun record_donation(
        tracker: &mut DonationTracker,
        isbn: u64,
        donor: address
    ) {
        // Only records if ISBN not already present
        if (!vec_map::contains(&tracker.book_donors, &isbn)) {
            vec_map::insert(&mut tracker.book_donors, isbn, donor);
        };
    }

    public fun get_donor(tracker: &DonationTracker, isbn: u64): &address {
        vec_map::get(&tracker.book_donors, &isbn)
    }
}
```

## Key VecMap Operations

```move
// Create empty map
let mut donations: VecMap<u64, address> = vec_map::empty();

// Insert key-value pair (aborts if key exists!)
vec_map::insert(&mut donations, 12345, @donor1);

// Safe insertion with check
if (!vec_map::contains(&donations, &12345)) {
    vec_map::insert(&mut donations, 12345, @donor1);
};

// Get value by key (returns reference)
let donor: &address = vec_map::get(&donations, &12345);

// Get mutable reference to value
let donor_mut: &mut address = vec_map::get_mut(&mut donations, &12345);

// Try to get (returns Option)
let maybe_donor: Option<&address> = vec_map::try_get(&donations, &99999);

// Remove and get the value
let (key, value) = vec_map::remove(&mut donations, &12345);

// Check size
let count: u64 = vec_map::size(&donations);

// Get all keys
let keys: vector<u64> = vec_map::keys(&donations);

// Destructure into separate vectors
let (all_keys, all_values) = vec_map::into_keys_values(donations);
```

## Preventing Duplicates Pattern

Odessa implemented a complete system:

```move
module library::complete_registry {
    use sui::vec_set::{Self, VecSet};
    use sui::vec_map::{Self, VecMap};

    const E_BOOK_ALREADY_REGISTERED: u64 = 1;
    const E_BOOK_NOT_FOUND: u64 = 2;

    public struct Library has key {
        id: UID,
        registered_books: VecSet<u64>,
        book_donors: VecMap<u64, address>,
        book_titles: VecMap<u64, vector<u8>>,
    }

    public fun donate_book(
        library: &mut Library,
        isbn: u64,
        title: vector<u8>,
        donor: address
    ) {
        // Check for duplicates first
        assert!(
            !vec_set::contains(&library.registered_books, &isbn),
            E_BOOK_ALREADY_REGISTERED
        );

        // Register the book
        vec_set::insert(&mut library.registered_books, isbn);
        vec_map::insert(&mut library.book_donors, isbn, donor);
        vec_map::insert(&mut library.book_titles, isbn, title);
    }

    public fun get_book_info(library: &Library, isbn: u64): (&address, &vector<u8>) {
        assert!(
            vec_set::contains(&library.registered_books, &isbn),
            E_BOOK_NOT_FOUND
        );

        let donor = vec_map::get(&library.book_donors, &isbn);
        let title = vec_map::get(&library.book_titles, &isbn);
        (donor, title)
    }

    public fun total_books(library: &Library): u64 {
        vec_set::size(&library.registered_books)
    }
}
```

## When to Use Each

| Use Case                            | Data Structure |
| ----------------------------------- | -------------- |
| Track unique IDs                    | VecSet         |
| Membership checking                 | VecSet         |
| Key-value lookups                   | VecMap         |
| Associating data with IDs           | VecMap         |
| Simple list with duplicates allowed | vector         |

## Summary

Jaymart looked at the new system admiringly. "So VecSet keeps our ISBNs unique, and VecMap connects each ISBN to its donor?"

"Exactly!" Odessa smiled. "No more duplicate entries, and we always know who to thank for each book."

**Key Takeaways:**

- `VecSet` stores unique elements only—duplicates cause abort
- `VecMap` stores unique key-value pairs
- Always check with `contains()` before `insert()` for safe operations
- Use `try_get()` for optional lookups that might fail
- Both structures are built on vectors, so they're ordered by insertion
