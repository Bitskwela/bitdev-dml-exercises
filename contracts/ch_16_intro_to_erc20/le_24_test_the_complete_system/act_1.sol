// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ============================================
// TEST THE COMPLETE SYSTEM — Lesson 24
// by: <Your Name>
// ============================================
// There is NOTHING to fill in this file. Both contracts
// are FINISHED (as of Lesson 23). This lesson's work is
// not writing code — it is PROVING the code, by hand.
//
// Your deliverable is a test note, not an edit:
//   1. Compile THIS file AND RewardStore.sol (same folder).
//   2. Deploy WorkshopCredit, then RewardStore(WCR address),
//      then addItem("Turon", 100 * 10**18).
//   3. Work the checklist in act_1.md top to bottom, using
//      three accounts. Write down the EXPECTED result before
//      each row, then record the ACTUAL Remix output beside it.
//
// Every happy path must succeed; every unhappy path must
// revert with the EXACT error you predicted. "Should fail"
// is a hope — you are here to prove it.
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
