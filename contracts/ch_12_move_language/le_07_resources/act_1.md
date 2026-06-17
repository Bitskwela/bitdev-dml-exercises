### Move module activity

You are building MoveStack's ticket system. A `Ticket` is a true resource: it can be
minted, burned, and transferred, but it can never be copied, lost, or forged. Along the
way you will discover something important — naively transferring a resource to a bare
`address` does **not** work in Move, so the lesson keeps the broken `transfer_ticket`
around (it aborts on purpose) and introduces the correct `transfer_with_signer` that
both parties sign off on.

```move
module ticket_system::tickets {
    use std::signer;
    use std::vector;

    /// Error codes
    const E_TICKET_EXISTS: u64 = 1;
    const E_TICKET_NOT_FOUND: u64 = 2;
    const E_INVALID_PARAMS: u64 = 3;
    const E_SAME_ADDRESS: u64 = 4;
    const E_RECIPIENT_HAS_TICKET: u64 = 5;

    // TODO: Define the Ticket resource with `key` ability only

    // TODO: Define the TicketRegistry resource with `key` ability

    // TODO: Implement initialize_registry (move_to)

    // TODO: Implement is_registry_initialized (exists)

    // TODO: Implement mint_ticket (move_to)

    // TODO: Implement burn_ticket (move_from + destructure)

    // TODO: Implement transfer_ticket — the naive version that aborts

    // TODO: Implement move_to_address helper — aborts on purpose

    // TODO: Implement transfer_with_signer — the version that actually works

    // TODO: Implement view functions (has_ticket, get_ticket_info, ...)
}
```

## Tasks for Learners

The whole module lives in `module ticket_system::tickets`. Build the members below in
order — each snippet is copied straight from the working solution.

- Define the **`Ticket`** resource with **only** the `key` ability. No `copy`, no `drop` — that is what makes it a linear resource:

  ```move
  struct Ticket has key {
      /// Unique identifier for the ticket
      id: u64,
      /// Name of the event (stored as bytes)
      event_name: vector<u8>,
      /// Assigned seat number
      seat_number: u64,
      /// Current owner's address
      owner: address,
  }
  ```

- Define the **`TicketRegistry`** resource (also `key`) that tracks every minted ID:

  ```move
  struct TicketRegistry has key {
      /// List of all ticket IDs that have been minted
      minted_ids: vector<u64>,
      /// Counter for total tickets ever created
      total_minted: u64,
      /// Counter for total tickets burned
      total_burned: u64,
  }
  ```

- Implement **`initialize_registry`** to publish the registry under the admin (uses `move_to`, so no `acquires` needed):

  ```move
  public fun initialize_registry(admin: &signer) {
      let registry = TicketRegistry {
          minted_ids: vector::empty(),
          total_minted: 0,
          total_burned: 0,
      };
      move_to(admin, registry);
  }
  ```

- Implement **`is_registry_initialized`** using `exists` (no `acquires` needed):

  ```move
  public fun is_registry_initialized(addr: address): bool {
      exists<TicketRegistry>(addr)
  }
  ```

- Implement **`mint_ticket`** — create a `Ticket` and store it with `move_to`. Reject the mint if the recipient already holds a ticket:

  ```move
  public fun mint_ticket(
      recipient: &signer,
      id: u64,
      event_name: vector<u8>,
      seat_number: u64
  ) {
      let recipient_addr = signer::address_of(recipient);

      // Ensure recipient doesn't already have a ticket
      assert!(!exists<Ticket>(recipient_addr), E_TICKET_EXISTS);

      // Create the ticket resource
      let ticket = Ticket {
          id,
          event_name,
          seat_number,
          owner: recipient_addr,
      };

      // Store the ticket in the recipient's account
      // move_to takes ownership of the resource
      move_to(recipient, ticket);
  }
  ```

- Implement **`burn_ticket`** — pull the resource out with `move_from`, then destructure it so all fields are consumed (a resource has no `drop`, so it must be torn apart explicitly). This function reads global storage, so it declares `acquires Ticket`:

  ```move
  public fun burn_ticket(owner: &signer) acquires Ticket {
      let owner_addr = signer::address_of(owner);

      // Ensure the ticket exists
      assert!(exists<Ticket>(owner_addr), E_TICKET_NOT_FOUND);

      // Extract the ticket from storage
      // move_from takes ownership of the resource
      let ticket = move_from<Ticket>(owner_addr);

      // Destructure to destroy the resource
      // All fields must be handled (used or discarded with _)
      let Ticket {
          id: _,
          event_name: _,
          seat_number: _,
          owner: _,
      } = ticket;

      // The ticket resource no longer exists anywhere
  }
  ```

