// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 🚩 TODO: Step 1 - Create a library named MathLibrary with add and multiply functions
// 🚩 ANSWER: Place MathLibrary.sol in the same directory with the following code:
/*
library MathLibrary {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function multiply(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }
}
*/

// Import the library
import "./MathLibrary.sol";

contract Calculator {
    // 🚩 TODO: Step 2 - Use imported MathLibrary to perform operations

    // 🚩 ANSWER: Use MathLibrary for addition and multiplication
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
