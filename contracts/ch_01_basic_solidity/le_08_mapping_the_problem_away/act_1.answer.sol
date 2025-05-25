// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AntiHackanaLedger {
    mapping(address => uint256) public userBalances;

    function updateBalance(address _user, uint256 _newBalance) public {
        userBalances[_user] = _newBalance;
    }

    function getBalance(address _user) public view returns (uint256) {
        return userBalances[_user];
    }
}
