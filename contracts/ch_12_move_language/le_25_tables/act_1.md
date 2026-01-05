````markdown
## Smart contract activity

```move
module movestack::token_registry {
    use std::signer;
    use aptos_std::table::{Self, Table};

    // TODO: Define TokenInfo struct with copy, drop, store abilities
    // Fields: name (vector<u8>), symbol (vector<u8>), total_supply (u64)

    // TODO: Define Registry struct with key ability
    // Field: tokens (Table<u64, TokenInfo>)

    /// Initialize the registry for an account
    public fun initialize(account: &signer) {
        // TODO: Create a new Registry with an empty table and move to account
    }

    // TODO: Implement register_token
    // Adds a new token to the registry with given id and info
    // Should abort if token id already exists

    // TODO: Implement get_token_info
    // Returns a copy of TokenInfo for a given token id
    // Should abort if token doesn't exist

    // TODO: Implement token_exists
    // Returns true if a token with the given id exists

    // TODO: Implement update_supply
    // Updates the total_supply of an existing token
    // Should abort if token doesn't exist

    // TODO: Implement remove_token
    // Removes a token from the registry and returns its info
    // Should abort if token doesn't exist

    // TODO: Implement safe_register
    // Only registers if the token id doesn't already exist
    // Returns true if registered, false if already existed
}
```

## Tasks for Learners

- Define the `TokenInfo` struct with `copy`, `drop`, and `store` abilities:

  ```move
  struct TokenInfo has copy, drop, store {
      name: vector<u8>,
      symbol: vector<u8>,
      total_supply: u64
  }
  ```

- Define the `Registry` struct with the `key` ability:

  ```move
  struct Registry has key {
      tokens: Table<u64, TokenInfo>
  }
  ```

- Implement `initialize` to create an empty registry:

  ```move
  public fun initialize(account: &signer) {
      let registry = Registry {
          tokens: table::new()
      };
      move_to(account, registry);
  }
  ```

- Implement `register_token` to add a new token:

  ```move
  public fun register_token(
      registry: &mut Registry,
      id: u64,
      name: vector<u8>,
      symbol: vector<u8>,
      total_supply: u64
  ) {
      let info = TokenInfo { name, symbol, total_supply };
      table::add(&mut registry.tokens, id, info);
  }
  ```

- Implement `get_token_info` to retrieve token information:

  ```move
  public fun get_token_info(registry: &Registry, id: u64): TokenInfo {
      *table::borrow(&registry.tokens, id)
  }
  ```

- Implement `token_exists` to check if a token is registered:

  ```move
  public fun token_exists(registry: &Registry, id: u64): bool {
      table::contains(&registry.tokens, id)
  }
  ```

- Implement `update_supply` to modify a token's supply:

  ```move
  public fun update_supply(
      registry: &mut Registry,
      id: u64,
      new_supply: u64
  ) {
      let info = table::borrow_mut(&mut registry.tokens, id);
      info.total_supply = new_supply;
  }
  ```

- Implement `remove_token` to delete a token and return its info:

  ```move
  public fun remove_token(registry: &mut Registry, id: u64): TokenInfo {
      table::remove(&mut registry.tokens, id)
  }
  ```

- Implement `safe_register` to conditionally register:

  ```move
  public fun safe_register(
      registry: &mut Registry,
      id: u64,
      name: vector<u8>,
      symbol: vector<u8>,
      total_supply: u64
  ): bool {
      if (table::contains(&registry.tokens, id)) {
          false
      } else {
          let info = TokenInfo { name, symbol, total_supply };
          table::add(&mut registry.tokens, id, info);
          true
      }
  }
  ```

### Breakdown for learners

**The Table type** provides efficient key-value storage with O(1) lookups, insertions, and deletions.

**Key operations:**

- `table::new()` — Creates an empty table
- `table::add(table, key, value)` — Inserts a new key-value pair (aborts if key exists)
- `table::borrow(table, key)` — Returns immutable reference to value (aborts if key missing)
- `table::borrow_mut(table, key)` — Returns mutable reference to value (aborts if key missing)
- `table::contains(table, key)` — Returns true if key exists
- `table::remove(table, key)` — Removes and returns value (aborts if key missing)

**Key requirements:**

- Key types must have `copy` and `drop` abilities
- Value types must have `store` ability
- Tables must be stored in resources (cannot be local variables)

**Common patterns:**

- Always check `contains` before `add` if duplicates are possible
- Always check `contains` before `borrow` if key might not exist
- Use upsert pattern for "update or insert" logic

**Why Tables over Vectors:**

- O(1) lookup vs O(n) search
- Direct key access vs index-based access
- Better for mappings where order doesn't matter
````
