import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function windSpeed() view returns (uint256)","function released() view returns (bool)"];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;
export default function ReliefStats() {
  const [s, setS] = useState(null);
  const [error, setError] = useState("");
  useEffect(() => {
    async function load() {
      try {
        const [account] = await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.BrowserProvider(window.ethereum);
        const relief = new ethers.Contract(CONTRACT, ABI, provider);
        const ws = await relief.windSpeed();
        const rel = await relief.released();
        const bal = await provider.getBalance(CONTRACT);
        setS({ wind: Number(ws), released: rel, balance: Number(ethers.formatEther(bal)).toFixed(2) });
      } catch (e) { setError(e.message); }
    }
    load();
  }, []);
  if (error) return <p>{error}</p>;
  if (!s) return <p>Loading…</p>;
  return (<div><h3>Typhoon Relief</h3><p>Wind: {s.wind} km/h</p><p>Pool: {s.balance} ETH</p><p>{s.released ? "Naipadala na ang ayuda" : "Hindi pa"}</p></div>);
}
