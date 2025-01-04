// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import OpenZeppelin's ERC20 implementation
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 🚩 ANSWER: Define the contract and inherit from ERC20
contract SanJuanToken is ERC20 {
    // 🚩 ANSWER: Constructor to initialize the token
    constructor(uint256 initialSupply) ERC20("SanJuanToken", "SJT") {
        _mint(msg.sender, initialSupply);
    }
}
