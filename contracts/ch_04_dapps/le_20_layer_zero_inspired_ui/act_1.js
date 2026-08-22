// LockForm.js - Starter Code
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function lockTokens() payable returns (uint256)",
  "event Locked(address indexed user, uint256 amount, uint256 id)",
];

export default function LockForm({ onLocked }) {
  const [amt, setAmt] = useState("");
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Locking
  const [error, setError] = useState("");

  async function doLock() {
    // TODO: Task 1 - Connect the wallet, await the signer, build the contract
    // TODO: Task 2 - Call lockTokens() sending the amount as ETH value
    // TODO: Task 3 - Wait for the receipt, find the Locked event in its logs,
    //                and hand its id to onLocked()
  }

  return (
    <div>
      <h4>Amount to Bridge</h4>
      {/* TODO: Task 4 - Amount input, a Bridge button disabled on invalid input,
          a confirmation step before signing, and the locking / error states */}
      <p>Placeholder</p>
    </div>
  );
}
