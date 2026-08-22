// EscrowStats.js - Starter Code
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
      // TODO: Task 1 - Build a read-only provider and the escrow contract
      // TODO: Task 2 - Read buyer, seller, amount, deposited and released together
      // TODO: Task 3 - Store them
    }
    loadStats();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, the parties, the amount
  //                in ether, and a status of Released / Pending / Not Deposited
  return <p>Placeholder</p>;
}
