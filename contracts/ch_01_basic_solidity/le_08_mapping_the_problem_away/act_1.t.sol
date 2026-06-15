// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {AntiHackanaLedger} from "../src/AntiHackanaLedger.sol";

contract AntiHackanaLedgerTest is Test {
    AntiHackanaLedger internal ledger;

    address internal user1 = address(0x111);
    address internal user2 = address(0x222);

    function setUp() public {
        ledger = new AntiHackanaLedger();
    }

    function test_initialBalance_isZero() public {
        assertEq(ledger.getBalance(user1), 0, "initial balance should be zero");
    }

    function test_updateBalance_storesViaPublicMapping() public {
        ledger.updateBalance(user1, 1000);
        assertEq(ledger.userBalances(user1), 1000, "userBalances mapping wrong");
    }

    function test_getBalance_returnsStoredBalance() public {
        ledger.updateBalance(user2, 2500);
        assertEq(ledger.getBalance(user2), 2500, "getBalance returned wrong value");
    }

    function test_updateBalance_overwritesPreviousValue() public {
        ledger.updateBalance(user1, 1000);
        ledger.updateBalance(user1, 4200);
        assertEq(ledger.getBalance(user1), 4200, "balance not overwritten");
    }

    function test_balances_arePerUser() public {
        ledger.updateBalance(user1, 1000);
        ledger.updateBalance(user2, 2500);
        assertEq(ledger.getBalance(user1), 1000, "user1 balance wrong");
        assertEq(ledger.getBalance(user2), 2500, "user2 balance wrong");
    }
}
