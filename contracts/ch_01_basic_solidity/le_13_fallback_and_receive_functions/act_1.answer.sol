// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayWallet {
    uint256 public totalReceived;

    event InvalidCall(address sender, uint256 value, bytes data);

    receive() external payable {
        totalReceived += msg.value;
    }

    fallback() external payable {
        emit InvalidCall(msg.sender, msg.value, msg.data);
    }
}
