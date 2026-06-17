// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EfficientDataTransfer {
    // `calldata` is the cheapest location for read-only external arguments:
    // the value is read directly from the transaction payload, with no copy.
    function echoData(string calldata data) external pure returns (string memory) {
        return data;
    }

    // The `memory` variant copies the argument into memory first, which costs
    // more gas. It is shown here for comparison with the calldata version above.
    function memoryData(string memory data) public pure returns (string memory) {
        return data;
    }
}
