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
