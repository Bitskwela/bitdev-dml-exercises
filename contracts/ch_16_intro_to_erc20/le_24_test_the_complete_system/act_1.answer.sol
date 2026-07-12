// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

/// @title Workshop Credit (WCR)
/// @notice A transparent, instructor-issued points token for Dan's coding workshop.
///         Students earn WCR for attendance and finished exercises, and spend it at
///         the RewardStore. This is NOT a cryptocurrency to buy, sell, or speculate on —
///         it is a public, tamper-evident credit ledger.
/// @dev Built on OpenZeppelin Contracts v5. The deployer becomes the instructor (owner).
///      This is the finished token as of Lesson 23 (metadata + supply + controlled
///      minting + rewards + burning).
contract WorkshopCredit is ERC20, Ownable {
    /// @notice Emitted whenever the instructor rewards a student, recording the reason
    ///         permanently and publicly in the transaction log.
    event StudentRewarded(address indexed student, uint256 amount, string reason);

    /// @dev The deployer is both the initial holder of the starting supply and the owner
    ///      (instructor). `decimals()` defaults to 18, so 1,000 WCR is 1000 * 10**18 base units.
    constructor()
        ERC20("Workshop Credit", "WCR")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Instructor-only: issue new credits to a student, with a human-readable reason.
    /// @dev `onlyOwner` is what makes WCR trustworthy — no one else can print credits.
    function rewardStudent(address student, uint256 amount, string calldata reason)
        external
        onlyOwner
    {
        _mint(student, amount);
        emit StudentRewarded(student, amount, reason);
    }

    /// @notice Burn your own credits (used by the RewardStore when a reward is claimed).
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    /// @notice Burn credits from `account`, drawing on the caller's approved allowance.
    function burnFrom(address account, uint256 amount) external {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}
