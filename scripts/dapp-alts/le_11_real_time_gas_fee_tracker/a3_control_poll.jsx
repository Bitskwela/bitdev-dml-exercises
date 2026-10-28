import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getBaseFee() view returns (uint256)"];
export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");
  useEffect(() => {
    const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    const tracker = new ethers.Contract(process.env.REACT_APP_GAS_TRACKER_ADDRESS, ABI, provider);
    const refresh = () => tracker.getBaseFee().then(setBase).catch((e) => setError(e.message));
    refresh();
    const id = setInterval(refresh, 12000);
    return () => clearInterval(id);
  }, []);
  if (error) return <p>Error: {error}</p>;
  if (base === null) return <p>Loading base fee…</p>;
  return <p>Base fee: {base.toString()} wei</p>;
}
