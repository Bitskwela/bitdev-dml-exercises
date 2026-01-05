module movestack::voting {
    use std::signer;

    // ============================================
    // ERROR CODES
    // ============================================

    /// Voter has already cast their vote
    const E_ALREADY_VOTED: u64 = 1;

    // ============================================
    // STRUCTS
    // ============================================

    /// Represents a registered voter
    struct Voter has key {
        has_voted: bool,
        vote_choice: u64
    }

    /// Represents a proposal that can be voted on
    struct Proposal has key {
        yes_votes: u64,
        no_votes: u64
    }

    // ============================================
    // ENTRY FUNCTIONS
    // These can be called directly from transactions
    // ============================================

    /// Initialize a new proposal
    /// 
    /// # Arguments
    /// * `admin` - The signer who will own the proposal
    /// 
    /// # Effects
    /// Creates a new Proposal resource at admin's address
    public entry fun initialize_proposal(admin: &signer) {
        move_to(admin, Proposal { yes_votes: 0, no_votes: 0 });
    }

    /// Register as a voter (private entry - transaction only)
    /// 
    /// # Arguments
    /// * `account` - The signer registering to vote
    /// 
    /// # Effects
    /// Creates a new Voter resource at account's address
    entry fun register_voter(account: &signer) {
        move_to(account, Voter { has_voted: false, vote_choice: 0 });
    }

    /// Cast a vote on a proposal
    /// 
    /// # Arguments
    /// * `voter` - The signer casting the vote
    /// * `proposal_addr` - Address where the proposal is stored
    /// * `vote_yes` - true for yes vote, false for no vote
    /// 
    /// # Aborts
    /// * `E_ALREADY_VOTED` - If voter has already voted
    /// 
    /// # Effects
    /// Updates voter's status and increments proposal vote count
    public entry fun cast_vote(
        voter: &signer, 
        proposal_addr: address, 
        vote_yes: bool
    ) acquires Voter, Proposal {
        let voter_addr = signer::address_of(voter);
        let voter_data = borrow_global_mut<Voter>(voter_addr);
        
        // Ensure voter hasn't already voted
        assert!(!voter_data.has_voted, E_ALREADY_VOTED);
        voter_data.has_voted = true;
        
        // Update proposal vote counts
        let proposal = borrow_global_mut<Proposal>(proposal_addr);
        if (vote_yes) {
            voter_data.vote_choice = 1;
            proposal.yes_votes = proposal.yes_votes + 1;
        } else {
            voter_data.vote_choice = 2;
            proposal.no_votes = proposal.no_votes + 1;
        }
    }

    // ============================================
    // PUBLIC FUNCTIONS (Module callable only)
    // These cannot be entry functions because they return values
    // ============================================

    /// Get the current vote counts for a proposal
    /// 
    /// # Arguments
    /// * `proposal_addr` - Address where the proposal is stored
    /// 
    /// # Returns
    /// Tuple of (yes_votes, no_votes)
    /// 
    /// # Note
    /// This is NOT an entry function because it returns a value.
    /// Entry functions cannot return values to the transaction caller.
    public fun get_results(proposal_addr: address): (u64, u64) acquires Proposal {
        let proposal = borrow_global<Proposal>(proposal_addr);
        (proposal.yes_votes, proposal.no_votes)
    }

    /// Check if a voter has already voted
    /// 
    /// # Arguments
    /// * `voter_addr` - Address of the voter to check
    /// 
    /// # Returns
    /// true if voter has voted, false otherwise
    public fun has_voted(voter_addr: address): bool acquires Voter {
        if (exists<Voter>(voter_addr)) {
            borrow_global<Voter>(voter_addr).has_voted
        } else {
            false
        }
    }

    /// Check if a proposal exists at an address
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// true if proposal exists, false otherwise
    public fun proposal_exists(addr: address): bool {
        exists<Proposal>(addr)
    }

    /// Check if a voter is registered
    /// 
    /// # Arguments
    /// * `addr` - Address to check
    /// 
    /// # Returns
    /// true if voter is registered, false otherwise
    public fun is_registered(addr: address): bool {
        exists<Voter>(addr)
    }
}
