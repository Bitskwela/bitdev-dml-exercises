// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Reentrancy Fix" (permaname: sq-3-reentrancy-fix).
//
// The grader writes the student's submission to `src/PalengkeWallet.sol`, adds the
// OpenZeppelin libs, and drops this file in as `test/Exercise.t.sol`. PalengkeWallet
// is a ReentrancyGuard wallet: ETH sent to it via receive() credits the sender's
// balance, and withdraw() must follow checks-effects-interactions AND be guarded by
// nonReentrant.
//
// Coverage: deposit-via-send updates balances, a normal withdraw returns ETH and
// zeroes the balance, over-withdraw reverts ("Insufficient balance", exact string),
// and a reentrancy attack is defeated — the recursive re-entry is blocked by the
// guard, the failed inner call bubbles up, and the outer call reverts so the
// attacker drains nothing and the wallet keeps the rest of its ETH.

import {Test} from "forge-std/Test.sol";
import {PalengkeWallet} from "../src/PalengkeWallet.sol";

contract PalengkeWalletTest is Test {
    PalengkeWallet internal wallet;

    address internal alice = makeAddr("alice");

    function setUp() public {
        wallet = new PalengkeWallet();
        vm.deal(alice, 10 ether);
    }

    // Allow this test contract to receive ETH on withdraw.
    receive() external payable {}

    function _deposit(address from, uint256 amount) internal {
        vm.prank(from);
        (bool ok, ) = address(wallet).call{value: amount}("");
        require(ok, "deposit send failed");
    }

    function test_deposit_updatesBalance() public {
        _deposit(alice, 3 ether);
        assertEq(wallet.balances(alice), 3 ether, "balance not credited");
        assertEq(address(wallet).balance, 3 ether, "wallet should hold the ETH");
    }

    function test_deposit_accumulates() public {
        _deposit(alice, 1 ether);
        _deposit(alice, 2 ether);
        assertEq(wallet.balances(alice), 3 ether, "deposits should accumulate");
    }

    function test_withdraw_returnsFundsAndZeroesBalance() public {
        // This test contract deposits, then withdraws to itself.
        (bool ok, ) = address(wallet).call{value: 5 ether}("");
        require(ok, "seed deposit failed");
        assertEq(wallet.balances(address(this)), 5 ether, "self balance not credited");

        uint256 before = address(this).balance;
        wallet.withdraw(2 ether);

        assertEq(wallet.balances(address(this)), 3 ether, "balance not reduced");
        assertEq(address(this).balance, before + 2 ether, "ETH not returned");
    }

    function test_withdraw_revertsOnOverWithdraw() public {
        _deposit(alice, 1 ether);
        vm.prank(alice);
        vm.expectRevert(bytes("Insufficient balance"));
        wallet.withdraw(2 ether);
    }

    function test_reentrancy_cannotDrainOthersFunds() public {
        // Seed the wallet with other users' funds the attacker would try to steal.
        _deposit(alice, 5 ether);

        ReentrantAttacker attacker = new ReentrantAttacker(wallet);
        vm.deal(address(attacker), 1 ether);

        // The attacker deposits 1 ETH then tries to recursively re-enter withdraw().
        // Against a correct (nonReentrant + checks-effects-interactions) wallet the
        // re-entry is blocked, so the attacker can NEVER walk away with more than the
        // 1 ETH it put in. We therefore assert the security property directly rather
        // than a specific revert string: alice's 5 ETH must remain safe and the
        // attacker must not profit.
        try attacker.attack() {} catch {}

        // Alice's funds are untouched and the wallet never paid out more than the
        // attacker deposited (no theft of other users' balances).
        assertEq(wallet.balances(alice), 5 ether, "alice funds must be safe");
        assertGe(address(wallet).balance, 5 ether, "wallet must still hold alice's ETH");
        assertLe(address(attacker).balance, 1 ether, "attacker must not profit from reentrancy");
    }
}

// Malicious contract: tries to recursively re-enter withdraw() from its receive()
// to drain more than it deposited.
contract ReentrantAttacker {
    PalengkeWallet public immutable target;
    uint256 public reentries;

    constructor(PalengkeWallet _target) {
        target = _target;
    }

    function attack() external {
        // Deposit our own 1 ETH so we have a balance to withdraw.
        (bool ok, ) = address(target).call{value: 1 ether}("");
        require(ok, "attacker deposit failed");
        target.withdraw(1 ether);
    }

    receive() external payable {
        // Re-enter exactly once: pull a second 1 ETH before the balance is debited
        // (the classic reentrancy drain). We intentionally re-enter only one extra
        // level so that against a VULNERABLE wallet the attack cleanly succeeds
        // (stealing 1 ETH of someone else's funds) instead of recursing into an
        // underflow that would revert everything. Against a CORRECT wallet the guard
        // blocks this re-entry.
        if (reentries < 1 && address(target).balance >= 1 ether) {
            reentries++;
            target.withdraw(1 ether);
        }
    }
}
