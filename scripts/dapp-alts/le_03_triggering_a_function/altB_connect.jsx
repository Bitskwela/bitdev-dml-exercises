import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";
// Alt B: lecture's pattern (mat_1.md:136) - read contract, then .connect(signer).
export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");
  const castVote = async () => {
    if (!window.ethereum) return alert("Please install MetaMask");
    try {
      setStatus("pending");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const readContract = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, provider);
      const signer = await provider.getSigner();
      const writeContract = readContract.connect(signer);
      const tx = await writeContract.vote(selected, { gasLimit: 100_000 });
      await tx.wait();
      setStatus("confirmed");
      onVoted();
    } catch (e) { setStatus("error: " + e.message); }
  };
  return (
    <div>
      <select onChange={(e) => setSelected(e.target.value)}>{proposals.map((p) => <option key={p}>{p}</option>)}</select>
      <button onClick={castVote} disabled={status === "pending"}>{status === "pending" ? "Voting…" : "Vote"}</button>
      {status && <p>{status}</p>}
    </div>
  );
}
