# Act 1: Phantom Parameters

## Initial Code

```move
module phantom_exercise::typed_vault {

    // TODO: Define marker types for vault states
    // - Active (vault is operational)
    // - Frozen (vault is suspended)

    // TODO: Define marker types for asset classes
    // - Gold
    // - Silver

    // TODO: Define Vault struct with TWO phantom parameters
    // - One for State (Active/Frozen)
    // - One for Asset (Gold/Silver)
    // - Fields: balance (u64), owner (address)

    // TODO: Create a new Active vault for a specific asset type
    // public fun create_vault<Asset>(owner: address): Vault<Active, Asset>

    // TODO: Deposit into an Active vault only
    // public fun deposit<Asset>(vault: &mut Vault<Active, Asset>, amount: u64)

    // TODO: Freeze an Active vault, returning a Frozen vault
    // public fun freeze_vault<Asset>(vault: Vault<Active, Asset>): Vault<Frozen, Asset>

    // TODO: Unfreeze a Frozen vault, returning an Active vault
    // public fun unfreeze_vault<Asset>(vault: Vault<Frozen, Asset>): Vault<Active, Asset>

    // TODO: Get balance (works for any state)
    // public fun get_balance<State, Asset>(vault: &Vault<State, Asset>): u64
}
```

---

## Tasks

### Task 1: Define State Marker Types

Create empty structs to represent vault states.

```move
struct Active {}
struct Frozen {}
```

### Task 2: Define Asset Marker Types

Create empty structs to represent asset classes.

```move
struct Gold {}
struct Silver {}
```

### Task 3: Define the Vault Struct with Phantom Parameters

Create a vault that uses phantom types for state and asset tracking.

```move
struct Vault<phantom State, phantom Asset> has store {
    balance: u64,
    owner: address
}
```

### Task 4: Implement create_vault

Create a new vault in Active state for a specific asset type.

```move
public fun create_vault<Asset>(owner: address): Vault<Active, Asset> {
    Vault<Active, Asset> {
        balance: 0,
        owner
    }
}
```

### Task 5: Implement deposit

Allow deposits only to Active vaults.

```move
public fun deposit<Asset>(vault: &mut Vault<Active, Asset>, amount: u64) {
    vault.balance = vault.balance + amount;
}
```

### Task 6: Implement freeze_vault

Transform an Active vault into a Frozen vault.

```move
public fun freeze_vault<Asset>(vault: Vault<Active, Asset>): Vault<Frozen, Asset> {
    Vault<Frozen, Asset> {
        balance: vault.balance,
        owner: vault.owner
    }
}
```

### Task 7: Implement unfreeze_vault

Transform a Frozen vault back into an Active vault.

```move
public fun unfreeze_vault<Asset>(vault: Vault<Frozen, Asset>): Vault<Active, Asset> {
    Vault<Active, Asset> {
        balance: vault.balance,
        owner: vault.owner
    }
}
```

### Task 8: Implement get_balance

Read balance from any vault regardless of state.

```move
public fun get_balance<State, Asset>(vault: &Vault<State, Asset>): u64 {
    vault.balance
}
```

---

## Breakdown

### Phantom Type Parameters

The `phantom` keyword indicates a type parameter has no runtime representation:

```move
struct Vault<phantom State, phantom Asset>
```

- `State` and `Asset` exist only for compile-time type checking
- The actual struct stores only `balance` and `owner`
- `Vault<Active, Gold>` and `Vault<Frozen, Silver>` have identical memory layouts

### Marker Types

Empty structs serve as compile-time markers:

```move
struct Active {}  // No fields, no runtime cost
struct Frozen {}
```

These types are never instantiated—they only exist in type signatures.

### Type-Safe State Transitions

Phantom parameters enforce valid operations at compile time:

```move
// Only Active vaults accept deposits
public fun deposit<Asset>(vault: &mut Vault<Active, Asset>, amount: u64)

// Freezing changes the type, not just a flag
public fun freeze_vault<Asset>(vault: Vault<Active, Asset>): Vault<Frozen, Asset>
```

Attempting `deposit` on a `Vault<Frozen, Gold>` fails at compile time—no runtime check needed.

### Generic Over Phantom Parameters

Functions can be generic over phantom types when the operation applies to all variants:

```move
public fun get_balance<State, Asset>(vault: &Vault<State, Asset>): u64
```

This works for any combination of `State` and `Asset` because reading balance doesn't depend on either phantom parameter.

### Why Phantom Parameters Matter

1. **Zero runtime cost**: No storage overhead for type distinctions
2. **Compile-time safety**: Invalid operations caught before deployment
3. **Self-documenting**: Types express intent and constraints
4. **Composable**: Multiple phantom parameters enable rich type-level logic
