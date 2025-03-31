
# Side Quest 3: Reentrancy Fix

## Scenario:

One of Hackana’s minions left behind a reentrancy vulnerability in the Palengke digital wallet system. Vendors are losing funds when attackers withdraw repeatedly in a single transaction. Neri must fix the wallet.

- Time Allotment: 20 minutes
- Solidity Topics Covered: Reentrancy, Best Practices.
- Checklist: Prevent reentrancy, use Checks-Effects-Interactions pattern.

## TODO:

- Fix the withdrawal function to prevent reentrancy.
- Use a ReentrancyGuard or a boolean lock.

## Code Activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PalengkeWallet {
    mapping(address => uint256) public balances;

    // 🚩 TODO: Fix the vulnerability
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] -= amount; // Update balance after
    }
}
```

**Hints:**

- Deduct balances before making the external call.
- Consider using a ReentrancyGuard for extra security.