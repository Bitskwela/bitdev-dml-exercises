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
        // Task 1: Initialize provider and contract
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        const escrow = new ethers.Contract(ADDR, ABI, provider);

        // Task 2: Fetch all escrow data using Promise.all
        const [b, s, a, dep, rel] = await Promise.all([
          escrow.buyer(),
          escrow.seller(),
          escrow.amount(),
          escrow.deposited(),
          escrow.released(),
        ]);

        // Task 3: Update state with fetched data
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
