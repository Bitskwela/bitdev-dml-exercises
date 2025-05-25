// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MathLibrary.sol";

contract Calculator {
    function calculateSum(uint256 x, uint256 y) public pure returns (uint256) {
        return MathLibrary.add(x, y);
    }

    function calculateProduct(
        uint256 x,
        uint256 y
    ) public pure returns (uint256) {
        return MathLibrary.multiply(x, y);
    }
}
