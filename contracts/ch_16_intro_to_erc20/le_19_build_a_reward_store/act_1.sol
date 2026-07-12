// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// BUILD A REWARD STORE — Lesson 19
// by: <Your Name>
// ============================================
// A SECOND contract on the ledger. It does NOT hold
// WCR's balances — it holds WCR's ADDRESS (via IERC20)
// plus a catalog of items. No payment yet (that's L20).
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/IERC20.sol";

contract RewardStore {
    // The WCR token this store accepts. Set ONCE in the constructor and
    // frozen forever, so anyone can verify which token this store uses.
    IERC20 public immutable credit;

    // One price card: a name, a price (in WCR base units), and whether it's for sale.
    struct Item {
        string name;
        uint256 price; // e.g. 100 WCR = 100 * 10**18
        bool active;
    }

    // The catalog. The array index IS the item id (first pushed = id 0).
    Item[] public items;

    // Logged whenever a new item is listed, so the ledger records the catalog too.
    event ItemAdded(uint256 indexed id, string name, uint256 price);

    // Deploy WorkshopCredit FIRST, then pass its address here as creditToken.
    constructor(address creditToken) {
        credit = IERC20(creditToken);
    }

    // Add a new reward to the catalog. (Anyone can call this for now — locking
    // it to the instructor with onlyOwner is Lesson 21.)
    function addItem(string calldata name, uint256 price) external {
        // TODO (Task 1):
        //   1. push a new Item built from (name, price, true) onto `items`
        //   2. emit ItemAdded with the new id (items.length - 1), name, price
    }

    // How many items have ever been listed.
    function itemCount() external view returns (uint256) {
        // TODO (Task 2): return how many items are in `items` (its .length)
    }
}
