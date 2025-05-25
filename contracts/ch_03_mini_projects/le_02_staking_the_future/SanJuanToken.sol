// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract SanJuanToken is ERC20, ERC20Permit {
    constructor() ERC20("SanJuanToken", "SJMM") ERC20Permit("SanJuanToken") {
        // Mint initial supply of 1 million tokens to the deployer
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}
