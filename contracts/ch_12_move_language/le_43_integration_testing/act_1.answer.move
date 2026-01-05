#[test_only]
module test_addr::reward_integration_tests {
    use reward_system::points;
    use reward_system::rewards;
    
    const REWARD_COST: u64 = 100;
    
    #[test]
    fun test_earn_and_redeem_flow() {
        let user = @0x1;
        
        // Step 1 - User earns 150 points
        points::earn(user, 150);
        
        // Step 2 - User redeems a reward (costs 100 points)
        rewards::redeem(user, REWARD_COST);
        
        // Step 3 - Assert user has 50 points remaining
        assert!(points::balance(user) == 50, 1);
        
        // Step 4 - Assert user has 1 reward
        assert!(rewards::count(user) == 1, 2);
    }
}
