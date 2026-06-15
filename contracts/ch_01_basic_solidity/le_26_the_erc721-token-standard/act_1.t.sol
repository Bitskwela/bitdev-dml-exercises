// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "The ERC721 Token Standard" (the-erc721-token-standard).
// The student builds an owner-gated NFT minter with per-token URIs.

import {Test} from "forge-std/Test.sol";
import {DigitalArtToken} from "../src/DigitalArtToken.sol";

contract DigitalArtTokenTest is Test {
    DigitalArtToken internal nft;
    address internal addr1 = address(0xA11CE);

    function setUp() public {
        // Deployer (this contract) becomes the owner via Ownable(msg.sender).
        nft = new DigitalArtToken();
    }

    function test_nameAndSymbol() public view {
        assertEq(nft.name(), "DigitalArtToken", "wrong name");
        assertEq(nft.symbol(), "DAT", "wrong symbol");
    }

    function test_ownerCanMint_setsOwnerAndUri() public {
        uint256 id = nft.mintArt(addr1, "ipfs://metadataURI1");
        assertEq(id, 1, "first token id should be 1");
        assertEq(nft.ownerOf(1), addr1, "recipient should own the NFT");
        assertEq(nft.tokenURI(1), "ipfs://metadataURI1", "tokenURI not set");
    }

    function test_tokenIdsIncrement() public {
        nft.mintArt(addr1, "ipfs://art1");
        nft.mintArt(addr1, "ipfs://art2");
        assertEq(nft.ownerOf(1), addr1, "token 1 owner");
        assertEq(nft.ownerOf(2), addr1, "token 2 owner");
        assertEq(nft.tokenURI(2), "ipfs://art2", "second tokenURI");
    }

    function test_nonOwnerCannotMint() public {
        vm.prank(addr1);
        vm.expectRevert(); // OZ Ownable: OwnableUnauthorizedAccount
        nft.mintArt(addr1, "ipfs://nope");
    }
}
