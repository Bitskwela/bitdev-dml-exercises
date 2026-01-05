module village::village_projects {
    use std::signer;

    // State constants
    const STATE_PROPOSED: u8 = 0;
    const STATE_APPROVED: u8 = 1;
    const STATE_FUNDED: u8 = 2;
    const STATE_IN_PROGRESS: u8 = 3;
    const STATE_COMPLETED: u8 = 4;
    const STATE_REJECTED: u8 = 5;
    const STATE_CANCELLED: u8 = 6;

    // Error codes
    const E_INVALID_TRANSITION: u64 = 1;
    const E_PROJECT_NOT_FOUND: u64 = 2;

    // Project resource
    struct Project has key {
        id: u64,
        state: u8,
        title: vector<u8>,
        budget: u64,
        owner: address,
    }

    /// Create a new project in PROPOSED state
    public fun create_project(
        account: &signer,
        id: u64,
        title: vector<u8>,
        budget: u64
    ) {
        let owner = signer::address_of(account);
        let project = Project {
            id,
            state: STATE_PROPOSED,
            title,
            budget,
            owner,
        };
        move_to(account, project);
    }

    /// Approve a project (PROPOSED -> APPROVED)
    public fun approve_project(account: &signer) acquires Project {
        let addr = signer::address_of(account);
        let project = borrow_global_mut<Project>(addr);
        
        assert!(project.state == STATE_PROPOSED, E_INVALID_TRANSITION);
        project.state = STATE_APPROVED;
    }

    /// Fund a project (APPROVED -> FUNDED)
    public fun fund_project(account: &signer) acquires Project {
        let addr = signer::address_of(account);
        let project = borrow_global_mut<Project>(addr);
        
        assert!(project.state == STATE_APPROVED, E_INVALID_TRANSITION);
        project.state = STATE_FUNDED;
    }

    /// Start a project (FUNDED -> IN_PROGRESS)
    public fun start_project(account: &signer) acquires Project {
        let addr = signer::address_of(account);
        let project = borrow_global_mut<Project>(addr);
        
        assert!(project.state == STATE_FUNDED, E_INVALID_TRANSITION);
        project.state = STATE_IN_PROGRESS;
    }

    /// Complete a project (IN_PROGRESS -> COMPLETED)
    public fun complete_project(account: &signer) acquires Project {
        let addr = signer::address_of(account);
        let project = borrow_global_mut<Project>(addr);
        
        assert!(project.state == STATE_IN_PROGRESS, E_INVALID_TRANSITION);
        project.state = STATE_COMPLETED;
    }

    /// Reject a project (PROPOSED or APPROVED -> REJECTED)
    public fun reject_project(account: &signer) acquires Project {
        let addr = signer::address_of(account);
        let project = borrow_global_mut<Project>(addr);
        
        assert!(
            project.state == STATE_PROPOSED || project.state == STATE_APPROVED,
            E_INVALID_TRANSITION
        );
        project.state = STATE_REJECTED;
    }

    /// Cancel a project (FUNDED -> CANCELLED)
    public fun cancel_project(account: &signer) acquires Project {
        let addr = signer::address_of(account);
        let project = borrow_global_mut<Project>(addr);
        
        assert!(project.state == STATE_FUNDED, E_INVALID_TRANSITION);
        project.state = STATE_CANCELLED;
    }

    /// Check if a project is in an active (non-terminal) state
    public fun is_active(account_addr: address): bool acquires Project {
        let project = borrow_global<Project>(account_addr);
        
        project.state == STATE_PROPOSED ||
        project.state == STATE_APPROVED ||
        project.state == STATE_FUNDED ||
        project.state == STATE_IN_PROGRESS
    }
}
