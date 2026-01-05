````markdown
## Smart contract activity

```move
module capability_exercise::vault_access {
    use std::signer;

    // TODO: Define AdminCapability struct with key and store abilities


    // TODO: Define WithdrawCapability struct with key and store abilities
    // Include a max_amount field of type u64


    struct Vault has key {
        balance: u64
    }

    const E_NOT_OWNER: u64 = 1;
    const E_NO_CAPABILITY: u64 = 2;
    const E_INSUFFICIENT_ALLOWANCE: u64 = 3;
    const E_INSUFFICIENT_BALANCE: u64 = 4;

    // Initialize vault with balance
    public fun initialize(owner: &signer, initial_balance: u64) {
        move_to(owner, Vault { balance: initial_balance });
        // TODO: Also grant AdminCapability to owner
    }

    // TODO: Implement grant_withdraw_capability
    // Admin can grant withdraw capability with a max amount limit
    public fun grant_withdraw_capability(
        admin: &signer,
        recipient: &signer,
        max_amount: u64
    ) {
        // Verify admin has AdminCapability, then grant WithdrawCapability to recipient
    }

    // TODO: Implement withdraw
    // Uses WithdrawCapability to withdraw from vault
    public fun withdraw(
        user: &signer,
        vault_addr: address,
        amount: u64
    ): u64 {
        // Check user has WithdrawCapability with sufficient allowance
        // Deduct from allowance and vault balance
    }

    // TODO: Implement revoke_withdraw_capability
    // Remove withdraw capability from an address
    public fun revoke_withdraw_capability(user: &signer) {
        // Remove and destroy the WithdrawCapability
    }

    // View remaining allowance
    public fun get_allowance(addr: address): u64 acquires WithdrawCapability {
        if (exists<WithdrawCapability>(addr)) {
            borrow_global<WithdrawCapability>(addr).max_amount
        } else {
            0
        }
    }
}
```

## Tasks for Learners

Implement the Capability Pattern for controlled vault access with delegatable withdraw permissions.

- Define `AdminCapability` struct:

  ```move
  struct AdminCapability has key, store {}
  ```

- Define `WithdrawCapability` struct with allowance limit:

  ```move
  struct WithdrawCapability has key, store {
      max_amount: u64
  }
  ```

- Update `initialize` to grant admin capability:

  ```move
  public fun initialize(owner: &signer, initial_balance: u64) {
      move_to(owner, Vault { balance: initial_balance });
      move_to(owner, AdminCapability {});
  }
  ```

- Implement `grant_withdraw_capability`:

  ```move
  public fun grant_withdraw_capability(
      admin: &signer,
      recipient: &signer,
      max_amount: u64
  ) acquires AdminCapability {
      let admin_addr = signer::address_of(admin);
      assert!(exists<AdminCapability>(admin_addr), E_NO_CAPABILITY);

      move_to(recipient, WithdrawCapability { max_amount });
  }
  ```

- Implement `withdraw`:

  ```move
  public fun withdraw(
      user: &signer,
      vault_addr: address,
      amount: u64
  ): u64 acquires WithdrawCapability, Vault {
      let user_addr = signer::address_of(user);
      assert!(exists<WithdrawCapability>(user_addr), E_NO_CAPABILITY);

      let cap = borrow_global_mut<WithdrawCapability>(user_addr);
      assert!(cap.max_amount >= amount, E_INSUFFICIENT_ALLOWANCE);
      cap.max_amount = cap.max_amount - amount;

      let vault = borrow_global_mut<Vault>(vault_addr);
      assert!(vault.balance >= amount, E_INSUFFICIENT_BALANCE);
      vault.balance = vault.balance - amount;

      amount
  }
  ```

- Implement `revoke_withdraw_capability`:

  ```move
  public fun revoke_withdraw_capability(user: &signer) acquires WithdrawCapability {
      let user_addr = signer::address_of(user);
      assert!(exists<WithdrawCapability>(user_addr), E_NO_CAPABILITY);

      let WithdrawCapability { max_amount: _ } = move_from<WithdrawCapability>(user_addr);
  }
  ```

### Breakdown for learners

**The Capability Pattern** uses resources as permission tokens. If you have the capability, you have the permission.

**Key concepts:**

- `AdminCapability` - Grants admin-level access (granting permissions to others)
- `WithdrawCapability` - Grants permission to withdraw, with a spending limit

**Capability abilities:**

- `key` - Can be stored in global storage (user accounts)
- `store` - Can be stored inside other structs

**Granting permissions:**

- Check the granter has `AdminCapability`
- Use `move_to` to give the recipient their capability

**Using permissions:**

- Check `exists<Capability>(user_addr)` to verify permission
- Borrow and update the capability as needed
- The capability itself is the access control

**Revoking permissions:**

- Use `move_from` to remove the capability
- Destructure to consume: `let WithdrawCapability { max_amount: _ } = ...`

**Benefits over address-based checks:**

- Permissions are first-class resources
- Easy to transfer, delegate, or revoke
- Type system enforces access control
- No centralized role tables to manage
````
