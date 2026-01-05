module election::voter_registry {
    use sui::vec_set::{Self, VecSet};
    use sui::vec_map::{Self, VecMap};
    
    const E_ALREADY_REGISTERED: u64 = 1;
    const E_NOT_REGISTERED: u64 = 2;
    
    public struct VoterRegistry has key {
        id: UID,
        registered_voters: VecSet<address>,
        voter_precincts: VecMap<address, u64>,
        registration_times: VecMap<address, u64>,
    }
    
    public fun create_registry(ctx: &mut TxContext): VoterRegistry {
        VoterRegistry {
            id: object::new(ctx),
            registered_voters: vec_set::empty(),
            voter_precincts: vec_map::empty(),
            registration_times: vec_map::empty(),
        }
    }
    
    public fun register_voter(
        registry: &mut VoterRegistry,
        voter: address,
        precinct: u64,
        timestamp: u64
    ) {
        // Check if voter is already registered
        assert!(
            !vec_set::contains(&registry.registered_voters, &voter),
            E_ALREADY_REGISTERED
        );
        
        // Add voter to the set of registered voters
        vec_set::insert(&mut registry.registered_voters, voter);
        
        // Record their precinct
        vec_map::insert(&mut registry.voter_precincts, voter, precinct);
        
        // Record their registration timestamp
        vec_map::insert(&mut registry.registration_times, voter, timestamp);
    }
    
    public fun is_registered(registry: &VoterRegistry, voter: address): bool {
        vec_set::contains(&registry.registered_voters, &voter)
    }
    
    public fun get_voter_precinct(registry: &VoterRegistry, voter: address): u64 {
        // Assert voter is registered
        assert!(
            vec_set::contains(&registry.registered_voters, &voter),
            E_NOT_REGISTERED
        );
        
        // Return the precinct (dereference since get returns a reference)
        *vec_map::get(&registry.voter_precincts, &voter)
    }
    
    public fun total_voters(registry: &VoterRegistry): u64 {
        vec_set::size(&registry.registered_voters)
    }
}
