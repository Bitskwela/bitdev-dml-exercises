// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// PURCHASE A REWARD — Lesson 20
// by: <Your Name>
// ============================================
// Lesson 19's store, now getting a cashier. The token
// and the whole storefront are DONE — your only job is
// buyItem, which pulls the buyer's approved WCR via
// transferFrom. (Burning spent credits is Lesson 23.)
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/IERC20.sol";

contract RewardStore {
    // The WCR token this store accepts. Set once at deployment, frozen forever.
    IERC20 public immutable credit;

    struct Item {
        string name;
        uint256 price; // in WCR base units
        bool active;
    }

    Item[] public items;

    event ItemAdded(uint256 indexed id, string name, uint256 price);
    // NEW this lesson: logged whenever a student redeems an item.
    event ItemPurchased(uint256 indexed id, address indexed buyer, uint256 price);

    constructor(address creditToken) {
        credit = IERC20(creditToken);
    }

    // --- Done in Lesson 19 (leave as-is) ---
    function addItem(string calldata name, uint256 price) external {
        items.push(Item(name, price, true));
        emit ItemAdded(items.length - 1, name, price);
    }

    function itemCount() external view returns (uint256) {
        return items.length;
    }

    // --- Your work this lesson ---
    // Redeem an item: pull `price` WCR from the buyer into this store.
    // Requires the buyer to have called approve(storeAddress, price) on the
    // token FIRST — otherwise transferFrom reverts with ERC20InsufficientAllowance.
    function buyItem(uint256 id) external {
        // TODO (Task 1): take a storage reference to items[id], then
        //   require(item.active, "RewardStore: item not available");

        // TODO (Task 2): pull the payment with the token's transferFrom:
        //   from   = msg.sender      (the buyer)
        //   to     = address(this)   (this store)
        //   amount = the item's price
        //   -> credit.transferFrom(msg.sender, address(this), item.price);

        // TODO (Task 3): emit ItemPurchased(id, msg.sender, item.price);
    }
}
