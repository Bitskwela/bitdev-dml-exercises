module barangay::evidence_vault {
    // Task 1: Declare friend modules
    // These modules are granted access to public(friend) functions
    friend barangay::forensics_lab;
    friend barangay::investigation_team;

    struct Evidence has key {
        case_id: u64,
        item_count: u64,
        classification: u8  // 1=standard, 2=sensitive, 3=classified
    }

    struct ChainOfCustody has key {
        evidence_addr: address,
        handler_count: u64
    }

    // Task 2: Public(friend) function for classified access
    // Only forensics_lab and investigation_team can call this
    public(friend) fun access_classified_evidence(
        vault_addr: address
    ): (u64, u64, u8) acquires Evidence {
        let evidence = borrow_global<Evidence>(vault_addr);
        (evidence.case_id, evidence.item_count, evidence.classification)
    }

    // Task 3: Public(friend) function for chain of custody updates
    // Only friends can modify the chain of custody
    public(friend) fun update_chain_of_custody(
        vault_addr: address
    ) acquires ChainOfCustody {
        let chain = borrow_global_mut<ChainOfCustody>(vault_addr);
        chain.handler_count = chain.handler_count + 1;
    }

    // Public function - anyone can check if evidence exists
    public fun evidence_exists(vault_addr: address): bool {
        exists<Evidence>(vault_addr)
    }

    // Public function - anyone can see classification level
    public fun get_classification_level(vault_addr: address): u8 acquires Evidence {
        borrow_global<Evidence>(vault_addr).classification
    }

    // Entry function to initialize evidence (for testing)
    public entry fun store_evidence(
        admin: &signer,
        case_id: u64,
        item_count: u64,
        classification: u8
    ) {
        use std::signer;
        let addr = signer::address_of(admin);
        
        move_to(admin, Evidence {
            case_id,
            item_count,
            classification
        });
        
        move_to(admin, ChainOfCustody {
            evidence_addr: addr,
            handler_count: 1
        });
    }
}

module barangay::forensics_lab {
    use barangay::evidence_vault;

    // Task 4: Use friend access to analyze evidence
    // This works because forensics_lab is declared as a friend
    public fun analyze_evidence(vault_addr: address): u64 {
        // Call the public(friend) function - we have access!
        let (_case_id, item_count, _classification) = 
            evidence_vault::access_classified_evidence(vault_addr);
        
        // Return item count for analysis
        item_count
    }

    // Additional friend function usage example
    public fun full_analysis(vault_addr: address): (u64, u64, u8) {
        evidence_vault::access_classified_evidence(vault_addr)
    }

    // We can also call public functions
    public fun quick_check(vault_addr: address): bool {
        evidence_vault::evidence_exists(vault_addr)
    }
}

module barangay::investigation_team {
    use barangay::evidence_vault;

    // Task 5: Use friend access for investigation work
    // We can use multiple public(friend) functions
    public fun process_evidence(vault_addr: address): u64 {
        // Access the classified evidence details
        let (case_id, _item_count, _classification) = 
            evidence_vault::access_classified_evidence(vault_addr);
        
        // Update chain of custody - we handled the evidence
        evidence_vault::update_chain_of_custody(vault_addr);
        
        // Return case ID for tracking
        case_id
    }

    // Another example using friend access
    public fun investigate_case(vault_addr: address): bool {
        // Check classification before proceeding
        let (_case_id, _item_count, classification) = 
            evidence_vault::access_classified_evidence(vault_addr);
        
        // Only process if not top-secret (classification < 3)
        if (classification < 3) {
            evidence_vault::update_chain_of_custody(vault_addr);
            true
        } else {
            false  // Need higher clearance
        }
    }
}

module barangay::public_records {
    use barangay::evidence_vault;

    // Task 6: Show what non-friends CAN access
    // We can ONLY use public functions
    public fun query_evidence_status(vault_addr: address): (bool, u8) {
        // ✓ Can call evidence_exists - it's public
        let exists = evidence_vault::evidence_exists(vault_addr);
        
        if (exists) {
            // ✓ Can call get_classification_level - it's public
            let classification = evidence_vault::get_classification_level(vault_addr);
            (true, classification)
        } else {
            (false, 0)
        }
    }

    // This would NOT compile - we're not a friend:
    // 
    // public fun try_classified_access(vault_addr: address): u64 {
    //     let (case_id, _, _) = evidence_vault::access_classified_evidence(vault_addr);
    //     case_id
    //     // ERROR: Function 'access_classified_evidence' is not accessible.
    //     //        It requires friend access.
    // }
    
    // This would also NOT compile:
    //
    // public fun try_update_chain(vault_addr: address) {
    //     evidence_vault::update_chain_of_custody(vault_addr);
    //     // ERROR: Function 'update_chain_of_custody' is not accessible.
    //     //        It requires friend access.
    // }
}

// Additional example: A module that tries to be sneaky
module barangay::unauthorized_access {
    use barangay::evidence_vault;
    use barangay::forensics_lab;

    // Even though forensics_lab is a friend of evidence_vault,
    // we cannot use forensics_lab to get friend access to evidence_vault
    
    public fun attempt_through_intermediary(vault_addr: address): u64 {
        // ✓ Can call forensics_lab's public functions
        forensics_lab::analyze_evidence(vault_addr)
        
        // ✗ Cannot call evidence_vault's friend functions directly
        // evidence_vault::access_classified_evidence(vault_addr)  // ERROR
    }
    
    // This demonstrates that friendship is NOT transitive
}
