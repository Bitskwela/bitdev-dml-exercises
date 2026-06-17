## Smart contract activity

Odessa's lesson on the borrow checker turns into a hands-on drill. You will write **three
modules**, each one showing a different way to keep Move's reference-safety rules happy.
The recurring trick is the **"extract values first, then modify"** pattern — read what you
need into locals, then write — so you never hold a read borrow and a write borrow of the
same data at once.

- `safety::aliasing_fix` — fixes classic aliasing conflicts on an `Inventory`.
- `safety::restructure` — restructures `Account` updates for borrow safety.
- `safety::patterns` — a `Vault` showing safe read/check/modify patterns.

```move
/// Module demonstrating fixed aliasing issues
module safety::aliasing_fix {
    struct Inventory has drop {
        items: u64,
        capacity: u64
    }

    public fun check_and_add(inventory: &mut Inventory, amount: u64): bool {
        // TODO: Read items/capacity first, then add if there is room
    }

    public fun transfer_items(from: &mut Inventory, to: &mut Inventory, amount: u64): bool {
        // TODO: Extract all values, validate, then move items
    }

    public fun swap_inventories(inv1: &mut Inventory, inv2: &mut Inventory) {
        // TODO: Extract all values, then write the swapped values
    }
}

/// Module demonstrating restructured code for borrow safety
module safety::restructure {
    struct Account has drop {
        balance: u64,
        pending: u64,
        locked: bool
    }

    public fun available_balance(account: &Account): u64 {
        // TODO: Read-only: balance - pending
    }

    public fun process_pending(account: &mut Account) {
        // TODO: Fold pending into balance, then zero pending
    }

    public fun emergency_lock(account: &mut Account) {
        // TODO: Lock the account and zero pending (leave balance)
    }

    public fun transfer_pending(from: &mut Account, to: &mut Account) {
        // TODO: Move `from`'s pending into `to`'s balance
    }

    public fun consolidate_both(acc1: &mut Account, acc2: &mut Account) {
        // TODO: Process each account's pending into its own balance, one at a time
    }
}

/// Module demonstrating safe reference patterns
module safety::patterns {
    struct Vault has drop {
        gold: u64,
        silver: u64,
        is_open: bool
    }

    public fun new_vault(gold: u64, silver: u64): Vault {
        // TODO: Build a Vault that is open by default
    }

    public fun total_value(vault: &Vault): u64 {
        // TODO: gold * 10 + silver (read-only)
    }

    public fun deposit_gold(vault: &mut Vault, amount: u64): bool {
        // TODO: Add gold if the vault is open
    }

    public fun withdraw_silver(vault: &mut Vault, amount: u64): bool {
        // TODO: Remove silver if open and sufficient
    }

    public fun exchange_gold_for_silver(vault: &mut Vault, gold_amount: u64): bool {
        // TODO: Compute new values, then apply them
    }

    public fun close_and_empty(vault: &mut Vault): (u64, u64) {
        // TODO: Extract contents, close + empty the vault, return contents
    }

    public fun merge_vaults(dest: &mut Vault, source: &mut Vault) {
        // TODO: Extract from source, add to dest, then zero source
    }
}
```

## Tasks for Learners

Fix reference-safety violations by reading all values before modifying. Each snippet is
copied verbatim from the working solution.

### Module `safety::aliasing_fix`

```move
struct Inventory has drop {
    items: u64,
    capacity: u64
}
```

- **`check_and_add`** — read the fields into locals through the single mutable reference, compute remaining space, then write:

  ```move
  public fun check_and_add(inventory: &mut Inventory, amount: u64): bool {
      // Read values directly through the mutable reference
      let current_items = inventory.items;
      let max_capacity = inventory.capacity;
      let remaining = max_capacity - current_items;

      if (remaining >= amount) {
          inventory.items = current_items + amount;
          true
      } else {
          false
      }
  }
  ```

- **`transfer_items`** — extract every value first, validate both sides, then perform the writes:

  ```move
  public fun transfer_items(from: &mut Inventory, to: &mut Inventory, amount: u64): bool {
      // Extract all needed values first
      let from_items = from.items;
      let to_items = to.items;
      let to_capacity = to.capacity;

      // Check conditions
      if (from_items < amount) {
          return false
      };

      let to_remaining = to_capacity - to_items;
      if (to_remaining < amount) {
          return false
      };

      // Now perform modifications
      from.items = from_items - amount;
      to.items = to_items + amount;
      true
  }
  ```

- **`swap_inventories`** — extract all four values, then write the swapped values:

  ```move
  public fun swap_inventories(inv1: &mut Inventory, inv2: &mut Inventory) {
      // Extract all values first
      let items1 = inv1.items;
      let capacity1 = inv1.capacity;
      let items2 = inv2.items;
      let capacity2 = inv2.capacity;

      // Apply swapped values
      inv1.items = items2;
      inv1.capacity = capacity2;
      inv2.items = items1;
      inv2.capacity = capacity1;
  }
  ```

### Module `safety::restructure`

```move
struct Account has drop {
    balance: u64,
    pending: u64,
    locked: bool
}
```

