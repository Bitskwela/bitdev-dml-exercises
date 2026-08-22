// GasStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      // TODO: Task 1 - Create a read-only JsonRpcProvider
      // TODO: Task 2 - Create the contract instance
      // TODO: Task 3 - Read getBaseFee(), store it, and record any error
    }
    fetchBaseFee();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, and the fee
  return <p>Placeholder</p>;
}
