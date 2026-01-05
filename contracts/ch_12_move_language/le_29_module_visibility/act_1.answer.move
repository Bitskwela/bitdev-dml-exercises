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

    // Task 1: Private helper function
    // No visibility modifier = private
    // Can only be called within this module
    fun calculate_priority(request_type: u64): u64 {
        if (request_type == 1) {
            100  // High priority
        } else if (request_type == 2) {
            50   // Medium priority
        } else {
            10   // Low priority
        }
    }

    // Task 2: Public function
    // Can be called from any module
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

    // Task 3: Public(friend) function
    // Can only be called by declared friend modules
    public(friend) fun access_internal_metrics(desk_addr: address): (u64, u64) acquires ServiceDesk {
        let desk = borrow_global<ServiceDesk>(desk_addr);
        (desk.total_requests, desk.internal_code)
    }

    // Task 4: Public entry function
    // Can be called from transactions AND other modules
    public entry fun initialize_desk(admin: &signer) {
        move_to(admin, ServiceDesk {
            total_requests: 0,
            internal_code: 1234
        });
    }

    // Task 5: Private entry function
    // Can ONLY be called from transactions, not from other modules
    entry fun emergency_reset(admin: &signer) acquires ServiceDesk {
        let addr = signer::address_of(admin);
        let desk = borrow_global_mut<ServiceDesk>(addr);
        desk.internal_code = 0;
    }
}

module barangay::partner_org {
    use barangay::service_center;

    // Task 6: Function using friend access
    // This works because partner_org is declared as a friend
    public fun audit_service_center(desk_addr: address): u64 {
        let (total_requests, _internal_code) = service_center::access_internal_metrics(desk_addr);
        total_requests
    }

    // Additional example: This would work
    public fun submit_on_behalf(requester: &signer, request_type: u64): u64 {
        // Can call public functions from anywhere
        service_center::submit_request(requester, request_type)
    }

    // Note: The following would NOT compile:
    // fun try_private_access(): u64 {
    //     service_center::calculate_priority(1)  // ERROR: private function
    // }
}

// Example of a non-friend module
module barangay::random_module {
    use barangay::service_center;

    public fun try_access(requester: &signer): u64 {
        // ✓ This works - public function
        service_center::submit_request(requester, 1)

        // ✗ This would NOT compile - not a friend:
        // service_center::access_internal_metrics(@barangay)

        // ✗ This would NOT compile - private function:
        // service_center::calculate_priority(1)
    }
}
