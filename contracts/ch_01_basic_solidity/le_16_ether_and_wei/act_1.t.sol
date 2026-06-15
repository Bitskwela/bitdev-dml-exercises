// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {EtherConverter} from "../src/EtherConverter.sol";

contract EtherConverterTest is Test {
    EtherConverter internal converter;

    function setUp() public {
        converter = new EtherConverter();
    }

    function test_etherToWei_two() public {
        assertEq(converter.etherToWei(2), 2 ether, "2 ether -> 2e18 wei");
        assertEq(converter.etherToWei(2), 2e18, "2 ether -> 2e18 wei literal");
    }

    function test_etherToWei_one() public {
        assertEq(converter.etherToWei(1), 1 ether, "1 ether -> 1e18 wei");
    }

    function test_etherToWei_zero() public {
        assertEq(converter.etherToWei(0), 0, "0 ether -> 0 wei");
    }

    function test_weiToEther_two() public {
        assertEq(converter.weiToEther(2 ether), 2, "2e18 wei -> 2 ether");
    }

    function test_weiToEther_one() public {
        assertEq(converter.weiToEther(1 ether), 1, "1e18 wei -> 1 ether");
    }

    function test_weiToEther_truncatesBelowOneEther() public {
        assertEq(converter.weiToEther(1 ether - 1), 0, "less than 1 ether truncates to 0");
    }

    function test_roundTrip() public {
        assertEq(converter.weiToEther(converter.etherToWei(5)), 5, "round trip preserves value");
    }
}
