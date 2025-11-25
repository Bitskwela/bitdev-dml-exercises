## Background Story

Odessa enters the Observatory of Change—a vast chamber where every state transition in the blockchain's history plays out as light. At the center hovers Master Chronica, Keeper of Events, surrounded by streams of data flowing from countless contracts.

"Every action leaves a trace," Chronica begins, her voice resonating through time. "When a token is minted, when ownership transfers, when a vote is cast—these aren't just state changes. They're _events_. And events are how the outside world understands what's happening inside your contracts."

The master gestures, and event streams coalesce into readable patterns.

"Smart contracts live on the blockchain. They change state. But how does your frontend know a state changed? How does an indexer track token transfers? How does a monitoring system detect suspicious activity? The answer: **events**."

Chronica pulls down an event, showing its structure.

"Events are like a public announcement system. Your contract emits an event saying 'This happened.' Anyone listening can hear it. Frontend applications can display it to users. Indexers can store it in databases. Analytics systems can process it. Events turn your opaque contract into an observable, reactive system."

The keeper's eyes glow with knowledge.

"Today, you'll master event-driven architecture. You'll learn when to emit events, what data to include, how to design event schemas, and how to build systems that respond to events. By the end, your contracts won't just work—they'll be _observable_."

The observatory brightens with countless event streams.

"Let's begin."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Event Basics: What Are Events?**

Events are notifications emitted by smart contracts that external systems can observe.

**What problem do events solve?**

Without events:

- Frontend can't know when state changed
- Must poll contract repeatedly (expensive!)
- No historical record of what happened
- Can't build efficient indexers

With events:

- Contract announces "something changed"
- Frontend listens and updates UI instantly
- Full historical log of all actions
- Indexers can build queryable databases

**Basic event structure:**

```move
module spell_library::event_basics {
    use std::string::String;

    // Define an event struct
    struct Transfer has copy, drop {
        from: address,
        to: address,
        amount: u64
    }

    // Emit an event
    public fun transfer_tokens(from: address, to: address, amount: u64) {
        // ... perform transfer logic ...

        // Emit event to notify observers
        event::emit(Transfer {
            from,
            to,
            amount
        });
    }
}
```

**Why `copy` and `drop` abilities?**

Events need:

- `copy`: Can be duplicated for multiple listeners
- `drop`: Can be discarded after processing
- No `store` or `key`: Events aren't stored on-chain permanently

**What data should events include?**

Include everything observers need to understand what happened:

```move
struct TokenMinted has copy, drop {
    recipient: address,
    amount: u64,
    token_id: u64,
    timestamp: u64,
    minter: address
}
```

**Event emission is cheap:**

Events are logged off-chain (in transaction results), not stored in contract state. This makes them efficient for tracking actions.

**Events vs State:**

```move
module spell_library::comparison {
    // ❌ BAD: Storing history in state (expensive!)
    struct History has key {
        actions: vector<Action>  // Grows forever, costs gas
    }

    // ✅ GOOD: Emitting events (cheap!)
    struct ActionEvent has copy, drop {
        action_type: u8,
        timestamp: u64
    }

    public fun perform_action() {
        // Do action
        event::emit(ActionEvent {
            action_type: 1,
            timestamp: get_timestamp()
        });
        // Event logged, no storage cost!
    }
}
```

### 2️⃣ **Event Design Patterns**

How to design effective event schemas.

**Pattern 1: Comprehensive events**

Include all relevant data:

```move
struct UserRegistered has copy, drop {
    user_address: address,
    username: String,
    registration_time: u64,
    referrer: Option<address>,
    initial_balance: u64
}

public fun register_user(
    user: address,
    username: String,
    referrer: Option<address>
) {
    // ... registration logic ...

    event::emit(UserRegistered {
        user_address: user,
        username,
        registration_time: get_timestamp(),
        referrer,
        initial_balance: 0
    });
}
```

**Pattern 2: Event hierarchies**

Different event types for different actions:

