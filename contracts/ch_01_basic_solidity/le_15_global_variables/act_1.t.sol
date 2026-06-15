// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {TransactionTracker} from "../src/TransactionTracker.sol";

contract TransactionTrackerTest is Test {
    TransactionTracker internal tracker;

    function setUp() public {
        tracker = new TransactionTracker();
    }

    function test_initialState() public {
        assertEq(tracker.caller(), address(0), "caller starts unset");
        assertEq(tracker.transactionTime(), 0, "time starts unset");
    }

    function test_updateTransaction_recordsCallerAndTime() public {
        vm.warp(123456);
        tracker.updateTransaction();

        assertEq(tracker.caller(), address(this), "caller should be msg.sender");
        assertEq(tracker.transactionTime(), 123456, "time should be block.timestamp");
        assertGt(tracker.transactionTime(), 0, "time should be set");
    }

    function test_updateTransaction_withPrank() public {
        address neri = address(0xBEEF);
        vm.warp(1000);
        vm.prank(neri);
        tracker.updateTransaction();

        assertEq(tracker.caller(), neri, "caller should be pranked address");
        assertEq(tracker.transactionTime(), 1000, "time should be warped value");
    }

    function test_updateTransaction_multipleTimes() public {
        address user1 = address(0xA11CE);
        address user2 = address(0xB0B);

        vm.warp(500);
        vm.prank(user1);
        tracker.updateTransaction();
        uint256 firstTime = tracker.transactionTime();
        assertEq(tracker.caller(), user1, "first caller");
        assertGt(firstTime, 0, "first time set");

        vm.warp(900);
        vm.prank(user2);
        tracker.updateTransaction();
        uint256 secondTime = tracker.transactionTime();
        assertEq(tracker.caller(), user2, "second caller");
        assertGt(secondTime, firstTime, "time should advance");
    }
}
