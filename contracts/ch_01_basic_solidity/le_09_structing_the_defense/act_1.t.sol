// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Structing the Defense" (permaname: structing-the-defense).
//
// Ported from act_1.test.js (Hardhat/Chai). The grader writes the student's
// submission to `src/CustomerRegistry.sol`, so the import below resolves against
// that assembled layout, not the content-repo filename.
//
// Coverage: the student must define a `Customer` struct (name, walletAddress,
// balance), store it in the public `customers` mapping keyed by msg.sender, and
// return the three fields from `getCustomer`. We assert via both the public
// mapping getter and `getCustomer`, using vm.prank to control msg.sender.

import {Test} from "forge-std/Test.sol";
import {CustomerRegistry} from "../src/CustomerRegistry.sol";

contract CustomerRegistryTest is Test {
    CustomerRegistry internal registry;

    address internal user1 = address(0xA11CE);
    address internal user2 = address(0xB0B);

    function setUp() public {
        registry = new CustomerRegistry();
    }

    /// Happy path: adding a customer stores all struct fields under msg.sender.
    function test_addCustomer_storesStructFields() public {
        vm.prank(user1);
        registry.addCustomer("Juan Dela Cruz", 5000);

        (string memory name, address wallet, uint256 balance) = registry.customers(user1);
        assertEq(name, "Juan Dela Cruz", "name not stored");
        assertEq(wallet, user1, "walletAddress must equal msg.sender");
        assertEq(balance, 5000, "balance not stored");
    }

    /// getCustomer must return the stored struct fields.
    function test_getCustomer_returnsStoredDetails() public {
        vm.prank(user2);
        registry.addCustomer("Maria Clara", 7500);

        (string memory name, address wallet, uint256 balance) = registry.getCustomer(user2);
        assertEq(name, "Maria Clara", "getCustomer name mismatch");
        assertEq(wallet, user2, "getCustomer walletAddress mismatch");
        assertEq(balance, 7500, "getCustomer balance mismatch");
    }

    /// Edge case: initial state for an unknown address is empty/zero.
    function test_initialState_isEmpty() public view {
        (string memory name, address wallet, uint256 balance) = registry.getCustomer(user1);
        assertEq(name, "", "name should start empty");
        assertEq(wallet, address(0), "walletAddress should start at zero");
        assertEq(balance, 0, "balance should start at zero");
    }

    /// Edge case: each caller's record is keyed independently by msg.sender.
    function test_addCustomer_keyedBySender() public {
        vm.prank(user1);
        registry.addCustomer("Alice", 100);
        vm.prank(user2);
        registry.addCustomer("Bob", 200);

        (string memory n1,, uint256 b1) = registry.getCustomer(user1);
        (string memory n2,, uint256 b2) = registry.getCustomer(user2);
        assertEq(n1, "Alice", "user1 record clobbered");
        assertEq(b1, 100, "user1 balance clobbered");
        assertEq(n2, "Bob", "user2 record clobbered");
        assertEq(b2, 200, "user2 balance clobbered");
    }

    /// Edge case: a second addCustomer from the same sender overwrites the first.
    function test_addCustomer_overwritesSameSender() public {
        vm.startPrank(user1);
        registry.addCustomer("Old Name", 1);
        registry.addCustomer("New Name", 999);
        vm.stopPrank();

        (string memory name,, uint256 balance) = registry.getCustomer(user1);
        assertEq(name, "New Name", "overwrite failed for name");
        assertEq(balance, 999, "overwrite failed for balance");
    }
}
