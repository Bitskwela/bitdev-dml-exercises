// LPStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
];

export default function LPStats() {
  const [reserves, setReserves] = useState({ r0: null, r1: null });
  const [supply, setSupply] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchStats() {
      // TODO: Task 1 - Reject an invalid LP address before doing any work
      // TODO: Task 2 - Build a read-only provider and contract
      // TODO: Task 3 - Read getReserves() (a tuple) and getTotalSupply()
    }
    fetchStats();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, and the three numbers
  return <p>Placeholder</p>;
}
