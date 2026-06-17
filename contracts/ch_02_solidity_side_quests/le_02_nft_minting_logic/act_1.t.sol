// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "NFT Minting Logic" (permaname: sq-2-nft-minting-logic).
//
// The grader writes the student's submission to `src/SecureNFT.sol`, adds the
// OpenZeppelin libs, and drops this file in as `test/Exercise.t.sol`. SecureNFT is
// an ERC721URIStorage + Ownable token; its constructor calls Ownable(msg.sender),
// so the deployer (this test contract) is the owner.
//
// Coverage: name/symbol metadata, an owner mint (ownerOf + tokenURI + totalSupply),
// the onlyOwner guard (a non-owner mint must revert with OZ v5's
// OwnableUnauthorizedAccount custom error), and the maxSupply cap ("Max NFT supply
// reached", exact string from the answer).

import {Test} from "forge-std/Test.sol";
import {SecureNFT} from "../src/SecureNFT.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SecureNFTTest is Test {
    SecureNFT internal nft;

    address internal recipient = makeAddr("recipient");
    address internal stranger = makeAddr("stranger");

    function setUp() public {
        // Test contract is the deployer and therefore the Ownable owner.
        nft = new SecureNFT();
    }

    function test_metadata_nameAndSymbol() public view {
        assertEq(nft.name(), "SanJuanNFT", "name mismatch");
        assertEq(nft.symbol(), "SJN", "symbol mismatch");
    }

    function test_initialState_ownerAndSupply() public view {
        assertEq(nft.owner(), address(this), "deployer should be owner");
        assertEq(nft.totalSupply(), 0, "supply should start at zero");
        assertEq(nft.maxSupply(), 100, "maxSupply should be 100");
    }

    function test_ownerMint_assignsTokenAndURI() public {
        nft.mintNFT(recipient, "ipfs://token-1");

        assertEq(nft.totalSupply(), 1, "supply should increment");
        assertEq(nft.ownerOf(1), recipient, "token 1 should belong to recipient");
        assertEq(nft.tokenURI(1), "ipfs://token-1", "tokenURI not set");
    }

    function test_mint_incrementsTokenIdsSequentially() public {
        nft.mintNFT(recipient, "ipfs://a");
        nft.mintNFT(recipient, "ipfs://b");

        assertEq(nft.totalSupply(), 2, "supply should be 2");
        assertEq(nft.ownerOf(2), recipient, "second token should belong to recipient");
        assertEq(nft.tokenURI(2), "ipfs://b", "second tokenURI not set");
    }

    function test_nonOwnerMint_reverts() public {
        vm.prank(stranger);
        vm.expectRevert(
            abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, stranger)
        );
        nft.mintNFT(recipient, "ipfs://nope");
    }

    function test_mint_revertsWhenMaxSupplyReached() public {
        uint256 cap = nft.maxSupply();
        for (uint256 i = 0; i < cap; i++) {
            nft.mintNFT(recipient, "ipfs://bulk");
        }
        assertEq(nft.totalSupply(), cap, "supply should equal cap");

        vm.expectRevert(bytes("Max NFT supply reached"));
        nft.mintNFT(recipient, "ipfs://over");
    }
}
