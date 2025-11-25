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
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const relief = new ethers.Contract(CONTRACT, ABI, provider);

        const [ws, rel] = await Promise.all([
          relief.windSpeed(),
          relief.released(),
        ]);
        const bal = await provider.getBalance(CONTRACT);

        setWind(ws.toNumber());
        setReleased(rel);
        setBalance(ethers.utils.formatEther(bal));
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (wind === null) return <p>Loading relief stats…</p>;
  return (
    <div>
      <h3>Typhoon Relief Chain Stats</h3>
      <p>
        Wind Speed: <strong>{wind}</strong> km/h
      </p>
      <p>
        Pool Balance: <strong>{balance}</strong> ETH
      </p>
      <p>
        Released:{" "}
        <strong>{released ? "✅ Funds Dispatched" : "❌ Pending"}</strong>
      </p>
    </div>
  );
}
