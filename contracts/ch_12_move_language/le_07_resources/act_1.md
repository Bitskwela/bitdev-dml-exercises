### Move module activity

```move
module ticket_system::tickets {
    use std::signer;

    /// Error codes
    const E_TICKET_EXISTS: u64 = 1;
    const E_TICKET_NOT_FOUND: u64 = 2;

    // TODO: Define the Ticket resource with `key` ability only

    // TODO: Implement mint_ticket function

    // TODO: Implement burn_ticket function

    // TODO: Implement transfer_ticket function
}
```

## Tasks for Learners

- Create a `Ticket` struct with only the `key` ability (making it a resource):

  - Field `id` of type `u64`
  - Field `event_name` of type `vector<u8>`
  - Field `seat_number` of type `u64`
  - Field `owner` of type `address`

  ```move
  struct Ticket has key {
      id: u64,
      event_name: vector<u8>,
      seat_number: u64,
      owner: address,
  }
  ```

- Implement `mint_ticket` function to create and store a ticket:

  - Use `move_to` to store the resource in the recipient's account
  - Check that a ticket doesn't already exist

  ```move
  public fun mint_ticket(
      recipient: &signer,
      id: u64,
      event_name: vector<u8>,
      seat_number: u64
  ) {
      let addr = signer::address_of(recipient);
      assert!(!exists<Ticket>(addr), E_TICKET_EXISTS);
      let ticket = Ticket {
          id,
          event_name,
          seat_number,
          owner: addr,
      };
      move_to(recipient, ticket);
  }
  ```

- Implement `burn_ticket` function to remove and destroy a ticket:

  - Use `move_from` to extract the resource
  - Destructure the ticket to consume it

  ```move
  public fun burn_ticket(owner: &signer) acquires Ticket {
      let addr = signer::address_of(owner);
      assert!(exists<Ticket>(addr), E_TICKET_NOT_FOUND);
      let Ticket { id: _, event_name: _, seat_number: _, owner: _ } = move_from<Ticket>(addr);
  }
  ```

- Implement `transfer_ticket` function to move a ticket between accounts:

  - Extract from sender using `move_from`
  - Update owner field
  - Store to recipient using `move_to`

  ```move
  public fun transfer_ticket(from: &signer, to: &signer) acquires Ticket {
      let from_addr = signer::address_of(from);
      let to_addr = signer::address_of(to);
      assert!(exists<Ticket>(from_addr), E_TICKET_NOT_FOUND);
      assert!(!exists<Ticket>(to_addr), E_TICKET_EXISTS);
      let Ticket { id, event_name, seat_number, owner: _ } = move_from<Ticket>(from_addr);
      let new_ticket = Ticket { id, event_name, seat_number, owner: to_addr };
      move_to(to, new_ticket);
  }
  ```

### Breakdown for learners

- **Resources:** Structs with `key` ability but without `copy` or `drop` are called resources

- **Linear Types:** Resources cannot be copied or accidentally dropped—they must be explicitly handled

- **Ownership Model:** A resource exists in exactly one place at a time

- **`move_to(signer, resource)`:** Publishes a resource to the signer's address

- **`move_from<T>(address)`:** Removes and returns a resource from an address (requires `acquires`)

- **`exists<T>(address)`:** Checks if a resource exists at an address

- **Destructuring:** To destroy a resource without `drop`, destructure it: `let Ticket { field1: _, ... } = ticket;`

- **`acquires` Keyword:** Functions that use `move_from` or `borrow_global` must declare `acquires ResourceType`
