// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "ERC1155 Token Standard" (erc1155-token-standard).
// MultiAsset mints initial GOLD + ARTIFACT to the deployer, so the test contract
// inherits ERC1155Holder to legally receive ERC1155 tokens in its constructor.
//
// NOTE: the original Hardhat test asserted a URI that did not match the answer
// contract; this suite asserts the answer's actual URI so the golden gate holds.

import {Test} from "forge-std/Test.sol";
import {ERC1155Holder} from "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import {MultiAsset} from "../src/MultiAsset.sol";

contract MultiAssetTest is Test, ERC1155Holder {
    MultiAsset internal asset;
    address internal addr1 = address(0xA11CE);

    uint256 internal constant GOLD = 1;
    uint256 internal constant ARTIFACT = 2;

    function setUp() public {
        asset = new MultiAsset();
    }

    function test_initialUri() public view {
        assertEq(
            asset.uri(GOLD),
            "https://api.example.com/metadata/{id}.json",
            "wrong metadata URI"
        );
    }

    function test_mintsInitialGoldAndArtifactToOwner() public view {
        assertEq(asset.balanceOf(address(this), GOLD), 1000, "initial GOLD");
        assertEq(asset.balanceOf(address(this), ARTIFACT), 1, "initial ARTIFACT");
    }

    function test_ownerCanMintMore() public {
        asset.mint(addr1, GOLD, 500, "");
        assertEq(asset.balanceOf(addr1, GOLD), 500, "minted GOLD to addr1");
    }

    function test_transferGold() public {
        asset.safeTransferFrom(address(this), addr1, GOLD, 100, "");
        assertEq(asset.balanceOf(address(this), GOLD), 900, "sender GOLD reduced");
        assertEq(asset.balanceOf(addr1, GOLD), 100, "receiver GOLD increased");
    }

    function test_transferArtifact() public {
        asset.safeTransferFrom(address(this), addr1, ARTIFACT, 1, "");
        assertEq(asset.balanceOf(address(this), ARTIFACT), 0, "sender ARTIFACT gone");
        assertEq(asset.balanceOf(addr1, ARTIFACT), 1, "receiver got ARTIFACT");
    }
}
