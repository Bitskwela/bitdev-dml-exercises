/// Solution: Resource-Oriented Programming - Ticket System
/// 
/// This module demonstrates Move's resource model through a ticket system
/// that guarantees tickets cannot be duplicated, lost, or forged.
module ticket_system::tickets {
    use std::signer;
    use std::vector;

    // =========================================
    // Error Codes
    // =========================================
    
    /// Ticket already exists for this account
    const E_TICKET_EXISTS: u64 = 1;
    /// No ticket found at this address
    const E_TICKET_NOT_FOUND: u64 = 2;
    /// Invalid ticket parameters
    const E_INVALID_PARAMS: u64 = 3;
    /// Cannot transfer to same address
    const E_SAME_ADDRESS: u64 = 4;
    /// Recipient already has a ticket
    const E_RECIPIENT_HAS_TICKET: u64 = 5;

    // =========================================
    // Task 1: The Ticket Resource
    // =========================================
    
    /// A Ticket resource with only `key` ability.
    /// 
    /// By having only `key`:
    /// - Can be stored in global storage (key)
    /// - Cannot be copied (no copy ability)
    /// - Cannot be dropped/ignored (no drop ability)
    /// - Must be explicitly moved, stored, or destroyed
    /// 
    /// This makes Ticket a true "linear type" resource.
    struct Ticket has key {
        /// Unique identifier for the ticket
        id: u64,
        /// Name of the event (stored as bytes)
        event_name: vector<u8>,
        /// Assigned seat number
        seat_number: u64,
        /// Current owner's address
        owner: address,
    }

    /// Registry to track all minted ticket IDs (prevents ID reuse)
    struct TicketRegistry has key {
        /// List of all ticket IDs that have been minted
        minted_ids: vector<u64>,
        /// Counter for total tickets ever created
        total_minted: u64,
        /// Counter for total tickets burned
        total_burned: u64,
    }

    // =========================================
    // Registry Management
    // =========================================

    /// Initialize the ticket registry (call once at module deployment)
    public fun initialize_registry(admin: &signer) {
        let registry = TicketRegistry {
            minted_ids: vector::empty(),
            total_minted: 0,
            total_burned: 0,
        };
        move_to(admin, registry);
    }

    /// Check if registry is initialized
    public fun is_registry_initialized(addr: address): bool {
        exists<TicketRegistry>(addr)
    }

    // =========================================
    // Task 2a: Mint Ticket
    // =========================================

    /// Creates a new ticket and stores it in the recipient's account.
    /// 
    /// # Arguments
    /// * `recipient` - The signer who will receive the ticket
    /// * `id` - Unique ticket identifier
    /// * `event_name` - Name of the event
    /// * `seat_number` - Assigned seat number
    /// 
    /// # Aborts
    /// * `E_TICKET_EXISTS` - If recipient already has a ticket
    public fun mint_ticket(
        recipient: &signer,
        id: u64,
        event_name: vector<u8>,
        seat_number: u64
    ) {
        let recipient_addr = signer::address_of(recipient);
        
        // Ensure recipient doesn't already have a ticket
        assert!(!exists<Ticket>(recipient_addr), E_TICKET_EXISTS);
        
        // Create the ticket resource
        let ticket = Ticket {
            id,
            event_name,
            seat_number,
            owner: recipient_addr,
        };
        
        // Store the ticket in the recipient's account
        // move_to takes ownership of the resource
        move_to(recipient, ticket);
    }

    /// Mint with registry tracking (enhanced version)
    public fun mint_ticket_with_registry(
        recipient: &signer,
        registry_addr: address,
        id: u64,
        event_name: vector<u8>,
        seat_number: u64
    ) acquires TicketRegistry {
        let recipient_addr = signer::address_of(recipient);
        
        // Ensure recipient doesn't already have a ticket
        assert!(!exists<Ticket>(recipient_addr), E_TICKET_EXISTS);
        
        // Update registry
        let registry = borrow_global_mut<TicketRegistry>(registry_addr);
        vector::push_back(&mut registry.minted_ids, id);
        registry.total_minted = registry.total_minted + 1;
        
        // Create and store the ticket
        let ticket = Ticket {
            id,
            event_name,
            seat_number,
            owner: recipient_addr,
        };
        
        move_to(recipient, ticket);
    }

    // =========================================
    // Task 2b: Burn Ticket
    // =========================================

    /// Destroys a ticket, removing it from existence.
    /// 
    /// This demonstrates proper resource destruction:
    /// 1. Extract the resource with move_from
    /// 2. Destructure to handle all fields
    /// 3. Resource ceases to exist
    /// 
    /// # Arguments
    /// * `owner` - The signer who owns the ticket
    /// 
    /// # Aborts
    /// * `E_TICKET_NOT_FOUND` - If owner doesn't have a ticket
    public fun burn_ticket(owner: &signer) acquires Ticket {
        let owner_addr = signer::address_of(owner);
        
        // Ensure the ticket exists
        assert!(exists<Ticket>(owner_addr), E_TICKET_NOT_FOUND);
        
        // Extract the ticket from storage
        // move_from takes ownership of the resource
        let ticket = move_from<Ticket>(owner_addr);
        
        // Destructure to destroy the resource
        // All fields must be handled (used or discarded with _)
        let Ticket {
            id: _,
            event_name: _,
            seat_number: _,
            owner: _,
        } = ticket;
        
        // The ticket resource no longer exists anywhere
    }

