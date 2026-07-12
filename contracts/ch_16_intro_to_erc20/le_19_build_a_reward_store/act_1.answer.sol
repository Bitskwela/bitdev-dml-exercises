// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// BUILD A REWARD STORE — Full Solution
// Lesson 19 by Dan Santos
// ============================================
// A second contract on the ledger: it holds WCR's
// address (via IERC20) and a catalog of items.
// No payment yet — buyItem arrives in Lesson 20.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/IERC20.sol";

contract RewardStore {
    // The WCR token this store accepts. Set once at deployment, frozen forever.
    IERC20 public immutable credit;

    // One redeemable reward: a name, a price (in WCR base units), and availability.
    struct Item {
        string name;
        uint256 price; // in WCR base units, e.g. 100 WCR = 100 * 10**18
        bool active;
    }

    // The catalog. The array index is the item's id (first pushed = id 0).
    Item[] public items;

    // Logged whenever a new item is listed.
    event ItemAdded(uint256 indexed id, string name, uint256 price);

    // Deploy WorkshopCredit FIRST, then pass its address here as creditToken.
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
}
