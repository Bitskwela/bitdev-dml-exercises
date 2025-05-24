// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract BaseContract {
    string public organizationName;

    function setOrganizationName(string memory name) public {
        organizationName = name;
    }
}

contract DerivedContract {}
