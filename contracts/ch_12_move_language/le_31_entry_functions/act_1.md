## Smart contract activity

```move
module movestack::voting {
    use std::signer;

    struct Voter has key {
        has_voted: bool,
        vote_choice: u64
    }

    struct Proposal has key {
        yes_votes: u64,
        no_votes: u64
    }

    // TODO: Make this callable from a transaction
    public fun initialize_proposal(admin: &signer) {
        move_to(admin, Proposal { yes_votes: 0, no_votes: 0 });
    }

    // TODO: Make this a transaction entry point (not callable from other modules)
    public fun register_voter(account: &signer) {
        move_to(account, Voter { has_voted: false, vote_choice: 0 });
    }

    // TODO: Make this callable from both transactions and other modules
    public fun cast_vote(voter: &signer, proposal_addr: address, vote_yes: bool) acquires Voter, Proposal {
        let voter_addr = signer::address_of(voter);
        let voter_data = borrow_global_mut<Voter>(voter_addr);

        assert!(!voter_data.has_voted, 1);
        voter_data.has_voted = true;

        let proposal = borrow_global_mut<Proposal>(proposal_addr);
        if (vote_yes) {
            voter_data.vote_choice = 1;
            proposal.yes_votes = proposal.yes_votes + 1;
        } else {
            voter_data.vote_choice = 2;
            proposal.no_votes = proposal.no_votes + 1;
        }
    }

    // This helper should remain callable only from other modules (no changes needed)
    public fun get_results(proposal_addr: address): (u64, u64) acquires Proposal {
        let proposal = borrow_global<Proposal>(proposal_addr);
        (proposal.yes_votes, proposal.no_votes)
    }
}
```

## Tasks for Learners

Add entry modifiers to functions that need to be called from transactions. Choose the appropriate visibility based on each function's purpose.

- Add `entry` to `initialize_proposal` to make it callable from transactions (keep `public` for module access):

  ```move
  public entry fun initialize_proposal(admin: &signer) {
      move_to(admin, Proposal { yes_votes: 0, no_votes: 0 });
  }
  ```

- Change `register_voter` to be entry-only (remove `public`, add `entry`) since it's an internal registration:

  ```move
  entry fun register_voter(account: &signer) {
      move_to(account, Voter { has_voted: false, vote_choice: 0 });
  }
  ```

- Add `entry` to `cast_vote` while keeping `public` for maximum flexibility:

  ```move
  public entry fun cast_vote(voter: &signer, proposal_addr: address, vote_yes: bool) acquires Voter, Proposal {
      let voter_addr = signer::address_of(voter);
      let voter_data = borrow_global_mut<Voter>(voter_addr);

      assert!(!voter_data.has_voted, 1);
      voter_data.has_voted = true;

      let proposal = borrow_global_mut<Proposal>(proposal_addr);
      if (vote_yes) {
          voter_data.vote_choice = 1;
          proposal.yes_votes = proposal.yes_votes + 1;
      } else {
          voter_data.vote_choice = 2;
          proposal.no_votes = proposal.no_votes + 1;
      }
  }
  ```

- `get_results` remains as `public fun` because it returns a value (entry functions cannot return values):

  ```move
  public fun get_results(proposal_addr: address): (u64, u64) acquires Proposal {
      let proposal = borrow_global<Proposal>(proposal_addr);
      (proposal.yes_votes, proposal.no_votes)
  }
  ```

### Breakdown for learners

**Entry functions** are the only functions that can be called directly from blockchain transactions. They serve as the public API for external users.

**Three visibility options:**

- `entry fun` → Transaction-callable only (not from other modules)
- `public entry fun` → Callable from both transactions AND other modules
- `public fun` → Callable from other modules only (not from transactions)

**Entry function restrictions:**

- Cannot return values to the transaction caller
- Parameters must be transaction-compatible types: `&signer`, primitives, `vector<u8>`, `String`, `address`
- The `&signer` parameter represents who signed the transaction

**When to use each:**

| Modifier           | Use Case                                                   |
| ------------------ | ---------------------------------------------------------- |
| `entry fun`        | Internal operations only users should trigger directly     |
| `public entry fun` | Core API functions for both users and composability        |
| `public fun`       | Helper functions that return values or are module-internal |

**Why `get_results` stays as `public fun`:**

Entry functions cannot return values. Since `get_results` returns `(u64, u64)`, it must remain a regular `public fun`. Other modules can call it, or it can be wrapped by a view function.