```move
module spell_library::token_events {
    // Base event trait (conceptual)
    struct TokenEvent has copy, drop {
        token_id: u64,
        timestamp: u64
    }

    // Specific event types
    struct TokenMinted has copy, drop {
        token_id: u64,
        recipient: address,
        amount: u64,
        timestamp: u64
    }

    struct TokenBurned has copy, drop {
        token_id: u64,
        owner: address,
        amount: u64,
        timestamp: u64
    }

    struct TokenTransferred has copy, drop {
        token_id: u64,
        from: address,
        to: address,
        amount: u64,
        timestamp: u64
    }
}
```

**Pattern 3: Before/After events**

Track state changes:

```move
struct BalanceChanged has copy, drop {
    account: address,
    old_balance: u64,
    new_balance: u64,
    change_reason: String
}

public fun update_balance(
    account: address,
    old_balance: u64,
    new_balance: u64,
    reason: String
) {
    event::emit(BalanceChanged {
        account,
        old_balance,
        new_balance,
        change_reason: reason
    });
}
```

**Pattern 4: Aggregate events**

Batch multiple changes:

```move
struct BatchTransfer has copy, drop {
    from: address,
    recipients: vector<address>,
    amounts: vector<u64>,
    total_amount: u64,
    batch_id: u64
}

public fun batch_transfer(
    from: address,
    recipients: vector<address>,
    amounts: vector<u64>
) {
    // ... transfer logic ...

    let total = calculate_total(&amounts);

    event::emit(BatchTransfer {
        from,
        recipients,
        amounts,
        total_amount: total,
        batch_id: generate_id()
    });
}
```

**Pattern 5: Indexed events**

Make events easily queryable:

```move
struct OrderCreated has copy, drop {
    order_id: u64,        // Indexed: query by order
    user: address,        // Indexed: query by user
    item_id: u64,         // Indexed: query by item
    price: u64,
    quantity: u64,
    timestamp: u64
}
```

### 3️⃣ **Event Handling and Processing**

How external systems consume events.

**Frontend listening (conceptual):**

```typescript
// TypeScript/JavaScript frontend
const contract = new MoveContract(address);

// Listen for Transfer events
contract.on("Transfer", (event) => {
  console.log(`Transfer: ${event.from} -> ${event.to}: ${event.amount}`);
  updateUI(event);
});

// Listen for specific user's events
contract.on("Transfer", (event) => {
  if (event.to === currentUserAddress) {
    showNotification("You received tokens!");
  }
});
```

**Event filtering patterns:**

```move
// Events naturally support filtering
struct ActionEvent has copy, drop {
    actor: address,
    action_type: u8,
    target: Option<address>
}

// Frontend can filter:
// - All events from specific actor
// - All events of specific type
// - All events affecting specific target
```

**Indexer processing:**

Indexers build queryable databases from events:

```sql
-- SQL database built from events
SELECT * FROM transfers
WHERE to_address = '0x123'
ORDER BY timestamp DESC;

SELECT SUM(amount) FROM transfers
WHERE from_address = '0x456'
AND timestamp > '2024-01-01';
```

**Event replay:**

Events enable rebuilding state:

```move
// Start with empty state
let mut balances = empty_map();

// Replay all Transfer events
for event in all_transfer_events {
    balances[event.from] -= event.amount;
    balances[event.to] += event.amount;
}

// Final state reconstructed from events!
```

### 4️⃣ **Event-Driven Architecture Patterns**

Building systems around events.

**Pattern 1: Audit trail**

Every important action emits event:

```move
module spell_library::audit {
    struct AdminAction has copy, drop {
        admin: address,
        action: String,
        target: Option<address>,
        timestamp: u64,
        success: bool
    }

    public fun admin_update(
        admin: &AdminCap,
        target: address,
        new_value: u64
    ) {
        let success = try_update(target, new_value);

        event::emit(AdminAction {
            admin: get_admin_address(admin),
            action: string::utf8(b"update_value"),
            target: option::some(target),
            timestamp: get_timestamp(),
            success
        });
    }
}
```

