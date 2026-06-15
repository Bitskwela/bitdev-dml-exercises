// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {HackanaDefense} from "../src/HackanaDefense.sol";

contract HackanaDefenseTest is Test {
    HackanaDefense internal c;

    function setUp() public {
        c = new HackanaDefense();
    }

    function test_calculateFee() public view {
        // 5% of 1000 = 50
        assertEq(c.calculateFee(1000, 5), 50, "fee should be 5% of amount");
    }

    function test_city() public view {
        assertEq(c.city(), "San Juan City", "city should be set");
    }

    // Edge cases
    function test_calculateFee_zeroPercent() public view {
        assertEq(c.calculateFee(1000, 0), 0, "zero percent should yield zero fee");
    }

    function test_calculateFee_fullPercent() public view {
        assertEq(c.calculateFee(1000, 100), 1000, "100 percent should yield full amount");
    }

    function test_calculateFee_truncatesDivision() public view {
        // (10 * 5) / 100 = 0 due to integer division
        assertEq(c.calculateFee(10, 5), 0, "integer division truncates toward zero");
    }
}
