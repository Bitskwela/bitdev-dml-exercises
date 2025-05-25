# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayAidVault {
    mapping(address => uint256) public claimable;
    address public owner;

    function depositAid(address recipient) public payable {
        claimable[recipient] += msg.value;
    }

    function claimAid() public {
        require(claimable[msg.sender] > 0, "Nothing to claim");
        payable(msg.sender).transfer(claimable[msg.sender]);
        claimable[msg.sender] = 0;
    }

    function emergencyWithdraw() public {
        // tx.origin is bad here – opens phishing attack vector
        require(tx.origin == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }
}
```

### What’s wrong on this smart contract?

- No constructor → Anyone can call functions assuming they’re the owner
- Uses `tx.origin` → Allows phishing via malicious contracts
- No `onlyOwner` modifier → Access control is broken
- No validation in `depositAid` → Accepts zero-value deposits
- No event logging → Hard to audit for transparency

**Time Allotment: 1 hour**

## Tasks for students

- Add event declarations for logging deposits, claims, and withdrawals (`AidDeposited`, `AidClaimed`, `EmergencyWithdrawn`).
  ```solidity
      event AidDeposited(address indexed donor, address indexed recipient, uint256 amount);
      event AidClaimed(address indexed recipient, uint256 amount);
      event EmergencyWithdrawn(uint256 amount);
  ```
- Create an access control modifier `onlyOwner` to restrict certain functions to the contract owner.

  ```solidity
      modifier onlyOwner() {
          require(msg.sender == owner, "Not owner");
          _;
      }
  ```

- Set the contract owner in the constructor.

  ```solidity
      constructor() {
          owner = msg.sender;
      }
  ```

- Update the `depositAid` function to:

  - Validate that the deposit amount is greater than zero.
  - Update the `claimable` mapping for the recipient.
  - Emit `AidDeposited` event.

    ```solidity
        function depositAid(address recipient) public payable {
            require(msg.value > 0, "Cannot send 0 ETH");
            claimable[recipient] += msg.value;
            emit AidDeposited(msg.sender, recipient, msg.value);
        }
    ```

- Update the `claimAid` function to:

  - Ensure the caller has a claimable amount.
  - Throw an error if there’s nothing to claim via `require`.
  - Reset the claimable amount to zero before transferring the funds.
  - Transfer the claimable amount to the caller and emit `AidClaimed` event.

    ```solidity
        function claimAid() public {
            uint256 amount = claimable[msg.sender];
            require(amount > 0, "Nothing to claim");

            claimable[msg.sender] = 0;

            payable(msg.sender).transfer(amount);
            emit AidClaimed(msg.sender, amount);
        }
    ```

- Update the `emergencyWithdraw` function to:

  - Enforce the `onlyOwner` modifier.
  - Check if the contract has a balance before withdrawing.
  - Throw an error if there are no funds to withdraw via `require`.
  - Transfer the entire contract balance to the owner and emit `EmergencyWithdrawn` event.

    ```solidity
        function emergencyWithdraw() public onlyOwner {
            uint256 balance = address(this).balance;
            require(balance > 0, "No funds");
            payable(owner).transfer(balance);
            emit EmergencyWithdrawn(balance);
        }
    ```

### Additional Insights

`tx.origin` phishing has been used in real-world scams — especially where wallets interact with malicious dApps.

The `onlyOwner` modifier enforces strict protocol control, a common pattern in OpenZeppelin.

Events create on-chain audit logs which are critical for public-facing, government-style contracts.

Edge-case validation (like `msg.value > 0`) prevents silent failures and spam.
