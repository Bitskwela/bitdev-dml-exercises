// ProposalList.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
  "function confirmations(uint256, address) view returns (bool)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      // TODO: Task 1 - Connect the wallet and build the contract
      // TODO: Task 2 - Read getTransactionCount(), then transactions(i) for each
      // TODO: Task 3 - Format value as ether and keep the confirmation count
    }
    loadProposals();
  }, [contractAddress]);

  // TODO: Task 4 - Render the error, then one block per proposal showing its
  //                recipient, value, confirmations and executed state
  return <p>Placeholder</p>;
}
