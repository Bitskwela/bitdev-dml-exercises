import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    if (!window.ethereum) {
      alert("Please install MetaMask");
      return;
    }

    try {
      setStatus("pending");
      await window.ethereum.request({ method: "eth_requestAccounts" });

      const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = web3Provider.getSigner();
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        signer
      );

      const tx = await contract.vote(selected, { gasLimit: 100_000 });
      console.log("Tx Hash:", tx.hash);
      await tx.wait();
      setStatus("confirmed ✅");
      onVoted();
    } catch (err) {
      console.error(err);
      setStatus("error: " + (err.data?.message || err.message));
    }
  };

  return (
    <div>
      <select onChange={(e) => setSelected(e.target.value)}>
        {proposals.map((p) => (
          <option key={p}>{p}</option>
        ))}
      </select>
      <button onClick={castVote} disabled={status === "pending"}>
        {status === "pending" ? "Voting…" : "Vote"}
      </button>
      {status && <p>{status}</p>}
    </div>
  );
}