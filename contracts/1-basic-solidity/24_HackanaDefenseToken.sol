// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Import the ERC20 contract from OpenZeppelin
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 🚩 TODO: Create a custom token contract
contract HackanaDefenseToken is ERC20 {
    // 🚩 TODO: Add a constructor to initialize the token
    constructor() ERC20("DefenseToken", "DEF") {
        _mint(msg.sender, 1000 * 10 ** decimals()); // 🚩 Initial supply
    }
}
