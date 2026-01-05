# Security Capstone

## The Final Review

Odessa gathered the full team for their final security training. "Everything we've learned comes together here," she said. "Before any module goes live, it must pass our security checklist."

The team—Salvo, Neri, Dante, and the others—listened intently. This was the culmination of their journey.

## The Move Security Checklist

### 1. Access Control

```move
module access_control_checklist {
    use std::signer;

    struct AdminCap has key, store {}

    struct ProtectedResource has key {
        sensitive_data: u64,
        owner: address,
    }

    // ✅ GOOD: Verify signer owns the resource
    public fun update_own_resource(
        account: &signer,
        new_value: u64
    ) acquires ProtectedResource {
        let addr = signer::address_of(account);
        assert!(exists<ProtectedResource>(addr), 1);
        let resource = borrow_global_mut<ProtectedResource>(addr);
        assert!(resource.owner == addr, 2);  // Double-check ownership
        resource.sensitive_data = new_value;
    }

    // ✅ GOOD: Use capability pattern for admin functions
    public fun admin_function(
        _admin_cap: &AdminCap,
        target: address
    ) acquires ProtectedResource {
        // Only holders of AdminCap can call this
        let resource = borrow_global_mut<ProtectedResource>(target);
        resource.sensitive_data = 0;
    }
}
```

**Checklist Items:**

- [ ] All sensitive functions require signer verification
- [ ] Capability pattern used for privileged operations
- [ ] No public functions expose admin-only logic
- [ ] Resource ownership verified before modification

### 2. Integer Safety

```move
module integer_safety_checklist {
    // ✅ GOOD: Check for overflow before arithmetic
    public fun safe_add(a: u64, b: u64): u64 {
        let max = 18446744073709551615u64;  // Max u64
        assert!(a <= max - b, 1);  // Overflow check
        a + b
    }

    // ✅ GOOD: Check for underflow before subtraction
    public fun safe_subtract(a: u64, b: u64): u64 {
        assert!(a >= b, 2);  // Underflow check
        a - b
    }

    // ✅ GOOD: Check for division by zero
    public fun safe_divide(a: u64, b: u64): u64 {
        assert!(b != 0, 3);  // Division by zero check
        a / b
    }
}
```

**Checklist Items:**

- [ ] All arithmetic operations checked for overflow
- [ ] Subtraction checked for underflow
- [ ] Division checked for zero divisor
- [ ] Multiplication overflow considered

### 3. Resource Safety

```move
module resource_safety_checklist {
    use std::signer;

    struct UniqueAsset has key {
        id: u64,
        value: u64,
    }

    // ✅ GOOD: Ensure resource doesn't already exist
    public fun create_asset(account: &signer, id: u64, value: u64) {
        let addr = signer::address_of(account);
        assert!(!exists<UniqueAsset>(addr), 1);  // Prevent duplicate
        move_to(account, UniqueAsset { id, value });
    }

    // ✅ GOOD: Properly destroy resources
    public fun destroy_asset(account: &signer): (u64, u64) acquires UniqueAsset {
        let addr = signer::address_of(account);
        assert!(exists<UniqueAsset>(addr), 2);
        let UniqueAsset { id, value } = move_from<UniqueAsset>(addr);
        (id, value)  // Return values, resource is destroyed
    }
}
```

**Checklist Items:**

- [ ] Resources checked with `exists` before creation
- [ ] Resources properly destroyed (not abandoned)
- [ ] No resource duplication possible
- [ ] All resource fields properly initialized

### 4. Input Validation

```move
module input_validation_checklist {
    use std::vector;

    const MAX_NAME_LENGTH: u64 = 64;
    const MIN_AMOUNT: u64 = 1;
    const MAX_AMOUNT: u64 = 1000000;

    // ✅ GOOD: Validate all inputs
    public fun process_input(
        name: vector<u8>,
        amount: u64,
        recipient: address
    ) {
        // Validate name length
        let name_len = vector::length(&name);
        assert!(name_len > 0 && name_len <= MAX_NAME_LENGTH, 1);

        // Validate amount range
        assert!(amount >= MIN_AMOUNT && amount <= MAX_AMOUNT, 2);

        // Validate address (non-zero)
        assert!(recipient != @0x0, 3);

        // Process validated input...
    }
}
```

**Checklist Items:**

- [ ] All vector lengths validated
- [ ] Numeric ranges enforced
- [ ] Address validation performed
- [ ] Empty/null checks applied

### 5. Reentrancy Prevention

```move
module reentrancy_checklist {
    use std::signer;

    struct Vault has key {
        balance: u64,
        locked: bool,  // Reentrancy guard
    }

    // ✅ GOOD: Use reentrancy guard
    public fun withdraw(account: &signer, amount: u64) acquires Vault {
        let addr = signer::address_of(account);
        let vault = borrow_global_mut<Vault>(addr);

        // Check lock
        assert!(!vault.locked, 1);

        // Set lock
        vault.locked = true;

        // Validate
        assert!(vault.balance >= amount, 2);

        // Update state BEFORE external calls
        vault.balance = vault.balance - amount;

        // External operations would go here...

        // Release lock
        vault.locked = false;
    }
}
```

**Checklist Items:**

- [ ] State updated before external calls
- [ ] Reentrancy guards for sensitive functions
- [ ] Checks-Effects-Interactions pattern followed

## Common Vulnerabilities Summary

Odessa displayed the vulnerability matrix:

| Vulnerability              | Prevention                        | Severity |
| -------------------------- | --------------------------------- | -------- |
| Missing access control     | Signer verification, capabilities | Critical |
| Integer overflow/underflow | Safe math, assertions             | High     |
| Resource duplication       | Existence checks                  | Critical |
| Unvalidated input          | Input validation, bounds checking | High     |
| Reentrancy                 | Guards, state-first updates       | Critical |
| Front-running              | Commit-reveal, time locks         | Medium   |
| Denial of Service          | Gas limits, iteration bounds      | Medium   |

## Security Review Process

```
┌─────────────────────────────────────────────────────┐
│           SECURITY REVIEW WORKFLOW                   │
├─────────────────────────────────────────────────────┤
│                                                      │
│  1. Static Analysis                                  │
│     └── Check all functions against checklist        │
│                                                      │
│  2. Access Control Audit                             │
│     └── Map all entry points and permissions         │
│                                                      │
│  3. Data Flow Analysis                               │
│     └── Trace sensitive data through the system      │
│                                                      │
│  4. Edge Case Testing                                │
│     └── Test boundary conditions and error paths     │
│                                                      │
│  5. Integration Review                               │
│     └── Check interactions with other modules        │
│                                                      │
└─────────────────────────────────────────────────────┘
```

## Final Wisdom

Odessa concluded the training:

"Security is not a feature—it's a foundation. Every line of code we write affects real people and real assets. The checklist isn't bureaucracy; it's discipline."

The team understood. They were ready.

Salvo added: "And remember, optimization without security is just making bad code run faster."

Neri smiled: "We've come a long way since those early lessons."

"Indeed," Odessa agreed. "Now let's put it all together."
