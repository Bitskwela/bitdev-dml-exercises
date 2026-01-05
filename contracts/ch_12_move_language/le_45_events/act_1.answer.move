module village::village_bulletin {
    use std::signer;
    use aptos_framework::event::{Self, EventHandle};
    use aptos_framework::account;

    // Event emitted when an announcement is posted
    struct AnnouncementPosted has drop, store {
        announcement_id: u64,
        poster: address,
        category: vector<u8>,
        timestamp: u64,
    }

    // Event emitted when someone acknowledges an announcement
    struct AnnouncementAcknowledged has drop, store {
        announcement_id: u64,
        acknowledger: address,
    }

    // Resource that holds all event handles for the bulletin
    struct BulletinEvents has key {
        post_events: EventHandle<AnnouncementPosted>,
        ack_events: EventHandle<AnnouncementAcknowledged>,
    }

    /// Initialize the bulletin event system for an account
    public fun initialize_bulletin(account: &signer) {
        let bulletin_events = BulletinEvents {
            post_events: account::new_event_handle<AnnouncementPosted>(account),
            ack_events: account::new_event_handle<AnnouncementAcknowledged>(account),
        };
        move_to(account, bulletin_events);
    }

    /// Post an announcement and emit an event
    public fun post_announcement(
        admin: &signer,
        announcement_id: u64,
        category: vector<u8>,
        timestamp: u64
    ) acquires BulletinEvents {
        let admin_address = signer::address_of(admin);
        let events = borrow_global_mut<BulletinEvents>(admin_address);
        
        event::emit_event(
            &mut events.post_events,
            AnnouncementPosted {
                announcement_id,
                poster: admin_address,
                category,
                timestamp,
            }
        );
    }

    /// Acknowledge an announcement and emit an event
    public fun acknowledge_announcement(
        user: &signer,
        admin_address: address,
        announcement_id: u64
    ) acquires BulletinEvents {
        let events = borrow_global_mut<BulletinEvents>(admin_address);
        
        event::emit_event(
            &mut events.ack_events,
            AnnouncementAcknowledged {
                announcement_id,
                acknowledger: signer::address_of(user),
            }
        );
    }
}
