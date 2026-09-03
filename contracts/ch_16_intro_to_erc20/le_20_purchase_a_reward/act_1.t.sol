// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Purchase a Reward"
// (permaname: erc20-purchase-a-reward).
//
// `buyItem` is where the approve/transferFrom pair finally pays off: the buyer
// pre-authorises the store, the store pulls the price at checkout. The starter
// ships `addItem`/`itemCount` already working and leaves `buyItem` empty, so the
// whole gate is the purchase — the suite therefore asserts the pull, the
// allowance drawdown, the receipt, and both refusal paths.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {ERC20} from "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import {RewardStore} from "../src/RewardStore.sol";

/// Stand-in for WorkshopCredit, so the store has a real token to pull from.
contract CreditStub is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}

contract RewardStoreTest is Test {
    CreditStub internal credit;
    RewardStore internal store;

    uint256 internal constant PRICE = 100 * 10 ** 18;
    uint256 internal constant FUNDED = 300 * 10 ** 18;

    bytes32 internal constant PURCHASED_SIG = keccak256("ItemPurchased(uint256,address,uint256)");

    address internal buyer = address(0xB47E4);

    function setUp() public {
        credit = new CreditStub();
        store = new RewardStore(address(credit));
        store.addItem("Bitskwela Mug", PRICE);

        credit.transfer(buyer, FUNDED);
        vm.prank(buyer);
        credit.approve(address(store), PRICE);
    }

    /// The task: checkout pulls the price out of the buyer and into the store.
    function test_buyItem_pullsThePriceFromTheBuyer() public {
        vm.prank(buyer);
        store.buyItem(0);

        assertEq(credit.balanceOf(buyer), FUNDED - PRICE, "the buyer was not charged");
        assertEq(credit.balanceOf(address(store)), PRICE, "the store did not receive the price");
    }

    /// The pull spends the allowance the buyer granted.
    function test_buyItem_consumesTheAllowance() public {
        vm.prank(buyer);
        store.buyItem(0);

        assertEq(credit.allowance(buyer, address(store)), 0, "the allowance was not spent");
    }

    /// The receipt names the item, the buyer and the price paid.
    function test_buyItem_emitsItemPurchased() public {
        vm.recordLogs();
        vm.prank(buyer);
        store.buyItem(0);
        Vm.Log[] memory logs = vm.getRecordedLogs();

        bool found;
        for (uint256 i = 0; i < logs.length; i++) {
            if (logs[i].topics[0] != PURCHASED_SIG) continue;
            found = true;

            assertEq(uint256(logs[i].topics[1]), 0, "wrong item id in the receipt");
            assertEq(address(uint160(uint256(logs[i].topics[2]))), buyer, "wrong buyer in the receipt");
            assertEq(abi.decode(logs[i].data, (uint256)), PRICE, "wrong price in the receipt");
        }
        assertTrue(found, "ItemPurchased was never emitted");
    }

    /// No approval, no purchase — the store cannot help itself to a balance.
    function test_buyItem_revertsWithoutAnApproval() public {
        address stranger = address(0x5748);
        credit.transfer(stranger, FUNDED);

        vm.prank(stranger);
        vm.expectRevert();
        store.buyItem(0);

        assertEq(credit.balanceOf(address(store)), 0, "a refused purchase must move nothing");
    }

    /// Approval alone is not enough — the buyer must hold the credits.
    function test_buyItem_revertsWhenTheBuyerCannotAfford() public {
        address broke = address(0xB204E);

        vm.prank(broke);
        credit.approve(address(store), PRICE);

        vm.prank(broke);
        vm.expectRevert();
        store.buyItem(0);
    }

    /// The `active` flag is checked before any credits move.
    function test_buyItem_revertsForAnUnknownItem() public {
        vm.prank(buyer);
        vm.expectRevert();
        store.buyItem(1);
    }

    /// Buying moves credits; it never creates them, and never changes the shelf.
    function test_buyItem_preservesSupplyAndCatalog() public {
        vm.prank(buyer);
        store.buyItem(0);

        assertEq(credit.totalSupply(), 1000 * 10 ** 18, "supply must not change");
        assertEq(store.itemCount(), 1, "buying must not change the catalog");

        (,, bool active) = store.items(0);
        assertTrue(active, "this lesson does not deactivate an item on purchase");
    }

    /// Lesson 19's behaviour must survive: the shelf still stocks correctly.
    function test_addItem_stillWorks() public {
        store.addItem("Sticker Pack", 10 * 10 ** 18);

        assertEq(store.itemCount(), 2, "addItem regressed");
        (string memory name,,) = store.items(1);
        assertEq(name, "Sticker Pack", "addItem regressed");
    }
}
