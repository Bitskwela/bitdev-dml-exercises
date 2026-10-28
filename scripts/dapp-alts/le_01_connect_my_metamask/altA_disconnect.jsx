import { useState } from "react";
// Alt A: handler + .then, adds a Disconnect button once connected.
export default function WalletConnector() {
  const [account, setAccount] = useState(null);
  const hasWallet = typeof window.ethereum !== "undefined";
  const connectWallet = () => {
    if (!hasWallet) return alert("Please install MetaMask!");
    window.ethereum
      .request({ method: "eth_requestAccounts" })
      .then((accounts) => setAccount(accounts[0]))
      .catch((e) => console.error(e));
  };
  if (!hasWallet) return <p>Please install MetaMask to continue.</p>;
  if (!account) return <button onClick={connectWallet}>Connect Wallet</button>;
  return (
    <div>
      <p>Connected: {account}</p>
      <button onClick={() => setAccount(null)}>Disconnect</button>
    </div>
  );
}
