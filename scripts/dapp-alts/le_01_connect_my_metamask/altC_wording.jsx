import { useState } from "react";
// Alt C: bullets' logic, different but reasonable no-wallet copy.
export default function WalletConnector() {
  const [account, setAccount] = useState(null);
  const hasWallet = Boolean(window.ethereum);
  const connectWallet = async () => {
    const [first] = await window.ethereum.request({ method: "eth_requestAccounts" });
    setAccount(first);
  };
  return (
    <div>
      {hasWallet ? (account ? <p>Connected: {account}</p> : <button onClick={connectWallet}>Connect MetaMask</button>)
        : <p>MetaMask not detected. Please install the MetaMask extension.</p>}
    </div>
  );
}