- Implement **`transfer_ticket`** — the *naive* version. It validates the move, extracts the ticket, rebuilds it with the new owner, and then hands off to a helper. **This version is intentionally broken** because Move cannot publish a resource to a bare `address` (you need the recipient's `signer`). It compiles and is the teaching foil for the working version below:

  ```move
  public fun transfer_ticket(
      from: &signer,
      to_address: address
  ) acquires Ticket {
      let from_addr = signer::address_of(from);

      // Validate transfer
      assert!(exists<Ticket>(from_addr), E_TICKET_NOT_FOUND);
      assert!(from_addr != to_address, E_SAME_ADDRESS);
      assert!(!exists<Ticket>(to_address), E_RECIPIENT_HAS_TICKET);

      // Extract ticket from sender
      let ticket = move_from<Ticket>(from_addr);

      // Update the owner field
      // Note: We need to destructure and reconstruct since fields aren't directly mutable
      let Ticket { id, event_name, seat_number, owner: _ } = ticket;

      let updated_ticket = Ticket {
          id,
          event_name,
          seat_number,
          owner: to_address,
      };

      // Store in recipient's account
      // This requires a different approach in real implementations
      // For this example, we demonstrate the concept
      move_to_address(to_address, updated_ticket);
  }
  ```

- Implement the **`move_to_address`** helper that `transfer_ticket` calls. It **aborts on purpose** — there is no way to publish a resource to an address without that account's signer, so this documents the dead end and points learners at `transfer_with_signer`:

  ```move
  fun move_to_address(addr: address, ticket: Ticket) {
      // In practice, this would require the recipient to have called
      // a function to "accept" the transfer, or use a different pattern
      // like storing in a shared resource or using object model

      // For demonstration, we'll abort - see transfer_with_signer for proper impl
      abort E_INVALID_PARAMS
  }
  ```

- Implement **`transfer_with_signer`** — the version that actually works. Because *both* parties supply a `signer`, the recipient can receive the resource via `move_to`. This is the real ownership-transfer pattern: extract from sender, rebuild with the new owner, publish to the recipient:

  ```move
  public fun transfer_with_signer(
      from: &signer,
      to: &signer
  ) acquires Ticket {
      let from_addr = signer::address_of(from);
      let to_addr = signer::address_of(to);

      // Validate
      assert!(exists<Ticket>(from_addr), E_TICKET_NOT_FOUND);
      assert!(from_addr != to_addr, E_SAME_ADDRESS);
      assert!(!exists<Ticket>(to_addr), E_RECIPIENT_HAS_TICKET);

      // Extract from sender
      let ticket = move_from<Ticket>(from_addr);

      // Reconstruct with new owner
      let Ticket { id, event_name, seat_number, owner: _ } = ticket;
      let updated_ticket = Ticket {
          id,
          event_name,
          seat_number,
          owner: to_addr,
      };

      // Store with recipient's signer
      move_to(to, updated_ticket);
  }
  ```

- Add the read-only **view functions**. `has_ticket` only uses `exists` so it needs no `acquires`; the rest borrow from global storage and declare `acquires Ticket`:

  ```move
  public fun has_ticket(addr: address): bool {
      exists<Ticket>(addr)
  }

  public fun get_ticket_info(addr: address): (u64, vector<u8>, u64, address) acquires Ticket {
      assert!(exists<Ticket>(addr), E_TICKET_NOT_FOUND);

      let ticket = borrow_global<Ticket>(addr);
      (ticket.id, *&ticket.event_name, ticket.seat_number, ticket.owner)
  }
  ```

- **(Optional / bonus)** The instructor solution also ships registry-aware variants and extra getters — `mint_ticket_with_registry`, `burn_ticket_with_registry`, `get_ticket_id`, `get_event_name`, `get_seat_number`, `get_registry_stats` — plus a full `#[test]` suite. These reinforce the same `acquires` + `move_from`/`move_to` patterns; implement them if you want extra practice, but the core resource lifecycle above is what this lesson is teaching.

### Breakdown for learners

- **Resources:** Structs with the `key` ability but **no** `copy` or `drop` are resources. `Ticket` is exactly this.

- **Linear Types:** A resource cannot be copied or silently dropped — it must be explicitly moved, stored, or destructured.

- **Ownership Model:** A resource exists in exactly one place at a time. During a transfer there is never a moment where two copies exist.

- **`move_to(signer, resource)`:** Publishes a resource to the **signer's** address. You need a `signer`, not just an `address` — this is why `transfer_ticket` fails and `transfer_with_signer` succeeds.

- **`move_from<T>(address)`:** Removes and returns a resource from an address (requires `acquires T`).

- **`exists<T>(address)`:** Checks whether a resource lives at an address (no `acquires` needed).

- **Destructuring to destroy:** With no `drop` ability, the only way to consume a `Ticket` is to take it apart: `let Ticket { id: _, ... } = ticket;`.

- **`acquires` keyword:** Any function that uses `move_from` or `borrow_global` on `Ticket` must declare `acquires Ticket`. Functions that only `move_to` or call `exists` do not.

- **Why two transfer functions?** `transfer_ticket(from, to_address)` looks reasonable but cannot finish — Move has no way to deposit a resource into an account you do not hold a `signer` for, so its helper aborts. `transfer_with_signer(from, to)` is the correct, working pattern because the recipient signs for the deposit.
