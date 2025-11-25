// ProposalList.js - Complete Solution
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
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const wallet = new ethers.Contract(contractAddress, ABI, provider);

        const count = (await wallet.getTransactionCount()).toNumber();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [to, value, data, executed, numConfirmations] =
            await wallet.transactions(i);
          items.push({
            id: i,
            to,
            value: ethers.utils.formatEther(value),
            data: data.slice(0, 10) + "…",
            executed,
            numConfirmations: numConfirmations.toNumber(),
          });
        }
        setProposals(items);
      } catch (err) {
        setError(err.message);
      }
    }
    loadProposals();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Multisig Proposals</h3>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ borderBottom: "1px solid #ccc", padding: "8px 0" }}
        >
          <p>
            <strong>ID #{p.id}</strong>
          </p>
          <p>To: {p.to}</p>
          <p>Value: {p.value} ETH</p>
          <p>Data: {p.data}</p>
          <p>Confirmations: {p.numConfirmations}</p>
          <p>Executed: {p.executed ? "✅" : "❌"}</p>
        </div>
      ))}
    </div>
  );
}
