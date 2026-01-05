# State Machines in Move

## The Flow of Order

Ronnie paced in front of the warehouse, clipboard in hand. "Every package has a journey," he explained to Odessa. "It starts somewhere, goes through stages, and ends up delivered. But we can't skip steps—a package can't be delivered before it's shipped!"

Odessa studied the workflow chart. "So we need to enforce the order of operations."

"Exactly," Ronnie said. "That's what **state machines** are for."

---

## What Is a State Machine?

A state machine is a model that describes:

1. A set of **states** something can be in
2. **Transitions** that move between states
3. **Rules** about which transitions are valid

In Move, we implement state machines to ensure operations happen in the correct order.

---

## Representing States

Move doesn't have traditional enums, so we represent states using constants:

```move
module logistics::order_states {
    /// Order states as constants
    const STATE_CREATED: u8 = 0;
    const STATE_CONFIRMED: u8 = 1;
    const STATE_SHIPPED: u8 = 2;
    const STATE_IN_TRANSIT: u8 = 3;
    const STATE_DELIVERED: u8 = 4;
    const STATE_CANCELLED: u8 = 5;

    /// Error codes
    const E_INVALID_TRANSITION: u64 = 1;
    const E_ORDER_NOT_FOUND: u64 = 2;

    struct Order has key, store {
        id: u64,
        state: u8,
        customer: address,
        created_at: u64,
    }
}
```

---

## Defining Valid Transitions

Not all state changes are valid. Define a function to check:

```move
module logistics::order_states {
    // ... previous code ...

    /// Check if a transition from one state to another is valid
    public fun is_valid_transition(from_state: u8, to_state: u8): bool {
        if (from_state == STATE_CREATED) {
            // From CREATED, can go to CONFIRMED or CANCELLED
            to_state == STATE_CONFIRMED || to_state == STATE_CANCELLED
        } else if (from_state == STATE_CONFIRMED) {
            // From CONFIRMED, can go to SHIPPED or CANCELLED
            to_state == STATE_SHIPPED || to_state == STATE_CANCELLED
        } else if (from_state == STATE_SHIPPED) {
            // From SHIPPED, can only go to IN_TRANSIT
            to_state == STATE_IN_TRANSIT
        } else if (from_state == STATE_IN_TRANSIT) {
            // From IN_TRANSIT, can go to DELIVERED
            to_state == STATE_DELIVERED
        } else {
            // DELIVERED and CANCELLED are terminal states
            false
        }
    }
}
```

---

## Implementing Transitions

Each transition should validate and update the state:

```move
module logistics::order_manager {
    use std::signer;

    const STATE_CREATED: u8 = 0;
    const STATE_CONFIRMED: u8 = 1;
    const STATE_SHIPPED: u8 = 2;
    const STATE_DELIVERED: u8 = 4;

    const E_INVALID_TRANSITION: u64 = 1;

    struct Order has key {
        id: u64,
        state: u8,
        customer: address,
    }

    /// Create a new order (starts in CREATED state)
    public fun create_order(
        account: &signer,
        order_id: u64,
        customer: address
    ) {
        let order = Order {
            id: order_id,
            state: STATE_CREATED,
            customer,
        };
        move_to(account, order);
    }

    /// Confirm an order (CREATED -> CONFIRMED)
    public fun confirm_order(account: &signer) acquires Order {
        let addr = signer::address_of(account);
        let order = borrow_global_mut<Order>(addr);

        assert!(order.state == STATE_CREATED, E_INVALID_TRANSITION);
        order.state = STATE_CONFIRMED;
    }

    /// Ship an order (CONFIRMED -> SHIPPED)
    public fun ship_order(account: &signer) acquires Order {
        let addr = signer::address_of(account);
        let order = borrow_global_mut<Order>(addr);

        assert!(order.state == STATE_CONFIRMED, E_INVALID_TRANSITION);
        order.state = STATE_SHIPPED;
    }

    /// Deliver an order (SHIPPED -> DELIVERED)
    public fun deliver_order(account: &signer) acquires Order {
        let addr = signer::address_of(account);
        let order = borrow_global_mut<Order>(addr);

        assert!(order.state == STATE_SHIPPED, E_INVALID_TRANSITION);
        order.state = STATE_DELIVERED;
    }
}
```

---

## Workflow Modeling with Multiple Paths

Real workflows often have branches. Here's a proposal system:

```move
module governance::proposal {
    const STATE_DRAFT: u8 = 0;
    const STATE_SUBMITTED: u8 = 1;
    const STATE_VOTING: u8 = 2;
    const STATE_PASSED: u8 = 3;
    const STATE_REJECTED: u8 = 4;
    const STATE_EXECUTED: u8 = 5;
    const STATE_EXPIRED: u8 = 6;

    struct Proposal has key {
        id: u64,
        state: u8,
        votes_for: u64,
        votes_against: u64,
        deadline: u64,
    }

    /// Tally votes and transition based on result
    public fun tally_votes(account: &signer, current_time: u64) acquires Proposal {
        let addr = signer::address_of(account);
        let proposal = borrow_global_mut<Proposal>(addr);

        assert!(proposal.state == STATE_VOTING, 1);

        if (current_time > proposal.deadline) {
            // Expired without enough votes
            proposal.state = STATE_EXPIRED;
        } else if (proposal.votes_for > proposal.votes_against) {
            proposal.state = STATE_PASSED;
        } else {
            proposal.state = STATE_REJECTED;
        }
    }
}
```

---

## State Query Functions

Provide functions to check the current state:

```move
module logistics::order_queries {
    // ... order struct and states ...

    public fun is_created(order: &Order): bool {
        order.state == STATE_CREATED
    }

    public fun is_in_progress(order: &Order): bool {
        order.state == STATE_CONFIRMED ||
        order.state == STATE_SHIPPED ||
        order.state == STATE_IN_TRANSIT
    }

    public fun is_terminal(order: &Order): bool {
        order.state == STATE_DELIVERED || order.state == STATE_CANCELLED
    }

    public fun get_state_name(state: u8): vector<u8> {
        if (state == STATE_CREATED) b"Created"
        else if (state == STATE_CONFIRMED) b"Confirmed"
        else if (state == STATE_SHIPPED) b"Shipped"
        else if (state == STATE_DELIVERED) b"Delivered"
        else if (state == STATE_CANCELLED) b"Cancelled"
        else b"Unknown"
    }
}
```

---

## Best Practices

1. **Use Constants for States**: Makes code readable and prevents magic numbers
2. **Validate All Transitions**: Never allow invalid state changes
3. **Document the State Diagram**: Make it clear what transitions are allowed
4. **Consider Terminal States**: Some states cannot be left
5. **Emit Events on Transitions**: Track state changes for off-chain systems

---

## Summary

Ronnie checked off the final delivery on his clipboard. "With proper state management, every package follows its journey correctly."

Odessa nodded. "No shortcuts, no skipped steps. The system enforces the flow."

**Key Takeaways:**

- Use constants to represent discrete states
- Validate transitions before changing state
- Different workflows may have branches and terminal states
- State machines ensure operations happen in the correct order
