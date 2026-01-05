````markdown
# Tables in Move

## Opening Scene

Dex was reviewing the codebase when Ronnie walked in, looking frustrated. He dropped into the chair next to Dex and sighed.

"I've been trying to track user balances," Ronnie explained. "But vectors don't work well when I need to look up a specific user's balance by their address. I end up iterating through the entire vector every time."

Dex nodded knowingly. "You're running into the classic key-value storage problem. Vectors are great for ordered collections, but when you need direct lookups by a unique key, you need a Table."

"A Table?" Ronnie leaned forward, intrigued.

"Think of it like a dictionary or map from other languages," Dex explained. "You store values indexed by keys, and you can look them up in constant time—no iteration required."

---

## Topics

### Understanding Tables

"Tables in Move are fundamentally different from vectors," Dex began. "A vector is a linear sequence, but a Table is a key-value mapping stored in global storage."

```move
module movestack::table_basics {
    use aptos_std::table::{Self, Table};

    /// A registry mapping user addresses to their balances
    struct BalanceRegistry has key {
        balances: Table<address, u64>
    }

    /// A mapping from IDs to names
    struct NameRegistry has key {
        names: Table<u64, vector<u8>>
    }
}
```

Ronnie studied the code. "So `Table<address, u64>` means addresses are the keys and u64 values are stored?"

"Exactly," Dex confirmed. "The first type parameter is the key type, the second is the value type. Keys must have the `copy` and `drop` abilities."

### Creating Tables

"Creating a new table is straightforward," Dex continued.

```move
module movestack::user_registry {
    use std::signer;
    use aptos_std::table::{Self, Table};

    struct UserRegistry has key {
        balances: Table<address, u64>,
        names: Table<address, vector<u8>>
    }

    /// Initialize a new registry for the account
    public fun initialize(account: &signer) {
        let registry = UserRegistry {
            balances: table::new(),
            names: table::new()
        };
        move_to(account, registry);
    }
}
```

"The `table::new()` function creates an empty table," Dex explained. "Unlike vectors, tables must be stored in a resource—they can't exist as standalone local variables."

### Adding Entries with `add`

"To insert a key-value pair, use `table::add`," Dex demonstrated.

```move
module movestack::balance_manager {
    use aptos_std::table::{Self, Table};

    struct Ledger has key {
        balances: Table<address, u64>
    }

    /// Add a new user with an initial balance
    public fun register_user(
        ledger: &mut Ledger,
        user: address,
        initial_balance: u64
    ) {
        // Add only works if the key doesn't exist
        table::add(&mut ledger.balances, user, initial_balance);
    }

    /// Safe registration that checks first
    public fun safe_register(
        ledger: &mut Ledger,
        user: address,
        initial_balance: u64
    ) {
        if (!table::contains(&ledger.balances, user)) {
            table::add(&mut ledger.balances, user, initial_balance);
        };
    }
}
```

Ronnie asked, "What happens if the key already exists?"

"The transaction aborts," Dex replied. "That's why `safe_register` checks with `contains` first. Always verify before adding if there's any chance of duplicates."

### Reading with `borrow` and `borrow_mut`

"To read values, use `borrow` for immutable access or `borrow_mut` for mutable access," Dex showed.

```move
module movestack::balance_reader {
    use aptos_std::table::{Self, Table};

    struct Ledger has key {
        balances: Table<address, u64>
    }

    /// Get a user's balance (read-only)
    public fun get_balance(ledger: &Ledger, user: address): u64 {
        *table::borrow(&ledger.balances, user)
    }

    /// Increase a user's balance
    public fun deposit(
        ledger: &mut Ledger,
        user: address,
        amount: u64
    ) {
        let balance = table::borrow_mut(&mut ledger.balances, user);
        *balance = *balance + amount;
    }

    /// Transfer between users
    public fun transfer(
        ledger: &mut Ledger,
        from: address,
        to: address,
        amount: u64
    ) {
        // Deduct from sender
        let from_balance = table::borrow_mut(&mut ledger.balances, from);
        assert!(*from_balance >= amount, 1); // Insufficient balance
        *from_balance = *from_balance - amount;

        // Add to recipient
        let to_balance = table::borrow_mut(&mut ledger.balances, to);
        *to_balance = *to_balance + amount;
    }
}
```

