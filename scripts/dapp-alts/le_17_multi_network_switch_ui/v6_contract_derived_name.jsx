import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getChainId() view returns (uint256)"];
const NAMES = { 1: "Ethereum Mainnet", 11155111: "Sepolia", 137: "Polygon", 80002: "Polygon Amoy" };
export default function NetworkStats() {
  const [chainId, setChainId] = useState(null); const [error, setError] = useState("");
  useEffect(() => {
    let provider;
    async function loadChain() {
      try {
        if (window.ethereum) { await window.ethereum.request({ method: "eth_requestAccounts" }); provider = new ethers.BrowserProvider(window.ethereum); }
        else provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
        const c = new ethers.Contract(process.env.REACT_APP_NETWORK_DETECTOR, ABI, provider);
        setChainId(Number(await c.getChainId()));
      } catch (e) { setError(e.message); }
    }
    loadChain();
    const onChange = (hex) => setChainId(Number(hex));
    if (window.ethereum) window.ethereum.on("chainChanged", onChange);
    return () => { if (window.ethereum) window.ethereum.removeListener("chainChanged", onChange); };
  }, []);
  if (error) return <p>{error}</p>;
  if (chainId === null) return <p>Detecting network…</p>;
  return (<div><p>Chain ID: {chainId}</p><p>Chain Name: {NAMES[chainId] ?? "Unknown"}</p></div>);
}
