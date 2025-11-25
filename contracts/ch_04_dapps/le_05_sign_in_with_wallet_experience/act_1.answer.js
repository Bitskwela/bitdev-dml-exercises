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
    try {
      setError("");
      if (!window.ethereum) {
        setError("Please install MetaMask!");
        return;
      }

      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const address = await signer.getAddress();
      setAccount(address);
    } catch (err) {
      console.error("Connection failed:", err);
      setError("Failed to connect wallet");
    }
  };

  const signMessage = async () => {
    try {
      setError("");
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const nonce = Date.now().toString();
      const msg = `Sign in to Dashboard\n\nNonce: ${nonce}`;

      const sig = await signer.signMessage(msg);
      setMessage(msg);
      setSignature(sig);
    } catch (err) {
      console.error("Signing failed:", err);
      setError("Failed to sign message");
    }
  };

  const verifySignature = async () => {
    try {
      setError("");
      const msgHash = ethers.utils.id(message);
      const { v, r, s } = ethers.utils.splitSignature(signature);

      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const contract = new ethers.Contract(
        process.env.REACT_APP_CONTRACT_ADDRESS,
        abi,
        provider
      );

      const isValid = await contract.verify(account, msgHash, v, r, s);

      if (isValid) {
        setIsAuthenticated(true);
      } else {
        setError("Signature verification failed");
      }
    } catch (err) {
      console.error("Verification failed:", err);
      setError("Failed to verify signature");
    }
  };

  return (
    <div>
      {!account ? (
        <button onClick={connectWallet}>Connect Wallet</button>
      ) : !signature ? (
        <div>
          <p>Connected: {account}</p>
          <button onClick={signMessage}>Sign In</button>
        </div>
      ) : !isAuthenticated ? (
        <div>
          <p>Signature: {signature.slice(0, 20)}...</p>
          <button onClick={verifySignature}>Verify & Unlock</button>
        </div>
      ) : (
        <div>
          <h2>🚀 Welcome to the Dashboard!</h2>
          <p>Authenticated as: {account}</p>
        </div>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}