- **`available_balance`** — read-only through an immutable reference:

  ```move
  public fun available_balance(account: &Account): u64 {
      account.balance - account.pending
  }
  ```

- **`process_pending`** — extract `pending` first, then modify:

  ```move
  public fun process_pending(account: &mut Account) {
      let pending_amount = account.pending;
      account.balance = account.balance + pending_amount;
      account.pending = 0;
  }
  ```

- **`emergency_lock`** — modify several fields through one mutable reference (balance left alone):

  ```move
  public fun emergency_lock(account: &mut Account) {
      account.locked = true;
      account.pending = 0;
      // balance intentionally unchanged
  }
  ```

- **`transfer_pending`** — extract from the source before touching either account:

  ```move
  public fun transfer_pending(from: &mut Account, to: &mut Account) {
      // Extract the pending amount first
      let amount = from.pending;

      // Now modify both accounts
      from.pending = 0;
      to.balance = to.balance + amount;
  }
  ```

- **`consolidate_both`** — finish one account completely before starting the next:

  ```move
  public fun consolidate_both(acc1: &mut Account, acc2: &mut Account) {
      // Process first account completely
      let pending1 = acc1.pending;
      acc1.balance = acc1.balance + pending1;
      acc1.pending = 0;

      // Process second account completely
      let pending2 = acc2.pending;
      acc2.balance = acc2.balance + pending2;
      acc2.pending = 0;
  }
  ```

### Module `safety::patterns`

```move
struct Vault has drop {
    gold: u64,
    silver: u64,
    is_open: bool
}
```

- **`new_vault`** — open by default:

  ```move
  public fun new_vault(gold: u64, silver: u64): Vault {
      Vault {
          gold,
          silver,
          is_open: true
      }
  }
  ```

- **`total_value`** — read-only valuation (`gold * 10 + silver`):

  ```move
  public fun total_value(vault: &Vault): u64 {
      (vault.gold * 10) + vault.silver
  }
  ```

- **`deposit_gold`** — check-then-modify through a single reference:

  ```move
  public fun deposit_gold(vault: &mut Vault, amount: u64): bool {
      if (!vault.is_open) {
          return false
      };

      vault.gold = vault.gold + amount;
      true
  }
  ```

- **`withdraw_silver`** — multiple conditions, one modification:

  ```move
  public fun withdraw_silver(vault: &mut Vault, amount: u64): bool {
      if (!vault.is_open) {
          return false
      };

      if (vault.silver < amount) {
          return false
      };

      vault.silver = vault.silver - amount;
      true
  }
  ```

- **`exchange_gold_for_silver`** — compute new values, then apply (1 gold = 10 silver):

  ```move
  public fun exchange_gold_for_silver(vault: &mut Vault, gold_amount: u64): bool {
      // Check if vault has enough gold
      if (vault.gold < gold_amount) {
          return false
      };

      // Calculate silver to receive
      let silver_received = gold_amount * 10;

      // Apply changes
      vault.gold = vault.gold - gold_amount;
      vault.silver = vault.silver + silver_received;
      true
  }
  ```

- **`close_and_empty`** — extract values, modify state, return the extracted values:

  ```move
  public fun close_and_empty(vault: &mut Vault): (u64, u64) {
      // Extract current values
      let gold = vault.gold;
      let silver = vault.silver;

      // Modify vault state
      vault.gold = 0;
      vault.silver = 0;
      vault.is_open = false;

      // Return extracted values
      (gold, silver)
  }
  ```

- **`merge_vaults`** — extract from the source, add to the destination, then zero the source:

  ```move
  public fun merge_vaults(dest: &mut Vault, source: &mut Vault) {
      // Extract values from source
      let source_gold = source.gold;
      let source_silver = source.silver;

      // Add to destination
      dest.gold = dest.gold + source_gold;
      dest.silver = dest.silver + source_silver;

      // Zero out source
      source.gold = 0;
      source.silver = 0;
  }
  ```

- **(Optional / bonus)** The instructor solution includes a thorough `#[test]` suite in every module (success, boundary, and "unchanged on failure" cases). Reproducing them is excellent practice but not required for the core lesson.

### Breakdown for learners

**Reference-safety rules** prevent data races and ensure memory safety. Move's borrow
checker enforces them at compile time.

**Key aliasing rules:**

- You can have **multiple immutable references** (`&T`) to the same data.
- You can have **only one mutable reference** (`&mut T`) at a time.
- You **cannot** hold a mutable reference while any immutable reference exists.

**The "extract then modify" pattern** (used in every function above):

1. Read all the values you need into local variables.
2. Run your checks against those locals.
3. Then perform the writes through the mutable reference.

**Why three modules?**

- `aliasing_fix` shows the raw pattern on a two-field `Inventory`.
- `restructure` shows it across multi-field `Account` updates and across two accounts at once.
- `patterns` shows the read-only (`&Vault`) vs. check-then-modify (`&mut Vault`) split, plus extracting-and-returning values from `close_and_empty`.

**Why this matters:** prevents data races, catches errors at compile time, and keeps
ownership and access rules predictable.
