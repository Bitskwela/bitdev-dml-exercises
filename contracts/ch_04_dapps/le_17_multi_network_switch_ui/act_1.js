// NetworkStats.js - Starter Code
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
      // TODO: Task 1 - Use the wallet's provider when one is installed, and a
      //                read-only JsonRpcProvider when it is not
      // TODO: Task 2 - Read getChainId() and map it to a friendly name
    }

    // TODO: Task 3 - Handle the wallet's chainChanged event (its argument is a
    //                hex string) and update the display

    loadChain();

    // TODO: Task 3 - Subscribe to chainChanged, and return a cleanup that
    //                removes the listener

  }, []);

  // TODO: Task 4 - Render the error, the detecting state, then the chain id
  //                and its name
  return <p>Placeholder</p>;
}
