### Smart contract activity

```move
module movestack::access_control {

    /// Role constants
    const ROLE_GUEST: u8 = 0;
    const ROLE_MEMBER: u8 = 1;
    const ROLE_ADMIN: u8 = 2;

    /// Returns a role identifier based on role code
    public fun get_role_name(role: u8): u8 {
        // TODO: Implement if/else chain
    }

    /// Checks if user can access a feature (must be active AND have required role)
    public fun can_access_feature(user_role: u8, required_role: u8, is_active: bool): bool {
        // TODO: Implement using logical operators
    }

    /// Calculate access level based on role and verification status
    public fun get_access_level(role: u8, is_active: bool, is_verified: bool): u64 {
        // TODO: Implement nested conditionals
    }

    /// Calculate permission score with multiple bonus conditions
    public fun calculate_permission_score(role: u8, is_active: bool, is_verified: bool, account_age_days: u64): u64 {
        // TODO: Implement complex conditional logic
    }
}
```

## Tasks for Learners

- Implement `get_role_name` using an if/else if/else chain to return a role identifier:

  - Role 0 returns 0 (Guest)
  - Role 1 returns 1 (Member)
  - Role 2 returns 2 (Admin)
  - Any other value returns 0 (default to Guest)

  ```move
  public fun get_role_name(role: u8): u8 {
      if (role == 0) {
          0
      } else if (role == 1) {
          1
      } else if (role == 2) {
          2
      } else {
          0
      }
  }
  ```

- Implement `can_access_feature` using logical operators to combine conditions:

  - User must be active AND have at least the required role level
  - Return true only if both conditions are met

  ```move
  public fun can_access_feature(user_role: u8, required_role: u8, is_active: bool): bool {
      is_active && user_role >= required_role
  }
  ```

- Implement `get_access_level` with nested conditionals based on role and verification:

  - Inactive users always get 0
  - Active guests get 10
  - Active members: 30 if verified, 20 if not
  - Active admins: 100 if verified, 50 if not

  ```move
  public fun get_access_level(role: u8, is_active: bool, is_verified: bool): u64 {
      if (!is_active) {
          0
      } else if (role == ROLE_GUEST) {
          10
      } else if (role == ROLE_MEMBER) {
          if (is_verified) { 30 } else { 20 }
      } else if (role == ROLE_ADMIN) {
          if (is_verified) { 100 } else { 50 }
      } else {
          0
      }
  }
  ```

- Implement `calculate_permission_score` with complex conditional logic:

  - Return 0 if not active
  - Base score depends on role (guest=10, member=50, admin=100)
  - Add 25 bonus if verified
  - Add 15 bonus if account age >= 30 days

  ```move
  public fun calculate_permission_score(role: u8, is_active: bool, is_verified: bool, account_age_days: u64): u64 {
      if (!is_active) {
          return 0
      };

      let base_score = if (role == ROLE_GUEST) {
          10
      } else if (role == ROLE_MEMBER) {
          50
      } else if (role == ROLE_ADMIN) {
          100
      } else {
          10
      };

      let mut score = base_score;
      if (is_verified) {
          score = score + 25;
      };
      if (account_age_days >= 30) {
          score = score + 15;
      };
      score
  }
  ```

### Breakdown for learners

- If Expressions in Move:

  - `if` expressions return values and can be used inline
  - Syntax: `if (condition) { value1 } else { value2 }`
  - No parentheses required around condition, but commonly used for clarity

- If/Else Chains:

  - Chain multiple conditions with `else if`
  - Always provide an `else` branch for exhaustive matching
  - Each branch must return the same type

- Logical Operators:

  - `&&` (AND): Both conditions must be true
  - `||` (OR): At least one condition must be true
  - `!` (NOT): Negates the boolean value

- Nested Conditionals:

  - Conditionals can be nested inside other conditionals
  - Useful for complex decision trees
  - Keep nesting shallow for readability

- Early Returns:

  - Use `return` to exit early from a function
  - Useful for guard clauses (e.g., checking if active first)
