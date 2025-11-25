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
      try {
        const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

        if (!ethers.utils.isAddress(LP_ADDRESS)) {
          throw new Error("Invalid LP contract address");
        }

        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);

        const [r0, r1] = await lp.getReserves();
        const ts = await lp.getTotalSupply();
        setReserves({ r0, r1 });
        setSupply(ts);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (reserves.r0 === null) return <p>Loading LP data…</p>;
  return (
    <div>
      <h3>LP Reserves & Supply</h3>
      <p>Reserve0: {reserves.r0.toString()}</p>
      <p>Reserve1: {reserves.r1.toString()}</p>
      <p>Total Supply: {supply.toString()}</p>
    </div>
  );
}
