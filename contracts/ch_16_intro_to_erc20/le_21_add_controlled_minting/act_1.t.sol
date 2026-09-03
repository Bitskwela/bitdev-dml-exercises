// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Add Controlled Minting"
// (permaname: erc20-add-controlled-minting).
//
// Two things must land together: inheriting Ownable (with `Ownable(msg.sender)`
// in the constructor, which OpenZeppelin v5 requires) and an `onlyOwner` mint.
// The starter imports Ownable but never inherits it and has no mint at all, so
// it fails at the first call.
//
// The refusal test asserts OpenZeppelin v5's typed error rather than a string,
// because v5 replaced the old "Ownable: caller is not the owner" revert with
// `OwnableUnauthorizedAccount(address)`.

import {Test} from "forge-std/Test.sol";
import {Ownable} from "@openzeppelin/contracts@5.0.2/access/Ownable.sol";
import {WorkshopCredit} from "../src/WorkshopCredit.sol";

contract WorkshopCreditTest is Test {
    WorkshopCredit internal credit;

    uint256 internal constant SUPPLY = 1000 * 10 ** 18;
    uint256 internal constant MINT = 50 * 10 ** 18;

    address internal alice = address(0xA11CE);
    address internal student = address(0x57D7);

    function setUp() public {
        credit = new WorkshopCredit();
    }

    /// Ownable must be inherited AND initialised with the deployer.
    function test_deployerIsTheOwner() public view {
        assertEq(credit.owner(), address(this), "the deployer must be the owner");
    }

    /// The task: the owner can create new credits after deployment.
    function test_owner_canMint() public {
        credit.mint(student, MINT);

        assertEq(credit.balanceOf(student), MINT, "the minted credits did not arrive");
    }

    /// Minting is creation, not transfer: supply grows and no one is debited.
    function test_mint_growsTotalSupply() public {
        credit.mint(student, MINT);

        assertEq(credit.totalSupply(), SUPPLY + MINT, "total supply must grow by the minted amount");
        assertEq(credit.balanceOf(address(this)), SUPPLY, "the owner must not be debited");
    }

    /// The access control is the point of the lesson.
    function test_nonOwner_cannotMint() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, alice));
        credit.mint(alice, MINT);
    }

    /// A refused mint must leave the ledger exactly as it was.
    function test_refusedMint_changesNothing() public {
        vm.prank(alice);
        vm.expectRevert();
        credit.mint(alice, MINT);

        assertEq(credit.totalSupply(), SUPPLY, "a refused mint changed the supply");
        assertEq(credit.balanceOf(alice), 0, "a refused mint credited someone");
    }

    /// Minting can run more than once and accumulates.
    function test_mint_accumulates() public {
        credit.mint(student, MINT);
        credit.mint(student, MINT);

        assertEq(credit.balanceOf(student), 2 * MINT, "repeat mints must accumulate");
        assertEq(credit.totalSupply(), SUPPLY + 2 * MINT, "supply must track every mint");
    }

    /// Ownership is transferable, and the mint right travels with it.
    function test_mintRight_followsOwnership() public {
        credit.transferOwnership(alice);
        assertEq(credit.owner(), alice, "ownership was not transferred");

        vm.prank(alice);
        credit.mint(student, MINT);
        assertEq(credit.balanceOf(student), MINT, "the new owner could not mint");

        vm.expectRevert();
        credit.mint(student, MINT);
    }

    /// Everything the token already did must survive the new inheritance.
    function test_tokenBehaviour_isPreserved() public {
        assertEq(credit.name(), "Workshop Credit", "name() regressed");
        assertEq(credit.symbol(), "WCR", "symbol() regressed");
        assertEq(credit.balanceOf(address(this)), SUPPLY, "the initial supply regressed");
        assertTrue(credit.transfer(alice, MINT), "transfer() regressed");
    }
}
