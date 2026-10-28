import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const NAMES = { 1: "Ethereum Mainnet", 11155111: "Sepolia", 137: "Polygon", 80002: "Amoy" };
export default function NetworkStats() {
  const [chainId, setChainId] = useState(null); const [error, setError] = useState("");
  useEffect(() => {
    const provider = window.ethereum ? new ethers.BrowserProvider(window.ethereum) : new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
    (async () => {
      try {
        if (window.ethereum) await window.ethereum.request({ method: "eth_requestAccounts" });
        const net = await provider.getNetwork();
        setChainId(Number(net.chainId));
      } catch (e) { setError(e.message); }
    })();
    const onChange = (hex) => setChainId(Number(hex));
    window.ethereum?.on("chainChanged", onChange);
    return () => window.ethereum?.removeListener("chainChanged", onChange);
  }, []);
  if (error) return <p>{error}</p>;
  if (chainId === null) return <p>Detecting network…</p>;
  return (<div><p>Chain ID: {chainId}</p><p>Chain Name: {NAMES[chainId] || "Unknown"}</p></div>);
}
