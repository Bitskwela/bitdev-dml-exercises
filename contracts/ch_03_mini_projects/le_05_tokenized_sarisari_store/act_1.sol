// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SariSariToken is ERC20 {
    address public owner;
    uint256 public constant MAX_SUPPLY = 50000 * 1e18;

    // TODO 1: Add onlyOwner modifier to restrict minting access

    constructor() ERC20("SariSari Token", "SST") {
        // TODO 2: Set contract deployer as the owner
        // TODO 3: Mint 10,000 SST (₱10,000 worth) to the owner
    }

    function mint(address to, uint256 amount) public {
        // TODO 4: Restrict minting to onlyOwner
        // TODO 5: Enforce the max total supply limit
        // TODO 6: Mint tokens to recipient address
    }
}
