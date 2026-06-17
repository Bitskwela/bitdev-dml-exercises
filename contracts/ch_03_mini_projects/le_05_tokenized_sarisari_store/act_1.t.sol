// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "SariSari Token" (proj-5-sari-sari-token).
// The student builds an OpenZeppelin ERC20 with a manual owner, an initial
// mint to the deployer, owner-only minting, and a hard MAX_SUPPLY cap.

import {Test} from "forge-std/Test.sol";
import {SariSariToken} from "../src/SariSariToken.sol";

contract SariSariTokenTest is Test {
    SariSariToken internal token;

    address internal shopper = address(0x5409);
    address internal outsider = address(0x0107);

    uint256 internal constant INITIAL = 10_000 * 1e18;
    uint256 internal constant MAX = 50_000 * 1e18;

    function setUp() public {
        // Test contract is the deployer, therefore the owner and initial holder.
        token = new SariSariToken();
    }

    function test_nameAndSymbol() public view {
        assertEq(token.name(), "SariSari Token", "wrong token name");
        assertEq(token.symbol(), "SST", "wrong token symbol");
    }

    function test_ownerAndCap() public view {
        assertEq(token.owner(), address(this), "deployer should be owner");
        assertEq(token.MAX_SUPPLY(), MAX, "wrong max supply cap");
    }

    function test_initialSupplyMintedToDeployer() public view {
        assertEq(token.totalSupply(), INITIAL, "wrong initial total supply");
        assertEq(token.balanceOf(address(this)), INITIAL, "deployer balance wrong");
    }

    function test_ownerCanMintAndSupplyGrows() public {
        uint256 amount = 5_000 * 1e18;
        token.mint(shopper, amount);

        assertEq(token.balanceOf(shopper), amount, "recipient balance after mint");
        assertEq(token.totalSupply(), INITIAL + amount, "total supply not increased");
    }

    function test_nonOwnerMintReverts() public {
        vm.prank(outsider);
        vm.expectRevert(bytes("Not authorized"));
        token.mint(outsider, 1 * 1e18);
    }

    function test_mintRevertsWhenExceedingCap() public {
        // Initial supply is 10,000; cap is 50,000. Minting 40,001 overshoots.
        uint256 overCap = (MAX - INITIAL) + 1;
        vm.expectRevert(bytes("Exceeds cap"));
        token.mint(shopper, overCap);
    }

    function test_mintUpToCapSucceeds() public {
        // Exactly reaching the cap must be allowed.
        uint256 toCap = MAX - INITIAL;
        token.mint(shopper, toCap);
        assertEq(token.totalSupply(), MAX, "should mint exactly up to cap");
    }
}
