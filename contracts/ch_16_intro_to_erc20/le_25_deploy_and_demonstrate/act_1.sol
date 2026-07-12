// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// DEPLOY AND DEMONSTRATE — Lesson 25 (FINALE)
// by: <Your Name>
// ============================================
// There is NOTHING to fill in this file. The contract
// is FINISHED (as of Lesson 23) and already tested
// (Lesson 24). This lesson's work is not writing code
// — it is SHIPPING it to a real, public network.
//
// Your deliverable is a live deployment, not an edit:
//   1. Install MetaMask, switch to the Sepolia testnet,
//      and get free test ETH from a faucet.
//   2. In Remix, set Environment to "Injected Provider
//      - MetaMask" so deploys route onto Sepolia.
//   3. Deploy this WorkshopCredit, then RewardStore.sol
//      (pass WCR's address), then addItem("Turon", 100e18).
//   4. Run the graduation loop: rewardStudent -> switch to
//      the student -> approve -> buyItem(0) -> read the
//      whole thing on sepolia.etherscan.io.
//
// Follow the step-by-step in act_1.md.
// ============================================

import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.2/access/Ownable.sol";

contract WorkshopCredit is ERC20, Ownable {
    event StudentRewarded(address indexed student, uint256 amount, string reason);

    constructor()
        ERC20("Workshop Credit", "WCR")
        Ownable(msg.sender)
    {
        // 1,000 whole WCR to the deployer (the instructor), in base units.
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    /// @notice Instructor-only: issue new credits to a student, with a reason.
    function rewardStudent(address student, uint256 amount, string calldata reason)
        external
        onlyOwner
    {
        _mint(student, amount);
        emit StudentRewarded(student, amount, reason);
    }

    /// @notice Burn your own credits (used by the RewardStore on redemption).
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    /// @notice Burn credits from `account`, drawing on the caller's approved allowance.
    function burnFrom(address account, uint256 amount) external {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}
