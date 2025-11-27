// NetworkStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getChainId() view returns (uint256)"];
const RPC = process.env.REACT_APP_RPC_URL;
const CONTRACT = process.env.REACT_APP_NETWORK_DETECTOR;

const NAMES = {
  1: "Ethereum Mainnet",
  5: "Goerli",
  11155111: "Sepolia",
  137: "Polygon",
  80001: "Mumbai",
};

export default function NetworkStats() {
  const [chainId, setChainId] = useState(null);
  const [chainName, setChainName] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    let provider, contract;

    async function loadChain() {
      try {
        // Task 1: Create provider based on wallet availability
        if (window.ethereum) {
          provider = new ethers.providers.Web3Provider(window.ethereum);
          await window.ethereum.request({ method: "eth_requestAccounts" });
        } else {
          provider = new ethers.providers.JsonRpcProvider(RPC);
        }

        // Task 2: Fetch chain ID and map to friendly name
        contract = new ethers.Contract(CONTRACT, ABI, provider);
        const idBN = await contract.getChainId();
        const id = idBN.toNumber();
        setChainId(id);
        setChainName(NAMES[id] || "Unknown");
      } catch (err) {
        setError(err.message);
      }
    }

    // Task 3: Define handler for chainChanged event
    function handleChange(chainHex) {
      const id = parseInt(chainHex, 16);
      setChainId(id);
      setChainName(NAMES[id] || "Unknown");
    }

    loadChain();

    // Subscribe to chainChanged event
    if (window.ethereum) {
      window.ethereum.on("chainChanged", handleChange);
    }

    // Cleanup listener on unmount
    return () => {
      if (window.ethereum) {
        window.ethereum.removeListener("chainChanged", handleChange);
      }
    };
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (chainId === null) return <p>Detecting network…</p>;

  return (
    <div>
      <h3>Current Network</h3>
      <p>
        Chain ID: <strong>{chainId}</strong>
      </p>
      <p>
        Chain Name: <strong>{chainName}</strong>
      </p>
    </div>
  );
}