**Pattern 2: State machine transitions**

Emit events for state changes:

```move
struct StateChanged has copy, drop {
    entity_id: u64,
    old_state: u8,
    new_state: u8,
    timestamp: u64,
    changed_by: address
}

public fun transition_state(
    id: u64,
    old: u8,
    new: u8,
    actor: address
) {
    event::emit(StateChanged {
        entity_id: id,
        old_state: old,
        new_state: new,
        timestamp: get_timestamp(),
        changed_by: actor
    });
}
```

**Pattern 3: Activity feed**

Events become user activity:

```move
struct UserActivity has copy, drop {
    user: address,
    activity_type: String,
    details: String,
    related_users: vector<address>,
    timestamp: u64
}

public fun post_message(
    user: address,
    message: String,
    mentions: vector<address>
) {
    // ... post logic ...

    event::emit(UserActivity {
        user,
        activity_type: string::utf8(b"posted_message"),
        details: message,
        related_users: mentions,
        timestamp: get_timestamp()
    });
}
```

**Pattern 4: Analytics events**

Track metrics:

```move
struct Metrics has copy, drop {
    metric_name: String,
    value: u64,
    tags: vector<String>,
    timestamp: u64
}

public fun track_metric(
    name: String,
    value: u64,
    tags: vector<String>
) {
    event::emit(Metrics {
        metric_name: name,
        value,
        tags,
        timestamp: get_timestamp()
    });
}
```

**Pattern 5: Event sourcing**

Events as source of truth:

```move
// Never modify state directly
// Always:
// 1. Emit event
// 2. Update state based on event

struct InventoryChanged has copy, drop {
    item_id: u64,
    old_quantity: u64,
    new_quantity: u64,
    change_reason: String
}

public fun update_inventory(
    inventory: &mut Inventory,
    item_id: u64,
    delta: i64,
    reason: String
) {
    let old_qty = get_quantity(inventory, item_id);
    let new_qty = apply_delta(old_qty, delta);

    // Emit BEFORE state change
    event::emit(InventoryChanged {
        item_id,
        old_quantity: old_qty,
        new_quantity: new_qty,
        change_reason: reason
    });

    // Update state
    set_quantity(inventory, item_id, new_qty);
}
```

### 5️⃣ **Best Practices and Optimization**

Professional event design.

**Practice 1: Emit events for all important actions**

```move
// ✅ GOOD: Emit events
public fun transfer(from: &mut Account, to: &mut Account, amount: u64) {
    // Update state
    from.balance -= amount;
    to.balance += amount;

    // Emit event
    event::emit(Transfer {
        from: from.address,
        to: to.address,
        amount
    });
}

// ❌ BAD: No events
public fun silent_transfer(from: &mut Account, to: &mut Account, amount: u64) {
    from.balance -= amount;
    to.balance += amount;
    // No way to know this happened!
}
```

**Practice 2: Include timestamps**

```move
// ✅ GOOD: Timestamp included
struct Event has copy, drop {
    data: u64,
    timestamp: u64  // When did this happen?
}

// ❌ BAD: No timestamp
struct Event has copy, drop {
    data: u64
    // When did this happen? Unknown!
}
```

**Practice 3: Use descriptive names**

```move
// ✅ GOOD: Clear names
struct UserRegistered has copy, drop { }
struct TokenMinted has copy, drop { }
struct OwnershipTransferred has copy, drop { }

// ❌ BAD: Vague names
struct Event1 has copy, drop { }
struct Action has copy, drop { }
struct Update has copy, drop { }
```

**Practice 4: Don't emit too much data**

```move
// ✅ GOOD: Essential data only
struct Transfer has copy, drop {
    from: address,
    to: address,
    amount: u64,
    token_id: u64
}

// ❌ BAD: Too much data
struct Transfer has copy, drop {
    from: address,
    to: address,
    amount: u64,
    token_id: u64,
    from_balance_history: vector<u64>,  // Unnecessary!
    to_balance_history: vector<u64>,    // Unnecessary!
    all_past_transfers: vector<u64>     // Way too much!
}
```

