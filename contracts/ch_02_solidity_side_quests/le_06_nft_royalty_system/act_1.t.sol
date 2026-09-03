// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "NFT Royalty System"
// (permaname: sq-6-nft-royalty-system).
//
// The interesting case is the SECOND sale, not the first. On the first sale the
// creator is also the current owner, so royalty and proceeds both land in the
// same wallet and a completely unsplit payment looks correct. Only once the NFT
// has changed hands does a missing royalty become visible — which is why the
// split is asserted after a resale.
//
// Every participant is a plain EOA on purpose: the answer pays with `.transfer`,
// whose 2300-gas stipend a contract recipient would not survive.

import {Test} from "forge-std/Test.sol";
import {NFTWithRoyalties} from "../src/NFTWithRoyalties.sol";

contract NFTWithRoyaltiesTest is Test {
    NFTWithRoyalties internal nft;

    address internal creator = address(0xC4EA704);
    address internal firstBuyer = address(0xB1);
    address internal secondBuyer = address(0xB2);

    uint256 internal constant ROYALTY_PCT = 10;

    function setUp() public {
        nft = new NFTWithRoyalties(creator, ROYALTY_PCT);
        vm.deal(firstBuyer, 10 ether);
        vm.deal(secondBuyer, 10 ether);
    }

    /// Constructor behaviour: the creator starts as the owner.
    function test_constructor_setsCreatorAndOwner() public view {
        assertEq(nft.creator(), creator, "creator not stored");
        assertEq(nft.royaltyPercentage(), ROYALTY_PCT, "royalty percentage not stored");
        assertEq(nft.currentOwner(), creator, "the creator must start as the owner");
    }

    /// The payment must match the stated sale price exactly.
    function test_transferNFT_revertsOnAnIncorrectPayment() public {
        vm.prank(firstBuyer);
        vm.expectRevert(bytes("Incorrect payment amount"));
        nft.transferNFT{value: 0.5 ether}(firstBuyer, 1 ether);
    }

    /// Task 3: ownership moves to the buyer.
    function test_transferNFT_movesOwnership() public {
        vm.prank(firstBuyer);
        nft.transferNFT{value: 1 ether}(firstBuyer, 1 ether);

        assertEq(nft.currentOwner(), firstBuyer, "ownership did not move to the buyer");
    }

    /// Tasks 1 and 2 on a first sale: creator is also the seller, so it all
    /// lands in one wallet — and none of it may stay stuck in the contract.
    function test_firstSale_paysTheCreatorInFull() public {
        uint256 before = creator.balance;

        vm.prank(firstBuyer);
        nft.transferNFT{value: 1 ether}(firstBuyer, 1 ether);

        assertEq(creator.balance, before + 1 ether, "the creator was not paid in full");
        assertEq(address(nft).balance, 0, "the sale price must not sit in the contract");
    }

    /// The real test of the royalty: a resale splits 10% / 90%.
    function test_resale_splitsRoyaltyAndProceeds() public {
        vm.prank(firstBuyer);
        nft.transferNFT{value: 1 ether}(firstBuyer, 1 ether);

        uint256 creatorBefore = creator.balance;
        uint256 sellerBefore = firstBuyer.balance;

        vm.prank(secondBuyer);
        nft.transferNFT{value: 2 ether}(secondBuyer, 2 ether);

        assertEq(creator.balance, creatorBefore + 0.2 ether, "the creator's royalty is wrong");
        assertEq(firstBuyer.balance, sellerBefore + 1.8 ether, "the seller's proceeds are wrong");
        assertEq(nft.currentOwner(), secondBuyer, "ownership did not move on the resale");
    }

    /// The resale must not shortchange either party: everything is paid out.
    function test_resale_leavesNothingInTheContract() public {
        vm.prank(firstBuyer);
        nft.transferNFT{value: 1 ether}(firstBuyer, 1 ether);

        vm.prank(secondBuyer);
        nft.transferNFT{value: 2 ether}(secondBuyer, 2 ether);

        assertEq(address(nft).balance, 0, "ETH was left stranded in the contract");
    }

    /// The percentage is read from state, not hard-coded at 10.
    function test_royalty_followsTheConfiguredPercentage() public {
        NFTWithRoyalties quarter = new NFTWithRoyalties(creator, 25);

        vm.prank(firstBuyer);
        quarter.transferNFT{value: 1 ether}(firstBuyer, 1 ether);

        uint256 creatorBefore = creator.balance;
        uint256 sellerBefore = firstBuyer.balance;

        vm.prank(secondBuyer);
        quarter.transferNFT{value: 4 ether}(secondBuyer, 4 ether);

        assertEq(creator.balance, creatorBefore + 1 ether, "25% royalty not applied");
        assertEq(firstBuyer.balance, sellerBefore + 3 ether, "seller proceeds wrong at 25%");
    }

    /// A zero-royalty collection pays the seller everything.
    function test_zeroRoyalty_paysTheSellerEverything() public {
        NFTWithRoyalties free = new NFTWithRoyalties(creator, 0);

        vm.prank(firstBuyer);
        free.transferNFT{value: 1 ether}(firstBuyer, 1 ether);

        uint256 sellerBefore = firstBuyer.balance;

        vm.prank(secondBuyer);
        free.transferNFT{value: 2 ether}(secondBuyer, 2 ether);

        assertEq(firstBuyer.balance, sellerBefore + 2 ether, "a 0% royalty must pay the seller in full");
    }
}
