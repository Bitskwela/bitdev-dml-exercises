# Activity: The Barangay Event Scheduler

## Story

Ronnie and Det were asked to build an event scheduling system for multiple barangays. Each barangay could host multiple events, and each event could have multiple participants registered.

"We need three levels," Det explained. "Barangays contain events, and events contain participant lists."

Ronnie nodded. "And we need to track how many participants each event has, and find events across all barangays!"

## Task

Complete the `EventScheduler` module that manages a nested collection structure:

- Barangay (outer) → Events (middle) → Participants (inner)

Implement the following functions:

1. **`add_barangay`**: Register a new barangay in the system
2. **`create_event`**: Create an event within a specific barangay
3. **`register_participant`**: Add a participant to a specific event in a barangay
4. **`get_participant_count`**: Return the number of participants for a specific event
5. **`get_total_events`**: Count all events across all barangays

## Starter Code

```move
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

    // TODO: Implement add_barangay
    // - Check if barangay already exists (abort with E_BARANGAY_EXISTS if so)
    // - Insert barangay with an empty VecMap for events
    public fun add_barangay(
        scheduler: &mut EventScheduler,
        barangay_name: vector<u8>
    ) {
        // Your code here
    }

    // TODO: Implement create_event
    // - Check if barangay exists (abort with E_BARANGAY_NOT_FOUND if not)
    // - Check if event already exists in barangay (abort with E_EVENT_EXISTS if so)
    // - Create new Event with empty participants and given max_capacity
    // - Insert event into the barangay's event map
    public fun create_event(
        scheduler: &mut EventScheduler,
        barangay_name: vector<u8>,
        event_name: vector<u8>,
        max_capacity: u64
    ) {
        // Your code here
    }

    // TODO: Implement register_participant
    // - Check if barangay exists (abort with E_BARANGAY_NOT_FOUND if not)
    // - Check if event exists (abort with E_EVENT_NOT_FOUND if not)
    // - Add participant address to the event's participants vector
    public fun register_participant(
        scheduler: &mut EventScheduler,
        barangay_name: vector<u8>,
        event_name: vector<u8>,
        participant: address
    ) {
        // Your code here
    }

    // TODO: Implement get_participant_count
    // - Navigate to the specific event
    // - Return the length of the participants vector
    public fun get_participant_count(
        scheduler: &EventScheduler,
        barangay_name: vector<u8>,
        event_name: vector<u8>
    ): u64 {
        // Your code here
    }

    // TODO: Implement get_total_events
    // - Iterate through all barangays
    // - Sum up the number of events in each barangay
    // - Return the total count
    public fun get_total_events(scheduler: &EventScheduler): u64 {
        // Your code here
    }
}
```

## Requirements

1. Use proper error codes for missing barangays/events
2. Navigate the nested VecMap structure correctly
3. Use `vec_map::get_mut` when modifying nested data
4. Use `vec_map::keys` and iteration for counting across barangays
5. Use `vector::push_back` to add participants
6. Use `vector::length` to count participants

## Hints

- To access nested maps, first get the outer map, then access the inner map
- When modifying, use `get_mut` for mutable references
- Remember to copy the `event_name` when creating the Event struct if needed
- For iteration, get keys first, then loop through indices

## Expected Behavior

```move
let mut scheduler = create_scheduler(ctx);

// Add barangays
add_barangay(&mut scheduler, b"Maliwanag");
add_barangay(&mut scheduler, b"Masaya");

// Create events
create_event(&mut scheduler, b"Maliwanag", b"Fiesta", 100);
create_event(&mut scheduler, b"Maliwanag", b"Basketball", 50);
create_event(&mut scheduler, b"Masaya", b"Concert", 200);

// Total events across all barangays
assert!(get_total_events(&scheduler) == 3);

// Register participants
register_participant(&mut scheduler, b"Maliwanag", b"Fiesta", @0x123);
register_participant(&mut scheduler, b"Maliwanag", b"Fiesta", @0x456);

// Check participant count
assert!(get_participant_count(&scheduler, b"Maliwanag", b"Fiesta") == 2);
```
