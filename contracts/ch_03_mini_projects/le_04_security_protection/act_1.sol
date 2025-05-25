// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayAidVault {
    mapping(address => uint256) public claimable;
    address public owner;

    function depositAid(address recipient) public payable {
        claimable[recipient] += msg.value;
    }

    function claimAid() public {
        require(claimable[msg.sender] > 0, "Nothing to claim");
        payable(msg.sender).transfer(claimable[msg.sender]);
        claimable[msg.sender] = 0;
    }

    function emergencyWithdraw() public {
        // tx.origin is bad here – opens phishing attack vector
        require(tx.origin == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }
}
