// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.2/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

/// @dev The slice of WorkshopCredit the store needs: a standard ERC-20 that can also burn.
interface IWorkshopCredit is IERC20 {
    function burn(uint256 amount) external;
}

/// @title RewardStore
/// @notice Lists redeemable workshop rewards (turon, USB sticks, books) and collects
///         Workshop Credit (WCR) through the ERC-20 allowance model. A claimed reward's
///         credits are burned, so total supply reflects credits actually spent.
/// @dev Finished store as of Lesson 23. Deploy WorkshopCredit first, then pass its
///      address to this constructor.
contract RewardStore is Ownable {
    /// @notice The WCR token students pay with. Set once at deployment.
    IWorkshopCredit public immutable credit;

    struct Item {
        string name;
        uint256 price; // in WCR base units
        bool active;
    }

    Item[] public items;

    event ItemAdded(uint256 indexed id, string name, uint256 price);
    event ItemPurchased(uint256 indexed id, address indexed buyer, uint256 price);

    constructor(address creditToken) Ownable(msg.sender) {
        credit = IWorkshopCredit(creditToken);
    }

    /// @notice Instructor-only: list a new redeemable item.
    function addItem(string calldata name, uint256 price) external onlyOwner {
        items.push(Item(name, price, true));
        emit ItemAdded(items.length - 1, name, price);
    }

    /// @notice How many items have ever been listed.
    function itemCount() external view returns (uint256) {
        return items.length;
    }

    /// @notice Redeem an item. Pulls `price` WCR from the buyer (requires a prior
    ///         `approve` on the token), then burns it so the reward truly costs credits.
    function buyItem(uint256 id) external {
        Item storage item = items[id];
        require(item.active, "RewardStore: item not available");

        // Pull the WCR from the buyer into this contract (needs allowance from approve()).
        credit.transferFrom(msg.sender, address(this), item.price);
        // Burn the collected credits: a claimed reward removes WCR from circulation.
        credit.burn(item.price);

        emit ItemPurchased(id, msg.sender, item.price);
    }
}
