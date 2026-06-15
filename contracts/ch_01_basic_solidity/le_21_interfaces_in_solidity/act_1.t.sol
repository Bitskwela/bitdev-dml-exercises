// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {Marketplace, ITransaction} from "../src/Marketplace.sol";

contract MarketplaceTest is Test {
    Marketplace internal m;

    function setUp() public {
        m = new Marketplace();
        vm.deal(address(this), 10 ether);
    }

    // Allow the test contract to receive withdrawals.
    receive() external payable {}

    function test_deposit_withCorrectValue() public {
        m.deposit{value: 1 ether}(1 ether);
        assertEq(m.checkBalance(), 1 ether, "balance should equal deposit");
    }

    function test_deposit_revertsOnMismatch() public {
        vm.expectRevert(bytes("Amount does not match sent Ether"));
        m.deposit{value: 1 ether}(2 ether);
    }

    function test_withdraw_upToBalance() public {
        m.deposit{value: 1 ether}(1 ether);

        uint256 before = address(this).balance;
        m.withdraw(1 ether);

        assertEq(m.checkBalance(), 0, "balance should be zero after full withdraw");
        assertEq(address(this).balance, before + 1 ether, "ETH should return to caller");
    }

    function test_withdraw_revertsOnInsufficient() public {
        vm.expectRevert(bytes("Insufficient balance"));
        m.withdraw(1 ether);
    }

    function test_checkBalance_returnsCorrect() public {
        m.deposit{value: 0.5 ether}(0.5 ether);
        assertEq(m.checkBalance(), 0.5 ether, "checkBalance should reflect deposit");
    }

    // Edge cases
    function test_balances_arePerAddress() public {
        m.deposit{value: 1 ether}(1 ether);

        address other = address(0xBEEF);
        vm.prank(other);
        assertEq(m.checkBalance(), 0, "other address should have zero balance");
    }

    function test_deposit_accumulates() public {
        m.deposit{value: 1 ether}(1 ether);
        m.deposit{value: 2 ether}(2 ether);
        assertEq(m.checkBalance(), 3 ether, "deposits should accumulate");
    }

    function test_implementsInterface() public view {
        // Marketplace must satisfy the ITransaction interface.
        ITransaction t = ITransaction(address(m));
        assertEq(t.checkBalance(), 0, "interface call should return current balance");
    }
}
