// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SanJuanToken {
    string public name = "SanJuanToken";
    string public symbol = "SJT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Not enough balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        // TODO: Allow a spender to spend tokens on behalf of the owner
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        // TODO: Use allowance mechanism to let approved users send tokens on behalf of others
    }
}
