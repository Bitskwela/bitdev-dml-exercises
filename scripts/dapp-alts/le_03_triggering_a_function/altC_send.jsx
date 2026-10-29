import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";
// Alt C: ethers v6 idiom provider.send("eth_requestAccounts", []).
export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");
  const castVote = async () => {
    if (!window.ethereum) return alert("Please install MetaMask");
    try {
      setStatus("pending");
      const provider = new ethers.BrowserProvider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(process.env.REACT_APP_CONTRACT_ADDRESS, abi, signer);
      const tx = await contract.vote(selected);
      await tx.wait();
      setStatus("confirmed");
      onVoted();
    } catch (e) { setStatus("error: " + e.message); }
  };
  return (
    <div>
      <select onChange={(e) => setSelected(e.target.value)}>{proposals.map((p) => <option key={p}>{p}</option>)}</select>
      <button onClick={castVote}>Vote</button>
      {status && <p>{status}</p>}
    </div>
  );
}
