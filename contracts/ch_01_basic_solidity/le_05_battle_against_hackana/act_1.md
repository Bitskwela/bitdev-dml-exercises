## Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CommunityFund {
    address public fundOwner;
    uint256 public totalDonations;

    constructor() {
        fundOwner = msg.sender;
    }

    function donate(uint256 amount) public payable {
        totalDonations += amount;
    }

    function withdraw(uint256 amount) public {
        totalDonations -= amount;
        payable(fundOwner).transfer(amount);
    }
}
```

# Tasks for Learners

Neri wants to build a Community Fund contract that allows people to donate funds. However, to ensure the integrity of the system, donations can only be accepted if they meet the following conditions:

- Inside the `donate` function, ensure that donations can only be made with a non-zero amount. This is done using the `require` statement to check that the amount is greater than zero.

  ```solidity
  require(amount > 0, "Donation must be greater than zero");
  ```

- Inside the `donate` function, check that the amount sent with the transaction matches the donation amount. This is done using `msg.value` to ensure that the correct Ether is sent. This is done using the `require` statement to check that the value sent with the transaction matches the donation amount.

  ```solidity
      require(msg.value == amount, "Insufficient Ether provided");
  ```

- Inside the `withdraw` function, only allow the contract owner to withdraw funds. This is done by checking if the sender of the transaction (`msg.sender`) is the same as the `fundOwner`.

  ```solidity
  require(msg.sender == fundOwner, "Only the owner can withdraw funds");
  ```

- Ensure the `withdraw` function verifies there are enough funds before allowing a withdrawal. This is done by checking if the requested withdrawal amount is less than or equal to the total donations. This is done using the `totalDonations` variable.

  ```solidity
  require(amount <= totalDonations, "Not enough funds");
  ```

### Breakdown for Learners

`require` is a guardrail: It acts as a checkpoint to ensure that the contract operates within the defined rules. If the condition in `require` is not met, the transaction is **stopped**, and any changes made to the contract state are reverted. This is important for maintaining the integrity of the contract and ensuring that all operations are valid.

**Why use require?**

- Security: Prevents invalid operations from affecting the contract state (e.g., Hackana trying to withdraw funds without meeting conditions).

- Efficiency: require helps enforce conditions before performing costly operations or state changes, saving gas when conditions aren’t met.
