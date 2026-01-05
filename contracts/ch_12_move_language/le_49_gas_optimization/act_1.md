# Activity 1: Optimize the Token Registry

## The Challenge

Salvo has identified performance issues in the team's token registry module. The current implementation works but consumes excessive gas due to inefficient patterns.

Your task is to optimize the `TokenRegistry` module by applying the gas optimization techniques you've learned.

## Current Inefficient Implementation

```move
module token_registry_inefficient {
    use std::signer;
    use std::vector;

    struct TokenRegistry has key {
        tokens: vector<TokenInfo>,
        total_supply: u64,
        is_active: bool,
    }

    struct TokenInfo has store, drop, copy {
        id: u64,
        balance: u64,
        owner: address,
    }

    // PROBLEM 1: Multiple storage reads
    public fun get_registry_stats(addr: address): (u64, u64, bool) acquires TokenRegistry {
        let token_count = vector::length(&borrow_global<TokenRegistry>(addr).tokens);
        let supply = borrow_global<TokenRegistry>(addr).total_supply;
        let active = borrow_global<TokenRegistry>(addr).is_active;
        (token_count, supply, active)
    }

    // PROBLEM 2: Inefficient loop with recalculated length
    public fun calculate_total_balance(addr: address): u64 acquires TokenRegistry {
        let registry = borrow_global<TokenRegistry>(addr);
        let total = 0;
        let i = 0;
        while (i < vector::length(&registry.tokens)) {
            total = total + vector::borrow(&registry.tokens, i).balance;
            i = i + 1;
        };
        total
    }

    // PROBLEM 3: Expensive check first
    public fun can_transfer(
        registry_addr: address,
        amount: u64,
        has_permission: bool
    ): bool acquires TokenRegistry {
        let registry = borrow_global<TokenRegistry>(registry_addr);
        registry.is_active && registry.total_supply >= amount && has_permission
    }
}
```

## Your Task

Create an optimized version of this module called `token_registry_optimized` that fixes all three problems:

1. **Fix `get_registry_stats`**: Use a single storage read instead of three
2. **Fix `calculate_total_balance`**: Cache the vector length before the loop
3. **Fix `can_transfer`**: Reorder conditions to check cheap operations first

## Requirements

- Module name: `token_registry_optimized`
- Keep the same function signatures and return types
- Apply the optimization techniques from the lesson
- Maintain the same functionality

## Starter Code

```move
module token_registry_optimized {
    use std::signer;
    use std::vector;

    struct TokenRegistry has key {
        tokens: vector<TokenInfo>,
        total_supply: u64,
        is_active: bool,
    }

    struct TokenInfo has store, drop, copy {
        id: u64,
        balance: u64,
        owner: address,
    }

    // TODO: Optimize - use single storage read
    public fun get_registry_stats(addr: address): (u64, u64, bool) acquires TokenRegistry {
        // Your optimized code here
    }

    // TODO: Optimize - cache vector length
    public fun calculate_total_balance(addr: address): u64 acquires TokenRegistry {
        // Your optimized code here
    }

    // TODO: Optimize - reorder conditions (cheap first)
    public fun can_transfer(
        registry_addr: address,
        amount: u64,
        has_permission: bool
    ): bool acquires TokenRegistry {
        // Your optimized code here
    }
}
```

## Hints

1. For `get_registry_stats`: Borrow the global resource once and access all fields from that single reference
2. For `calculate_total_balance`: Store `vector::length()` in a local variable before the loop
3. For `can_transfer`: The `has_permission` parameter is a simple boolean—check it before reading storage
