// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ERC20 Mock Contract
contract PaymentFixer {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    constructor() {
        // Initial token allocation
        balances[msg.sender] = 1000;
    }

    // 🚩 TODO: Implement the approve function
    function approve(address spender, uint256 amount) public {
        allowances[msg.sender][spender] = amount;
    }

    // 🚩 TODO: Fix the transferFrom logic to respect allowances
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public {
        require(allowances[sender][msg.sender] >= amount, "Allowance exceeded");
        require(balances[sender] >= amount, "Insufficient balance");

        allowances[sender][msg.sender] -= amount;
        balances[sender] -= amount;
        balances[recipient] += amount;
    }
}
