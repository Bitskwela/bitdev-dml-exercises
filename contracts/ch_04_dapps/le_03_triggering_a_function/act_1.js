// CastVote.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    // TODO: Task 1 - Guard against a missing wallet, then request accounts
    // TODO: Task 2 - Build a BrowserProvider, await its signer, and construct
    //                the contract with that signer (a write needs a signer)
    // TODO: Task 3 - Send the vote, await tx.wait(), then report and call onVoted()
  };

  return (
    <div>
      {/* TODO: Task 4 - Render the proposal picker, the Vote button, and status */}
      <p>Placeholder</p>
    </div>
  );
}
