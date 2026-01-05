# Friend Modules

## Scene

The Barangay's modular system had grown significantly. Detective Odessa stood in the newly built "Integration Hub," where multiple barangay departments coordinated their operations. Det, her technical partner, was mapping out the relationships between different modules on a large display screen.

"We have a problem," Odessa said, examining the system architecture. "Our crime_records module has sensitive data that the investigation_unit needs to access, but we can't make it fully public—that would let anyone read case files."

Det nodded, highlighting the connections on screen. "What we need is a trust network. Specific modules that are authorized to access each other's protected functions."

"Like informant relationships," Odessa mused. "We trust certain informants with certain information, but not everyone gets access to everything."

"Exactly," Det replied. "In Move, we establish these trust relationships using friend declarations. A module explicitly declares which other modules it trusts, and only those friends can access its protected functions."

---

## Topics

### 1. Understanding Friend Declarations

Friend declarations establish a trust relationship between modules. The module declaring the friend grants access to its `public(friend)` functions.

```move
module barangay::crime_records {
    // Declare trusted modules
    friend barangay::investigation_unit;
    friend barangay::prosecutor_office;

    struct CaseFile has key {
        case_id: u64,
        classification: u8,  // 1=public, 2=confidential, 3=secret
        details: vector<u8>
    }

    // Only friends can access this
    public(friend) fun get_confidential_details(
        case_addr: address
    ): vector<u8> acquires CaseFile {
        let file = borrow_global<CaseFile>(case_addr);
        file.details
    }

    // Anyone can access this
    public fun get_case_classification(
        case_addr: address
    ): u8 acquires CaseFile {
        let file = borrow_global<CaseFile>(case_addr);
        file.classification
    }
}
```

**Key Points:**

- Friend declarations go at the top of the module, after `use` statements
- The declaring module (crime_records) grants access TO the friend modules
- Friendship is one-way—crime_records trusts investigation_unit, not vice versa

### 2. Using Friend Access

Friend modules can call `public(friend)` functions of their grantor:

```move
module barangay::investigation_unit {
    use barangay::crime_records;

    struct Investigation has key {
        lead_detective: address,
        case_ref: address
    }

    public fun analyze_case(case_addr: address): vector<u8> {
        // ✓ We can call this because we're a declared friend
        crime_records::get_confidential_details(case_addr)
    }

    public fun check_classification(case_addr: address): u8 {
        // ✓ Anyone can call public functions
        crime_records::get_case_classification(case_addr)
    }
}

module barangay::public_inquiry {
    use barangay::crime_records;

    public fun request_case_info(case_addr: address): u8 {
        // ✓ Can call public function
        crime_records::get_case_classification(case_addr)

        // ✗ Cannot call - not a friend
        // crime_records::get_confidential_details(case_addr)  // ERROR!
    }
}
```

### 3. Multiple Friend Declarations

Modules can have multiple friends, each with equal access:

```move
module barangay::citizen_database {
    // Multiple trusted departments
    friend barangay::tax_office;
    friend barangay::health_department;
    friend barangay::election_commission;
    friend barangay::emergency_services;

    struct CitizenRecord has key {
        id: u64,
        name: vector<u8>,
        address_info: vector<u8>,
        tax_id: u64,
        health_id: u64
    }

    // All friends can access personal info
    public(friend) fun get_citizen_address(
        citizen: address
    ): vector<u8> acquires CitizenRecord {
        borrow_global<CitizenRecord>(citizen).address_info
    }

    // All friends can verify identity
    public(friend) fun verify_citizen(
        citizen: address,
        claimed_id: u64
    ): bool acquires CitizenRecord {
        let record = borrow_global<CitizenRecord>(citizen);
        record.id == claimed_id
    }

    // Public access for basic queries
    public fun citizen_exists(citizen: address): bool {
        exists<CitizenRecord>(citizen)
    }
}
```

### 4. Bidirectional Friend Relationships

Sometimes modules need to trust each other mutually:

```move
module barangay::patrol_unit {
    friend barangay::dispatch_center;

    struct PatrolStatus has key {
        unit_id: u64,
        location: u64,
        available: bool
    }

    // Dispatch can check our status
    public(friend) fun get_patrol_location(
        unit_addr: address
    ): u64 acquires PatrolStatus {
        borrow_global<PatrolStatus>(unit_addr).location
    }

    // Dispatch can update our availability
    public(friend) fun set_availability(
        unit_addr: address,
        available: bool
    ) acquires PatrolStatus {
        let status = borrow_global_mut<PatrolStatus>(unit_addr);
        status.available = available;
    }
}

module barangay::dispatch_center {
    friend barangay::patrol_unit;

    use barangay::patrol_unit;

    struct DispatchQueue has key {
        pending_calls: u64,
        priority_level: u8
    }

    // Patrol units can check queue status
    public(friend) fun get_pending_calls(
        dispatch_addr: address
    ): u64 acquires DispatchQueue {
        borrow_global<DispatchQueue>(dispatch_addr).pending_calls
    }

    // Dispatch operations using patrol info
    public fun assign_patrol(
        unit_addr: address,
        dispatch_addr: address
    ) acquires DispatchQueue {
        // Access patrol's friend function
        let location = patrol_unit::get_patrol_location(unit_addr);

        // Use location for assignment logic
        if (location > 0) {
            patrol_unit::set_availability(unit_addr, false);
        }
    }
}
```

