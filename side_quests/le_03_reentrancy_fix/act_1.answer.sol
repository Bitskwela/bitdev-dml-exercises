// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PalengkeWallet is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function withdraw(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount; // Effects

        (bool success, ) = msg.sender.call{value: amount}(""); // Interactions
        require(success, "Transfer failed");
    }

    // Added for testing/depositing
    receive() external payable {
        balances[msg.sender] += msg.value;
    }
}
