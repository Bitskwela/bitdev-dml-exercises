# MetaMask Wallet Connection Activity

## Initial Code

```js
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
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: MetaMask detection, `window.ethereum` API, `eth_requestAccounts`, React state management, conditional rendering

---

### Task 1: Detect MetaMask Installation

Check if MetaMask is installed by detecting the `window.ethereum` object. Create a boolean variable `hasWallet` that evaluates to `true` if MetaMask is available.

```js
const hasWallet = Boolean(window.ethereum);
```

---

### Task 2: Implement the `connectWallet` Function

Complete the `connectWallet` function to request account access from MetaMask using the `eth_requestAccounts` method. Store the connected account address in the `account` state variable.

```js
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
```

---

### Task 3: Implement Conditional Rendering

Update the component's return statement to handle three states:

- If MetaMask is **not installed**: Show "Please install MetaMask to continue."
- If MetaMask is installed but **not connected**: Show a "Connect MetaMask 🦊" button.
- If wallet is **connected**: Display the connected account address.

```js
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
```

---

## Breakdown of the Activity

**Variables Defined:**

- `account`: A React state variable that stores the connected wallet address. Initially set to `null` indicating no wallet is connected. When a user successfully connects their MetaMask wallet, this variable holds their Ethereum address (e.g., `0xAbC...123`).

- `hasWallet`: A boolean variable that checks for the presence of `window.ethereum`. This object is injected by MetaMask (or other Web3 wallets) into the browser. If it exists, the user has a compatible wallet installed.

**Key Functions:**

- `connectWallet`:
  An async function that initiates the wallet connection process. It first validates that MetaMask is installed by checking `window.ethereum`. Then it calls the `eth_requestAccounts` method which triggers a MetaMask popup asking the user for permission to connect. If approved, it stores the first account address in state. The try-catch block gracefully handles scenarios where the user rejects the connection request. This function demonstrates proper error handling, which is essential in Web3 development since users can reject transactions or connections at any time.

- **Conditional Rendering Logic**:
  The component uses nested ternary operators to handle three distinct UI states. First, it checks if MetaMask is installed (`window.ethereum`). If not installed, it prompts the user to install MetaMask. If installed, it checks whether an account is connected. When connected, it displays the wallet address; otherwise, it shows a connect button. This pattern ensures users always see relevant information based on their current wallet state.
