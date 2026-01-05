````markdown
# Mat 1: Witness Pattern

## Scene

Odessa scrolled through the deployment logs, her expression troubled. "Neri, come look at this. Someone called our token's `initialize` function twice. They're trying to mint tokens from a second pool."

Neri hurried over, studying the transaction history. "How is that possible? The function should only work once."

"It should," Odessa agreed grimly, "but we didn't enforce it. Anyone can call `initialize` as many times as they want." She pulled up the code. "We need a way to guarantee that certain operations can only happen once—ever."

Neri thought for a moment. "Like a one-time key that gets consumed when you use it?"

Odessa's eyes brightened. "Exactly! In Move, that's called the Witness Pattern. You create a special type that can only be generated once, and functions require it as proof that they have permission to proceed."

"So the 'witness' is like a ticket that burns itself after use?"

"Precisely. The witness type has no `copy` or `drop` abilities, so once it's created, it must be consumed. After that, there's no way to create another one—the type itself becomes the proof of one-time execution."

Neri nodded slowly. "And since Move's type system tracks these resources, the compiler guarantees the pattern is enforced."

"That's the beauty of it," Odessa said, already typing. "Type-level proofs that can't be forged."

---

## Topics

### 1. What is the Witness Pattern?

The Witness Pattern uses a type as proof of authorization. The witness is a struct that can only be created under specific conditions:

```move
module examples::witness_demo {
    /// The witness type - can only be created in this module
    struct InitWitness has drop {}

    /// One-time initialization using witness
    struct Registry has key {
        initialized: bool,
        admin: address
    }

    /// Only callable with a valid witness
    public fun initialize(witness: InitWitness, admin: address) {
        // witness is consumed here, proving authorization
        let InitWitness {} = witness;
        // ... initialization logic
    }
}
```

The witness type serves as cryptographic-style proof that the caller has the right to perform an action.

### 2. One-Time Initialization

The most common use of the witness pattern is ensuring something happens exactly once:

```move
module examples::one_time_init {
    use std::signer;

    /// Witness that can only exist once
    struct Genesis has drop {}

    struct TokenConfig has key {
        name: vector<u8>,
        total_supply: u64,
        initialized: bool
    }

    /// This function creates AND consumes the witness
    fun init_module(account: &signer) {
        // Genesis witness is created only during module publication
        let witness = Genesis {};

        // Use witness to prove this is the first initialization
        initialize_with_witness(account, witness);
    }

    fun initialize_with_witness(account: &signer, witness: Genesis) {
        // Witness is consumed - cannot be created again
        let Genesis {} = witness;

        move_to(account, TokenConfig {
            name: b"MyToken",
            total_supply: 1000000,
            initialized: true
        });
    }
}
```

### 3. Type as Proof

Witnesses provide type-level guarantees that can't be faked:

```move
module examples::type_proof {
    /// Only this module can create AdminWitness
    struct AdminWitness has drop {}

    /// Privileged operation requires witness
    public fun emergency_shutdown(witness: AdminWitness) {
        let AdminWitness {} = witness;
        // Perform shutdown...
    }

    /// Only admins can obtain the witness
    public fun get_admin_witness(account: &signer): AdminWitness {
        // Verify account is admin...
        assert!(signer::address_of(account) == @admin, 1);
        AdminWitness {}
    }
}
```

Since `AdminWitness` can only be created within the module, external code cannot forge the proof.

### 4. Witness with Hot Potato

Combining witness with the "hot potato" pattern (no `drop` ability) ensures the witness must be handled:

```move
module examples::hot_potato_witness {
    /// Hot potato - MUST be consumed, cannot be dropped
    struct MintPermission { amount: u64 }

    /// Create permission (controlled creation)
    public fun create_mint_permission(admin: &signer, amount: u64): MintPermission {
        // verify admin...
        MintPermission { amount }
    }

    /// Consume permission to mint
    public fun mint_with_permission(permission: MintPermission): u64 {
        let MintPermission { amount } = permission;
        // Mint tokens...
        amount
    }

    // Cannot just drop MintPermission - must call mint_with_permission
}
```

---

## Closing Scene

Odessa deployed the updated contract with the witness pattern in place. The initialization function now required a `Genesis` witness that was created and consumed during module publication.

"Try calling initialize now," she challenged.

Neri ran the transaction and watched it fail. "No way to create the witness from outside the module."

"And even if someone could," Odessa added, "the original witness was already consumed during deployment. There's nothing left to use."

Neri smiled. "One-time execution, guaranteed by the type system. No flags to check, no state to corrupt."

"That's the power of witnesses," Odessa said. "The proof is in the type."

---

## Summary

- The Witness Pattern uses a type as proof of authorization or one-time execution
- Witness types are structs that can only be created under controlled conditions
- Consuming the witness (destructuring it) proves the authorization was used
- Common for one-time initialization during module publication
- Hot potato witnesses (no `drop`) ensure the permission must be used
- Type-level guarantees that cannot be forged or bypassed
````