**Practice 5: Version your events**

```move
// Version 1
struct UserRegistered_V1 has copy, drop {
    user: address,
    timestamp: u64
}

// Version 2 (added fields)
struct UserRegistered_V2 has copy, drop {
    user: address,
    username: String,  // New field
    referrer: Option<address>,  // New field
    timestamp: u64
}

// Systems can handle both versions
```

**Practice 6: Make events testable**

```move
#[test]
fun test_event_emission() {
    let from = @0x123;
    let to = @0x456;
    let amount = 100u64;

    // Perform action
    transfer(from, to, amount);

    // In testing frameworks, can verify event was emitted
    // assert_event_emitted(Transfer { from, to, amount });
}
```

---

## 🎯 Activity / Exercises

### Exercise 1: Basic Event System 📡

**Scenario:** Build a simple voting system with comprehensive events.

**Boilerplate Code:**

```move
module spell_library::voting {
    use std::string::String;

    // TODO: Define VoteCase event
    struct VoteCast has ____, ____ {
        voter: address,
        proposal_id: u64,
        vote_value: bool,
        timestamp: u64
    }

    // TODO: Define ProposalCreated event
    struct ProposalCreated has copy, drop {
        proposal_id: ____,
        creator: ____,
        title: String,
        timestamp: u64
    }

    struct Proposal has key {
        id: u64,
        title: String,
        yes_votes: u64,
        no_votes: u64
    }

    public fun create_proposal(
        creator: address,
        id: u64,
        title: String
    ): Proposal {
        // TODO: Emit ProposalCreated event
        event::emit(ProposalCreated {
            proposal_id: ____,
            creator: ____,
            title: ____,
            timestamp: 1000  // Mock timestamp
        });

        Proposal {
            id,
            title,
            yes_votes: 0,
            no_votes: 0
        }
    }

    public fun cast_vote(
        proposal: &mut Proposal,
        voter: address,
        vote: bool
    ) {
        // Update vote count
        if (vote) {
            proposal.____ = proposal.yes_votes + 1;
        } else {
            proposal.____ = proposal.no_votes + 1;
        };

        // TODO: Emit VoteCast event
        event::emit(____ {
            voter: ____,
            proposal_id: proposal.____,
            vote_value: ____,
            timestamp: 1000
        });
    }

    public fun get_results(proposal: &Proposal): (u64, u64) {
        (proposal.____, proposal.____)
    }
}

#[test_only]
module spell_library::voting_tests {
    use spell_library::voting;
    use std::string;

    #[test]
    fun test_voting_system() {
        let mut proposal = voting::create_proposal(
            @0x123,
            1,
            string::utf8(b"Test Proposal")
        );

        voting::cast_vote(&mut proposal, @0x456, true);
        voting::cast_vote(&mut proposal, @0x789, false);
        voting::cast_vote(&mut proposal, @0xabc, true);

        let (yes, no) = voting::get_results(&proposal);
        assert!(yes == ____, 1);
        assert!(no == ____, 2);
    }
}
```

**Your Task:**

1. Define event structs with correct abilities
2. Emit ProposalCreated event
3. Emit VoteCast event
4. Complete vote counting logic
5. Verify events are emitted correctly

---

### Exercise 2: State Change Events 🔄

**Scenario:** Build an order system that tracks state transitions.

**Boilerplate Code:**

