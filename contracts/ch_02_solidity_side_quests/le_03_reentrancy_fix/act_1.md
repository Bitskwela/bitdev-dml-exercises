# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeWallet {
    mapping(address => uint256) public balances;

    // TODO: Fix the vulnerability
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] -= amount; // Balance update
    }

    // Added for testing/depositing
    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}
```

**Hints:**

- The above contract has a reentrancy vulnerability in the `withdraw` function.
- The balance is updated after the external call, allowing reentrancy attacks.
- Use the `checks-effects-interactions` pattern to secure the contract.
- Deduct balances before making the external call.
- Consider using a ReentrancyGuard for extra security.

## Tasks for students

- Import OpenZeppelin's `ReentrancyGuard` contract to prevent reentrancy attacks. Inherit from it in your contract.

  ```solidity
  import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
  ```

- Modify the `withdraw` function to:

  - Use the `nonReentrant` modifier from `ReentrancyGuard`.
  - Use the `checks-effects-interactions` pattern.
  - Deduct the balance before making the external call.

    ```solidity
        function withdraw(uint256 amount) public nonReentrant {

            // Checks
            require(balances[msg.sender] >= amount, "Insufficient balance");

            // Effects
            balances[msg.sender] -= amount;

            // Interactions
            (bool success, ) = msg.sender.call{value: amount}("");
            require(success, "Transfer failed");
        }
    ```
