// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Build a Reward Store"
// (permaname: erc20-build-a-reward-store).
//
// The student's file here is the STORE, not the token, so the suite deploys a
// minimal OpenZeppelin-backed credit token of its own to stand in for
// WorkshopCredit. Only two functions are in scope this lesson — `addItem` and
// `itemCount`; buying arrives in Lesson 20 — so nothing below calls `buyItem`.
//
// Both starter bodies are empty, and `itemCount`'s empty body cannot even
// compile with a declared return, so the starter fails at the compiler.

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {ERC20} from "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import {RewardStore} from "../src/RewardStore.sol";

/// Stand-in for WorkshopCredit, so the store has a real token to point at.
contract CreditStub is ERC20 {
    constructor() ERC20("Workshop Credit", "WCR") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}

contract RewardStoreTest is Test {
    CreditStub internal credit;
    RewardStore internal store;

    uint256 internal constant PRICE = 100 * 10 ** 18;

    bytes32 internal constant ITEM_ADDED_SIG = keccak256("ItemAdded(uint256,string,uint256)");

    function setUp() public {
        credit = new CreditStub();
        store = new RewardStore(address(credit));
    }

    /// The store is wired to the token it was constructed with.
    function test_store_pointsAtTheCreditToken() public view {
        assertEq(address(store.credit()), address(credit), "the store must hold the token address");
    }

    /// A fresh store stocks nothing.
    function test_itemCount_startsAtZero() public view {
        assertEq(store.itemCount(), 0, "a new store must be empty");
    }

    /// Task: addItem must push onto the array, which itemCount must report.
    function test_addItem_growsTheCatalog() public {
        store.addItem("Bitskwela Mug", PRICE);

        assertEq(store.itemCount(), 1, "itemCount did not grow after addItem");

        store.addItem("Sticker Pack", 10 * 10 ** 18);
        assertEq(store.itemCount(), 2, "itemCount must track every item added");
    }

    /// The struct's three fields must all be stored, `active` included.
    function test_addItem_storesNamePriceAndActive() public {
        store.addItem("Bitskwela Mug", PRICE);

        (string memory name, uint256 price, bool active) = store.items(0);
        assertEq(name, "Bitskwela Mug", "the item name was not stored");
        assertEq(price, PRICE, "the item price was not stored");
        assertTrue(active, "a newly added item must be active");
    }

    /// Items keep their own slots — the second must not overwrite the first.
    function test_addItem_keepsEachItemSeparate() public {
        store.addItem("Bitskwela Mug", PRICE);
        store.addItem("Sticker Pack", 10 * 10 ** 18);

        (string memory first,,) = store.items(0);
        (string memory second, uint256 secondPrice,) = store.items(1);

        assertEq(first, "Bitskwela Mug", "item 0 was overwritten");
        assertEq(second, "Sticker Pack", "item 1 was not stored");
        assertEq(secondPrice, 10 * 10 ** 18, "item 1 price was not stored");
    }

    /// The receipt carries the id the item was filed under.
    function test_addItem_emitsItemAddedWithTheNewId() public {
        store.addItem("Bitskwela Mug", PRICE);

        vm.recordLogs();
        store.addItem("Sticker Pack", 10 * 10 ** 18);
        Vm.Log[] memory logs = vm.getRecordedLogs();

        assertEq(logs.length, 1, "expected exactly one ItemAdded event");
        assertEq(logs[0].topics[0], ITEM_ADDED_SIG, "wrong event emitted");
        assertEq(uint256(logs[0].topics[1]), 1, "the id must be the new item's index");

        (string memory name, uint256 price) = abi.decode(logs[0].data, (string, uint256));
        assertEq(name, "Sticker Pack", "wrong name in the receipt");
        assertEq(price, 10 * 10 ** 18, "wrong price in the receipt");
    }

    /// Stocking the shelf is bookkeeping — it must not move any credits.
    function test_addItem_movesNoCredits() public {
        store.addItem("Bitskwela Mug", PRICE);

        assertEq(credit.balanceOf(address(store)), 0, "the store must not receive credits");
        assertEq(credit.balanceOf(address(this)), 1000 * 10 ** 18, "the owner's balance changed");
    }

    /// Reading past the end is out of bounds, which proves the count is honest.
    function test_items_revertsBeyondTheCatalog() public {
        store.addItem("Bitskwela Mug", PRICE);

        vm.expectRevert();
        store.items(1);
    }
}
