# Activity 1: Village Project Workflow

## Managing Community Projects

Ronnie and Odessa are helping the village manage community improvement projects. Each project goes through several stages, and it's critical that no step is skipped.

"A project must follow the proper workflow," Ronnie explained. "You can't start building before the plans are approved!"

---

## The Project Workflow

Projects follow this state flow:

```
PROPOSED → APPROVED → FUNDED → IN_PROGRESS → COMPLETED
    ↓         ↓         ↓
 REJECTED  REJECTED  CANCELLED
```

- **PROPOSED**: Initial submission
- **APPROVED**: Council has approved the plan
- **FUNDED**: Budget has been allocated
- **IN_PROGRESS**: Work has started
- **COMPLETED**: Project finished successfully
- **REJECTED**: Not approved (terminal)
- **CANCELLED**: Stopped after funding (terminal)

---

## Your Task

Complete the `village_projects` module to implement this state machine:

1. **Define state constants** for all 7 states
2. **Create the Project struct** with appropriate fields
3. **Implement transition functions** that validate state changes
4. **Add a state query function** to check if a project is active

---

## Starter Code

```move
module village::village_projects {
    use std::signer;

    // TODO 1: Define state constants
    // PROPOSED = 0, APPROVED = 1, FUNDED = 2, IN_PROGRESS = 3
    // COMPLETED = 4, REJECTED = 5, CANCELLED = 6


    // Error codes
    const E_INVALID_TRANSITION: u64 = 1;
    const E_PROJECT_NOT_FOUND: u64 = 2;

    // TODO 2: Define the Project struct with:
    // - id: u64
    // - state: u8
    // - title: vector<u8>
    // - budget: u64
    // - owner: address


    // TODO 3: Implement create_project
    // Creates a new project in PROPOSED state
    public fun create_project(
        account: &signer,
        id: u64,
        title: vector<u8>,
        budget: u64
    ) {
        // Your code here
    }

    // TODO 4: Implement approve_project
    // Transitions from PROPOSED to APPROVED
    public fun approve_project(account: &signer) acquires Project {
        // Your code here
    }

    // TODO 5: Implement fund_project
    // Transitions from APPROVED to FUNDED
    public fun fund_project(account: &signer) acquires Project {
        // Your code here
    }

    // TODO 6: Implement start_project
    // Transitions from FUNDED to IN_PROGRESS
    public fun start_project(account: &signer) acquires Project {
        // Your code here
    }

    // TODO 7: Implement complete_project
    // Transitions from IN_PROGRESS to COMPLETED
    public fun complete_project(account: &signer) acquires Project {
        // Your code here
    }

    // TODO 8: Implement reject_project
    // Can only reject from PROPOSED or APPROVED states
    public fun reject_project(account: &signer) acquires Project {
        // Your code here
    }

    // TODO 9: Implement cancel_project
    // Can only cancel from FUNDED state
    public fun cancel_project(account: &signer) acquires Project {
        // Your code here
    }

    // TODO 10: Implement is_active
    // Returns true if project is in PROPOSED, APPROVED, FUNDED, or IN_PROGRESS
    public fun is_active(account_addr: address): bool acquires Project {
        // Your code here
    }
}
```

---

## Requirements

- Each transition function must validate the current state
- Invalid transitions must abort with `E_INVALID_TRANSITION`
- `reject_project` works from PROPOSED or APPROVED only
- `cancel_project` works from FUNDED only
- Terminal states (COMPLETED, REJECTED, CANCELLED) cannot transition

---

## Hints

- Use `assert!` to validate state before transitioning
- Use `borrow_global_mut` to modify the project state
- Remember that `||` is the OR operator for checking multiple valid states
- The Project struct needs `key` ability to be stored as a resource

---

## Test Your Understanding

After completing the activity, consider:

1. Why can't you cancel a project that's IN_PROGRESS?
2. What would happen if you tried to approve a FUNDED project?
3. How would you add a PAUSED state to this workflow?