```move
module spell_library::orders {
    use std::string::String;

    // Order states
    const PENDING: u8 = 0;
    const CONFIRMED: u8 = 1;
    const SHIPPED: u8 = 2;
    const DELIVERED: u8 = 3;
    const CANCELLED: u8 = 4;

    struct OrderStateChanged has copy, drop {
        order_id: u64,
        old_state: u8,
        new_state: u8,
        changed_by: address,
        timestamp: u64
    }

    struct Order has key {
        id: u64,
        customer: address,
        state: u8,
        amount: u64
    }

    public fun create_order(
        customer: address,
        id: u64,
        amount: u64
    ): Order {
        Order {
            id,
            customer,
            state: ____,  // TODO: Initial state
            amount
        }
    }

    public fun transition_state(
        order: &mut Order,
        new_state: u8,
        actor: address
    ) {
        let old_state = order.____;

        // TODO: Emit state change event
        event::emit(OrderStateChanged {
            order_id: order.____,
            old_state: ____,
            new_state: ____,
            changed_by: ____,
            timestamp: 1000
        });

        // Update state
        order.____ = new_state;
    }

    public fun confirm_order(order: &mut Order, admin: address) {
        assert!(order.state == ____, 100);
        transition_state(order, ____, admin);
    }

    public fun ship_order(order: &mut Order, admin: address) {
        assert!(order.state == CONFIRMED, 101);
        transition_state(order, ____, admin);
    }

    public fun deliver_order(order: &mut Order, admin: address) {
        assert!(order.state == ____, 102);
        transition_state(order, DELIVERED, admin);
    }

    public fun cancel_order(order: &mut Order, admin: address) {
        transition_state(order, ____, admin);
    }
}

#[test_only]
module spell_library::order_tests {
    use spell_library::orders;

    #[test]
    fun test_order_lifecycle() {
        let mut order = orders::create_order(@0x123, 1, 1000);

        orders::confirm_order(&mut order, @0x999);
        orders::ship_order(&mut order, @0x999);
        orders::deliver_order(&mut order, @0x999);

        assert!(order.state == ____, 1);
    }

    #[test]
    fun test_order_cancellation() {
        let mut order = orders::create_order(@0x123, 2, 500);
        orders::cancel_order(&mut order, @0x999);

        assert!(order.state == ____, 1);
    }
}
```

**Your Task:**

1. Define initial order state
2. Implement state transition with events
3. Complete state transition functions
4. Track old and new states in events
5. Test full order lifecycle

---

### Exercise 3: Comprehensive Audit Trail 📝

**Scenario:** Build a bank system with complete audit logging.

**Boilerplate Code:**

```move
module spell_library::bank {
    struct DepositEvent has copy, drop {
        account: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64
    }

    struct WithdrawEvent has copy, drop {
        account: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        from_new_balance: u64,
        to_new_balance: u64,
        timestamp: u64
    }

    struct Account has key {
        owner: address,
        balance: u64
    }

    public fun create_account(owner: address): Account {
        Account {
            owner,
            balance: 0
        }
    }

    public fun deposit(account: &mut Account, amount: u64) {
        let old_balance = account.____;
        account.balance = old_balance + amount;

        // TODO: Emit deposit event
        event::emit(____ {
            account: account.____,
            amount: ____,
            new_balance: account.____,
            timestamp: 1000
        });
    }

    public fun withdraw(account: &mut Account, amount: u64) {
        assert!(account.balance >= ____, 100);

        let old_balance = account.balance;
        account.balance = old_balance - ____;

        // TODO: Emit withdraw event
        event::emit(WithdrawEvent {
            account: account.owner,
            amount: ____,
            new_balance: ____,
            timestamp: 1000
        });
    }

    public fun transfer(
        from: &mut Account,
        to: &mut Account,
        amount: u64
    ) {
        assert!(from.balance >= amount, 101);

        from.balance = from.balance - ____;
        to.balance = to.balance + ____;

        // TODO: Emit transfer event
        event::emit(____ {
            from: from.____,
            to: to.owner,
            amount: ____,
            from_new_balance: from.____,
            to_new_balance: to.balance,
            timestamp: 1000
        });
    }

    public fun get_balance(account: &Account): u64 {
        account.____
    }
}

#[test_only]
module spell_library::bank_tests {
    use spell_library::bank;

    #[test]
    fun test_deposit() {
        let mut account = bank::create_account(@0x123);
        bank::deposit(&mut account, 500);

        assert!(bank::get_balance(&account) == ____, 1);
    }

    #[test]
    fun test_transfer() {
        let mut account1 = bank::create_account(@0x123);
        let mut account2 = bank::create_account(@0x456);

        bank::deposit(&mut account1, 1000);
        bank::transfer(&mut account1, &mut account2, 300);

        assert!(bank::get_balance(&account1) == ____, 1);
        assert!(bank::get_balance(&account2) == ____, 2);
    }

    #[test]
    #[expected_failure]
    fun test_insufficient_funds() {
        let mut account = bank::create_account(@0x123);
        bank::withdraw(&mut account, 100);  // Should fail
    }
}
```

