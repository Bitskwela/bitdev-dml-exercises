import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";
// Alt A: v6, no gasLimit, own status copy.
export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");
  const castVote = async () => {
    if (!window.ethereum) return alert("Please install MetaMask");
    try {
      setStatus("pending");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
      const contract = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, signer);
      const tx = await contract.vote(selected);
      await tx.wait();
      setStatus("Vote recorded on-chain ✅");
      onVoted();
    } catch (e) { setStatus("error: " + e.message); }
  };
  return (
    <div>
      <select value={selected} onChange={(e) => setSelected(e.target.value)}>
        {proposals.map((p) => <option key={p}>{p}</option>)}
      </select>
      <button onClick={castVote} disabled={status === "pending"}>Cast Vote</button>
      {status && <p>{status}</p>}
    </div>
  );
}
