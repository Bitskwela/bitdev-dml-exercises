# Module Visibility

## Scene

The Barangay Hall's administrative building had been reorganized after the recent security improvements. Ronnie stood in the newly established "Operations Center," a room filled with filing cabinets, each marked with different access levels.

"Neri, you've done excellent work implementing the acquires system," Ronnie said, gesturing to the organized cabinets. "But we have a new challenge. Not every function in our modules should be accessible to everyone."

Neri examined the cabinet labels: "PUBLIC ACCESS," "STAFF ONLY," "AUTHORIZED PARTNERS."

"Think of it like our Barangay services," Ronnie continued. "Some services are open to all residents—anyone can request a barangay clearance. Other services are only for internal staff—like updating the master resident list. And some services are shared only with trusted partner organizations—like the health center accessing vaccination records."

"So functions can have different visibility levels?" Neri asked.

Ronnie nodded. "Exactly. In Move, we control who can call our functions using visibility modifiers. This is fundamental to building secure, well-organized modules."

---

## Topics

### 1. Private Functions (Default Visibility)

By default, all functions in Move are private. They can only be called from within the same module.

```move
module barangay::internal_ops {
    // Private function - only callable within this module
    fun calculate_internal_fee(amount: u64): u64 {
        amount * 5 / 100  // 5% internal processing fee
    }

    // Another private function using the first one
    fun process_internal_request(amount: u64): u64 {
        let fee = calculate_internal_fee(amount);
        amount - fee
    }
}
```

**Key Points:**

- No modifier needed—private is the default
- Cannot be called from other modules
- Cannot be called from transactions directly
- Ideal for internal helper functions and implementation details

### 2. Public Functions

Public functions can be called from any other module or from transactions.

```move
module barangay::public_services {
    use std::signer;

    struct ServiceRecord has key {
        request_count: u64
    }

    // Public function - callable from anywhere
    public fun request_clearance(resident: &signer): u64 {
        let resident_addr = signer::address_of(resident);
        // Process clearance request
        // Return request ID
        generate_request_id(resident_addr)
    }

    // Public function for querying
    public fun get_service_status(request_id: u64): bool {
        // Check if request is complete
        request_id > 0
    }

    // Private helper - not accessible outside
    fun generate_request_id(addr: address): u64 {
        // Internal logic
        (addr as u64) % 10000
    }
}
```

**Key Points:**

- Marked with `public` keyword
- Callable from any module in any package
- Callable directly from transactions (entry points)
- Forms the external API of your module

### 3. Public(friend) Functions

Public(friend) functions are only callable by modules explicitly declared as friends.

```move
module barangay::resident_records {
    friend barangay::health_center;
    friend barangay::social_services;

    struct ResidentData has key {
        name: vector<u8>,
        age: u64,
        health_status: u8
    }

    // Only friend modules can call this
    public(friend) fun get_resident_health_data(
        resident_addr: address
    ): u8 acquires ResidentData {
        let data = borrow_global<ResidentData>(resident_addr);
        data.health_status
    }

    // Public - anyone can call
    public fun get_resident_name(
        resident_addr: address
    ): vector<u8> acquires ResidentData {
        let data = borrow_global<ResidentData>(resident_addr);
        data.name
    }

    // Private - only this module
    fun update_internal_records(addr: address, status: u8) acquires ResidentData {
        let data = borrow_global_mut<ResidentData>(addr);
        data.health_status = status;
    }
}
```

**Key Points:**

- Marked with `public(friend)` keyword
- Requires `friend` declarations at the top of the module
- Only declared friend modules can call these functions
- Cannot be called from transactions directly
- Perfect for controlled sharing between trusted modules

### 4. Visibility Comparison

```move
module barangay::visibility_example {
    friend barangay::partner_module;

    struct Example has key { value: u64 }

    // PRIVATE: Only this module can call
    fun internal_only(): u64 {
        42
    }

    // PUBLIC(FRIEND): Only friend modules can call
    public(friend) fun partner_access(): u64 {
        internal_only()  // Can call private functions
    }

    // PUBLIC: Anyone can call
    public fun open_access(): u64 {
        partner_access()  // Can call friend functions from within
    }
}

module barangay::partner_module {
    use barangay::visibility_example;

    public fun use_partner_access(): u64 {
        // ✓ Can call public(friend) - we are a friend
        visibility_example::partner_access()
    }

    public fun use_open_access(): u64 {
        // ✓ Can call public - anyone can
        visibility_example::open_access()
    }

    // ✗ Cannot call visibility_example::internal_only() - it's private
}

module barangay::random_module {
    use barangay::visibility_example;

    public fun try_access(): u64 {
        // ✓ Can call public
        visibility_example::open_access()

        // ✗ Cannot call visibility_example::partner_access() - not a friend
        // ✗ Cannot call visibility_example::internal_only() - it's private
    }
}
```

