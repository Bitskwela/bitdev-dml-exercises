### Smart contract activity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1. Define the Transaction interface
interface ITransaction {
    // 🚩 TODO: Implement deposit function
    function deposit(uint256 amount) external payable;

    // 🚩 TODO: Implement withdraw function
    function withdraw(uint256 amount) external;

    // 🚩 TODO: Implement checkBalance function
    function checkBalance() external view returns (uint256);
}

// 2. Implement the interface in the Marketplace contract
contract Marketplace is ITransaction {
    mapping(address => uint256) private balances;

    // 🚩 TODO: Implement the deposit function
    function deposit(uint256 amount) external payable override {
        require(msg.value == amount, "Amount does not match sent Ether");

        balances[msg.sender] += amount;
    }

    // 🚩 TODO: Implement the withdraw function
    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // 🚩 TODO: Implement the checkBalance function
    function checkBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}
```

### Task for Learners

- Creare an interface named `ITransaction` that defines the following functions:

  - `deposit(uint256 amount)`: Allows users to deposit Ether into the contract.
  - `withdraw(uint256 amount)`: Allows users to withdraw their Ether from the contract.
  - `checkBalance()`: Allows users to check their current balance within the contract.

```solidity
interface ITransaction {
    function deposit(uint256 amount) external payable;
    function withdraw(uint256 amount) external;
    function checkBalance() external view returns (uint256);
}
```

- Implement the `ITransaction` interface in a contract named `Marketplace`. This contract should:

  - Allow users to deposit Ether into the contract.
  - Allow users to withdraw Ether from the contract.
  - Allow users to check their balance within the contract.

  ```solidity
  contract Marketplace is ITransaction {
    mapping(address => uint256) private balances;

    function deposit(uint256 amount) external payable override {
        require(msg.value == amount, "Amount does not match sent Ether");

        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function checkBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
  }
  ```

### Breakdown of Activity

**ITransaction** Interface:

`deposit(uint256 amount)`: Allows users to deposit Ether into the contract.

`withdraw(uint256 amount)`: Allows users to withdraw their Ether from the contract.

`checkBalance()`: Allows users to check their current balance within the contract.

**Marketplace Contract:**

- The contract implements the `ITransaction` interface, ensuring it follows the required structure for depositing, withdrawing, and checking balances.

- **deposit**: When a user sends Ether to the contract, the amount is added to their balance in the contract.

- **withdraw**: Users can withdraw Ether from their contract balance as long as they have enough funds.

- **checkBalance**: Users can check their contract balance without needing to interact with external systems.

**Key functionality:**

The contract provides a decentralized payment system where multiple external contracts can interact using the `ITransaction` interface.

### Closing Story

After successfully implementing the interface for her decentralized payment system, Neri felt a surge of confidence. The powerful tool she had created allowed different platforms to communicate seamlessly, making her marketplace more secure and efficient. She knew that Hackana, the destructive malware, was now facing a much tougher opponent.

With the newly built Marketplace contract, Neri ensured that the users' transactions could be trusted and tracked. The contract’s deposit, withdraw, and checkBalance functions allowed her to maintain tight control over funds, protecting users from potential hacks or errors in transactions.

As Neri watched the balance updates in real-time, she realized that Hackana was now cornered. The malware had been relying on exploiting loopholes in transaction systems across various platforms.

But with her secure and transparent contract, Hackana’s attacks were rendered useless. Neri had not only protected the people but also restored their confidence in digital finance systems.

```

```
