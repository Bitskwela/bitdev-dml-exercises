// WalletAuth.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/Authenticator.json";

export default function WalletAuth() {
  const [account, setAccount] = useState(null);
  const [message, setMessage] = useState("");
  const [signature, setSignature] = useState("");
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [error, setError] = useState("");

  const connectWallet = async () => {
    // TODO: Task 1 - Guard for MetaMask, request accounts, then read the
    //                signer's address into `account`
  };

  const signMessage = async () => {
    // TODO: Task 2 - Build a message containing a nonce and have the signer
    //                sign it; store both the message and the signature
  };

  const verifySignature = async () => {
    // TODO: Task 3 - Verify the signature on-chain and unlock on success
  };

  return (
    <div>
      {/* TODO: Task 4 - Walk the user through connect, sign in, verify, done */}
      <p>Placeholder</p>
    </div>
  );
}
