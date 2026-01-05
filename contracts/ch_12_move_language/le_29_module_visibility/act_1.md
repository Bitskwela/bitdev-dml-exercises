# Module Visibility - Activity 1

## Initial Code Template

```move
module barangay::service_center {
    use std::signer;

    friend barangay::partner_org;

    struct ServiceDesk has key {
        total_requests: u64,
        internal_code: u64
    }

    struct RequestLog has key {
        approved_count: u64,
        denied_count: u64
    }

    // TODO: Task 1 - Create a private helper function
    // Function: calculate_priority
    // Takes request_type (u64), returns priority score (u64)


    // TODO: Task 2 - Create a public function
    // Function: submit_request
    // Takes requester (&signer), request_type (u64)
    // Returns request ID (u64)


    // TODO: Task 3 - Create a public(friend) function
    // Function: access_internal_metrics
    // Takes desk_addr (address)
    // Returns (total_requests, internal_code)


    // TODO: Task 4 - Create a public entry function
    // Function: initialize_desk
    // Takes admin (&signer)
    // Creates ServiceDesk with total_requests: 0, internal_code: 1234


    // TODO: Task 5 - Create a private entry function
    // Function: emergency_reset
    // Takes admin (&signer)
    // Resets the ServiceDesk internal_code to 0

}

module barangay::partner_org {
    use barangay::service_center;

    // TODO: Task 6 - Create a public function that uses the friend access
    // Function: audit_service_center
    // Takes desk_addr (address)
    // Returns the total_requests by calling access_internal_metrics

}
```

---

## Tasks

### Task 1: Create a Private Helper Function

Create a private function that calculates priority based on request type.

```move
fun calculate_priority(request_type: u64): u64 {
    if (request_type == 1) {
        100  // High priority
    } else if (request_type == 2) {
        50   // Medium priority
    } else {
        10   // Low priority
    }
}
```

### Task 2: Create a Public Function

Create a public function that anyone can call to submit a request.

```move
public fun submit_request(requester: &signer, request_type: u64): u64 acquires ServiceDesk {
    let addr = signer::address_of(requester);
    let priority = calculate_priority(request_type);

    if (exists<ServiceDesk>(@barangay)) {
        let desk = borrow_global_mut<ServiceDesk>(@barangay);
        desk.total_requests = desk.total_requests + 1;
    };

    // Generate request ID based on address and priority
    ((addr as u64) % 1000) + priority
}
```

### Task 3: Create a Public(friend) Function

Create a function only accessible by declared friend modules.

```move
public(friend) fun access_internal_metrics(desk_addr: address): (u64, u64) acquires ServiceDesk {
    let desk = borrow_global<ServiceDesk>(desk_addr);
    (desk.total_requests, desk.internal_code)
}
```

### Task 4: Create a Public Entry Function

Create a function callable from transactions and other modules.

```move
public entry fun initialize_desk(admin: &signer) {
    move_to(admin, ServiceDesk {
        total_requests: 0,
        internal_code: 1234
    });
}
```

### Task 5: Create a Private Entry Function

Create a function only callable from transactions (not other modules).

```move
entry fun emergency_reset(admin: &signer) acquires ServiceDesk {
    let addr = signer::address_of(admin);
    let desk = borrow_global_mut<ServiceDesk>(addr);
    desk.internal_code = 0;
}
```

### Task 6: Use Friend Access from Partner Module

Create a function in the partner module that uses friend access.

```move
public fun audit_service_center(desk_addr: address): u64 {
    let (total_requests, _internal_code) = service_center::access_internal_metrics(desk_addr);
    total_requests
}
```

---

## Breakdown

### Private Functions

Private functions have no visibility modifier. They can only be called within the same module:

```move
fun calculate_priority(request_type: u64): u64 {
    // Only this module can call this function
}
```

**Access Rules:**

- ✓ Same module can call
- ✗ Other modules cannot call
- ✗ Transactions cannot call (unless also marked `entry`)

### Public Functions

The `public` keyword allows any module or transaction to call the function:

```move
public fun submit_request(requester: &signer, request_type: u64): u64 {
    // Anyone can call this function
}
```

**Access Rules:**

- ✓ Same module can call
- ✓ Any other module can call
- ✓ Transactions can call (if used with `entry`)

### Public(friend) Functions

The `public(friend)` keyword restricts access to declared friend modules:

```move
friend barangay::partner_org;  // Declare friend at module level

public(friend) fun access_internal_metrics(desk_addr: address): (u64, u64) {
    // Only partner_org (and this module) can call this
}
```

**Access Rules:**

- ✓ Same module can call
- ✓ Declared friend modules can call
- ✗ Non-friend modules cannot call
- ✗ Transactions cannot call directly

### Entry Functions

The `entry` modifier allows functions to be transaction entry points:

```move
// Private entry - only transactions, not other modules
entry fun emergency_reset(admin: &signer) { }

// Public entry - transactions AND other modules
public entry fun initialize_desk(admin: &signer) { }
```

### Friend Declaration

Friends must be declared at the module level, before any other declarations:

```move
module barangay::service_center {
    friend barangay::partner_org;    // Partner can access friend functions
    friend barangay::another_module; // Multiple friends allowed

    // ... rest of module
}
```

### Visibility Access Matrix

| Function Type        | Same Module | Friend Module | Other Module | Transaction |
| -------------------- | ----------- | ------------- | ------------ | ----------- |
| `fun` (private)      | ✓           | ✗             | ✗            | ✗           |
| `public fun`         | ✓           | ✓             | ✓            | ✗           |
| `public(friend) fun` | ✓           | ✓             | ✗            | ✗           |
| `entry fun`          | ✓           | ✗             | ✗            | ✓           |
| `public entry fun`   | ✓           | ✓             | ✓            | ✓           |

### Complete Solution Structure

```move
module barangay::service_center {
    use std::signer;
    friend barangay::partner_org;

    struct ServiceDesk has key { total_requests: u64, internal_code: u64 }

    // Private - internal only
    fun calculate_priority(request_type: u64): u64 { ... }

    // Public - anyone
    public fun submit_request(...): u64 { ... }

    // Public(friend) - only partner_org
    public(friend) fun access_internal_metrics(...): (u64, u64) { ... }

    // Public entry - transactions and modules
    public entry fun initialize_desk(...) { ... }

    // Entry only - transactions only
    entry fun emergency_reset(...) { ... }
}

module barangay::partner_org {
    // Can call access_internal_metrics because declared as friend
    public fun audit_service_center(desk_addr: address): u64 {
        let (total, _) = service_center::access_internal_metrics(desk_addr);
        total
    }
}
```
