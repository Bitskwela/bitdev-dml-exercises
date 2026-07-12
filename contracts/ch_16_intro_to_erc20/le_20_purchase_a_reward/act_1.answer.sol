// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// PURCHASE A REWARD — Full Solution
// Lesson 20 by Dan Santos
// ============================================
// RewardStore now has a cashier: buyItem pulls the
// buyer's approved WCR via transferFrom and holds it.
// One call, two contracts, two events. (Burning the
// collected credits comes in Lesson 23.)
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/IERC20.sol";

contract RewardStore {
    // The WCR token students pay with. Set once at deployment, frozen forever.
    IERC20 public immutable credit;

    struct Item {
        string name;
        uint256 price; // in WCR base units
        bool active;
    }

    Item[] public items;

    event ItemAdded(uint256 indexed id, string name, uint256 price);
    event ItemPurchased(uint256 indexed id, address indexed buyer, uint256 price);

    constructor(address creditToken) {
        credit = IERC20(creditToken);
    }

    // Add a new reward to the catalog.
    function addItem(string calldata name, uint256 price) external {
        items.push(Item(name, price, true));
        emit ItemAdded(items.length - 1, name, price);
    }

    // How many items have ever been listed.
    function itemCount() external view returns (uint256) {
        return items.length;
    }

    // Redeem an item. Pulls `price` WCR from the buyer into this store.
    // The buyer must have called approve(storeAddress, price) on the token first,
    // otherwise transferFrom reverts with ERC20InsufficientAllowance.
    function buyItem(uint256 id) external {
        Item storage item = items[id];
        require(item.active, "RewardStore: item not available");

        // Pull the WCR from the buyer into this contract. From the token's
        // point of view, the spender is THIS store's address.
        credit.transferFrom(msg.sender, address(this), item.price);

        emit ItemPurchased(id, msg.sender, item.price);
    }
}