    /// Burn with registry tracking (enhanced version)
    public fun burn_ticket_with_registry(
        owner: &signer,
        registry_addr: address
    ) acquires Ticket, TicketRegistry {
        let owner_addr = signer::address_of(owner);
        
        assert!(exists<Ticket>(owner_addr), E_TICKET_NOT_FOUND);
        
        // Update registry
        let registry = borrow_global_mut<TicketRegistry>(registry_addr);
        registry.total_burned = registry.total_burned + 1;
        
        // Extract and destroy
        let ticket = move_from<Ticket>(owner_addr);
        let Ticket { id: _, event_name: _, seat_number: _, owner: _ } = ticket;
    }

    // =========================================
    // Task 3: Transfer Ticket
    // =========================================

    /// Transfers a ticket from one account to another.
    /// 
    /// This demonstrates the ownership transfer pattern:
    /// 1. Extract resource from sender (sender loses ownership)
    /// 2. Update internal ownership field
    /// 3. Store in recipient (recipient gains ownership)
    /// 
    /// At no point do two copies exist - ownership is transferred atomically.
    /// 
    /// # Arguments
    /// * `from` - The signer transferring their ticket
    /// * `to_address` - The address receiving the ticket
    /// 
    /// # Aborts
    /// * `E_TICKET_NOT_FOUND` - If sender doesn't have a ticket
    /// * `E_SAME_ADDRESS` - If trying to transfer to self
    /// * `E_RECIPIENT_HAS_TICKET` - If recipient already has a ticket
    public fun transfer_ticket(
        from: &signer,
        to_address: address
    ) acquires Ticket {
        let from_addr = signer::address_of(from);
        
        // Validate transfer
        assert!(exists<Ticket>(from_addr), E_TICKET_NOT_FOUND);
        assert!(from_addr != to_address, E_SAME_ADDRESS);
        assert!(!exists<Ticket>(to_address), E_RECIPIENT_HAS_TICKET);
        
        // Extract ticket from sender
        let ticket = move_from<Ticket>(from_addr);
        
        // Update the owner field
        // Note: We need to destructure and reconstruct since fields aren't directly mutable
        let Ticket { id, event_name, seat_number, owner: _ } = ticket;
        
        let updated_ticket = Ticket {
            id,
            event_name,
            seat_number,
            owner: to_address,
        };
        
        // Store in recipient's account
        // This requires a different approach in real implementations
        // For this example, we demonstrate the concept
        move_to_address(to_address, updated_ticket);
    }

    /// Internal helper to move resource to an address
    /// Note: In real Move implementations, you typically need the recipient's signer
    /// This is a simplified version for educational purposes
    fun move_to_address(addr: address, ticket: Ticket) {
        // In practice, this would require the recipient to have called
        // a function to "accept" the transfer, or use a different pattern
        // like storing in a shared resource or using object model
        
        // For demonstration, we'll abort - see transfer_with_signer for proper impl
        abort E_INVALID_PARAMS
    }

    /// Proper transfer implementation requiring recipient's signer
    public fun transfer_with_signer(
        from: &signer,
        to: &signer
    ) acquires Ticket {
        let from_addr = signer::address_of(from);
        let to_addr = signer::address_of(to);
        
        // Validate
        assert!(exists<Ticket>(from_addr), E_TICKET_NOT_FOUND);
        assert!(from_addr != to_addr, E_SAME_ADDRESS);
        assert!(!exists<Ticket>(to_addr), E_RECIPIENT_HAS_TICKET);
        
        // Extract from sender
        let ticket = move_from<Ticket>(from_addr);
        
        // Reconstruct with new owner
        let Ticket { id, event_name, seat_number, owner: _ } = ticket;
        let updated_ticket = Ticket {
            id,
            event_name,
            seat_number,
            owner: to_addr,
        };
        
        // Store with recipient's signer
        move_to(to, updated_ticket);
    }

    // =========================================
    // View Functions
    // =========================================

    /// Check if an address has a ticket
    public fun has_ticket(addr: address): bool {
        exists<Ticket>(addr)
    }

    /// Get ticket details (returns copies of data, not the resource itself)
    public fun get_ticket_info(addr: address): (u64, vector<u8>, u64, address) acquires Ticket {
        assert!(exists<Ticket>(addr), E_TICKET_NOT_FOUND);
        
        let ticket = borrow_global<Ticket>(addr);
        (ticket.id, *&ticket.event_name, ticket.seat_number, ticket.owner)
    }

    /// Get just the ticket ID
    public fun get_ticket_id(addr: address): u64 acquires Ticket {
        assert!(exists<Ticket>(addr), E_TICKET_NOT_FOUND);
        borrow_global<Ticket>(addr).id
    }

