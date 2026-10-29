import { useState, useEffect } from "react";
// Alt B: restores an existing connection on mount with eth_accounts (common pattern).
export default function WalletConnector() {
  const [account, setAccount] = useState(null);
  const hasWallet = Boolean(window.ethereum);
  useEffect(() => {
    if (!window.ethereum) return;
    window.ethereum.request({ method: "eth_accounts" }).then((a) => setAccount(a[0] || null));
  }, []);
  const connectWallet = async () => {
    try {
      const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
      setAccount(accounts[0]);
    } catch (e) { console.error(e); }
  };
  return (
    <div>
      {!hasWallet ? <p>Please install MetaMask to continue.</p>
        : account ? <p>Connected: {account}</p>
        : <button onClick={connectWallet}>Connect MetaMask</button>}
    </div>
  );
}
