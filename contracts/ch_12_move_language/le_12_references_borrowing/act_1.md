## Smart contract activity

```move
module movestack::borrowing_practice {
    // ============================================
    // STRUCT DEFINITIONS
    // ============================================

    // TODO: Define 'UserProfile' with:
    //       - id: u64
    //       - reputation: u64
    //       - is_verified: bool

    // TODO: Define 'Transaction' with:
    //       - from_id: u64
    //       - to_id: u64
    //       - amount: u64

    // ============================================
    // BASIC BORROWING FUNCTIONS
    // ============================================

    // TODO: Create 'get_reputation'
    // Takes &UserProfile, returns reputation

    // TODO: Create 'is_trusted_user'
    // Takes &UserProfile, returns true if reputation >= 100 AND is_verified

    // TODO: Create 'get_transaction_amount'
    // Takes &Transaction, returns amount

    // ============================================
    // MULTIPLE BORROWS
    // ============================================

    // TODO: Create 'compare_reputation'
    // Takes two &UserProfile, returns true if first has higher reputation

    // TODO: Create 'is_valid_transaction'
    // Takes &Transaction and &UserProfile
    // Returns true if from_id matches, user is verified, amount > 0

    // ============================================
    // BORROWING WITH OWNERSHIP
    // ============================================

    // TODO: Create 'create_and_check_user'
    // Create UserProfile, borrow it multiple times, return all results

    // TODO: Create 'destroy_user'
    // Takes UserProfile (ownership), destructures and returns reputation
}
```

## Tasks for Learners

- Define structs without abilities. These must be explicitly handled (moved or destructured):

  ```move
  struct UserProfile {
      id: u64,
      reputation: u64,
      is_verified: bool
  }

  struct Transaction {
      from_id: u64,
      to_id: u64,
      amount: u64
  }
  ```

- Create functions that borrow data immutably using `&`. The caller keeps ownership after the function returns:

  ```move
  public fun get_reputation(user: &UserProfile): u64 {
      user.reputation
  }

  public fun is_trusted_user(user: &UserProfile): bool {
      user.reputation >= 100 && user.is_verified
  }

  public fun get_transaction_amount(tx: &Transaction): u64 {
      tx.amount
  }
  ```

- Create functions that take multiple immutable references. Both values remain owned by the caller:

  ```move
  public fun compare_reputation(user_a: &UserProfile, user_b: &UserProfile): bool {
      user_a.reputation > user_b.reputation
  }

  public fun is_valid_transaction(tx: &Transaction, sender: &UserProfile): bool {
      tx.from_id == sender.id &&
      sender.is_verified &&
      tx.amount > 0
  }
  ```

- Demonstrate borrowing the same value multiple times, then returning ownership:

  ```move
  public fun create_and_check_user(): (u64, bool, UserProfile) {
      let user = UserProfile {
          id: 1,
          reputation: 150,
          is_verified: true
      };

      let reputation = get_reputation(&user);
      let is_trusted = is_trusted_user(&user);

      (reputation, is_trusted, user)
  }
  ```

- Create a function that takes ownership (not a reference) to consume the struct:

  ```move
  public fun destroy_user(user: UserProfile): u64 {
      let UserProfile { id: _, reputation, is_verified: _ } = user;
      reputation
  }
  ```

### Breakdown for Learners

**References vs Ownership:** When a function takes `user: UserProfile`, it takes ownership—the caller loses access. When it takes `user: &UserProfile`, it borrows—the caller keeps ownership and can use the value again.

**Immutable References (`&`):** The `&` symbol creates an immutable reference. You can read fields but not modify them. Multiple immutable references to the same value can exist simultaneously.

**When to Borrow:** Use references when you only need to read data. This is more efficient and allows the caller to continue using their value. Only take ownership when you need to consume or store the value.

**Field Access:** Access fields through a reference using dot notation: `user.reputation`. This works the same whether you own the value or are borrowing it.

**Multiple Borrows:** You can borrow the same value multiple times in sequence. Each borrow is temporary—once the function returns, the borrow ends and you can borrow again or transfer ownership.
