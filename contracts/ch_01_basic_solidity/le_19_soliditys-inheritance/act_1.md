## Smart Contract Activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract BaseContract {
    string public organizationName;

    // TODO: Task 1 - Complete this function to validate that the name is not empty
    function setOrganizationName(string memory name) public {
        organizationName = name;
    }
}

// TODO: Task 2 - Create a derived contract that extends BaseContract. Add a function to deposit funds.
contract DerivedContract is BaseContract {
    uint256 public fundBalance;

    function depositFunds(uint256 amount) public {}
}
```

# Task for Learners

Hackana’s new malware exploits contracts with redundant code. Your task is to:

- Create a base contract named `BaseContract` with shared functionality.

```solidity
contract BaseContract {

    string public organizationName;

    function setOrganizationName(string memory name) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        organizationName = name;
    }
}
```

- Build a child contract that inherits from the base contract and extends its logic. Add a function to deposit funds, ensuring the amount is greater than zero.

```solidity
contract DerivedContract is BaseContract {
    uint256 public fundBalance;

    function depositFunds(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        fundBalance += amount;
    }
}
```

### Breakdown of Activity

**Task 1**:

In the `setOrganizationName` function, we added a `require` statement:

```solidity
require(bytes(name).length > 0, "Name cannot be empty");
```

- Purpose: This ensures the name provided is not empty before assigning it to organizationName.

**Task 2**:

In the `depositFunds` function, we added a `require` statement:

```solidity
require(amount > 0, "Amount must be greater than zero");
```

- Purpose: This validates that the deposit `amount` is greater than zero before updating the `fundBalance`.

### Closing Story

Neri uses an analogy to explain inheritance to her team:
"**Parang pamilya ito: ang base contract ay ang magulang, at ang derived contract ay ang anak. Ang anak ay may minana sa magulang, pero puwede rin itong magdagdag ng sariling katangian.**"

(_It’s like a family: the base contract is the parent, and the derived contract is the child. The child inherits traits from the parent but can also add its own features._)

As they implement the **BaseContract** and **DerivedContract**, the team notices how inheritance makes their code cleaner and easier to update.

Hackana’s malware struggles against this new modular structure, forcing it to retreat once more. Neri smiles, knowing that every improvement brings them closer to victory.
