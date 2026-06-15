// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {EtherReceiver} from "../src/EtherReceiver.sol";

contract EtherReceiverTest is Test {
    EtherReceiver internal c;

    event PaymentReceived(address indexed from, uint256 amount);

    function setUp() public {
        c = new EtherReceiver();
        vm.deal(address(this), 10 ether);
    }

    function test_balanceZeroInitially() public view {
        assertEq(c.getBalance(), 0, "balance should start at 0");
    }

    function test_receivePayment_increasesBalance() public {
        c.receivePayment{value: 1 ether}();
        assertEq(c.getBalance(), 1 ether, "balance should equal sent amount");
        assertEq(address(c).balance, 1 ether, "contract balance should match");
    }

    function test_receivePayment_emitsEvent() public {
        vm.expectEmit(true, false, false, true, address(c));
        emit PaymentReceived(address(this), 1 ether);
        c.receivePayment{value: 1 ether}();
    }

    // Edge cases
    function test_receivePayment_accumulates() public {
        c.receivePayment{value: 1 ether}();
        c.receivePayment{value: 2 ether}();
        assertEq(c.getBalance(), 3 ether, "balances should accumulate");
    }

    function test_receivePayment_zeroValueAllowed() public {
        c.receivePayment{value: 0}();
        assertEq(c.getBalance(), 0, "zero-value payment keeps balance at 0");
    }
}