"Notice how `borrow` returns a reference," Dex pointed out. "We dereference with `*` to get the actual value."

### Checking Existence with `contains`

"Before accessing a key, you often want to check if it exists," Dex explained.

```move
module movestack::safe_access {
    use aptos_std::table::{Self, Table};
    use std::option::{Self, Option};

    struct Registry has key {
        data: Table<u64, vector<u8>>
    }

    /// Check if an entry exists
    public fun has_entry(registry: &Registry, id: u64): bool {
        table::contains(&registry.data, id)
    }

    /// Get entry if it exists, return Option
    public fun try_get(registry: &Registry, id: u64): Option<vector<u8>> {
        if (table::contains(&registry.data, id)) {
            option::some(*table::borrow(&registry.data, id))
        } else {
            option::none()
        }
    }

    /// Get or default value
    public fun get_or_default(
        registry: &Registry,
        id: u64,
        default: vector<u8>
    ): vector<u8> {
        if (table::contains(&registry.data, id)) {
            *table::borrow(&registry.data, id)
        } else {
            default
        }
    }
}
```

### Removing Entries with `remove`

"To remove a key-value pair, use `table::remove`," Dex continued.

```move
module movestack::cleanup {
    use aptos_std::table::{Self, Table};

    struct UserData has key {
        profiles: Table<address, u64>
    }

    /// Remove a user's profile and return their data
    public fun delete_profile(
        data: &mut UserData,
        user: address
    ): u64 {
        // Remove returns the value that was stored
        table::remove(&mut data.profiles, user)
    }

    /// Safe removal that checks first
    public fun safe_delete(
        data: &mut UserData,
        user: address
    ): bool {
        if (table::contains(&data.profiles, user)) {
            let _ = table::remove(&mut data.profiles, user);
            true
        } else {
            false
        }
    }

    /// Clear multiple entries
    public fun clear_users(
        data: &mut UserData,
        users: vector<address>
    ) {
        let i = 0;
        let len = std::vector::length(&users);
        while (i < len) {
            let user = *std::vector::borrow(&users, i);
            if (table::contains(&data.profiles, user)) {
                let _ = table::remove(&mut data.profiles, user);
            };
            i = i + 1;
        };
    }
}
```

"The `remove` function returns the value, so you can capture it if needed," Dex noted. "If you don't need the value, assign it to `_` to discard."

### Upserting Values

"A common pattern is 'upsert'—update if exists, insert if not," Dex showed.

```move
module movestack::upsert_pattern {
    use aptos_std::table::{Self, Table};

    struct Counter has key {
        counts: Table<address, u64>
    }

    /// Increment counter, creating it if needed
    public fun increment(counter: &mut Counter, user: address) {
        if (table::contains(&counter.counts, user)) {
            let count = table::borrow_mut(&mut counter.counts, user);
            *count = *count + 1;
        } else {
            table::add(&mut counter.counts, user, 1);
        };
    }

    /// Set value, creating or updating as needed
    public fun set_count(
        counter: &mut Counter,
        user: address,
        value: u64
    ) {
        if (table::contains(&counter.counts, user)) {
            let count = table::borrow_mut(&mut counter.counts, user);
            *count = value;
        } else {
            table::add(&mut counter.counts, user, value);
        };
    }

    /// Upsert using remove and add (alternative pattern)
    public fun upsert_via_remove(
        counter: &mut Counter,
        user: address,
        value: u64
    ) {
        if (table::contains(&counter.counts, user)) {
            let _ = table::remove(&mut counter.counts, user);
        };
        table::add(&mut counter.counts, user, value);
    }
}
```

---

## Closing Scene

Ronnie leaned back, processing everything. "So Tables give me O(1) lookups by key, but I need to be careful about checking existence before add or borrow operations."

"Exactly," Dex confirmed. "Tables are perfect for mappings where you need direct access by a unique identifier—user balances, token ownership, configuration settings. Just remember: they live in global storage, keys need `copy` and `drop`, and always check `contains` when you're not certain a key exists."

"This is going to clean up my balance tracking code significantly," Ronnie said, already planning the refactor. "No more O(n) vector searches!"

Dex smiled. "That's the power of choosing the right data structure. Tables and vectors each have their place—now you know when to use each one."
````
