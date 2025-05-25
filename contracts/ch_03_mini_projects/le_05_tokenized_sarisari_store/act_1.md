# Smart contract activity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SariSariToken is ERC20 {
    address public owner;
    uint256 public constant MAX_SUPPLY = 50000 * 1e18;

    // TODO Add onlyOwner modifier to restrict minting access

    constructor() ERC20("SariSari Token", "SST") {
        // TODO: Set contract deployer as the owner
        // TODO: Mint 10,000 SST (₱10,000 worth) to the owner
    }

    function mint(address to, uint256 amount) public {
        // TODO: Restrict minting to onlyOwner
        // TODO: Enforce the max total supply limit
        // TODO: Mint tokens to recipient address
    }
}

```

**Time Allotment: 1 hour**

## Tasks for students

- Add onlyOwner modifier to restrict minting access

  ```solidity
  modifier onlyOwner() {
      require(msg.sender == owner, "Not authorized");
      _;
  }
  ```

- Update the constructor to set the contract deployer as the owner and mint 10,000 SST (₱10,000 worth) to the owner

  ```solidity
  constructor() ERC20("SariSari Token", "SST") {
        owner = msg.sender;
        _mint(owner, 10000 * 1e18); // ₱10,000 worth of tokenized inventory
    }
  ```

- Complete the `mint` function to restrict minting to onlyOwner, enforce the max total supply limit, and mint tokens to the recipient address. Throw an error if the minting exceeds the cap and ensure the total supply does not exceed `MAX_SUPPLY`.

  ```solidity
      function mint(address to, uint256 amount) public onlyOwner {
          require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds cap");
          _mint(to, amount);
      }
  ```
