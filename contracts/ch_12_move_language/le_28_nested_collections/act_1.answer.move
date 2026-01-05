module scheduler::event_system {
    use sui::vec_map::{Self, VecMap};
    
    const E_BARANGAY_NOT_FOUND: u64 = 1;
    const E_EVENT_NOT_FOUND: u64 = 2;
    const E_BARANGAY_EXISTS: u64 = 3;
    const E_EVENT_EXISTS: u64 = 4;
    
    public struct Event has store {
        name: vector<u8>,
        participants: vector<address>,
        max_capacity: u64,
    }
    
    public struct EventScheduler has key {
        id: UID,
        // Barangay name -> (Event name -> Event data)
        barangays: VecMap<vector<u8>, VecMap<vector<u8>, Event>>,
    }
    
    public fun create_scheduler(ctx: &mut TxContext): EventScheduler {
        EventScheduler {
            id: object::new(ctx),
            barangays: vec_map::empty(),
        }
    }
    
    public fun add_barangay(
        scheduler: &mut EventScheduler,
        barangay_name: vector<u8>
    ) {
        // Check if barangay already exists
        assert!(
            !vec_map::contains(&scheduler.barangays, &barangay_name),
            E_BARANGAY_EXISTS
        );
        
        // Insert barangay with empty events map
        vec_map::insert(
            &mut scheduler.barangays,
            barangay_name,
            vec_map::empty()
        );
    }
    
    public fun create_event(
        scheduler: &mut EventScheduler,
        barangay_name: vector<u8>,
        event_name: vector<u8>,
        max_capacity: u64
    ) {
        // Check if barangay exists
        assert!(
            vec_map::contains(&scheduler.barangays, &barangay_name),
            E_BARANGAY_NOT_FOUND
        );
        
        // Get the barangay's events map
        let events = vec_map::get_mut(&mut scheduler.barangays, &barangay_name);
        
        // Check if event already exists
        assert!(
            !vec_map::contains(events, &event_name),
            E_EVENT_EXISTS
        );
        
        // Create new event
        let event = Event {
            name: copy event_name,
            participants: vector::empty(),
            max_capacity: max_capacity,
        };
        
        // Insert event into barangay's events map
        vec_map::insert(events, event_name, event);
    }
    
    public fun register_participant(
        scheduler: &mut EventScheduler,
        barangay_name: vector<u8>,
        event_name: vector<u8>,
        participant: address
    ) {
        // Check if barangay exists
        assert!(
            vec_map::contains(&scheduler.barangays, &barangay_name),
            E_BARANGAY_NOT_FOUND
        );
        
        // Get the barangay's events map
        let events = vec_map::get_mut(&mut scheduler.barangays, &barangay_name);
        
        // Check if event exists
        assert!(
            vec_map::contains(events, &event_name),
            E_EVENT_NOT_FOUND
        );
        
        // Get the event and add participant
        let event = vec_map::get_mut(events, &event_name);
        vector::push_back(&mut event.participants, participant);
    }
    
    public fun get_participant_count(
        scheduler: &EventScheduler,
        barangay_name: vector<u8>,
        event_name: vector<u8>
    ): u64 {
        // Navigate to the barangay
        let events = vec_map::get(&scheduler.barangays, &barangay_name);
        
        // Navigate to the event
        let event = vec_map::get(events, &event_name);
        
        // Return participant count
        vector::length(&event.participants)
    }
    
    public fun get_total_events(scheduler: &EventScheduler): u64 {
        let mut total = 0;
        
        // Get all barangay names
        let barangay_names = vec_map::keys(&scheduler.barangays);
        let num_barangays = vector::length(&barangay_names);
        
        // Iterate through all barangays
        let mut i = 0;
        while (i < num_barangays) {
            let name = vector::borrow(&barangay_names, i);
            let events = vec_map::get(&scheduler.barangays, name);
            
            // Add the number of events in this barangay
            total = total + vec_map::size(events);
            
            i = i + 1;
        };
        
        total
    }
}
