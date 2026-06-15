// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Official grading suite for "The Dawn of Tokenization" (the-dawn-of-tokenization).
// The student mints an ERC20 city token via OpenZeppelin.

import {Test} from "forge-std/Test.sol";
import {SanJuanCityToken} from "../src/SanJuanCityToken.sol";

contract SanJuanCityTokenTest is Test {
    SanJuanCityToken internal token;
    address internal addr1 = address(0xA11CE);

    function setUp() public {
        token = new SanJuanCityToken();
    }

    function test_nameAndSymbol() public view {
        assertEq(token.name(), "SanJuanToken", "wrong token name");
        assertEq(token.symbol(), "SJC", "wrong token symbol");
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
