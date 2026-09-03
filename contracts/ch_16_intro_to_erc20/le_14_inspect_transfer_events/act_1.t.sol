// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Inspect Transfer Events"
// (permaname: erc20-inspect-transfer-events).
//
// Two receipts must come out of one call: the inherited ERC-20 `Transfer`,
// emitted by the transfer itself, and the lesson's own `CreditsAwarded`, which
// records the WHY that `Transfer` cannot carry.
//
// The suite reads raw logs rather than using expectEmit alone, because the
// interesting properties here are structural: that BOTH events fire, in that
// order, and that `to` was declared `indexed` — none of which a value-only
// assertion can see.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant AMOUNT = 25 * 10 ** 18;

    bytes32 internal constant TRANSFER_SIG = keccak256("Transfer(address,address,uint256)");
    bytes32 internal constant AWARDED_SIG = keccak256("CreditsAwarded(address,uint256,string)");

    address internal alice = address(0xA11CE);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The credits must actually move — an event without a transfer is a lie.
    function test_awardWithNote_movesTheCredits() public {
        credit.awardWithNote(alice, AMOUNT, "Top scorer");

        assertEq(credit.balanceOf(alice), AMOUNT, "credits did not reach the student");
        assertEq(
            credit.balanceOf(address(this)),
            1000 * 10 ** 18 - AMOUNT,
            "the caller was not debited"
        );
    }

    /// The task: the lesson's own receipt is emitted, with the note intact.
    function test_awardWithNote_emitsCreditsAwarded() public {
        vm.recordLogs();
        credit.awardWithNote(alice, AMOUNT, "Top scorer");
        Vm.Log[] memory logs = vm.getRecordedLogs();

        bool found;
        for (uint256 i = 0; i < logs.length; i++) {
            if (logs[i].topics[0] != AWARDED_SIG) continue;
            found = true;

            assertEq(logs[i].topics.length, 2, "CreditsAwarded must index `to` and nothing else");
            assertEq(address(uint160(uint256(logs[i].topics[1]))), alice, "wrong `to` in the receipt");

            (uint256 amount, string memory note) = abi.decode(logs[i].data, (uint256, string));
            assertEq(amount, AMOUNT, "wrong amount in the receipt");
            assertEq(note, "Top scorer", "the note was not recorded");
        }
        assertTrue(found, "CreditsAwarded(address,uint256,string) was never emitted");
    }

    /// The inherited Transfer receipt fires too — one call, two records.
    function test_awardWithNote_alsoEmitsTheInheritedTransfer() public {
        vm.recordLogs();
        credit.awardWithNote(alice, AMOUNT, "Top scorer");
        Vm.Log[] memory logs = vm.getRecordedLogs();

        assertEq(logs.length, 2, "expected exactly two events: Transfer, then CreditsAwarded");
        assertEq(logs[0].topics[0], TRANSFER_SIG, "the transfer receipt must come first");
        assertEq(logs[1].topics[0], AWARDED_SIG, "the note receipt must come second");

        assertEq(address(uint160(uint256(logs[0].topics[1]))), address(this), "wrong Transfer from");
        assertEq(address(uint160(uint256(logs[0].topics[2]))), alice, "wrong Transfer to");
    }

    /// The note is free-form and must survive verbatim, empty included.
    function test_awardWithNote_recordsAnyNote() public {
        vm.recordLogs();
        credit.awardWithNote(alice, AMOUNT, "");
        Vm.Log[] memory logs = vm.getRecordedLogs();

        (, string memory note) = abi.decode(logs[logs.length - 1].data, (uint256, string));
        assertEq(note, "", "an empty note must still be recorded faithfully");
    }

    /// Emitting a receipt cannot invent credits.
    function test_awardWithNote_preservesTotalSupply() public {
        credit.awardWithNote(alice, AMOUNT, "Top scorer");

        assertEq(credit.totalSupply(), 1000 * 10 ** 18, "supply must not change");
    }

    /// No balance, no receipt: the transfer's guard still applies.
    function test_awardWithNote_revertsWithoutBalance() public {
        vm.prank(alice);
        vm.expectRevert();
        credit.awardWithNote(address(0xB0B), AMOUNT, "Nice try");
    }
}
