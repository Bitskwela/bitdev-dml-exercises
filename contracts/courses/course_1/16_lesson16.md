---
title: "Storage vs. Memory – Unmasking Hackana’s Data Trap"
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
type: "NormalExercise"

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "storage-vs-memory"

# Can be the same as permaname but can be changed if needed.
slug: "storage-vs-memory"
---

# Storage vs. Memory – Unmasking Hackana’s Data Trap

## Scene

Neri is working with the Barangay San Juan officials to digitize their public records. One concern brought up was how residents could check barangay service fees (like IDs, permits, or certifications) without making changes to the records.

While brainstorming, Neri shares how blockchain can provide solutions using Pure and View functions. These functions are perfect for fetching data or performing calculations without altering the state of the contract.

## Solidity Topics: Pure and View Functions

### How to use

**View Functions:**

- Use when you need to fetch or display a state variable.
- Example: Checking service fees.

**Pure Functions:**

- Use for calculations or transformations based on provided input.
- Example: Multiplying a fee by a number of requests.

**Combine Both:**

- Use view functions for reading data and pure functions for computations without state dependencies.

### More Info about View and Pure Functions

**View Functions:**

- Allow contracts to read state variables without modifying them.
- Declared using the view keyword.
- Example: Retrieving barangay service fees or account balances.

**Pure Functions:**

- Perform computations without interacting with state variables.
- Declared using the pure keyword.
- Example: Calculating fees or total costs based on given inputs.

### Key Differences: View vs. Pure functions

| Feature             | View Functions                                                                     | Pure Functions                                                                              |
| ------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| **Purpose**         | Read state variables without modifying them.                                       | Perform computations _without_ interacting with state variables.                            |
| **Access to State** | Can read state variables (like the price of a Barangay ID).                        | Cannot read _or_ modify state variables.                                                    |
| **Data Source**     | Reads data from the blockchain's state.                                            | Operates solely on input parameters.                                                        |
| **Gas Usage**       | No gas cost when called externally (since it's read-only).                         | No gas cost when called externally (computation only).                                      |
| **Keyword**         | `view`                                                                             | `pure`                                                                                      |
| **Example**         | Getting the current Barangay ID fee.                                               | Calculating the total cost of multiple Barangay IDs based on a given quantity.              |
| **Sample Analogy**  | Checking the price of a _fish_ at the _palengke_. You're just looking, not buying. | Calculating how much change you'll get after paying for the _fish_. You're just doing math. |

### Sample contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {

    uint256 public barangayIdFee = 50;

    uint256 public barangayClearanceFee = 100;

    // View function: Returns the Barangay ID fee.
    // Like checking the "listahan" for the ID price.
    // "view" keyword means this function only reads data, doesn't change it.
    function getBarangayIdFee() public view returns (uint256) {
        return barangayIdFee;
    }

    // View function: Returns the Barangay Clearance fee.
    function getBarangayClearanceFee() public view returns (uint256) {
        return barangayClearanceFee;
    }

    // Pure function: Calculates the total cost for multiple Barangay IDs.
    // Like using a calculator to find the total.
    // "pure" keyword means this function doesn't read or change any data in the contract.
    function calculateTotalIdCost(uint256 _quantity) public pure returns (uint256) {
        uint256 totalCost = _quantity * barangayIdFee;
        return totalCost;
    }
}
```

### Task for Learners

- Implement a view function to fetch the barangay certification fee.
- Implement a pure function to calculate the total cost for multiple certifications.

### Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayServiceFees {
    // 🚩 Task 1: State variable for service fee
    uint256 public certificationFee = 100; // Fee for one certification

    // 🚩 Task 2: View function to get the fee
    function getCertificationFee() public view returns (uint256) {
        return certificationFee;
    }

    // 🚩 Task 3: Pure function to calculate total fees for multiple requests
    function calculateTotalCost(
        uint256 numberOfCertifications
    ) public pure returns (uint256) {
        return numberOfCertifications * 100; // Assuming fixed fee of 100
    }
}
```

### Breakdown of Activity

**State variable defined:**

- `certificationFee`: Holds the fee for a single barangay certification.

**View Function:**

- Purpose: Retrieve the fee for a barangay certification without modifying the state.
- Syntax: Declared using `view`
- Function: `getCertificationFee()`

**Pure Function:**

- Purpose: Perform a calculation (e.g., total fees for multiple certifications) without interacting with the state.
- Syntax: Declared using pure.
- Function: `calculateTotalCost()`

### Closing Story

Neri demonstrates how Pure and View functions work:

- Barangay residents can view the certification fee anytime using the getCertificationFee function.

- For those needing multiple certifications, the calculateTotalCost function allows them to compute their total fee instantly.

A vendor smiles and says: "**Neri, parang ganito rin ‘yung ginagawa ng tindahan ko kapag nagkukwenta ng presyo!**”
(_Neri, this feels just like how my store calculates prices!_)

Neri adds:
**"Tama ka! Kaya ang smart contracts ay kayang mag-digitize ng proseso kahit simple lang ang kailangan."**
(_Exactly! Smart contracts can digitize even simple processes._)

The barangay captain nods approvingly, excited to see blockchain help empower the community further.
