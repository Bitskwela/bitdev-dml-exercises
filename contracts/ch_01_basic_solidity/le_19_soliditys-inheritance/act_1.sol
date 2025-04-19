// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract BaseContract {
    string public organizationName;

    // 🚩 TODO: Task 1 - Modify this function to validate that the name is not empty
    function setOrganizationName(string memory name) public {
        // 🚩 ✅ Answer: Add a require statement to check that name is not empty
        require(bytes(name).length > 0, "Name cannot be empty");
        organizationName = name;
    }
}

// Child contract inheriting from BaseContract
contract DerivedContract is BaseContract {
    uint256 public fundBalance;

    // 🚩 TODO: Task 2 - Add a condition to ensure only positive deposit amounts are allowed
    function depositFunds(uint256 amount) public {
        // 🚩 ✅ Answer: Add a require statement to check that amount > 0
        require(amount > 0, "Amount must be greater than zero");
        fundBalance += amount;
    }
}
