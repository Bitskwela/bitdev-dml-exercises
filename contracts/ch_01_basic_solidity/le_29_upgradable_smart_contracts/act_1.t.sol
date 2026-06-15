// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {UserRegistryV1, UserRegistryV2} from "../src/UserRegistryV2.sol";

contract UserRegistryTest is Test {
    UserRegistryV1 internal v1;
    UserRegistryV2 internal v2;

    function setUp() public {
        v1 = new UserRegistryV1();
        v2 = new UserRegistryV2();
    }

    // V1 behavior (also inherited by V2)
    function test_v1_registerUser() public {
        v1.initialize();
        v1.registerUser("Alice");
        assertEq(v1.getUser(address(this)), "Alice", "registered name should be returned");
    }

    function test_v1_getUser_emptyByDefault() public view {
        assertEq(v1.getUser(address(0xBEEF)), "", "unregistered user returns empty string");
    }

    function test_v1_userNames_publicGetter() public {
        v1.registerUser("Bob");
        assertEq(v1.userNames(address(this)), "Bob", "public mapping getter reflects registration");
    }

    // V2 inherits V1 functionality
    function test_v2_inheritsRegisterUser() public {
        v2.registerUser("Carol");
        assertEq(v2.getUser(address(this)), "Carol", "V2 should inherit registerUser/getUser");
    }

    // V2 new behavior
    function test_v2_updateUser() public {
        v2.registerUser("Dan");
        v2.updateUser("Daniel");
        assertEq(v2.getUser(address(this)), "Daniel", "updateUser should overwrite the name");
    }

    function test_v2_updateUser_perAddress() public {
        v2.registerUser("Eve");

        address other = address(0xCAFE);
        vm.prank(other);
        v2.updateUser("Frank");

        assertEq(v2.getUser(address(this)), "Eve", "caller's name unchanged");
        assertEq(v2.getUser(other), "Frank", "other address updated independently");
    }
}
