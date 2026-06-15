// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {BarangayServiceFees} from "../src/BarangayServiceFees.sol";

contract BarangayServiceFeesTest is Test {
    BarangayServiceFees internal serviceFees;

    function setUp() public {
        serviceFees = new BarangayServiceFees();
    }

    function test_certificationFee_publicVar() public {
        assertEq(serviceFees.certificationFee(), 100, "certificationFee should be 100");
    }

    function test_getCertificationFee() public {
        assertEq(serviceFees.getCertificationFee(), 100, "view fn should return 100");
    }

    function test_calculateTotalCost_three() public {
        assertEq(serviceFees.calculateTotalCost(3), 300, "3 certs should cost 300");
    }

    function test_calculateTotalCost_zero() public {
        assertEq(serviceFees.calculateTotalCost(0), 0, "0 certs should cost 0");
    }

    function test_calculateTotalCost_one() public {
        assertEq(serviceFees.calculateTotalCost(1), 100, "1 cert should cost 100");
    }

    function test_calculateTotalCost_large() public {
        assertEq(serviceFees.calculateTotalCost(250), 25000, "250 certs should cost 25000");
    }
}
