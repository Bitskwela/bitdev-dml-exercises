# Activity: The Voter Registration System

## Story

Odessa was tasked with building a voter registration system for the upcoming Barangay elections. Jaymart helped her identify the requirements:

1. Each voter can only register once (no duplicate registrations)
2. Track which precinct each voter is assigned to
3. Record the registration timestamp for each voter

"We can't have anyone voting twice," Odessa emphasized. "The system must reject duplicate registrations!"

## Task

Complete the `VoterRegistry` module by implementing the following:

1. **`register_voter`**: Register a voter with their precinct and timestamp. Must reject if already registered.
2. **`is_registered`**: Check if an address is already registered.
3. **`get_voter_precinct`**: Get the precinct number for a registered voter.
4. **`total_voters`**: Return the total count of registered voters.

## Starter Code

```move
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

    // TODO: Implement register_voter
    // - Check if voter is already registered (abort with E_ALREADY_REGISTERED if so)
    // - Add voter to registered_voters set
    // - Record their precinct in voter_precincts map
    // - Record their timestamp in registration_times map
    public fun register_voter(
        registry: &mut VoterRegistry,
        voter: address,
        precinct: u64,
        timestamp: u64
    ) {
        // Your code here
    }

    // TODO: Implement is_registered
    // - Return true if the voter address is in registered_voters set
    public fun is_registered(registry: &VoterRegistry, voter: address): bool {
        // Your code here
    }

    // TODO: Implement get_voter_precinct
    // - Assert voter is registered (abort with E_NOT_REGISTERED if not)
    // - Return the precinct number from voter_precincts map
    public fun get_voter_precinct(registry: &VoterRegistry, voter: address): u64 {
        // Your code here
    }

    // TODO: Implement total_voters
    // - Return the size of registered_voters set
    public fun total_voters(registry: &VoterRegistry): u64 {
        // Your code here
    }
}
```

## Requirements

1. `register_voter` must abort with `E_ALREADY_REGISTERED` if the voter is already in the set
2. `get_voter_precinct` must abort with `E_NOT_REGISTERED` if the voter isn't registered
3. Use `vec_set::contains()` to check for existing registrations
4. Use `vec_set::insert()` to add voters to the set
5. Use `vec_map::insert()` to store precinct and timestamp data
6. Use `vec_map::get()` to retrieve precinct data

## Hints

- Remember that `vec_map::get()` returns a reference, so dereference with `*` when returning a value
- Check the set BEFORE inserting to provide a meaningful error message
- The `contains()` function takes a reference to the element you're checking

## Expected Behavior

```move
// Create registry
let mut registry = create_registry(ctx);

// Register first voter
register_voter(&mut registry, @0x123, 5, 1000);
assert!(is_registered(&registry, @0x123) == true);
assert!(get_voter_precinct(&registry, @0x123) == 5);
assert!(total_voters(&registry) == 1);

// Attempting to register same voter again should abort!
// register_voter(&mut registry, @0x123, 5, 1001); // This would abort!

// Register second voter
register_voter(&mut registry, @0x456, 3, 1002);
assert!(total_voters(&registry) == 2);
```
