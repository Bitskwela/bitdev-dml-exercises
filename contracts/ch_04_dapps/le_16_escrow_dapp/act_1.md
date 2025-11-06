# Activity 1: EscrowStats Component ⏱️ 10 mins

Build `EscrowStats` to read on-chain: buyer, seller, deposited amount (ETH), and status (`Pending` | `Released`).

## 📋 Contract Baseline

**Solidity Contract (`SimulatedEscrow.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimulatedEscrow {
    address public buyer;
    address public seller;
    uint256 public amount;
    bool public deposited;
    bool public released;

    event Deposited(uint256 amount);
    event Released(address to, uint256 amount);

    constructor(address _buyer, address _seller) {
        buyer = _buyer;
        seller = _seller;
    }

    modifier onlyBuyer() { require(msg.sender == buyer, "only buyer"); _; }
    modifier onlySeller() { require(msg.sender == seller, "only seller"); _; }
    modifier onlyDeposited() { require(deposited, "not deposited"); _; }
    modifier onlyNotReleased() { require(!released, "already released"); _; }

    function deposit() external payable onlyBuyer {
        require(!deposited, "already deposited");
        amount = msg.value;
        deposited = true;
        emit Deposited(msg.value);
    }

    function release() external onlyBuyer onlyDeposited onlyNotReleased {
        released = true;
        payable(seller).transfer(amount);
        emit Released(seller, amount);
    }

    function refund() external onlySeller onlyDeposited onlyNotReleased {
        released = true;
        payable(buyer).transfer(amount);
        emit Released(buyer, amount);
    }
}
```

## 🚀 Starter Code

**`EscrowStats.js`**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
];

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        // TODO: provider = new ethers.providers.JsonRpcProvider(RPC_URL)
        // TODO: contract = new ethers.Contract(ESCROW_ADDR, ABI, provider)
        // TODO: [b, s, a, dep, rel] = await Promise.all([...])
        // TODO: setBuyer(b), setSeller(s), setAmt(a), setDeposited(dep), setReleased(rel)
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (amt === null) return <p>Loading escrow stats…</p>;
  return (
    <div>
      <h3>Escrow Status</h3>
      <p>Buyer: {buyer}</p>
      <p>Seller: {seller}</p>
      <p>Amount: {ethers.utils.formatEther(amt)} ETH</p>
      <p>
        Status:{" "}
        {released
          ? "Released ✅"
          : deposited
          ? "Pending ⏳"
          : "Not Deposited ❌"}
      </p>
    </div>
  );
}
```

## ✅ To Do List

- [ ] Initialize `provider` with `process.env.REACT_APP_RPC_URL`.
- [ ] Instantiate contract with `process.env.REACT_APP_ESCROW_ADDRESS`.
- [ ] Call `buyer()`, `seller()`, `amount()`, `deposited()`, `released()`.
- [ ] Update state accordingly.

## 🎯 Full Solution

```js
// EscrowStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        const escrow = new ethers.Contract(ADDR, ABI, provider);
        const [b, s, a, dep, rel] = await Promise.all([
          escrow.buyer(),
          escrow.seller(),
          escrow.amount(),
          escrow.deposited(),
          escrow.released(),
        ]);
        setBuyer(b);
        setSeller(s);
        setAmt(a);
        setDeposited(dep);
        setReleased(rel);
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (amt === null) return <p>Loading escrow stats…</p>;
  return (
    <div>
      <h3>Escrow Status</h3>
      <p>Buyer: {buyer}</p>
      <p>Seller: {seller}</p>
      <p>Amount: {ethers.utils.formatEther(amt)} ETH</p>
      <p>
        Status:{" "}
        {released
          ? "Released ✅"
          : deposited
          ? "Pending ⏳"
          : "Not Deposited ❌"}
      </p>
    </div>
  );
}
```

## 📄 .env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_ESCROW_ADDRESS=0xYourEscrowAddress
```
