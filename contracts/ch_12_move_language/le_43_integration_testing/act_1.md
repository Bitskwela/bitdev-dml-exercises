# Activity 1: Integration Testing

## Task

You're building a simple reward system with two modules: `points` and `rewards`. Write an integration test that verifies the complete flow:

1. A user earns points
2. The user redeems points for a reward
3. Both modules reflect the correct final state

Complete the integration test function below.

## Starter Code

```move
#[test_only]
module test_addr::reward_integration_tests {
    use reward_system::points;
    use reward_system::rewards;

    const REWARD_COST: u64 = 100;

    #[test]
    fun test_earn_and_redeem_flow() {
        let user = @0x1;

        // TODO: Step 1 - User earns 150 points
        // Hint: Use points::earn(user, amount)

        // TODO: Step 2 - User redeems a reward (costs 100 points)
        // Hint: Use rewards::redeem(user, REWARD_COST)

        // TODO: Step 3 - Assert user has 50 points remaining
        // Hint: Use points::balance(user)

        // TODO: Step 4 - Assert user has 1 reward
        // Hint: Use rewards::count(user)
    }
}
```

## Requirements

1. Call `points::earn` to give the user 150 points
2. Call `rewards::redeem` to redeem a reward costing 100 points
3. Assert that the user's point balance is now 50
4. Assert that the user's reward count is 1
