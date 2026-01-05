# Gas Optimization

## The Weight of Every Instruction

Salvo examined the performance reports, his analytical mind immediately spotting the inefficiencies. "Every operation has a cost," he said, pointing to the metrics. "In Move, gas represents computational resources. The more efficient our code, the less it costs to execute."

Neri leaned in, curious. "So we need to think about performance from the start?"

"Exactly," Salvo confirmed. "Optimization isn't an afterthought—it's a discipline."

## Understanding Gas Costs

In Move, different operations consume different amounts of gas:

```move
module gas_basics {
    // Storage operations are expensive
    struct Data has key, store {
        value: u64,
        items: vector<u64>,
    }

    // Reading from storage costs gas
    public fun read_value(addr: address): u64 acquires Data {
        borrow_global<Data>(addr).value
    }

    // Writing to storage costs more gas
    public fun write_value(account: &signer, new_value: u64) acquires Data {
        let data = borrow_global_mut<Data>(signer::address_of(account));
        data.value = new_value;
    }
}
```

### Cost Hierarchy (General)

1. **Storage writes** - Most expensive
2. **Storage reads** - Expensive
3. **Vector operations** - Moderate
4. **Arithmetic operations** - Cheap
5. **Local variables** - Very cheap

## Optimization Techniques

### 1. Minimize Storage Operations

```move
module storage_optimization {
    struct Counter has key {
        count: u64,
        last_updated: u64,
    }

    // INEFFICIENT: Multiple storage reads
    public fun inefficient_check(addr: address): bool acquires Counter {
        let count = borrow_global<Counter>(addr).count;
        let updated = borrow_global<Counter>(addr).last_updated;
        count > 0 && updated > 0
    }

    // EFFICIENT: Single storage read
    public fun efficient_check(addr: address): bool acquires Counter {
        let counter = borrow_global<Counter>(addr);
        counter.count > 0 && counter.last_updated > 0
    }
}
```

### 2. Batch Operations

```move
module batch_operations {
    use std::vector;

    struct Registry has key {
        entries: vector<u64>,
    }

    // INEFFICIENT: Multiple transactions
    public fun add_one(account: &signer, value: u64) acquires Registry {
        let registry = borrow_global_mut<Registry>(signer::address_of(account));
        vector::push_back(&mut registry.entries, value);
    }

    // EFFICIENT: Batch in single transaction
    public fun add_many(account: &signer, values: vector<u64>) acquires Registry {
        let registry = borrow_global_mut<Registry>(signer::address_of(account));
        let i = 0;
        let len = vector::length(&values);
        while (i < len) {
            vector::push_back(&mut registry.entries, *vector::borrow(&values, i));
            i = i + 1;
        };
    }
}
```

### 3. Efficient Data Structures

```move
module efficient_structures {
    use std::vector;

    // For small collections, vectors are efficient
    struct SmallSet has store {
        items: vector<u64>,  // Good for < 100 items
    }

    // For lookups, consider the access pattern
    struct IndexedData has store {
        // If you frequently access by index
        data: vector<u64>,
    }

    // Avoid unnecessary nesting
    struct FlatStructure has store {
        field1: u64,
        field2: u64,
        field3: u64,
    }
}
```

### 4. Short-Circuit Evaluation

```move
module short_circuit {
    // Conditions are evaluated left to right
    // Put cheap checks first
    public fun optimized_validation(
        simple_flag: bool,
        addr: address
    ): bool acquires ExpensiveResource {
        // Check simple flag FIRST (cheap)
        // Only read storage if flag is true (expensive)
        simple_flag && exists<ExpensiveResource>(addr)
    }

    struct ExpensiveResource has key {
        data: vector<u64>,
    }
}
```

### 5. Avoid Redundant Computations

```move
module computation_optimization {
    use std::vector;

    // INEFFICIENT: Recalculating length
    public fun inefficient_loop(data: &vector<u64>): u64 {
        let sum = 0;
        let i = 0;
        while (i < vector::length(data)) {  // Length checked each iteration
            sum = sum + *vector::borrow(data, i);
            i = i + 1;
        };
        sum
    }

    // EFFICIENT: Cache the length
    public fun efficient_loop(data: &vector<u64>): u64 {
        let sum = 0;
        let i = 0;
        let len = vector::length(data);  // Calculate once
        while (i < len) {
            sum = sum + *vector::borrow(data, i);
            i = i + 1;
        };
        sum
    }
}
```

## Practical Patterns

Salvo showed Neri a complete optimized module:

```move
module optimized_vault {
    use std::signer;
    use std::vector;

    struct Vault has key {
        balance: u64,
        transaction_count: u64,
        authorized_users: vector<address>,
    }

    // Efficient initialization
    public fun initialize(account: &signer, initial_balance: u64) {
        move_to(account, Vault {
            balance: initial_balance,
            transaction_count: 0,
            authorized_users: vector::empty(),
        });
    }

    // Optimized authorization check
    public fun is_authorized(vault_addr: address, user: address): bool acquires Vault {
        let vault = borrow_global<Vault>(vault_addr);
        vector::contains(&vault.authorized_users, &user)
    }

    // Batch deposit with single storage write
    public fun batch_deposit(
        account: &signer,
        amounts: vector<u64>
    ) acquires Vault {
        let addr = signer::address_of(account);
        let vault = borrow_global_mut<Vault>(addr);

        // Calculate total first (cheap operations)
        let total = 0u64;
        let i = 0;
        let len = vector::length(&amounts);
        while (i < len) {
            total = total + *vector::borrow(&amounts, i);
            i = i + 1;
        };

        // Single storage update (expensive operation, done once)
        vault.balance = vault.balance + total;
        vault.transaction_count = vault.transaction_count + 1;
    }
}
```

## Key Principles

Neri summarized what she learned:

1. **Measure first** - Understand where gas is being spent
2. **Minimize storage** - Read and write as little as possible
3. **Batch operations** - Combine multiple operations when possible
4. **Order conditions** - Put cheap checks before expensive ones
5. **Cache values** - Don't recalculate what you can store

"Optimization is about respect," Salvo concluded. "Respect for the resources we're given and the users who pay for them."
