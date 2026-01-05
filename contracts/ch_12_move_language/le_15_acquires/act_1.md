## Smart contract activity

```move
module movestack::vault {
    use std::signer;

    struct Vault has key {
        balance: u64
    }

    public fun initialize(account: &signer) {
        move_to(account, Vault { balance: 0 });
    }

    fun get_vault(addr: address): &Vault {
        // TODO: Add acquires annotation to this function
        borrow_global<Vault>(addr)
    }

    fun get_vault_mut(addr: address): &mut Vault {
        // TODO: Add acquires annotation to this function
        borrow_global_mut<Vault>(addr)
    }

    public fun get_balance(addr: address): u64 {
        // TODO: Add acquires annotation (calls get_vault)
        let vault = get_vault(addr);
        vault.balance
    }

    public fun deposit(addr: address, amount: u64) {
        // TODO: Add acquires annotation (calls get_vault_mut)
        let vault = get_vault_mut(addr);
        vault.balance = vault.balance + amount;
    }
}
```

## Tasks for Learners

Add `acquires` annotations to functions that access global storage. Move requires explicit declaration of which resources a function accesses.

- Add the `acquires` annotation to `get_vault` which uses `borrow_global`:

  ```move
  fun get_vault(addr: address): &Vault acquires Vault {
      borrow_global<Vault>(addr)
  }
  ```

- Add the `acquires` annotation to `get_vault_mut` which uses `borrow_global_mut`:

  ```move
  fun get_vault_mut(addr: address): &mut Vault acquires Vault {
      borrow_global_mut<Vault>(addr)
  }
  ```

- Add the `acquires` annotation to `get_balance` because it calls `get_vault`:

  ```move
  public fun get_balance(addr: address): u64 acquires Vault {
      let vault = get_vault(addr);
      vault.balance
  }
  ```

- Add the `acquires` annotation to `deposit` because it calls `get_vault_mut`:

  ```move
  public fun deposit(addr: address, amount: u64) acquires Vault {
      let vault = get_vault_mut(addr);
      vault.balance = vault.balance + amount;
  }
  ```

### Breakdown for learners

**The `acquires` annotation** tells the Move compiler which global resources a function may access. This is required for safety and reentrancy protection.

**When to add `acquires`:**

- Functions using `borrow_global<T>` → add `acquires T`
- Functions using `borrow_global_mut<T>` → add `acquires T`
- Functions using `move_from<T>` → add `acquires T`
- Functions that **call** other functions with `acquires` → must also add `acquires`

**When NOT to add `acquires`:**

- Functions using only `move_to` (publishing a resource)
- Functions using only `exists<T>` (checking existence)

**Acquires propagation**: If function A calls function B, and B has `acquires Vault`, then A must also have `acquires Vault`. This ensures the entire call chain is transparent about resource access.

**Why this matters:**

- **Prevents reentrancy bugs**: The compiler knows what resources are being accessed
- **Explicit contracts**: Callers know exactly what a function will touch
- **Safety guarantees**: Global storage access is tracked at compile time
