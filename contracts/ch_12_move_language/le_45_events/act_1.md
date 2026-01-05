# Activity 1: Broadcasting Village Announcements

## The Village Bulletin Board

Liway has set up a new digital bulletin board system for the village. "We need to track when announcements are posted and when villagers acknowledge them," she explained to Neri.

Your task is to create an event system that broadcasts these village activities.

---

## Your Task

Complete the `village_bulletin` module by implementing the event system:

1. **Define event structs** for announcements and acknowledgments
2. **Create the event handle storage** resource
3. **Implement the initialization function** for event handles
4. **Implement functions that emit events** when actions occur

---

## Starter Code

```move
module village::village_bulletin {
    use std::signer;
    use aptos_framework::event::{Self, EventHandle};
    use aptos_framework::account;

    // TODO 1: Define an AnnouncementPosted event struct
    // It should contain:
    // - announcement_id: u64
    // - poster: address
    // - category: vector<u8>
    // - timestamp: u64


    // TODO 2: Define an AnnouncementAcknowledged event struct
    // It should contain:
    // - announcement_id: u64
    // - acknowledger: address


    // TODO 3: Define a BulletinEvents resource that holds:
    // - post_events: EventHandle<AnnouncementPosted>
    // - ack_events: EventHandle<AnnouncementAcknowledged>


    // TODO 4: Implement initialize_bulletin
    // Create and store the BulletinEvents resource
    public fun initialize_bulletin(account: &signer) {
        // Your code here
    }

    // TODO 5: Implement post_announcement
    // Emit an AnnouncementPosted event
    public fun post_announcement(
        admin: &signer,
        announcement_id: u64,
        category: vector<u8>,
        timestamp: u64
    ) acquires BulletinEvents {
        // Your code here
    }

    // TODO 6: Implement acknowledge_announcement
    // Emit an AnnouncementAcknowledged event
    public fun acknowledge_announcement(
        user: &signer,
        admin_address: address,
        announcement_id: u64
    ) acquires BulletinEvents {
        // Your code here
    }
}
```

---

## Requirements

- All event structs must have `drop` and `store` abilities
- The `BulletinEvents` resource must have the `key` ability
- Events must be emitted with correct data
- Use proper borrowing for event handles

---

## Hints

- Use `account::new_event_handle<T>(account)` to create event handles
- Use `event::emit_event(&mut handle, event_data)` to emit events
- Remember to borrow the resource mutably when emitting events
- The `poster` in `post_announcement` should be the admin's address

---

## Expected Behavior

When someone calls `post_announcement(admin, 1, b"urgent", 1234567890)`:

- An `AnnouncementPosted` event is emitted with the provided data

When someone calls `acknowledge_announcement(user, admin_addr, 1)`:

- An `AnnouncementAcknowledged` event is emitted with the announcement ID and user's address
