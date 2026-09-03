// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Reentrancy Fix"
// (permaname: sq-3-reentrancy-fix).
//
// A note on what this suite does NOT do, because it is the interesting part:
// it does not try to drain the wallet. Under Solidity 0.8's checked arithmetic
// the classic drain cannot actually steal from this contract — the unwinding
// `balances[msg.sender] -= amount` underflows and reverts the whole attack, so
// the vulnerable version and the fixed one end in exactly the same state. A
// "the attacker got rich" assertion would pass against the bug.
//
// What genuinely separates them is the ORDER. The vulnerability is that the
// ledger still shows the full balance while the ETH is already on its way out —
// so `Observer` below reads its own recorded balance from inside the receive
// callback, mid-withdrawal. A wallet that applies effects before interactions
// reports the debited figure; a vulnerable one reports the stale one.
//
// This is deliberately fix-agnostic: checks-effects-interactions alone passes,
// `nonReentrant` alone would not — which matches the lesson, whose whole point
// is the ordering, with the guard as belt and braces.

import {Test} from "forge-std/Test.sol";
import {PalengkeWallet} from "../src/PalengkeWallet.sol";

/// Reads the wallet's ledger from inside the payout callback, then attempts to
/// re-enter. A failed re-entry is swallowed: the assertions live in the test.
contract Observer {
    PalengkeWallet public wallet;

    uint256 public ledgerDuringPayout;
    bool public observed;
    bool public reenter;
    uint256 public reentryAmount;

    constructor(PalengkeWallet wallet_) {
        wallet = wallet_;
    }

    function deposit(uint256 value) external {
        (bool ok,) = address(wallet).call{value: value}("");
        require(ok, "deposit failed");
    }

    function withdraw(uint256 amount) external {
        wallet.withdraw(amount);
    }

    /// Withdraw while re-entering once, to prove no extra ETH can be extracted.
    function attack(uint256 amount) external {
        reenter = true;
        reentryAmount = amount;
        address(wallet).call(abi.encodeWithSignature("withdraw(uint256)", amount));
        reenter = false;
    }

    receive() external payable {
        if (!observed) {
            observed = true;
            ledgerDuringPayout = wallet.balances(address(this));
        }
        if (reenter) {
            reenter = false;
            address(wallet).call(abi.encodeWithSignature("withdraw(uint256)", reentryAmount));
        }
    }
}

contract PalengkeWalletTest is Test {
    PalengkeWallet internal wallet;

    address internal honest = address(0x404E57);

    function setUp() public {
        wallet = new PalengkeWallet();

        vm.deal(honest, 5 ether);
        vm.prank(honest);
        (bool ok,) = address(wallet).call{value: 5 ether}("");
        assertTrue(ok, "setup deposit failed");
    }

    /// Deposits are still recorded — the fix must not break the receive hook.
    function test_deposit_isRecorded() public view {
        assertEq(wallet.balances(honest), 5 ether, "the deposit was not recorded");
        assertEq(address(wallet).balance, 5 ether, "the wallet did not keep the ETH");
    }

    /// The wallet still has to work for the people using it honestly.
    function test_withdraw_paysAnHonestDepositor() public {
        uint256 before = honest.balance;

        vm.prank(honest);
        wallet.withdraw(2 ether);

        assertEq(honest.balance, before + 2 ether, "honest withdrawal did not pay out");
        assertEq(wallet.balances(honest), 3 ether, "the ledger was not debited");
        assertEq(address(wallet).balance, 3 ether, "the wallet balance is wrong");
    }

    /// You may not withdraw more than you put in.
    function test_withdraw_revertsBeyondTheDeposit() public {
        vm.prank(honest);
        vm.expectRevert(bytes("Insufficient balance"));
        wallet.withdraw(6 ether);
    }

    /// THE FIX. Mid-payout, the ledger must already show the debited balance.
    function test_effectsAreAppliedBeforeTheExternalCall() public {
        Observer observer = new Observer(wallet);
        vm.deal(address(observer), 2 ether);
        observer.deposit(2 ether);

        observer.withdraw(1 ether);

        assertTrue(observer.observed(), "the payout callback never ran");
        assertEq(
            observer.ledgerDuringPayout(),
            1 ether,
            "the balance must be debited BEFORE the ETH is sent, not after"
        );
    }

    /// And the ledger is correct once the call returns.
    function test_withdraw_settlesTheLedgerAfterwards() public {
        Observer observer = new Observer(wallet);
        vm.deal(address(observer), 2 ether);
        observer.deposit(2 ether);

        observer.withdraw(1 ether);

        assertEq(wallet.balances(address(observer)), 1 ether, "the ledger is wrong after payout");
        assertEq(address(observer).balance, 1 ether, "the withdrawal did not pay out");
    }

    /// A re-entering caller must never extract more than it deposited.
    function test_reentrancy_cannotExceedTheDeposit() public {
        Observer observer = new Observer(wallet);
        vm.deal(address(observer), 1 ether);
        observer.deposit(1 ether);

        assertEq(address(wallet).balance, 6 ether, "setup wrong: expected 5 + 1 ETH");

        observer.attack(1 ether);

        assertLe(address(observer).balance, 1 ether, "a re-entering caller took more than it deposited");
        assertGe(address(wallet).balance, 5 ether, "the honest depositor's ETH was taken");
    }

    /// After an attempted attack the honest depositor is still whole.
    function test_honestDepositorSurvivesAnAttack() public {
        Observer observer = new Observer(wallet);
        vm.deal(address(observer), 1 ether);
        observer.deposit(1 ether);
        observer.attack(1 ether);

        uint256 before = honest.balance;
        vm.prank(honest);
        wallet.withdraw(5 ether);

        assertEq(honest.balance, before + 5 ether, "the honest depositor could not withdraw");
    }

    /// The ledger must never let one balance be spent twice.
    function test_balanceCannotBeWithdrawnTwice() public {
        vm.startPrank(honest);
        wallet.withdraw(5 ether);

        vm.expectRevert(bytes("Insufficient balance"));
        wallet.withdraw(1);
        vm.stopPrank();

        assertEq(wallet.balances(honest), 0, "the ledger should be emptied");
    }
}
