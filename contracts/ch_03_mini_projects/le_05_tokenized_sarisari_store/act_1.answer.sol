// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SariSariToken is ERC20 {
    address public owner;
    uint256 public constant MAX_SUPPLY = 50000 * 1e18;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() ERC20("SariSari Token", "SST") {
        owner = msg.sender;
        _mint(owner, 10000 * 1e18); // Mint ₱10,000 worth
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds cap");
        _mint(to, amount);
    }
}
