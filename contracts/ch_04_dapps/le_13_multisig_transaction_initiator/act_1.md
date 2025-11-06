# Activity 1: List All Proposals

**Time**: 10 minutes  
**Goal**: Build a `ProposalList` component that connects to MetaMask, fetches `getTransactionCount()`, loops through `transactions(i)`, and renders each proposal's ID, to-address, ETH value, data (hex snippet), executed flag, and current confirmation count.

## Solidity Contract Baseline

Deploy this `MultisigWallet.sol` contract first:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultisigWallet {
    event Submit(uint indexed txId, address indexed proposer);
    event Confirmation(address indexed owner, uint indexed txId);
    event Execution(uint indexed txId, bool success);

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public threshold;

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public confirmations;

    constructor(address[] memory _owners, uint _threshold) {
        require(_owners.length >= _threshold, "owners < threshold");
        threshold = _threshold;
        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "zero owner");
            require(!isOwner[owner], "duplicate owner");
            isOwner[owner] = true;
            owners.push(owner);
        }
    }

    function submitTransaction(address _to, uint _value, bytes calldata _data)
        external onlyOwner returns (uint txId)
    {
        txId = transactions.length;
        transactions.push(
            Transaction({ to: _to, value: _value, data: _data, executed: false, numConfirmations: 0 })
        );
        emit Submit(txId, msg.sender);
    }

    function confirmTransaction(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) notConfirmed(_txId, msg.sender) {
        confirmations[_txId][msg.sender] = true;
        transactions[_txId].numConfirmations += 1;
        emit Confirmation(msg.sender, _txId);
    }

    function executeTransaction(uint _txId)
        external onlyOwner txExists(_txId) notExecuted(_txId)
    {
        Transaction storage txn = transactions[_txId];
        require(txn.numConfirmations >= threshold, "not enough confirmations");
        txn.executed = true;
        (bool success, ) = txn.to.call{ value: txn.value }(txn.data);
        emit Execution(_txId, success);
    }

    modifier onlyOwner() { require(isOwner[msg.sender], "not owner"); _; }
    modifier txExists(uint _txId) { require(_txId < transactions.length, "tx !exists"); _; }
    modifier notExecuted(uint _txId) { require(!transactions[_txId].executed, "tx executed"); _; }
    modifier notConfirmed(uint _txId, address _owner) { require(!confirmations[_txId][_owner], "already confirmed"); _; }

    receive() external payable {}
}
```

## Starter Code

Create `ProposalList.js`:

```javascript
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
  "function confirmations(uint256, address) view returns (bool)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const wallet = new ethers.Contract(contractAddress, ABI, provider);

        const count = (await wallet.getTransactionCount()).toNumber();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [to, value, data, executed, numConfirmations] =
            await wallet.transactions(i);
          items.push({
            id: i,
            to,
            value: ethers.utils.formatEther(value),
            data: data.slice(0, 10) + "…",
            executed,
            numConfirmations: numConfirmations.toNumber(),
          });
        }
        setProposals(items);
      } catch (err) {
        setError(err.message);
      }
    }
    loadProposals();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Multisig Proposals</h3>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ borderBottom: "1px solid #ccc", padding: "8px 0" }}
        >
          <p>
            <strong>ID #{p.id}</strong>
          </p>
          <p>To: {p.to}</p>
          <p>Value: {p.value} ETH</p>
          <p>Data: {p.data}</p>
          <p>Confirmations: {p.numConfirmations}</p>
          <p>Executed: {p.executed ? "✅" : "❌"}</p>
        </div>
      ))}
    </div>
  );
}
```

## To Do List

- [ ] Request accounts via `eth_requestAccounts`
- [ ] Instantiate `provider` & `wallet` contract
- [ ] Call `getTransactionCount()`
- [ ] Loop `i < count`, `wallet.transactions(i)`
- [ ] Format `value` with `ethers.utils.formatEther`
- [ ] `setProposals(items)`

## Key Concepts

- **MetaMask Integration**: Connect to user's wallet for contract reads
- **Contract Loops**: Iterate through on-chain transaction proposals
- **Data Formatting**: Display hex data snippets and ETH amounts
- **Multisig Pattern**: Multiple owners must approve before execution
