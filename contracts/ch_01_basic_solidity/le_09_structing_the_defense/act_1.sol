// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomerRegistry {
    function addCustomer(string memory _name, uint256 _balance) public {}

    function getCustomer(
        address _walletAddress
    ) public view returns (string memory, address, uint256) {}
}
