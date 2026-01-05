# Events in Move

## The Signal Fires of the Blockchain

Liway adjusted her monitoring console as streams of data flowed across multiple screens. "Every action on the blockchain leaves a trace," she explained to Neri. "But how do we track what happened without reading every single transaction?"

Neri studied the patterns. "We need a signaling system—something that broadcasts important changes."

"Exactly," Liway nodded. "That's what **events** are for."

---

## What Are Events?

Events in Move are a way to emit signals that external systems can listen to. They're stored in the transaction's event stream and can be queried by off-chain applications, indexers, and frontends.

Think of events as announcements: "Hey, something important just happened!"

---

## Defining Event Structs

Events are defined as structs with specific capabilities:

```move
module village::announcements {
    use aptos_framework::event;

    /// Event emitted when a new hero registers
    struct HeroRegistered has drop, store {
        hero_address: address,
        hero_name: vector<u8>,
        registration_time: u64,
    }

    /// Event emitted when a quest is completed
    struct QuestCompleted has drop, store {
        hero_address: address,
        quest_id: u64,
        reward_amount: u64,
    }
}
```

**Key Points:**

- Event structs need `drop` and `store` abilities
- They contain the data you want to broadcast
- Keep event data minimal but informative

---

## Event Handles

To emit events, you need an **event handle**. This is typically stored in a resource:

```move
module village::quest_tracker {
    use aptos_framework::event::{Self, EventHandle};
    use aptos_framework::account;

    struct HeroRegistered has drop, store {
        hero_address: address,
        hero_name: vector<u8>,
    }

    struct QuestCompleted has drop, store {
        hero_address: address,
        quest_id: u64,
    }

    /// Resource that holds event handles
    struct QuestEvents has key {
        registration_events: EventHandle<HeroRegistered>,
        completion_events: EventHandle<QuestCompleted>,
    }

    /// Initialize event handles for an account
    public fun initialize_events(account: &signer) {
        let events = QuestEvents {
            registration_events: account::new_event_handle<HeroRegistered>(account),
            completion_events: account::new_event_handle<QuestCompleted>(account),
        };
        move_to(account, events);
    }
}
```

---

## Emitting Events

Use `event::emit_event` to broadcast an event:

```move
module village::quest_tracker {
    // ... previous code ...

    /// Register a new hero and emit an event
    public fun register_hero(
        admin: &signer,
        hero_address: address,
        hero_name: vector<u8>
    ) acquires QuestEvents {
        let events = borrow_global_mut<QuestEvents>(signer::address_of(admin));

        event::emit_event(
            &mut events.registration_events,
            HeroRegistered {
                hero_address,
                hero_name,
            }
        );
    }

    /// Complete a quest and emit an event
    public fun complete_quest(
        admin: &signer,
        hero_address: address,
        quest_id: u64
    ) acquires QuestEvents {
        let events = borrow_global_mut<QuestEvents>(signer::address_of(admin));

        event::emit_event(
            &mut events.completion_events,
            QuestCompleted {
                hero_address,
                quest_id,
            }
        );
    }
}
```

---

## Modern Event Emission (Aptos v2)

In newer versions of Aptos, you can emit events directly without handles:

```move
module village::simple_events {
    use aptos_framework::event;

    #[event]
    struct TransferOccurred has drop, store {
        from: address,
        to: address,
        amount: u64,
    }

    public fun transfer(from: address, to: address, amount: u64) {
        // ... transfer logic ...

        event::emit(TransferOccurred {
            from,
            to,
            amount,
        });
    }
}
```

The `#[event]` attribute marks the struct as an event type.

---

## Best Practices

1. **Be Descriptive**: Include enough information to understand what happened
2. **Be Efficient**: Don't include data that can be derived elsewhere
3. **Be Consistent**: Use similar patterns across your modules
4. **Think About Indexers**: What queries will off-chain systems need?

---

## Summary

Liway reviewed the monitoring console, now showing clean event streams. "With events, we can track every important action without drowning in data."

Neri smiled. "The signal fires are lit. Now everyone knows what's happening in the village."

**Key Takeaways:**

- Events broadcast important state changes
- Event structs need `drop` and `store` abilities
- Use event handles to manage and emit events
- Events are queryable by off-chain systems
