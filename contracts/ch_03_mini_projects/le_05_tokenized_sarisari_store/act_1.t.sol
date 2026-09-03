// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Tokenized Sari-Sari Store"
// (permaname: proj-5-sari-sari-token).
//
// Six TODOs, three graded properties: the constructor claims ownership and mints
// the opening float, minting is owner-only, and the hard cap holds. The starter
// leaves the constructor and `mint` empty, so it deploys an unowned token with
// zero supply — which the first two assertions catch.
//
// The cap is tested at its exact boundary in both directions, because
// `totalSupply() + amount <= MAX_SUPPLY` and `<` differ by precisely one mint.

import {Test} from "forge-std/Test.sol";
import {SariSariToken} from "../src/SariSariToken.sol";

contract SariSariTokenTest is Test {
    SariSariToken internal token;

    uint256 internal constant INITIAL = 10_000 * 1e18;
    uint256 internal constant MAX = 50_000 * 1e18;

    address internal customer = address(0xC0570);

    function setUp() public {
        token = new SariSariToken();
    }

    /// Identity, carried over from the starter unchanged.
    function test_metadata() public view {
        assertEq(token.name(), "SariSari Token", "name regressed");
        assertEq(token.symbol(), "SST", "symbol regressed");
        assertEq(token.MAX_SUPPLY(), MAX, "the cap regressed");
    }

    /// Task 2: the deployer is recorded as the owner.
    function test_constructor_setsTheOwner() public view {
        assertEq(token.owner(), address(this), "the deployer must be the owner");
    }

    /// Task 3: the opening float is minted to the owner.
    function test_constructor_mintsTheOpeningFloat() public view {
        assertEq(token.totalSupply(), INITIAL, "the constructor must mint 10,000 SST");
        assertEq(token.balanceOf(address(this)), INITIAL, "the owner must hold the float");
    }

    /// Tasks 4 and 6: the owner can mint to a customer.
    function test_mint_creditsTheRecipient() public {
        token.mint(customer, 1_000 * 1e18);

        assertEq(token.balanceOf(customer), 1_000 * 1e18, "the recipient was not credited");
        assertEq(token.totalSupply(), INITIAL + 1_000 * 1e18, "supply did not grow");
    }

    /// Tasks 1 and 4: minting is restricted to the owner.
    function test_mint_revertsForNonOwners() public {
        vm.prank(customer);
        vm.expectRevert(bytes("Not authorized"));
        token.mint(customer, 1_000 * 1e18);

        assertEq(token.totalSupply(), INITIAL, "a refused mint changed the supply");
    }

    /// Task 5: minting exactly up to the cap is allowed.
    function test_mint_allowsReachingTheCapExactly() public {
        token.mint(customer, MAX - INITIAL);

        assertEq(token.totalSupply(), MAX, "minting to the cap must be allowed");
    }

    /// Task 5: one unit past the cap is refused.
    function test_mint_revertsOneUnitOverTheCap() public {
        vm.expectRevert(bytes("Exceeds cap"));
        token.mint(customer, MAX - INITIAL + 1);

        assertEq(token.totalSupply(), INITIAL, "a refused mint changed the supply");
    }

    /// The cap counts every mint, not just the current one.
    function test_mint_capIsCumulative() public {
        token.mint(customer, 20_000 * 1e18);
        token.mint(customer, 20_000 * 1e18);

        assertEq(token.totalSupply(), MAX, "supply should now sit at the cap");

        vm.expectRevert(bytes("Exceeds cap"));
        token.mint(customer, 1);
    }

    /// It is still a working ERC-20: the float can be spent.
    function test_tokenIsSpendable() public {
        assertTrue(token.transfer(customer, 500 * 1e18), "transfer failed");

        assertEq(token.balanceOf(customer), 500 * 1e18, "the customer was not paid");
        assertEq(token.balanceOf(address(this)), INITIAL - 500 * 1e18, "the owner was not debited");
    }
}
