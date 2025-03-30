---
title: "Ether and Wei – Preparing for the Financial Counterstrike"
description: "A short description of this document."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Currently supported types:
# NormalExercise - Just a simple module.  Does not require user input.
# ActivityExercise - Where the user needs to submit a code and verify.  As of now, no backend verification.
# May be supported in the future:
# VideoExercise - For exercises that are just videos.
type: "ActivityExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "eth-and-wei"

# Can be the same as permaname but can be changed if needed.
slug: "eth-and-wei"
---

# Ether and Wei – Preparing for the Financial Counterstrike

## Scene

The day has finally arrived. Neri is at the forefront of the battle against Hackana, whose malware continues to exploit weak financial infrastructures and siphon off funds. Hackana’s latest scheme? Overcharging and draining wallets by manipulating small transaction units, making it hard for people to notice.

As Neri strategizes, her blockchain mentor sends her an urgent message:
_"**Neri, remember Ether and Wei. Those small units Hackana manipulates? They’re the building blocks of Ethereum transactions. Understand them, and you’ll gain the upper hand!**"_

Neri starts reviewing her notes. She recalls that Ether (ETH) is the main cryptocurrency of Ethereum, while Wei is its smallest denomination (like centavos to pesos). Understanding these units will be crucial for her to counter Hackana’s financial tricks.

## Solidity Topics: Ether and Wei

### More Info about Ether and Wei

In Ethereum, Ether (ETH) is the main currency used for transactions. Since dealing with large decimals can be tricky, Ethereum breaks Ether into smaller units called Wei for precise calculations.

Here’s the conversion:

_1 Ether = 10¹⁸ Wei (1 ETH = 1,000,000,000,000,000,000 Wei)._

### Why use Wei?

- It ensures accuracy in microtransactions.
- Prevents rounding errors during computations.

Solidity provides helper functions for conversions:

- `1 ether` equals `10**18 wei`.
- `1 gwei` equals `10**9 wei` (used for gas fees).

### Example usage in Solidity

```solidity
uint256 public oneEther = 1 ether; // 1 ETH in Wei
uint256 public gasFee = 1 gwei;   // Gas fee in Wei
uint256 public smallTransaction = 500 wei; // Microtransaction
```

### How to use Ether and Wei on real smart contract

**Basic conversion**

- Solidity uses the keywords ether, gwei, and wei for easier calculations.

  Example:

  ```solidty
  uint256 oneEtherInWei = 1 ether; // 1 ETH = 10^18 Wei
  uint256 gasPriceInGwei = 1 gwei; // 1 Gwei = 10^9 Wei
  ```

- Microtransaction
  Small amounts like 500 wei are often used for precise payments.

  Example:

  ```solidity
  uint256 payment = 500 wei;
  ```

### Tasks for learners

Hackana is stealing small fractions of Ether by manipulating conversion errors. Neri needs a function to calculate precise Ether and Wei values to block Hackana’s tricks.

- Write a function to convert Ether to Wei.
- Write a function to convert Wei to Ether for validation.

### Smart contract activity

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

### Breakdown of Activity

**Functions: **

- `etherToWei`:
  - Converts an Ether amount into Wei.
  - Multiplies the input by `1 ether` to get the Wei equivalent.
- `weiToEther`:
  - Converts a Wei amount into Ether.
  - Divides the input by `1 ether` to return the Ether value.

**Sample usage:**

- Converting 2 Ether to Wei: `etherToWei(2)` returns `2,000,000,000,000,000,000 Wei`.
  Converting 1,000 Wei to Ether: `weiToEther(1000)` returns `0.000000000000001 Ether`.

### Closing Story

As Neri deploys the EtherConverter contract, the barangay treasurer approaches her with a report:

_"Neri, we’ve found suspicious transactions where only small amounts of Ether are being siphoned. Can we track this?"_

Neri demonstrates the EtherConverter:

**"Ganito ‘yun. Kapag kaya nating gawing wei ang Ether, maayos natin itong mababantayan."**

_(Here’s how it works. If we convert Ether into Wei, we can monitor it accurately.)_

The treasurer nods, impressed: _"Hackana won’t see this coming."_

Meanwhile, Hackana, noticing the increased vigilance, laughs:
_"You’re learning quickly, Neri. But can you keep up with my next move?"_

The battle heats up, and Neri prepares to tackle Hackana’s next attack with her newfound expertise.
