// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Iloilo Lending Protocol" (proj-3-iloilo-lending-protocol).
// The student builds a peer-to-peer ETH lending board: borrowers post loan
// requests, lenders fund them with the exact amount, and ETH flows to the borrower.

import {Test} from "forge-std/Test.sol";
import {BarangayLending} from "../src/BarangayLending.sol";

contract BarangayLendingTest is Test {
    BarangayLending internal lending;

    address internal borrower = address(0xB0110);
    address internal lender = address(0x1E11DE);

    // Mirror the contract's events so vm.expectEmit can match them.
    event LoanRequested(uint256 loanId, address borrower, uint256 amount, string reason);
    event LoanFunded(uint256 loanId, address lender);

    function setUp() public {
        lending = new BarangayLending();
        vm.deal(lender, 100 ether);
    }

    function test_requestLoan_storesStructAndEmitsEvent() public {
        vm.expectEmit(true, true, true, true);
        emit LoanRequested(1, borrower, 5 ether, "Repair fishing boat");

        vm.prank(borrower);
        lending.requestLoan(5 ether, "Repair fishing boat");

        assertEq(lending.loanCounter(), 1, "loanCounter not incremented");

        (
            address storedBorrower,
            uint256 amount,
            string memory reason,
            bool isFunded,
            address storedLender
        ) = lending.loans(1);

        assertEq(storedBorrower, borrower, "borrower not stored");
        assertEq(amount, 5 ether, "amount not stored");
        assertEq(reason, "Repair fishing boat", "reason not stored");
        assertEq(isFunded, false, "loan should start unfunded");
        assertEq(storedLender, address(0), "lender should start empty");
    }

    function test_requestLoan_assignsIncrementingIds() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "first");
        vm.prank(borrower);
        lending.requestLoan(2 ether, "second");

        assertEq(lending.loanCounter(), 2, "counter should be 2");

        (, uint256 amount2,,,) = lending.loans(2);
        assertEq(amount2, 2 ether, "second loan amount wrong");
    }

    function test_fundLoan_transfersEthToBorrowerAndMarksFunded() public {
        vm.prank(borrower);
        lending.requestLoan(5 ether, "Repair fishing boat");

        uint256 borrowerBefore = borrower.balance;

        vm.expectEmit(true, true, true, true);
        emit LoanFunded(1, lender);

        vm.prank(lender);
        lending.fundLoan{value: 5 ether}(1);

        assertEq(borrower.balance, borrowerBefore + 5 ether, "borrower did not receive ETH");

        (,,, bool isFunded, address storedLender) = lending.loans(1);
        assertEq(isFunded, true, "loan not marked funded");
        assertEq(storedLender, lender, "lender not recorded");
    }

    function test_fundLoan_revertsOnWrongAmount() public {
        vm.prank(borrower);
        lending.requestLoan(5 ether, "Repair fishing boat");

        vm.prank(lender);
        vm.expectRevert(bytes("Incorrect amount"));
        lending.fundLoan{value: 4 ether}(1);
    }

    function test_fundLoan_revertsOnDoubleFunding() public {
        vm.prank(borrower);
        lending.requestLoan(5 ether, "Repair fishing boat");

        vm.prank(lender);
        lending.fundLoan{value: 5 ether}(1);

        // Second funding attempt must be rejected.
        vm.prank(lender);
        vm.expectRevert(bytes("Loan already funded"));
        lending.fundLoan{value: 5 ether}(1);
    }
}
