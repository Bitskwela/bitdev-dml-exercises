import { useState } from "react";

export default function WalletConnector() {
  const [account, setAccount] = useState(null);

  // Task 1: Detect MetaMask installation
  const hasWallet = Boolean(window.ethereum);

  // Task 2: Implement wallet connection logic
  const connectWallet = async () => {
    if (!window.ethereum) return alert("Please install MetaMask!");

    try {
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(accounts[0]);
    } catch (error) {
      console.error("User rejected wallet connection", error);
    }
  };

  // Task 3: Implement conditional rendering
  return (
    <div>
      {window.ethereum ? (
        account ? (
          <p>Connected: {account}</p>
        ) : (
          <button onClick={connectWallet}>Connect MetaMask 🦊</button>
        )
      ) : (
        <p>Please install MetaMask to continue.</p>
      )}
    </div>
  );
}
