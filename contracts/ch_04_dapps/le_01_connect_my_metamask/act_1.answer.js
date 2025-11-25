import { useState } from "react";

export default function WalletConnector() {
  const [account, setAccount] = useState(null);
  const hasWallet = Boolean(window.ethereum);

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

  return (
    <div>
      {hasWallet ? (
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