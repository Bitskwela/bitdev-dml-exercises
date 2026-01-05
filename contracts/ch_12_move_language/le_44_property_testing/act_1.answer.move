#[test_only]
module test_addr::token_property_tests {
    use token::coin;
    
    #[test]
    fun test_transfer_preserves_total_supply() {
        let alice = @0x1;
        let bob = @0x2;
        
        // Setup: Mint tokens to Alice
        coin::mint(alice, 1000);
        
        // Step 1 - Record the total supply before transfer
        let supply_before = coin::total_supply();
        
        // Step 2 - Transfer 300 tokens from Alice to Bob
        coin::transfer(alice, bob, 300);
        
        // Step 3 - Record the total supply after transfer
        let supply_after = coin::total_supply();
        
        // Step 4 - Assert the invariant: total supply is preserved
        assert!(supply_before == supply_after, 1);
    }
}
