## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherConverter {
    // 🚩 Task 1: Function to convert Ether to Wei
    function etherToWei(uint256 etherAmount) public pure returns (uint256) {
        return etherAmount * 1 ether;
    }

    // 🚩 Task 2: Function to convert Wei to Ether
    function weiToEther(uint256 weiAmount) public pure returns (uint256) {
        return weiAmount / 1 ether;
    }
}
```

# Task for Learners

Hackana is stealing small fractions of Ether by manipulating conversion errors. Neri needs a function to calculate precise Ether and Wei values to block Hackana’s tricks.

- Create a function named `etherToWei` that converts Ether to Wei.

```solidity
    function etherToWei(uint256 etherAmount) public pure returns (uint256) {
        return etherAmount * 1 ether;
    }
```

- Create a function named `weiToEther` that converts Wei to Ether.

```solidity
    function weiToEther(uint256 weiAmount) public pure returns (uint256) {
        return weiAmount / 1 ether;
    }
```

### Breakdown of Activity

**Functions**:

- `etherToWei`:

  - Converts an Ether amount into Wei.
  - Multiplies the input by 1 ether to get the Wei equivalent.

- `weiToEther`:
  - Converts a Wei amount into Ether.
  - Divides the input by 1 ether to return the Ether value.

**Examples of Use**:

- Converting 2 Ether to Wei: `etherToWei(2)` returns `2,000,000,000,000,000,000` `Wei`.
- Converting 1,000 Wei to Ether: `weiToEther(1000)` returns `0.000000000000001 Ether`.

### Closing Story

As Neri deploys the `EtherConverter` contract, the barangay treasurer approaches her with a report:
"_Neri, we’ve found suspicious transactions where only small amounts of Ether are being siphoned. Can we track this?_"

Neri demonstrates the `EtherConverter`:
"**Ganito ‘yun. Kapag kaya nating gawing wei ang Ether, maayos natin itong mababantayan.**"
(_Here’s how it works. If we convert Ether into Wei, we can monitor it accurately._)

The treasurer nods, impressed:
"_Hackana won’t see this coming._"

Meanwhile, Hackana, noticing the increased vigilance, laughs:
"_You’re learning quickly, Neri. But can you keep up with my next move?_"

The battle heats up, and Neri prepares to tackle Hackana’s next attack with her newfound expertise.
