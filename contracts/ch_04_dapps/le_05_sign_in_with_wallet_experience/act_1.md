# Connect Wallet & Display Address activity:

```js
// WalletConnect.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";

export default function WalletConnect() {
  const [account, setAccount] = useState(null);
  const [error, setError] = useState("");

  const connectWallet = async () => {
    // TODO: request accounts and set state
  };

  return (
    <div>
      {account ? (
        <div>
          <p>Connected: {account}</p>
          <button onClick={() => setAccount(null)}>Disconnect</button>
        </div>
      ) : (
        <button onClick={connectWallet}>Connect Wallet</button>
      )}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Wallet connection, MetaMask detection, error handling, account display

- Update the `WalletConnect` component to:

  - Check for MetaMask availability by detecting `window.ethereum`.
  - Request accounts using `eth_requestAccounts` method.
  - Handle user rejection and other connection errors gracefully.
  - Display the connected wallet address in a user-friendly format.
  - Provide disconnect functionality to clear the account state.

  ```js
  const connectWallet = async () => {
    try {
      setError("");
      if (!window.ethereum) {
        setError("Please install MetaMask!");
        return;
      }

      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });

      setAccount(accounts[0]);
    } catch (err) {
      console.error("Connection failed:", err);
      setError("Failed to connect wallet");
    }
  };
  ```
