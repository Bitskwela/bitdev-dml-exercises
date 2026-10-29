import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getTransactionCount() view returns (uint256)","function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)"];
export default function ProposalList({ contractAddress }) {
  const [rows, setRows] = useState([]);
  const [error, setError] = useState("");
  useEffect(() => {
    (async () => {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const msig = new ethers.Contract(contractAddress, ABI, new ethers.BrowserProvider(window.ethereum));
        const n = Number(await msig.getTransactionCount());
        const out = [];
        for (let i = 0; i < n; i++) {
          const [to, value, , executed, numConfirmations] = await msig.transactions(i);
          out.push({ id: i, to, value: ethers.formatEther(value), executed, confs: Number(numConfirmations) });
        }
        setRows(out);
      } catch (e) { setError(e.message); }
    })();
  }, [contractAddress]);
  if (error) return <p>{error}</p>;
  return (<div><h3>Multisig Proposals</h3>{rows.map((r) => (<div key={r.id}><p>To: {r.to}</p><p>Value: {r.value} ETH</p><p>Confirmations: {r.confs}</p><p>Executed: {r.executed ? "yes" : "no"}</p></div>))}</div>);
}
