// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {DataOptimization} from "../src/DataOptimization.sol";

contract DataOptimizationTest is Test {
    DataOptimization internal data;

    function setUp() public {
        data = new DataOptimization();
    }

    function test_initialStoredMessage() public {
        assertEq(data.storedMessage(), "Stored permanently", "default stored message");
    }

    function test_updateMessage() public {
        data.updateMessage("New message stored");
        assertEq(data.storedMessage(), "New message stored", "stored message updated");
    }

    function test_compareStorageAndMemory_default() public {
        assertEq(
            data.compareStorageAndMemory(),
            "Stored permanently",
            "memory copy matches storage default"
        );
    }

    function test_compareStorageAndMemory_afterUpdate() public {
        data.updateMessage("Hackana was here");
        assertEq(
            data.compareStorageAndMemory(),
            "Hackana was here",
            "memory copy reflects updated storage"
        );
    }

    function test_updateMessage_emptyString() public {
        data.updateMessage("");
        assertEq(data.storedMessage(), "", "can store empty string");
        assertEq(data.compareStorageAndMemory(), "", "memory copy of empty string");
    }
}
