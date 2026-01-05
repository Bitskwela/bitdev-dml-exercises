# Access Control in Move

Odessa was setting up a new governance system when Mike joined her at the workstation.

"Odessa, I'm worried about security. How do we make sure only authorized users can perform certain actions?" Mike asked.

Odessa smiled. "Great question! **Access control** is fundamental to smart contract security. Let me show you the patterns we use in Move."

---

## The Basics of Access Control

In Move, access control revolves around **signers**, **capabilities**, and **resource ownership**.

```move
module access::basic_admin {
    use std::signer;

    /// Error codes
    const E_NOT_ADMIN: u64 = 1;
    const E_NOT_INITIALIZED: u64 = 2;

    /// Stores the admin address
    struct AdminConfig has key {
        admin: address,
    }

    /// Initialize with deployer as admin
    public entry fun initialize(deployer: &signer) {
        let admin_addr = signer::address_of(deployer);
        move_to(deployer, AdminConfig {
            admin: admin_addr,
        });
    }

    /// Check if caller is admin
    public fun is_admin(addr: address): bool acquires AdminConfig {
        let config = borrow_global<AdminConfig>(@access);
        config.admin == addr
    }

    /// Only admin can call this
    public entry fun admin_only_action(caller: &signer) acquires AdminConfig {
        let caller_addr = signer::address_of(caller);
        assert!(is_admin(caller_addr), E_NOT_ADMIN);

        // Perform privileged action
    }
}
```

Mike nodded. "So we store who the admin is, then check before each action?"

"Exactly! But we can do much more sophisticated things," Odessa replied.

---

## Role-Based Access Control (RBAC)

For complex systems, we need multiple roles:

```move
module access::role_based {
    use std::signer;
    use aptos_std::table::{Self, Table};

    const E_NOT_AUTHORIZED: u64 = 1;
    const E_ROLE_EXISTS: u64 = 2;
    const E_ROLE_NOT_FOUND: u64 = 3;

    /// Role identifiers
    const ROLE_ADMIN: u64 = 0;
    const ROLE_MODERATOR: u64 = 1;
    const ROLE_OPERATOR: u64 = 2;

    struct RoleManager has key {
        roles: Table<address, u64>,
        super_admin: address,
    }

    public entry fun initialize(deployer: &signer) {
        let deployer_addr = signer::address_of(deployer);
        let roles = table::new<address, u64>();
        table::add(&mut roles, deployer_addr, ROLE_ADMIN);

        move_to(deployer, RoleManager {
            roles,
            super_admin: deployer_addr,
        });
    }

    public entry fun grant_role(
        admin: &signer,
        user: address,
        role: u64
    ) acquires RoleManager {
        let admin_addr = signer::address_of(admin);
        let manager = borrow_global_mut<RoleManager>(@access);

        // Only admin can grant roles
        assert!(has_role_internal(manager, admin_addr, ROLE_ADMIN), E_NOT_AUTHORIZED);
        assert!(!table::contains(&manager.roles, user), E_ROLE_EXISTS);

        table::add(&mut manager.roles, user, role);
    }

    public entry fun revoke_role(
        admin: &signer,
        user: address
    ) acquires RoleManager {
        let admin_addr = signer::address_of(admin);
        let manager = borrow_global_mut<RoleManager>(@access);

        assert!(has_role_internal(manager, admin_addr, ROLE_ADMIN), E_NOT_AUTHORIZED);
        assert!(table::contains(&manager.roles, user), E_ROLE_NOT_FOUND);
        assert!(user != manager.super_admin, E_NOT_AUTHORIZED); // Can't revoke super admin

        table::remove(&mut manager.roles, user);
    }

    fun has_role_internal(manager: &RoleManager, user: address, role: u64): bool {
        if (!table::contains(&manager.roles, user)) {
            return false
        };
        *table::borrow(&manager.roles, user) == role
    }

    public fun has_role(user: address, role: u64): bool acquires RoleManager {
        let manager = borrow_global<RoleManager>(@access);
        has_role_internal(manager, user, role)
    }
}
```

---

## Capability Pattern

"What about temporary permissions?" Mike asked.

Odessa showed him the capability pattern:

```move
module access::capability_pattern {
    use std::signer;

    const E_NOT_AUTHORIZED: u64 = 1;

    /// Capability that grants minting rights
    struct MintCapability has key, store {
        max_amount: u64,
    }

    /// Admin capability - only one exists
    struct AdminCapability has key {
        holder: address,
    }

    /// Grant mint capability to a user
    public entry fun grant_mint_capability(
        admin: &signer,
        recipient: &signer,
        max_amount: u64
    ) acquires AdminCapability {
        let admin_addr = signer::address_of(admin);
        let cap = borrow_global<AdminCapability>(@access);
        assert!(cap.holder == admin_addr, E_NOT_AUTHORIZED);

        move_to(recipient, MintCapability { max_amount });
    }

    /// Use mint capability
    public entry fun mint_with_capability(
        minter: &signer,
        amount: u64
    ) acquires MintCapability {
        let minter_addr = signer::address_of(minter);
        let cap = borrow_global<MintCapability>(minter_addr);

        assert!(amount <= cap.max_amount, E_NOT_AUTHORIZED);

        // Perform minting...
    }

    /// Revoke by having user destroy their capability
    public entry fun revoke_own_capability(user: &signer) acquires MintCapability {
        let user_addr = signer::address_of(user);
        let MintCapability { max_amount: _ } = move_from<MintCapability>(user_addr);
    }
}
```

---

## Multi-Signature Pattern

For critical operations, require multiple approvals:

```move
module access::multisig {
    use std::signer;
    use std::vector;

    const E_NOT_SIGNER: u64 = 1;
    const E_ALREADY_SIGNED: u64 = 2;
    const E_NOT_ENOUGH_SIGNATURES: u64 = 3;

    struct MultiSigAction has key {
        required_signatures: u64,
        signers: vector<address>,
        current_signatures: vector<address>,
        executed: bool,
    }

    public fun has_signed(action: &MultiSigAction, addr: address): bool {
        vector::contains(&action.current_signatures, &addr)
    }

    public entry fun sign_action(signer_account: &signer) acquires MultiSigAction {
        let signer_addr = signer::address_of(signer_account);
        let action = borrow_global_mut<MultiSigAction>(@access);

        assert!(vector::contains(&action.signers, &signer_addr), E_NOT_SIGNER);
        assert!(!has_signed(action, signer_addr), E_ALREADY_SIGNED);

        vector::push_back(&mut action.current_signatures, signer_addr);
    }

    public entry fun execute_action(caller: &signer) acquires MultiSigAction {
        let action = borrow_global_mut<MultiSigAction>(@access);
        let sig_count = vector::length(&action.current_signatures);

        assert!(sig_count >= action.required_signatures, E_NOT_ENOUGH_SIGNATURES);

        action.executed = true;
        // Execute the privileged action...
    }
}
```

---

## Best Practices

Mike was impressed as Odessa summarized:

1. **Principle of least privilege** - Grant minimum necessary permissions
2. **Use capabilities for fine-grained control** - Better than simple role checks
3. **Implement role hierarchies carefully** - Avoid circular dependencies
4. **Always validate the signer** - Never trust input addresses alone
5. **Consider time-locked operations** - For sensitive changes
6. **Emit events for auditing** - Track all permission changes

"Security isn't just about preventing attacks," Odessa concluded. "It's about designing systems where mistakes are hard to make."

Mike grinned. "Time to lock down our contracts!"
