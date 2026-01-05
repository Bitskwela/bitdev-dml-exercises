module treasury::role_treasury {
    use std::signer;

    /// Role: Full access to all operations
    const ROLE_ADMIN: u64 = 0;
    /// Role: Can withdraw funds
    const ROLE_OPERATOR: u64 = 1;
    /// Role: Can only view balance
    const ROLE_VIEWER: u64 = 2;

    /// Error: Caller is not an admin
    const E_NOT_ADMIN: u64 = 1;
    /// Error: Caller does not have required role
    const E_NOT_AUTHORIZED: u64 = 2;
    /// Error: Treasury has insufficient balance
    const E_INSUFFICIENT_BALANCE: u64 = 3;

    /// Treasury resource holding funds
    struct Treasury has key {
        balance: u64,
        admin: address,
    }

    /// Role assignment for a user
    struct Role has key {
        role_type: u64,
    }

    /// Initialize the treasury with an admin and initial balance
    public entry fun initialize(admin: &signer, initial_balance: u64) {
        let admin_addr = signer::address_of(admin);

        // Create the treasury
        move_to(admin, Treasury {
            balance: initial_balance,
            admin: admin_addr,
        });

        // Assign admin role to the initializer
        move_to(admin, Role {
            role_type: ROLE_ADMIN,
        });
    }

    /// Grant a role to a user (admin only)
    public entry fun grant_role(
        admin: &signer,
        user: &signer,
        role_type: u64
    ) acquires Role {
        let admin_addr = signer::address_of(admin);

        // Verify caller is admin
        assert!(exists<Role>(admin_addr), E_NOT_ADMIN);
        let admin_role = borrow_global<Role>(admin_addr);
        assert!(admin_role.role_type == ROLE_ADMIN, E_NOT_ADMIN);

        // Assign role to user
        move_to(user, Role {
            role_type,
        });
    }

    /// Withdraw funds from treasury (admin or operator only)
    public fun withdraw(operator: &signer, amount: u64): u64 acquires Treasury, Role {
        let operator_addr = signer::address_of(operator);

        // Check caller has admin or operator role
        assert!(exists<Role>(operator_addr), E_NOT_AUTHORIZED);
        let role = borrow_global<Role>(operator_addr);
        assert!(
            role.role_type == ROLE_ADMIN || role.role_type == ROLE_OPERATOR,
            E_NOT_AUTHORIZED
        );

        // Get treasury and check balance
        let treasury = borrow_global_mut<Treasury>(@treasury);
        assert!(treasury.balance >= amount, E_INSUFFICIENT_BALANCE);

        // Perform withdrawal
        treasury.balance = treasury.balance - amount;
        amount
    }

    /// Get treasury balance (any role can view)
    public fun get_balance(viewer: &signer): u64 acquires Treasury, Role {
        let viewer_addr = signer::address_of(viewer);

        // Check caller has any valid role
        assert!(exists<Role>(viewer_addr), E_NOT_AUTHORIZED);
        let role = borrow_global<Role>(viewer_addr);
        assert!(
            role.role_type == ROLE_ADMIN ||
            role.role_type == ROLE_OPERATOR ||
            role.role_type == ROLE_VIEWER,
            E_NOT_AUTHORIZED
        );

        // Return balance
        let treasury = borrow_global<Treasury>(@treasury);
        treasury.balance
    }
}
