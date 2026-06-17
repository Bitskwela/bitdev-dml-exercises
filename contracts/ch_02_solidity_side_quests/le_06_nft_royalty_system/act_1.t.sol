// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "NFT Royalty System" (permaname: sq-6-nft-royalty-system).
//
// The grader writes the student's submission to `src/NFTWithRoyalties.sol` and drops
// this file in as `test/Exercise.t.sol`. The contract is constructed with a creator
// EOA and a royalty percentage; currentOwner starts as the creator. transferNFT is
// payable, requires msg.value == salePrice, sends royalty (salePrice*pct/100) to the
// creator via .transfer, sends the remainder to the current owner via .transfer, and
// sets currentOwner = buyer.
//
// All payees are plain vm addresses (EOAs) so .transfer succeeds. Coverage: initial
// state, the wrong-payment revert ("Incorrect payment amount", exact string), a
// resale where creator != currentOwner so the royalty/seller split is observable on
// two distinct balances, and ownership handover across successive sales.

import {Test} from "forge-std/Test.sol";
import {NFTWithRoyalties} from "../src/NFTWithRoyalties.sol";

contract NFTWithRoyaltiesTest is Test {
    NFTWithRoyalties internal nft;

    // Use vm addresses (EOAs) so .transfer works on every payee.
    address internal creator = makeAddr("creator");
    address internal buyer1 = makeAddr("buyer1");
    address internal buyer2 = makeAddr("buyer2");

    uint256 internal constant PCT = 10; // 10% royalty

    function setUp() public {
        nft = new NFTWithRoyalties(creator, PCT);
        vm.deal(buyer1, 100 ether);
        vm.deal(buyer2, 100 ether);
    }

    function test_initialState() public view {
        assertEq(nft.creator(), creator, "creator mismatch");
        assertEq(nft.royaltyPercentage(), PCT, "percentage mismatch");
        assertEq(nft.currentOwner(), creator, "currentOwner should start as creator");
    }

    function test_transfer_revertsOnWrongPayment() public {
        vm.prank(buyer1);
        vm.expectRevert(bytes("Incorrect payment amount"));
        nft.transferNFT{value: 1 ether}(buyer1, 2 ether);
    }

    function test_firstSale_handsOwnershipToBuyer() public {
        uint256 salePrice = 10 ether;
        uint256 creatorBefore = creator.balance;

        // On the first sale creator == currentOwner, so the whole salePrice (royalty
        // + seller amount) lands on the creator.
        vm.prank(buyer1);
        nft.transferNFT{value: salePrice}(buyer1, salePrice);

        assertEq(creator.balance, creatorBefore + salePrice, "creator should receive full first-sale proceeds");
        assertEq(nft.currentOwner(), buyer1, "ownership should transfer to buyer1");
    }

    function test_resale_splitsRoyaltyAndSellerProceeds() public {
        uint256 firstPrice = 10 ether;
        uint256 secondPrice = 20 ether;

        // First sale: creator -> buyer1.
        vm.prank(buyer1);
        nft.transferNFT{value: firstPrice}(buyer1, firstPrice);

        // Now currentOwner (buyer1, the seller) is distinct from creator, so the
        // royalty and seller-proceeds land on two different balances.
        uint256 creatorBefore = creator.balance;
        uint256 sellerBefore = buyer1.balance;

        uint256 expectedRoyalty = (secondPrice * PCT) / 100; // 2 ether
        uint256 expectedSeller = secondPrice - expectedRoyalty; // 18 ether

        vm.prank(buyer2);
        nft.transferNFT{value: secondPrice}(buyer2, secondPrice);

        assertEq(creator.balance, creatorBefore + expectedRoyalty, "royalty to creator wrong");
        assertEq(buyer1.balance, sellerBefore + expectedSeller, "seller proceeds wrong");
        assertEq(nft.currentOwner(), buyer2, "ownership should transfer to buyer2");
    }

    function test_resale_buyerSpendsExactSalePrice() public {
        uint256 firstPrice = 10 ether;
        uint256 secondPrice = 20 ether;

        vm.prank(buyer1);
        nft.transferNFT{value: firstPrice}(buyer1, firstPrice);

        uint256 buyerBefore = buyer2.balance;
        vm.prank(buyer2);
        nft.transferNFT{value: secondPrice}(buyer2, secondPrice);

        assertEq(buyer2.balance, buyerBefore - secondPrice, "buyer should spend exactly salePrice");
    }
}
