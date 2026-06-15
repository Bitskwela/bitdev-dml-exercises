// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "Understanding OpenZeppelin" (understanding-openzeppelin).
// The student builds an ERC20 token via OpenZeppelin inheritance.

import {Test} from "forge-std/Test.sol";
import {HackanaDefenseToken} from "../src/HackanaDefenseToken.sol";

contract HackanaDefenseTokenTest is Test {
    HackanaDefenseToken internal token;
    address internal addr1 = address(0xA11CE);

    function setUp() public {
        // The test contract is the deployer, so it receives the initial supply.
        token = new HackanaDefenseToken();
    }

    function test_nameAndSymbol() public view {
        assertEq(token.name(), "DefenseToken", "wrong token name");
        assertEq(token.symbol(), "DEF", "wrong token symbol");
    }

    function test_mintsInitialSupplyToDeployer() public view {
        uint256 expected = 1000 * 10 ** token.decimals();
        assertEq(token.balanceOf(address(this)), expected, "deployer balance");
        assertEq(token.totalSupply(), expected, "total supply");
    }

    function test_ownerCanTransfer() public {
        uint256 amount = 100 * 10 ** token.decimals();
        token.transfer(addr1, amount);
        assertEq(token.balanceOf(addr1), amount, "recipient balance after transfer");
    }
}
