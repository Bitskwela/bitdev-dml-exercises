# Integration Testing

EJ was reviewing some test results when Ronnie walked over, looking puzzled.

"EJ, I've been writing unit tests for each module separately, and they all pass," Ronnie said. "But when I deploy everything together, things break. What am I missing?"

EJ nodded knowingly. "You're missing **integration tests**. Unit tests verify individual modules work correctly in isolation. Integration tests verify that multiple modules work correctly _together_."

## Why Integration Testing Matters

"Think of it like this," EJ explained. "You can test that a car's engine works perfectly, and the wheels spin correctly, and the steering responds properly. But you still need to test that when you put them all together, the car actually drives."

In Move, modules often depend on each other:

- A marketplace module might call a token module
- A game module might interact with a rewards module
- A governance module might update a treasury module

## Multi-Module Test Structure

```move
#[test_only]
module test_addr::integration_tests {
    use marketplace::listing;
    use marketplace::token;
    use marketplace::escrow;

    #[test]
    fun test_full_purchase_flow() {
        // Setup: Create accounts
        let seller = @0x1;
        let buyer = @0x2;

        // Step 1: Seller creates a token
        token::mint(seller, 100);

        // Step 2: Seller lists the token
        listing::create(seller, 50, 10); // 50 tokens at price 10

        // Step 3: Buyer purchases through escrow
        escrow::initiate_purchase(buyer, seller, 50);

        // Step 4: Verify final state across all modules
        assert!(token::balance(seller) == 50, 1);
        assert!(token::balance(buyer) == 50, 2);
        assert!(listing::is_closed(seller), 3);
    }
}
```

Ronnie studied the example. "So we're testing the entire flow across multiple modules?"

"Exactly," EJ confirmed. "Each step touches a different module, but together they represent a real user scenario."

## Testing Module Interactions

"The key is to test the _boundaries_ between modules," EJ continued.

```move
#[test]
fun test_module_callback() {
    // Module A calls Module B, which calls back to Module A
    let initial_state = module_a::get_state();

    // This triggers: A -> B -> A
    module_a::trigger_interaction();

    let final_state = module_a::get_state();
    assert!(final_state != initial_state, 1);
}

#[test]
#[expected_failure(abort_code = ERR_INSUFFICIENT_FUNDS)]
fun test_cross_module_failure() {
    // Test that failures propagate correctly across modules
    token::mint(@0x1, 10);

    // This should fail because listing requires more tokens than available
    listing::create(@0x1, 100, 5); // Trying to list 100 when only 10 exist
}
```

## Test Isolation

Ronnie raised a concern. "What if one test affects another?"

"Great question! Each test runs in isolation," EJ assured. "The blockchain state resets between tests. But within a single test, state persists across module calls—that's what makes integration testing possible."

```move
#[test]
fun test_state_persists_within_test() {
    // State from step 1...
    registry::register(@0x1, b"Alice");

    // ...is visible in step 2
    let name = registry::get_name(@0x1);
    assert!(name == b"Alice", 1);

    // ...and can be modified in step 3
    permissions::grant(@0x1, ADMIN_ROLE);

    // ...with changes visible in step 4
    assert!(permissions::has_role(@0x1, ADMIN_ROLE), 2);
}
```

Ronnie smiled. "This makes so much more sense now. Test the parts, then test them together!"

"That's the integration testing mindset," EJ agreed.
