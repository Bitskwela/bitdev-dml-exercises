# Friend Modules - Activity 1

## Initial Code Template

```move
module barangay::evidence_vault {
    // TODO: Task 1 - Declare friend modules
    // Friends: forensics_lab, investigation_team


    struct Evidence has key {
        case_id: u64,
        item_count: u64,
        classification: u8  // 1=standard, 2=sensitive, 3=classified
    }

    struct ChainOfCustody has key {
        evidence_addr: address,
        handler_count: u64
    }

    // TODO: Task 2 - Create a public(friend) function
    // Function: access_classified_evidence
    // Takes vault_addr (address)
    // Returns (case_id, item_count, classification)


    // TODO: Task 3 - Create another public(friend) function
    // Function: update_chain_of_custody
    // Takes vault_addr (address)
    // Increments handler_count by 1


    // Public function for basic queries
    public fun evidence_exists(vault_addr: address): bool {
        exists<Evidence>(vault_addr)
    }

    public fun get_classification_level(vault_addr: address): u8 acquires Evidence {
        borrow_global<Evidence>(vault_addr).classification
    }
}

module barangay::forensics_lab {
    // TODO: Task 4 - Use friend access to analyze evidence
    // Function: analyze_evidence
    // Takes vault_addr (address)
    // Calls access_classified_evidence and returns the item_count

}

module barangay::investigation_team {
    // TODO: Task 5 - Use friend access for investigation work
    // Function: process_evidence
    // Takes vault_addr (address)
    // Calls access_classified_evidence and update_chain_of_custody
    // Returns the case_id

}

module barangay::public_records {
    // TODO: Task 6 - Show what non-friends CAN access
    // Function: query_evidence_status
    // Takes vault_addr (address)
    // Can only use public functions from evidence_vault
    // Returns (exists: bool, classification: u8)

}
```

---

## Tasks

### Task 1: Declare Friend Modules

Add friend declarations at the top of the evidence_vault module.

```move
friend barangay::forensics_lab;
friend barangay::investigation_team;
```

### Task 2: Create Public(friend) Function for Evidence Access

Create a function that only friends can use to access classified evidence.

```move
public(friend) fun access_classified_evidence(
    vault_addr: address
): (u64, u64, u8) acquires Evidence {
    let evidence = borrow_global<Evidence>(vault_addr);
    (evidence.case_id, evidence.item_count, evidence.classification)
}
```

### Task 3: Create Public(friend) Function for Chain Updates

Create a function that friends can use to update the chain of custody.

```move
public(friend) fun update_chain_of_custody(
    vault_addr: address
) acquires ChainOfCustody {
    let chain = borrow_global_mut<ChainOfCustody>(vault_addr);
    chain.handler_count = chain.handler_count + 1;
}
```

### Task 4: Use Friend Access in Forensics Lab

Create a function that uses the friend relationship to analyze evidence.

```move
module barangay::forensics_lab {
    use barangay::evidence_vault;

    public fun analyze_evidence(vault_addr: address): u64 {
        let (_case_id, item_count, _classification) =
            evidence_vault::access_classified_evidence(vault_addr);
        item_count
    }
}
```

### Task 5: Use Friend Access in Investigation Team

Create a function that uses multiple friend functions.

```move
module barangay::investigation_team {
    use barangay::evidence_vault;

    public fun process_evidence(vault_addr: address): u64 {
        // Access the classified evidence
        let (case_id, _item_count, _classification) =
            evidence_vault::access_classified_evidence(vault_addr);

        // Update chain of custody
        evidence_vault::update_chain_of_custody(vault_addr);

        case_id
    }
}
```

### Task 6: Show Non-Friend Access Limitations

Create a function that can only use public functions.

```move
module barangay::public_records {
    use barangay::evidence_vault;

    public fun query_evidence_status(vault_addr: address): (bool, u8) {
        let exists = evidence_vault::evidence_exists(vault_addr);

        if (exists) {
            let classification = evidence_vault::get_classification_level(vault_addr);
            (true, classification)
        } else {
            (false, 0)
        }

        // Cannot call these - not a friend:
        // evidence_vault::access_classified_evidence(vault_addr)  // ERROR
        // evidence_vault::update_chain_of_custody(vault_addr)     // ERROR
    }
}
```

---

## Breakdown

### Friend Declaration Syntax

Friend declarations must appear at the beginning of a module:

```move
module barangay::evidence_vault {
    // Use statements first (if any)
    use std::signer;

    // Friend declarations come next
    friend barangay::forensics_lab;
    friend barangay::investigation_team;

    // Then structs, functions, etc.
    struct Evidence has key { ... }
}
```

### Public(friend) Function Pattern

Functions marked `public(friend)` are only accessible by declared friends:

```move
// In evidence_vault module:
public(friend) fun access_classified_evidence(
    vault_addr: address
): (u64, u64, u8) acquires Evidence {
    // This function can:
    // - Be called by forensics_lab (friend)
    // - Be called by investigation_team (friend)
    // - NOT be called by public_records (not a friend)
    // - NOT be called from transactions
}
```

### Friend Modules Calling Protected Functions

Friend modules import and call protected functions normally:

```move
module barangay::forensics_lab {
    use barangay::evidence_vault;  // Import the module

    public fun analyze_evidence(vault_addr: address): u64 {
        // Call the friend function - this works because we're a friend
        let (_case_id, item_count, _classification) =
            evidence_vault::access_classified_evidence(vault_addr);
        item_count
    }
}
```

### Non-Friend Modules

Modules not declared as friends can only access public functions:

```move
module barangay::public_records {
    use barangay::evidence_vault;

    public fun query_evidence_status(vault_addr: address): (bool, u8) {
        // ✓ Can call public functions
        let exists = evidence_vault::evidence_exists(vault_addr);
        let classification = evidence_vault::get_classification_level(vault_addr);

        // ✗ Cannot call public(friend) functions
        // evidence_vault::access_classified_evidence(vault_addr)  // COMPILE ERROR

        (exists, classification)
    }
}
```

### Access Level Summary

| Module             | access_classified_evidence | update_chain_of_custody | evidence_exists | get_classification_level |
| ------------------ | -------------------------- | ----------------------- | --------------- | ------------------------ |
| evidence_vault     | ✓ (own module)             | ✓ (own module)          | ✓               | ✓                        |
| forensics_lab      | ✓ (friend)                 | ✓ (friend)              | ✓               | ✓                        |
| investigation_team | ✓ (friend)                 | ✓ (friend)              | ✓               | ✓                        |
| public_records     | ✗                          | ✗                       | ✓               | ✓                        |

### Friendship Properties

1. **One-way**: evidence_vault friends forensics_lab does NOT mean forensics_lab friends evidence_vault
2. **Non-transitive**: If A friends B and B friends C, A does NOT automatically friend C
3. **Explicit**: All friend relationships are visible in the code
4. **Compile-time enforced**: Access violations are caught at compile time
