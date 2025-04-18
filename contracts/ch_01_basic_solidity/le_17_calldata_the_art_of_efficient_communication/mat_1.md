# Calldata – The Art of Efficient Communication

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
