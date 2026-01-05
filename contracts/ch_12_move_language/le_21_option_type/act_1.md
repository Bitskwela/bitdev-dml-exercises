### Smart contract activity

```move
module option_demo::user_registry {
    use std::option::{Self, Option};
    use std::vector;

    // TODO: Define User struct with copy and drop abilities

    /// Creates a new user
    public fun create_user(id: u64, balance: u64): User {
        User { id, balance }
    }

    /// Gets the ID from a user
    public fun get_id(user: &User): u64 {
        user.id
    }

    /// Gets the balance from a user
    public fun get_balance(user: &User): u64 {
        user.balance
    }

    // TODO: Implement find_user function

    // TODO: Implement get_user_balance function

    // TODO: Implement find_highest_balance function
}
```

## Tasks for Learners

- Define the `User` struct with `copy` and `drop` abilities:

  - Fields: `id: u64`, `balance: u64`

  ```move
  struct User has copy, drop {
      id: u64,
      balance: u64,
  }
  ```

- Implement `find_user` to search for a user by ID, returning `Option<User>`:

  - If user with matching ID is found, return `option::some(user)`
  - If no user matches, return `option::none()`

  ```move
  public fun find_user(users: &vector<User>, target_id: u64): Option<User> {
      let mut i = 0;
      let len = vector::length(users);
      while (i < len) {
          let user = *vector::borrow(users, i);
          if (user.id == target_id) {
              return option::some(user)
          };
          i = i + 1;
      };
      option::none()
  }
  ```

- Implement `get_user_balance` to get a user's balance with a default value:

  - If user exists, return their balance
  - If user doesn't exist, return 0

  ```move
  public fun get_user_balance(users: &vector<User>, user_id: u64): u64 {
      let user_opt = find_user(users, user_id);
      if (option::is_some(&user_opt)) {
          let user = option::destroy_some(user_opt);
          user.balance
      } else {
          option::destroy_none(user_opt);
          0
      }
  }
  ```

- Implement `find_highest_balance` to find the user with the highest balance:

  - If vector is empty, return `option::none()`
  - If vector has users, return `option::some(user)` with highest balance

  ```move
  public fun find_highest_balance(users: &vector<User>): Option<User> {
      let len = vector::length(users);
      if (len == 0) {
          return option::none()
      };

      let mut highest = *vector::borrow(users, 0);
      let mut i = 1;
      while (i < len) {
          let user = *vector::borrow(users, i);
          if (user.balance > highest.balance) {
              highest = user;
          };
          i = i + 1;
      };
      option::some(highest)
  }
  ```

### Breakdown for learners

- Option Type:

  - `Option<T>` represents a value that may or may not exist
  - Defined in `std::option` module
  - Forces explicit handling of "not found" cases

- Creating Option Values:

  - `option::some(value)` - wraps a value in Option
  - `option::none()` - creates an empty Option

- Checking Option State:

  - `option::is_some(&opt)` - returns true if Option contains a value
  - `option::is_none(&opt)` - returns true if Option is empty

- Extracting Values:

  - `option::destroy_some(opt)` - extracts value, aborts if none
  - `option::destroy_none(opt)` - destroys empty option, aborts if some
  - `option::destroy_with_default(opt, default)` - extracts value or returns default

- Pattern for Safe Lookups:

  - Return `Option<T>` from search functions
  - Caller must check `is_some`/`is_none` before extracting
  - Provides compile-time safety for nullable values
