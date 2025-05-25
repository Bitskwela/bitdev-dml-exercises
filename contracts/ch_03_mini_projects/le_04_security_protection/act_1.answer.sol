// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayAidVault {
    mapping(address => uint256) public claimable;
    address public owner;

    event AidDeposited(
        address indexed donor,
        address indexed recipient,
        uint256 amount
    );
    event AidClaimed(address indexed recipient, uint256 amount);
    event EmergencyWithdrawn(uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function depositAid(address recipient) public payable {
        require(msg.value > 0, "Cannot send 0 ETH");
        claimable[recipient] += msg.value;
        emit AidDeposited(msg.sender, recipient, msg.value);
    }

    function claimAid() public {
        uint256 amount = claimable[msg.sender];
        require(amount > 0, "Nothing to claim");

        claimable[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit AidClaimed(msg.sender, amount);
    }

    function emergencyWithdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");
        payable(owner).transfer(balance);
        emit EmergencyWithdrawn(balance);
    }
}
