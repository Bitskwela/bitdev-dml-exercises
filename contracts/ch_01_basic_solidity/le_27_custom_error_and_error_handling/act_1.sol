// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;

// contract CustomErrorExample {
//     address public owner;
//     uint256 public totalBalance;

//     constructor() {
//         owner = msg.sender;
//         totalBalance = 1000;
//     }

//     function withdraw(uint256 amount) public {
//         if (msg.sender != owner) {}

//         if (amount > totalBalance) {}

//         totalBalance -= amount;
//     }

//     function checkBalance() public view returns (uint256) {
//         return totalBalance;
//     }
// }