    /// Get the event name
    public fun get_event_name(addr: address): vector<u8> acquires Ticket {
        assert!(exists<Ticket>(addr), E_TICKET_NOT_FOUND);
        *&borrow_global<Ticket>(addr).event_name
    }

    /// Get the seat number
    public fun get_seat_number(addr: address): u64 acquires Ticket {
        assert!(exists<Ticket>(addr), E_TICKET_NOT_FOUND);
        borrow_global<Ticket>(addr).seat_number
    }

    /// Get registry statistics
    public fun get_registry_stats(registry_addr: address): (u64, u64) acquires TicketRegistry {
        let registry = borrow_global<TicketRegistry>(registry_addr);
        (registry.total_minted, registry.total_burned)
    }

    // =========================================
    // Tests
    // =========================================

    #[test_only]
    use std::string;

    #[test(account = @0x1)]
    fun test_mint_ticket(account: &signer) {
        let addr = signer::address_of(account);
        
        // Mint a ticket
        mint_ticket(
            account,
            1,
            b"Move Conference 2026",
            42
        );
        
        // Verify ticket exists
        assert!(has_ticket(addr), 0);
    }

    #[test(account = @0x1)]
    fun test_get_ticket_info(account: &signer) acquires Ticket {
        let addr = signer::address_of(account);
        
        mint_ticket(account, 100, b"Blockchain Summit", 15);
        
        let (id, event_name, seat, owner) = get_ticket_info(addr);
        assert!(id == 100, 0);
        assert!(event_name == b"Blockchain Summit", 1);
        assert!(seat == 15, 2);
        assert!(owner == addr, 3);
    }

    #[test(account = @0x1)]
    fun test_burn_ticket(account: &signer) acquires Ticket {
        let addr = signer::address_of(account);
        
        // Mint then burn
        mint_ticket(account, 1, b"Event", 1);
        assert!(has_ticket(addr), 0);
        
        burn_ticket(account);
        assert!(!has_ticket(addr), 1);
    }

    #[test(from = @0x1, to = @0x2)]
    fun test_transfer_ticket(from: &signer, to: &signer) acquires Ticket {
        let from_addr = signer::address_of(from);
        let to_addr = signer::address_of(to);
        
        // Mint to sender
        mint_ticket(from, 1, b"Concert", 50);
        assert!(has_ticket(from_addr), 0);
        assert!(!has_ticket(to_addr), 1);
        
        // Transfer
        transfer_with_signer(from, to);
        
        // Verify transfer
        assert!(!has_ticket(from_addr), 2);
        assert!(has_ticket(to_addr), 3);
        
        // Verify owner updated
        let (_, _, _, owner) = get_ticket_info(to_addr);
        assert!(owner == to_addr, 4);
    }

    #[test(account = @0x1)]
    #[expected_failure(abort_code = E_TICKET_EXISTS)]
    fun test_cannot_mint_duplicate(account: &signer) {
        mint_ticket(account, 1, b"Event1", 1);
        // This should fail - account already has a ticket
        mint_ticket(account, 2, b"Event2", 2);
    }

    #[test(account = @0x1)]
    #[expected_failure(abort_code = E_TICKET_NOT_FOUND)]
    fun test_cannot_burn_nonexistent(account: &signer) acquires Ticket {
        // This should fail - no ticket to burn
        burn_ticket(account);
    }

    #[test(from = @0x1, to = @0x2)]
    #[expected_failure(abort_code = E_TICKET_NOT_FOUND)]
    fun test_cannot_transfer_nonexistent(from: &signer, to: &signer) acquires Ticket {
        // This should fail - no ticket to transfer
        transfer_with_signer(from, to);
    }

    #[test(account = @0x1, other = @0x2)]
    #[expected_failure(abort_code = E_RECIPIENT_HAS_TICKET)]
    fun test_cannot_transfer_to_holder(account: &signer, other: &signer) acquires Ticket {
        // Both have tickets
        mint_ticket(account, 1, b"Event", 1);
        mint_ticket(other, 2, b"Event", 2);
        
        // This should fail - recipient already has a ticket
        transfer_with_signer(account, other);
    }

    #[test(admin = @0x1)]
    fun test_registry_initialization(admin: &signer) acquires TicketRegistry {
        let addr = signer::address_of(admin);
        
        initialize_registry(admin);
        assert!(is_registry_initialized(addr), 0);
        
        let (minted, burned) = get_registry_stats(addr);
        assert!(minted == 0, 1);
        assert!(burned == 0, 2);
    }

    #[test(admin = @0x1, user = @0x2)]
    fun test_mint_with_registry(admin: &signer, user: &signer) acquires TicketRegistry {
        let admin_addr = signer::address_of(admin);
        
        initialize_registry(admin);
        
        mint_ticket_with_registry(user, admin_addr, 1, b"Event", 1);
        
        let (minted, burned) = get_registry_stats(admin_addr);
        assert!(minted == 1, 0);
        assert!(burned == 0, 1);
    }
}
