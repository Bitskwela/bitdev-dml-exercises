import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getReserves() view returns (uint112, uint112)","function getTotalSupply() view returns (uint256)"];
export default function LPStats() {
  const [stats, setStats] = useState(null);
  const [error, setError] = useState("");
  useEffect(() => {
    async function fetchStats() {
      try {
        const addr = process.env.REACT_APP_LP_ADDRESS;
        if (!ethers.isAddress(addr)) throw new Error("Invalid LP address");
        const lp = new ethers.Contract(addr, ABI, new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL));
        const [reserves, supply] = await Promise.all([lp.getReserves(), lp.getTotalSupply()]);
        setStats({ r0: reserves[0], r1: reserves[1], supply });
      } catch (e) { setError(e.message); }
    }
    fetchStats();
  }, []);
  if (error) return <p>{error}</p>;
  if (!stats) return <p>Loading LP data…</p>;
  return (<div><h3>LP Reserves & Supply</h3><p>Reserve0: {stats.r0.toString()}</p><p>Reserve1: {stats.r1.toString()}</p><p>Total Supply: {stats.supply.toString()}</p></div>);
}
