// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Iloilo Lending Protocol"
// (permaname: proj-3-iloilo-lending-protocol).
//
// Loan ids start at 1, not 0: the answer increments the counter BEFORE writing,
// so `loans[0]` is permanently empty. The suite reads id 1 everywhere and asserts
// the zero slot stays empty, because an off-by-one here silently orphans the
// first loan a barangay ever files.
//
// Borrowers are EOAs: `fundLoan` pays with `.transfer`, whose 2300-gas stipend a
// contract borrower would not survive.

import {Test} from "forge-std/Test.sol";
import {BarangayLending} from "../src/BarangayLending.sol";

contract BarangayLendingTest is Test {
    BarangayLending internal lending;

    address internal borrower = address(0xB0770);
    address internal lender = address(0x1E4DE4);

    event LoanRequested(uint256 loanId, address borrower, uint256 amount, string reason);
    event LoanFunded(uint256 loanId, address lender);

    function setUp() public {
        lending = new BarangayLending();
        vm.deal(lender, 10 ether);
    }

    /// A fresh protocol holds no loans.
    function test_loanCounter_startsAtZero() public view {
        assertEq(lending.loanCounter(), 0, "a new protocol must have no loans");
    }

    /// Task 1: the request is stored, unfunded, with no lender yet.
    function test_requestLoan_storesTheRequest() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Sari-sari store restock");

        assertEq(lending.loanCounter(), 1, "the counter did not advance");

        (address who, uint256 amount, string memory reason, bool isFunded, address who2) =
            lending.loans(1);
        assertEq(who, borrower, "the borrower was not recorded");
        assertEq(amount, 1 ether, "the amount was not recorded");
        assertEq(reason, "Sari-sari store restock", "the reason was not recorded");
        assertFalse(isFunded, "a new request must not be funded");
        assertEq(who2, address(0), "a new request must have no lender");
    }

    /// Ids start at 1, so slot 0 stays empty.
    function test_requestLoan_numbersLoansFromOne() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");

        (address zeroSlot,,,,) = lending.loans(0);
        assertEq(zeroSlot, address(0), "loan ids must start at 1, leaving slot 0 empty");
    }

    /// The request is announced so lenders can find it.
    function test_requestLoan_emitsLoanRequested() public {
        vm.expectEmit(false, false, false, true);
        emit LoanRequested(1, borrower, 1 ether, "Restock");

        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");
    }

    /// Requests are independent and keep their own ids.
    function test_requestLoan_keepsEachRequestSeparate() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");
        vm.prank(lender);
        lending.requestLoan(2 ether, "Tricycle repair");

        (, uint256 first,,,) = lending.loans(1);
        (address secondBorrower, uint256 second,,,) = lending.loans(2);

        assertEq(first, 1 ether, "loan 1 was overwritten");
        assertEq(second, 2 ether, "loan 2 was not stored");
        assertEq(secondBorrower, lender, "loan 2 has the wrong borrower");
    }

    /// Task 2: funding pays the borrower, in full and immediately.
    function test_fundLoan_paysTheBorrower() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");

        uint256 before = borrower.balance;
        vm.prank(lender);
        lending.fundLoan{value: 1 ether}(1);

        assertEq(borrower.balance, before + 1 ether, "the borrower was not paid");
        assertEq(address(lending).balance, 0, "the ETH must not sit in the protocol");
    }

    /// Task 2: the loan is marked funded and the lender is recorded.
    function test_fundLoan_recordsTheLender() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");

        vm.prank(lender);
        lending.fundLoan{value: 1 ether}(1);

        (,,, bool isFunded, address who) = lending.loans(1);
        assertTrue(isFunded, "the loan was not marked funded");
        assertEq(who, lender, "the lender was not recorded");
    }

    /// The funding is announced too.
    function test_fundLoan_emitsLoanFunded() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");

        vm.expectEmit(false, false, false, true);
        emit LoanFunded(1, lender);

        vm.prank(lender);
        lending.fundLoan{value: 1 ether}(1);
    }

    /// The payment must match the requested amount exactly.
    function test_fundLoan_revertsOnTheWrongAmount() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");

        vm.prank(lender);
        vm.expectRevert(bytes("Incorrect amount"));
        lending.fundLoan{value: 0.5 ether}(1);
    }

    /// A loan cannot be funded twice.
    function test_fundLoan_revertsOnADoubleFunding() public {
        vm.prank(borrower);
        lending.requestLoan(1 ether, "Restock");

        vm.startPrank(lender);
        lending.fundLoan{value: 1 ether}(1);

        vm.expectRevert(bytes("Loan already funded"));
        lending.fundLoan{value: 1 ether}(1);
        vm.stopPrank();
    }

    /// Funding one loan must not mark another as funded.
    function test_fundLoan_affectsOnlyTheTargetLoan() public {
        vm.startPrank(borrower);
        lending.requestLoan(1 ether, "Restock");
        lending.requestLoan(2 ether, "Repair");
        vm.stopPrank();

        vm.prank(lender);
        lending.fundLoan{value: 1 ether}(1);

        (,,, bool secondFunded,) = lending.loans(2);
        assertFalse(secondFunded, "funding leaked to another loan");
    }
}
