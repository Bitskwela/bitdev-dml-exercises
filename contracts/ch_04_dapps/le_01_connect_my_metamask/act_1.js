// WalletConnector.js - Starter Code
import { useState } from "react";

export default function WalletConnector() {
  const [account, setAccount] = useState(null);

  // TODO: Task 1 - Detect MetaMask installation
  // @note Create a boolean variable that checks if window.ethereum exists

  const connectWallet = async () => {
    // TODO: Task 2 - Implement wallet connection logic
    // @note Check for MetaMask, request accounts, and store the connected address
  };

  return (
    <div>
      {/* TODO: Task 3 - Implement conditional rendering */}
      {/* @note Handle three states: no MetaMask, not connected, and connected */}
      <p>Placeholder</p>
    </div>
  );
}