**Your Task:**

1. Emit deposit events with balance tracking
2. Emit withdraw events with validation
3. Emit transfer events with both account states
4. Complete all balance operations
5. Test full audit trail

---

## ✅ Full Answers

[Full solutions provided - continuing in next response due to length]

### Exercise 1: Complete Solution

```move
module spell_library::voting {
    use std::string::String;

    struct VoteCast has copy, drop {
        voter: address,
        proposal_id: u64,
        vote_value: bool,
        timestamp: u64
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        creator: address,
        title: String,
        timestamp: u64
    }

    struct Proposal has key {
        id: u64,
        title: String,
        yes_votes: u64,
        no_votes: u64
    }

    public fun create_proposal(
        creator: address,
        id: u64,
        title: String
    ): Proposal {
        event::emit(ProposalCreated {
            proposal_id: id,
            creator,
            title,
            timestamp: 1000
        });

        Proposal {
            id,
            title,
            yes_votes: 0,
            no_votes: 0
        }
    }

    public fun cast_vote(
        proposal: &mut Proposal,
        voter: address,
        vote: bool
    ) {
        if (vote) {
            proposal.yes_votes = proposal.yes_votes + 1;
        } else {
            proposal.no_votes = proposal.no_votes + 1;
        };

        event::emit(VoteCast {
            voter,
            proposal_id: proposal.id,
            vote_value: vote,
            timestamp: 1000
        });
    }

    public fun get_results(proposal: &Proposal): (u64, u64) {
        (proposal.yes_votes, proposal.no_votes)
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::orders {
    use std::string::String;

    const PENDING: u8 = 0;
    const CONFIRMED: u8 = 1;
    const SHIPPED: u8 = 2;
    const DELIVERED: u8 = 3;
    const CANCELLED: u8 = 4;

    struct OrderStateChanged has copy, drop {
        order_id: u64,
        old_state: u8,
        new_state: u8,
        changed_by: address,
        timestamp: u64
    }

    struct Order has key {
        id: u64,
        customer: address,
        state: u8,
        amount: u64
    }

    public fun create_order(
        customer: address,
        id: u64,
        amount: u64
    ): Order {
        Order {
            id,
            customer,
            state: PENDING,
            amount
        }
    }

    public fun transition_state(
        order: &mut Order,
        new_state: u8,
        actor: address
    ) {
        let old_state = order.state;

        event::emit(OrderStateChanged {
            order_id: order.id,
            old_state,
            new_state,
            changed_by: actor,
            timestamp: 1000
        });

        order.state = new_state;
    }

    public fun confirm_order(order: &mut Order, admin: address) {
        assert!(order.state == PENDING, 100);
        transition_state(order, CONFIRMED, admin);
    }

    public fun ship_order(order: &mut Order, admin: address) {
        assert!(order.state == CONFIRMED, 101);
        transition_state(order, SHIPPED, admin);
    }

    public fun deliver_order(order: &mut Order, admin: address) {
        assert!(order.state == SHIPPED, 102);
        transition_state(order, DELIVERED, admin);
    }

    public fun cancel_order(order: &mut Order, admin: address) {
        transition_state(order, CANCELLED, admin);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::bank {
    struct DepositEvent has copy, drop {
        account: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64
    }

    struct WithdrawEvent has copy, drop {
        account: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        from_new_balance: u64,
        to_new_balance: u64,
        timestamp: u64
    }

    struct Account has key {
        owner: address,
        balance: u64
    }

    public fun create_account(owner: address): Account {
        Account { owner, balance: 0 }
    }

    public fun deposit(account: &mut Account, amount: u64) {
        account.balance = account.balance + amount;

        event::emit(DepositEvent {
            account: account.owner,
            amount,
            new_balance: account.balance,
            timestamp: 1000
        });
    }

    public fun withdraw(account: &mut Account, amount: u64) {
        assert!(account.balance >= amount, 100);
        account.balance = account.balance - amount;

        event::emit(WithdrawEvent {
            account: account.owner,
            amount,
            new_balance: account.balance,
            timestamp: 1000
        });
    }

    public fun transfer(
        from: &mut Account,
        to: &mut Account,
        amount: u64
    ) {
        assert!(from.balance >= amount, 101);

        from.balance = from.balance - amount;
        to.balance = to.balance + amount;

        event::emit(TransferEvent {
            from: from.owner,
            to: to.owner,
            amount,
            from_new_balance: from.balance,
            to_new_balance: to.balance,
            timestamp: 1000
        });
    }

    public fun get_balance(account: &Account): u64 {
        account.balance
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Basic Events

**Event emission pattern:**

```move
event::emit(ProposalCreated { ... });
// Announces proposal creation to all listeners
```

**Why emit events:**

- Frontend can update UI instantly
- Indexers can build searchable databases
- Analytics can track voting patterns

### Exercise 2 Explanation: State Tracking

**State transition events:**

```move
OrderStateChanged {
    old_state,
    new_state,
    ...
}
// Full state history through events
```

**Benefits:**

- Can replay state changes
- Build timeline UI
- Audit who changed what when

### Exercise 3 Explanation: Audit Trail

**Comprehensive logging:**

```move
event::emit(TransferEvent {
    from, to, amount,
    from_new_balance,
    to_new_balance
});
// Every account change tracked
```

**Use cases:**

- Regulatory compliance
- User activity feeds
- Fraud detection

---

## 🧪 Unit Tests

```move
#[test_only]
module spell_library::event_lesson_tests {
    use spell_library::voting_tests;
    use spell_library::order_tests;
    use spell_library::bank_tests;

