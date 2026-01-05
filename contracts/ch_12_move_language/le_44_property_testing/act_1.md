# Activity 1: Property Testing

## Task

You're testing a token module. Write a test that verifies the **preservation property**: when tokens are transferred, the total supply remains unchanged.

Complete the property test function below.

## Starter Code

```move
#[test_only]
module test_addr::token_property_tests {
    use token::coin;

    #[test]
    fun test_transfer_preserves_total_supply() {
        let alice = @0x1;
        let bob = @0x2;

        // Setup: Mint tokens to Alice
        coin::mint(alice, 1000);

        // TODO: Step 1 - Record the total supply before transfer
        // Hint: Use coin::total_supply()

        // TODO: Step 2 - Transfer 300 tokens from Alice to Bob
        // Hint: Use coin::transfer(from, to, amount)

        // TODO: Step 3 - Record the total supply after transfer

        // TODO: Step 4 - Assert the invariant: total supply is preserved
        // The total supply before should equal total supply after
    }
}
```

## Requirements

1. Record the total supply before the transfer
2. Execute a transfer of 300 tokens from Alice to Bob
3. Record the total supply after the transfer
4. Assert that the total supply before equals the total supply after (preservation property)
