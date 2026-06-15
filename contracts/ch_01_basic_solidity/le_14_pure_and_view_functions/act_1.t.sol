// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {BarangayServiceFees} from "../src/BarangayServiceFees.sol";

contract BarangayServiceFeesTest is Test {
    BarangayServiceFees internal c;

    function setUp() public {
        c = new BarangayServiceFees();
    }

    function test_certificationFee_publicVar() public {
        assertEq(c.certificationFee(), 100, "certificationFee should be 100");
    }

    function test_getCertificationFee() public {
        assertEq(c.getCertificationFee(), 100, "view fn should return 100");
    }

    function test_calculateTotalCost_three() public {
        assertEq(c.calculateTotalCost(3), 300, "3 certs should cost 300");
    }

    function test_calculateTotalCost_zero() public {
        assertEq(c.calculateTotalCost(0), 0, "0 certs should cost 0");
    }

    function test_calculateTotalCost_one() public {
        assertEq(c.calculateTotalCost(1), 100, "1 cert should cost 100");
    }

    function test_calculateTotalCost_large() public {
        assertEq(c.calculateTotalCost(1000), 100000, "1000 certs should cost 100000");
    }
}
