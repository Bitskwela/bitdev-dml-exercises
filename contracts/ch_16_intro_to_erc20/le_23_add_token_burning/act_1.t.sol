// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Add Token Burning"
// (permaname: erc20-add-token-burning).
//
// Two functions, two different trust models: `burn` destroys your OWN credits,
// `burnFrom` destroys SOMEONE ELSE'S within the allowance they granted — which is
// why the answer spends the allowance before burning. A `burnFrom` that skips
// `_spendAllowance` would let anyone destroy anyone's balance, so that path gets
// its own refusal tests.
//
// `RewardStore.sol` rides along as an `extra_sources` helper (the chapter's
// finished store, which burns the price at checkout) so the suite can prove the
// student's burn works through the real integration, not only when called
// directly.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";
import {RewardStore} from "../src/RewardStore.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant SUPPLY = 1000 * 10 ** 18;
    uint256 internal constant BURN = 40 * 10 ** 18;

    bytes32 internal constant TRANSFER_SIG = keccak256("Transfer(address,address,uint256)");

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Task 1: burning your own credits removes them from your balance.
    function test_burn_debitsTheCaller() public {
        credit.burn(BURN);

        assertEq(credit.balanceOf(address(this)), SUPPLY - BURN, "the burner was not debited");
    }

    /// Burning is destruction, not transfer: the supply itself shrinks.
    function test_burn_shrinksTotalSupply() public {
        credit.burn(BURN);

        assertEq(credit.totalSupply(), SUPPLY - BURN, "total supply must shrink by the burn");
    }

    /// The receipt of destruction is a Transfer to the zero address.
    function test_burn_emitsTransferToZero() public {
        vm.recordLogs();
        credit.burn(BURN);
        Vm.Log[] memory logs = vm.getRecordedLogs();

        assertEq(logs.length, 1, "expected exactly one Transfer event");
        assertEq(logs[0].topics[0], TRANSFER_SIG, "wrong event emitted");
        assertEq(address(uint160(uint256(logs[0].topics[1]))), address(this), "wrong burner");
        assertEq(address(uint160(uint256(logs[0].topics[2]))), address(0), "a burn goes to address(0)");
    }

    /// You cannot burn what you do not hold.
    function test_burn_revertsBeyondTheBalance() public {
        vm.prank(alice);
        vm.expectRevert();
        credit.burn(1);

        assertEq(credit.totalSupply(), SUPPLY, "a refused burn changed the supply");
    }

    /// Task 2: burnFrom destroys another account's credits, within its allowance.
    function test_burnFrom_burnsWithinTheAllowance() public {
        credit.transfer(alice, 100 * 10 ** 18);

        vm.prank(alice);
        credit.approve(bob, BURN);

        vm.prank(bob);
        credit.burnFrom(alice, BURN);

        assertEq(credit.balanceOf(alice), 100 * 10 ** 18 - BURN, "alice was not debited");
        assertEq(credit.totalSupply(), SUPPLY - BURN, "supply must shrink");
        assertEq(credit.balanceOf(bob), 0, "burnFrom must destroy, not collect");
    }

    /// The allowance is spent, exactly as a transferFrom would spend it.
    function test_burnFrom_consumesTheAllowance() public {
        credit.transfer(alice, 100 * 10 ** 18);

        vm.prank(alice);
        credit.approve(bob, 2 * BURN);

        vm.prank(bob);
        credit.burnFrom(alice, BURN);

        assertEq(credit.allowance(alice, bob), BURN, "the allowance was not spent");
    }

    /// Without an allowance, burnFrom must refuse — this is the whole guard.
    function test_burnFrom_revertsWithoutAnAllowance() public {
        credit.transfer(alice, 100 * 10 ** 18);

        vm.prank(bob);
        vm.expectRevert();
        credit.burnFrom(alice, BURN);

        assertEq(credit.balanceOf(alice), 100 * 10 ** 18, "an unauthorised burn succeeded");
        assertEq(credit.totalSupply(), SUPPLY, "an unauthorised burn changed the supply");
    }

    /// Beyond the allowance is refused even when the account is rich.
    function test_burnFrom_revertsBeyondTheAllowance() public {
        credit.transfer(alice, 100 * 10 ** 18);

        vm.prank(alice);
        credit.approve(bob, BURN);

        vm.prank(bob);
        vm.expectRevert();
        credit.burnFrom(alice, BURN + 1);
    }

    /// The chapter's real integration: the store burns the price at checkout.
    function test_burn_worksThroughTheRewardStore() public {
        RewardStore store = new RewardStore(address(credit));
        store.addItem("Bitskwela Mug", 100 * 10 ** 18);

        credit.transfer(alice, 300 * 10 ** 18);
        vm.prank(alice);
        credit.approve(address(store), 100 * 10 ** 18);

        vm.prank(alice);
        store.buyItem(0);

        assertEq(credit.balanceOf(alice), 200 * 10 ** 18, "the buyer was not charged");
        assertEq(credit.balanceOf(address(store)), 0, "the store must burn what it collects");
        assertEq(credit.totalSupply(), SUPPLY - 100 * 10 ** 18, "the price was not burned");
    }

    /// Everything the token already did must survive.
    function test_tokenBehaviour_isPreserved() public {
        assertEq(credit.name(), "Workshop Credit", "name() regressed");
        assertEq(credit.owner(), address(this), "ownership regressed");

        credit.rewardStudent(alice, 10 * 10 ** 18, "Still works");
        assertEq(credit.balanceOf(alice), 10 * 10 ** 18, "rewardStudent regressed");
    }
}
