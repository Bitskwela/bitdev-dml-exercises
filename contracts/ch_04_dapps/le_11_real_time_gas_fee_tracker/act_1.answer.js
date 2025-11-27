import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      try {
        // Task 1: Create the provider instance
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );

        // Task 2: Create the contract instance
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );

        // Task 3: Fetch base fee and update state
        const fee = await contract.getBaseFee();
        setBase(fee);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchBaseFee();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (base === null) return <p>Loading base fee…</p>;
  return <p>Current Base Fee: {base.toString()} wei</p>;
}
