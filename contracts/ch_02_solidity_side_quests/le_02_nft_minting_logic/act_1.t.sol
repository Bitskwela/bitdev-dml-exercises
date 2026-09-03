// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "NFT Minting Logic"
// (permaname: sq-2-nft-minting-logic).
//
// The starter's `mintNFT()` takes no arguments at all, so this suite does not
// compile against it — the strongest possible signal that the required signature
// `mintNFT(address recipient, string memory tokenURI)` is part of the answer.
//
// Three properties are graded: the owner-only guard, the supply cap, and the
// token URI actually being stored. The cap test mints all 100, which is why it
// is written as a loop rather than a `vm.store` shortcut: the counter has to be
// the contract's own.

import {Test} from "forge-std/Test.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {SecureNFT} from "../src/SecureNFT.sol";

contract SecureNFTTest is Test {
    SecureNFT internal nft;

    address internal collector = address(0xC0FFEE);
    address internal stranger = address(0x5748);

    string internal constant URI = "ipfs://QmSanJuan/1.json";

    function setUp() public {
        nft = new SecureNFT();
    }

    /// The collection's identity comes from the constructor, unchanged.
    function test_collectionMetadata() public view {
        assertEq(nft.name(), "SanJuanNFT", "collection name regressed");
        assertEq(nft.symbol(), "SJN", "collection symbol regressed");
        assertEq(nft.maxSupply(), 100, "maxSupply regressed");
        assertEq(nft.owner(), address(this), "the deployer must own the collection");
    }

    /// A fresh collection has minted nothing.
    function test_totalSupply_startsAtZero() public view {
        assertEq(nft.totalSupply(), 0, "a new collection must be empty");
    }

    /// The task: mint to a recipient and count it.
    function test_mintNFT_mintsToTheRecipient() public {
        nft.mintNFT(collector, URI);

        assertEq(nft.totalSupply(), 1, "totalSupply did not increment");
        assertEq(nft.ownerOf(1), collector, "token 1 must belong to the recipient");
        assertEq(nft.balanceOf(collector), 1, "recipient balance wrong");
    }

    /// Token ids start at 1 and follow the counter, not the array index.
    function test_mintNFT_numbersTokensFromOne() public {
        nft.mintNFT(collector, URI);
        nft.mintNFT(stranger, "ipfs://QmSanJuan/2.json");

        assertEq(nft.ownerOf(1), collector, "token 1 owner wrong");
        assertEq(nft.ownerOf(2), stranger, "token 2 owner wrong");
        assertEq(nft.totalSupply(), 2, "totalSupply must count every mint");
    }

    /// The URI is what makes the NFT worth anything — it must be stored.
    function test_mintNFT_storesTheTokenURI() public {
        nft.mintNFT(collector, URI);

        assertEq(nft.tokenURI(1), URI, "the token URI was not stored");
    }

    /// Minting is owner-only: this is the "Secure" in SecureNFT.
    function test_mintNFT_revertsForNonOwners() public {
        vm.prank(stranger);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, stranger));
        nft.mintNFT(stranger, URI);

        assertEq(nft.totalSupply(), 0, "a refused mint changed the supply");
    }

    /// The cap is enforced at the boundary, not one past it.
    function test_mintNFT_enforcesTheMaxSupply() public {
        for (uint256 i = 0; i < 100; i++) {
            nft.mintNFT(collector, URI);
        }
        assertEq(nft.totalSupply(), 100, "should have minted the full supply");

        vm.expectRevert(bytes("Max NFT supply reached"));
        nft.mintNFT(collector, URI);

        assertEq(nft.totalSupply(), 100, "a refused mint changed the supply");
    }

    /// Minted tokens are real ERC-721s the holder can move on.
    function test_mintedTokenIsTransferable() public {
        nft.mintNFT(collector, URI);

        vm.prank(collector);
        IERC721(address(nft)).transferFrom(collector, stranger, 1);

        assertEq(nft.ownerOf(1), stranger, "the minted token must be transferable");
    }
}