    #[test]
    fun run_all_voting_tests() {
        voting_tests::test_voting_system();
    }

    #[test]
    fun run_all_order_tests() {
        order_tests::test_order_lifecycle();
        order_tests::test_order_cancellation();
    }

    #[test]
    fun run_all_bank_tests() {
        bank_tests::test_deposit();
        bank_tests::test_transfer();
    }

    #[test]
    #[expected_failure]
    fun verify_insufficient_funds() {
        bank_tests::test_insufficient_funds();
    }
}
```

---

## 🌟 Closing Story

Master Chronica stands with Odessa in the Observatory, now fully synchronized with the blockchain's event stream. Every action, every state change, every transition perfectly visible.

> "You've mastered events," Chronica says, voice resonating with satisfaction. "Your contracts are no longer black boxes. They announce their actions. They create audit trails. They enable frontends to react instantly and indexers to build rich query layers."

> "This is observable architecture. Every important action emits an event. Every state change is tracked. Every modification is logged. External systems can listen, react, and build upon your contracts."

The keeper gestures to the flowing event streams.

> "Remember: events are cheap, comprehensive, and permanent. Emit them liberally. Include timestamps. Use descriptive names. Make your contracts tell their story."

Chronica's form shimmers with knowledge.

> "Your next lesson: generics. You'll learn how to write code that works with any type—type parameters, constraints, phantom types, and generic programming patterns. Events made your code observable. Generics will make it reusable."

The observatory fades into pure light.

> "Go. Build observable systems. Emit events. Trust that observers are listening."

---

**Next Lesson:** Generics in Move - writing type-safe, reusable code with type parameters.
