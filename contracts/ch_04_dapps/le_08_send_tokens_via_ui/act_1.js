// TokenTransfer.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function transfer(address, uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");

  const handleTransfer = async (e) => {
    e.preventDefault();
    // TODO: Task 1 - Reject an invalid recipient address and a non-positive amount
    // TODO: Task 2 - Connect the wallet and build a signer-backed contract
    // TODO: Task 3 - Read decimals(), parse the amount, send transfer(), then
    //                store the hash and await the receipt
  };

  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      {/* TODO: Task 4 - Recipient input, amount input, submit button, and
          the pending / success / error states */}
      <p>Placeholder</p>
    </form>
  );
}
