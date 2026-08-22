// ReliefStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      // TODO: Task 1 - Connect the wallet and build the contract
      // TODO: Task 2 - Read windSpeed() and released() together
      // TODO: Task 3 - Read the pool's ETH balance from the provider and format it
    }
    loadStats();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, then wind speed,
  //                pool balance, and whether funds were dispatched
  return <p>Placeholder</p>;
}
