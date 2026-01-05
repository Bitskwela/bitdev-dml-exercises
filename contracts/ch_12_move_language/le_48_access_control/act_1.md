# Activity 1: Building a Role-Based Treasury

Mike came to Odessa with a new project. "We need a treasury system where different roles can perform different actions. Admins can do everything, operators can withdraw up to a limit, and viewers can only check balances."

Odessa nodded. "A perfect case for role-based access control. Let's implement it!"

---

## Your Task

Create a module called `role_treasury` that implements a role-based access control system.

### Requirements

1. **Define role constants:**

   - `ROLE_ADMIN: u64 = 0`
   - `ROLE_OPERATOR: u64 = 1`
   - `ROLE_VIEWER: u64 = 2`

2. **Define error codes:**

   - `E_NOT_ADMIN: u64 = 1`
   - `E_NOT_AUTHORIZED: u64 = 2`
   - `E_INSUFFICIENT_BALANCE: u64 = 3`

3. **Create `Treasury` struct** with:

   - `balance: u64`
   - `admin: address`

4. **Create `Role` struct** with:

   - `role_type: u64`

5. **Implement `initialize`** function:

   - Takes `admin: &signer` and `initial_balance: u64`
   - Creates Treasury and assigns admin the ROLE_ADMIN

6. **Implement `grant_role`** function:

   - Takes `admin: &signer`, `user: &signer`, `role_type: u64`
   - Only admin can grant roles
   - Stores Role resource on user's account

7. **Implement `withdraw`** function:

   - Takes `operator: &signer` and `amount: u64`
   - Requires ROLE_ADMIN or ROLE_OPERATOR
   - Checks sufficient balance
   - Returns the withdrawn amount

8. **Implement `get_balance`** function:
   - Takes `viewer: &signer`
   - Requires any role (ADMIN, OPERATOR, or VIEWER)
   - Returns the treasury balance

### Starter Code

```move
module treasury::role_treasury {
    use std::signer;

    // TODO: Define role constants

    // TODO: Define error codes

    // TODO: Define Treasury struct

    // TODO: Define Role struct

    // TODO: Implement initialize function

    // TODO: Implement grant_role function

    // TODO: Implement withdraw function

    // TODO: Implement get_balance function
}
```

### Expected Behavior

```move
// Admin initializes treasury with 10000 balance
initialize(&admin, 10000);

// Admin grants operator role to user1
grant_role(&admin, &user1, ROLE_OPERATOR);

// Admin grants viewer role to user2
grant_role(&admin, &user2, ROLE_VIEWER);

// Operator can withdraw
let amount = withdraw(&user1, 500); // Returns 500

// Viewer can check balance
let balance = get_balance(&user2); // Returns 9500

// Viewer cannot withdraw - should fail with E_NOT_AUTHORIZED
withdraw(&user2, 100); // FAILS
```

Good luck, Mike!
