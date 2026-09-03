// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Add Student Rewards"
// (permaname: erc20-add-student-rewards).
//
// The starter already inherits Ownable and already carries the `onlyOwner`
// modifier on `rewardStudent` — the body is what is missing. So the access
// control is NOT what this gate turns on; the mint and the reason-carrying
// receipt are. Both are asserted, along with the pairing between them: a mint
// with no event, or an event with no mint, both fail.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant SUPPLY = 1000 * 10 ** 18;
    uint256 internal constant REWARD = 25 * 10 ** 18;

    bytes32 internal constant TRANSFER_SIG = keccak256("Transfer(address,address,uint256)");
    bytes32 internal constant REWARDED_SIG = keccak256("StudentRewarded(address,uint256,string)");

    address internal student = address(0x57D7);
    address internal alice = address(0xA11CE);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// The task: the reward is minted into the student's balance.
    function test_rewardStudent_mintsToTheStudent() public {
        credit.rewardStudent(student, REWARD, "Finished chapter 16");

        assertEq(credit.balanceOf(student), REWARD, "the student was not rewarded");
    }

    /// Minted, not transferred: supply grows and the owner is not debited.
    function test_rewardStudent_growsSupplyWithoutDebitingTheOwner() public {
        credit.rewardStudent(student, REWARD, "Finished chapter 16");

        assertEq(credit.totalSupply(), SUPPLY + REWARD, "supply must grow by the reward");
        assertEq(credit.balanceOf(address(this)), SUPPLY, "the owner must not be debited");
    }

    /// The reason is the point: it goes on-chain, attached to the student.
    function test_rewardStudent_emitsTheReasonOnChain() public {
        vm.recordLogs();
        credit.rewardStudent(student, REWARD, "Finished chapter 16");
        Vm.Log[] memory logs = vm.getRecordedLogs();

        bool found;
        for (uint256 i = 0; i < logs.length; i++) {
            if (logs[i].topics[0] != REWARDED_SIG) continue;
            found = true;

            assertEq(logs[i].topics.length, 2, "StudentRewarded must index the student");
            assertEq(address(uint160(uint256(logs[i].topics[1]))), student, "wrong student");

            (uint256 amount, string memory reason) = abi.decode(logs[i].data, (uint256, string));
            assertEq(amount, REWARD, "wrong amount in the receipt");
            assertEq(reason, "Finished chapter 16", "the reason was not recorded");
        }
        assertTrue(found, "StudentRewarded(address,uint256,string) was never emitted");
    }

    /// A mint writes a Transfer from the zero address — the receipt of creation.
    function test_rewardStudent_alsoEmitsTheMintTransfer() public {
        vm.recordLogs();
        credit.rewardStudent(student, REWARD, "Finished chapter 16");
        Vm.Log[] memory logs = vm.getRecordedLogs();

        assertEq(logs.length, 2, "expected a mint Transfer and a StudentRewarded");
        assertEq(logs[0].topics[0], TRANSFER_SIG, "the mint receipt must come first");
        assertEq(address(uint160(uint256(logs[0].topics[1]))), address(0), "a mint comes from address(0)");
        assertEq(address(uint160(uint256(logs[0].topics[2]))), student, "wrong mint recipient");
    }

    /// Different reasons, one student, both recorded and both paid.
    function test_rewardStudent_accumulatesAcrossRewards() public {
        credit.rewardStudent(student, REWARD, "Helped a classmate");
        credit.rewardStudent(student, REWARD, "Perfect quiz");

        assertEq(credit.balanceOf(student), 2 * REWARD, "repeat rewards must accumulate");
        assertEq(credit.totalSupply(), SUPPLY + 2 * REWARD, "supply must track every reward");
    }

    /// The modifier the starter already carries must not be removed.
    function test_onlyTheOwnerMayReward() public {
        vm.prank(alice);
        vm.expectRevert();
        credit.rewardStudent(alice, REWARD, "Self-awarded");

        assertEq(credit.balanceOf(alice), 0, "a refused reward credited someone");
        assertEq(credit.totalSupply(), SUPPLY, "a refused reward changed the supply");
    }

    /// Everything the token already did must survive.
    function test_tokenBehaviour_isPreserved() public {
        assertEq(credit.name(), "Workshop Credit", "name() regressed");
        assertEq(credit.owner(), address(this), "ownership regressed");
        assertTrue(credit.transfer(alice, REWARD), "transfer() regressed");
    }
}
