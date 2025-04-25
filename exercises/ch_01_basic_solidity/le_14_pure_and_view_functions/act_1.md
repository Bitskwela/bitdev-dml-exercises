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