### 5. Friend Module Patterns

#### Pattern A: Central Data Module with Multiple Accessors

```move
module barangay::treasury {
    friend barangay::payroll;
    friend barangay::procurement;
    friend barangay::projects;

    struct Funds has key {
        balance: u64,
        reserved: u64
    }

    // Only friends can allocate funds
    public(friend) fun allocate(
        treasury_addr: address,
        amount: u64
    ): bool acquires Funds {
        let funds = borrow_global_mut<Funds>(treasury_addr);
        if (funds.balance >= amount) {
            funds.balance = funds.balance - amount;
            funds.reserved = funds.reserved + amount;
            true
        } else {
            false
        }
    }

    // Public balance check
    public fun get_available_balance(
        treasury_addr: address
    ): u64 acquires Funds {
        borrow_global<Funds>(treasury_addr).balance
    }
}
```

#### Pattern B: Layered Access Levels

```move
module barangay::security_system {
    friend barangay::security_admin;  // Full access
    friend barangay::security_guard;  // Limited access

    struct SecurityLog has key {
        entries: vector<u64>,
        alert_level: u8
    }

    // Both friends can read
    public(friend) fun get_alert_level(
        addr: address
    ): u8 acquires SecurityLog {
        borrow_global<SecurityLog>(addr).alert_level
    }

    // Both friends can read, but only admin should modify
    // (enforced by admin module's logic, not visibility)
    public(friend) fun set_alert_level(
        addr: address,
        level: u8
    ) acquires SecurityLog {
        let log = borrow_global_mut<SecurityLog>(addr);
        log.alert_level = level;
    }
}

module barangay::security_admin {
    use barangay::security_system;

    public entry fun escalate_alert(addr: address) {
        let current = security_system::get_alert_level(addr);
        security_system::set_alert_level(addr, current + 1);
    }
}

module barangay::security_guard {
    use barangay::security_system;

    // Guards can only check, not modify
    public fun check_current_alert(addr: address): u8 {
        security_system::get_alert_level(addr)
    }

    // Could technically call set_alert_level, but shouldn't
    // Business logic in this module limits its behavior
}
```

### 6. Friend Declaration Rules

```move
module barangay::rules_demo {
    // ✓ Friends must be from the same package or dependencies
    friend barangay::internal_module;

    // ✓ Multiple friends allowed
    friend barangay::module_a;
    friend barangay::module_b;

    // ✗ Cannot friend yourself
    // friend barangay::rules_demo;  // ERROR

    // ✗ Friend declarations must come before other items
    // (except 'use' statements)

    struct Data has key { value: u64 }

    // ✗ Cannot add friends after struct/function definitions
    // friend barangay::late_friend;  // ERROR

    public(friend) fun protected_access(): u64 {
        42
    }
}
```

**Rules Summary:**

1. Friend declarations must appear at the module's beginning
2. Friends can only be modules from the same package or dependencies
3. A module cannot friend itself
4. Friendship is not transitive (A friends B, B friends C → A does NOT friend C)
5. Friendship is not symmetric (A friends B does NOT mean B friends A)

---

## Closing Scene

Odessa reviewed the completed architecture on Det's screen. The friend relationships formed a clear web of trust between modules.

"So the crime_records module trusts investigation_unit and prosecutor_office," she traced the connections. "But investigation_unit doesn't automatically trust crime_records back."

"Correct," Det confirmed. "Each module independently decides who it trusts. And most importantly, this trust relationship is explicit in the code—anyone auditing the system can see exactly which modules have access to what."

"No hidden backdoors, no implicit access," Odessa nodded approvingly. "Every trust relationship is declared and verifiable."

"That's the power of friend modules. Controlled access with full transparency."

---

## Summary

| Concept            | Description                                                     |
| ------------------ | --------------------------------------------------------------- |
| Friend Declaration | `friend package::module_name;` - grants trust to another module |
| public(friend)     | Functions only callable by declared friends                     |
| One-way Trust      | Declaring a friend doesn't give you access to their functions   |
| Non-transitive     | Friends of friends don't get access                             |
| Placement          | Friend declarations must appear at module start (after use)     |

**Friend Module Patterns:**

1. **Central Data Pattern** - One data module with multiple accessor friends
2. **Bidirectional Trust** - Modules that mutually declare each other as friends
3. **Layered Access** - Multiple friends with different intended access levels

**Best Practices:**

- Only friend modules that genuinely need protected access
- Document why each friend relationship exists
- Use public(friend) only for functions that need controlled sharing
- Remember: friendship in Move is explicit, one-way, and auditable