### 5. Entry Functions and Visibility

Entry functions have special visibility rules:

```move
module barangay::transaction_handlers {
    use std::signer;

    struct UserBalance has key {
        amount: u64
    }

    // Entry + Public: Can be called from transactions AND other modules
    public entry fun deposit(account: &signer, amount: u64) acquires UserBalance {
        let addr = signer::address_of(account);
        if (exists<UserBalance>(addr)) {
            let balance = borrow_global_mut<UserBalance>(addr);
            balance.amount = balance.amount + amount;
        } else {
            move_to(account, UserBalance { amount });
        }
    }

    // Entry only (private): Can ONLY be called from transactions
    entry fun admin_reset(admin: &signer, target: address) acquires UserBalance {
        // Only direct transaction can trigger this
        let balance = borrow_global_mut<UserBalance>(target);
        balance.amount = 0;
    }

    // Public only: Can be called from modules, but not as transaction entry
    public fun get_balance(addr: address): u64 acquires UserBalance {
        if (exists<UserBalance>(addr)) {
            borrow_global<UserBalance>(addr).amount
        } else {
            0
        }
    }
}
```

### 6. Visibility Best Practices

```move
module barangay::secure_treasury {
    friend barangay::approved_spender;

    struct Treasury has key {
        funds: u64,
        admin: address
    }

    // PRIVATE: Internal calculations nobody else needs
    fun calculate_tax(amount: u64): u64 {
        amount * 3 / 100
    }

    // PRIVATE: Sensitive operations
    fun deduct_funds(treasury: &mut Treasury, amount: u64) {
        assert!(treasury.funds >= amount, 1);
        treasury.funds = treasury.funds - amount;
    }

    // PUBLIC(FRIEND): Trusted modules can spend
    public(friend) fun authorized_spend(
        treasury_addr: address,
        amount: u64
    ) acquires Treasury {
        let treasury = borrow_global_mut<Treasury>(treasury_addr);
        deduct_funds(treasury, amount);
    }

    // PUBLIC: Anyone can check balance
    public fun get_treasury_balance(addr: address): u64 acquires Treasury {
        borrow_global<Treasury>(addr).funds
    }

    // PUBLIC ENTRY: Anyone can donate
    public entry fun donate(
        donor: &signer,
        treasury_addr: address,
        amount: u64
    ) acquires Treasury {
        let treasury = borrow_global_mut<Treasury>(treasury_addr);
        treasury.funds = treasury.funds + amount;
    }
}
```

**Design Principles:**

1. **Start private** - Make functions private by default
2. **Expose minimally** - Only make public what needs to be public
3. **Use friend for partners** - Share with trusted modules via public(friend)
4. **Protect sensitive operations** - Keep critical logic private

---

## Closing Scene

Neri reorganized the whiteboard, drawing three circles representing the visibility levels.

"So private functions are like our internal staff procedures—only we use them. Public functions are like our community services—open to everyone. And public(friend) functions are like our partnership agreements—shared only with approved organizations."

"Perfect analogy," Ronnie said. "Remember, visibility is about trust and security. The less you expose, the smaller your attack surface. Public(friend) gives you a middle ground—sharing functionality without opening it to the entire world."

"This will help me design modules that are both useful AND secure," Neri said confidently.

---

## Summary

| Visibility     | Keyword          | Callable From            | Use Case                                   |
| -------------- | ---------------- | ------------------------ | ------------------------------------------ |
| Private        | (none)           | Same module only         | Internal helpers, sensitive logic          |
| Public(friend) | `public(friend)` | Declared friend modules  | Controlled sharing between trusted modules |
| Public         | `public`         | Any module, transactions | External API, general access               |
| Entry          | `entry`          | Transactions only        | Transaction entry points                   |
| Public Entry   | `public entry`   | Modules and transactions | Flexible entry points                      |

**Key Takeaways:**

- Default visibility is private—functions are hidden by default
- Use `public` for your module's external API
- Use `public(friend)` for controlled access between modules
- Combine `entry` with visibility for transaction entry points
- Follow the principle of least privilege—expose only what's necessary
