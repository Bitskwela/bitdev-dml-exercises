````markdown
## Smart contract activity

```move
module witness_exercise::token_factory {
    use std::signer;

    // TODO: Define a Genesis witness struct with `drop` ability


    struct TokenRegistry has key {
        name: vector<u8>,
        symbol: vector<u8>,
        total_supply: u64,
        is_initialized: bool
    }

    // TODO: Define a MintPermission witness struct (hot potato - no abilities)


    const E_ALREADY_INITIALIZED: u64 = 1;
    const E_NOT_ADMIN: u64 = 2;

    // TODO: Implement init_module that creates a Genesis witness
    // and calls initialize_with_witness
    fun init_module(account: &signer) {
        // Create witness and use it for initialization
    }

    // TODO: Implement initialize_with_witness that consumes the Genesis witness
    // and creates the TokenRegistry
    fun initialize_with_witness(account: &signer, witness: Genesis) {
        // Consume witness and create registry
    }

    // TODO: Implement create_mint_permission that returns a MintPermission
    // Only the admin (@token_factory) can create permissions
    public fun create_mint_permission(admin: &signer, amount: u64): MintPermission {
        // Verify admin and return permission
    }

    // TODO: Implement mint_with_permission that consumes MintPermission
    // and returns the minted amount
    public fun mint_with_permission(permission: MintPermission): u64 {
        // Consume permission and return amount
    }
}
```

## Tasks for Learners

Implement the Witness Pattern to ensure one-time initialization and controlled minting permissions.

- Define the `Genesis` witness struct with `drop` ability:

  ```move
  struct Genesis has drop {}
  ```

- Define the `MintPermission` hot potato struct (no abilities):

  ```move
  struct MintPermission { amount: u64 }
  ```

- Implement `init_module` to create and use the Genesis witness:

  ```move
  fun init_module(account: &signer) {
      let witness = Genesis {};
      initialize_with_witness(account, witness);
  }
  ```

- Implement `initialize_with_witness` to consume the witness and create the registry:

  ```move
  fun initialize_with_witness(account: &signer, witness: Genesis) {
      let Genesis {} = witness;

      move_to(account, TokenRegistry {
          name: b"FactoryToken",
          symbol: b"FTK",
          total_supply: 0,
          is_initialized: true
      });
  }
  ```

- Implement `create_mint_permission` with admin verification:

  ```move
  public fun create_mint_permission(admin: &signer, amount: u64): MintPermission {
      assert!(signer::address_of(admin) == @token_factory, E_NOT_ADMIN);
      MintPermission { amount }
  }
  ```

- Implement `mint_with_permission` to consume the permission:

  ```move
  public fun mint_with_permission(permission: MintPermission): u64 {
      let MintPermission { amount } = permission;
      amount
  }
  ```

### Breakdown for learners

**The Witness Pattern** uses types as unforgeable proof of authorization. A witness struct can only be created in specific, controlled circumstances.

**Genesis Witness:**

- Created only in `init_module` which runs once during module publication
- Has `drop` ability so it can be consumed by destructuring
- Pattern: `let Genesis {} = witness;` consumes and validates the witness

**Hot Potato Pattern:**

- `MintPermission` has no abilities (not even `drop`)
- Once created, it MUST be consumed—cannot be ignored or discarded
- Forces the caller to complete the intended action

**Why witnesses work:**

- Only this module can create `Genesis` or `MintPermission`
- External code cannot forge these types
- The type system enforces the authorization at compile time

**Common uses:**

- One-time initialization (Genesis pattern)
- Controlled permissions (capability tokens)
- Multi-step operations that must complete
````
